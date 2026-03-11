package weiver.service;

import weiver.constant.Sub_category;
import weiver.constant.URLs;
import weiver.domain.entity.Actor;
import weiver.domain.repository.ActorRepository;
import weiver.domain.entity.Casting;
import weiver.domain.repository.CastingRepository;
import weiver.domain.entity.Musical;
import weiver.domain.repository.MusicalRepository;
import weiver.web.dto.ActorsByRoleDto;
import weiver.web.dto.MusicalActorDto;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@RequiredArgsConstructor
@Service
@Slf4j
public class CrawlingService {
    private final MusicalRepository musicalRepository;
    private final ActorRepository actorRepository;
    private final CastingRepository castingRepository;
    private final CrawlingStatus crawlingStatus;
    private boolean isFirst = true;


    /*실행 흐름
     * 1. 처음 실행이라면 모든 데이터를, 아니라면 공연 예정 데이터에 대해서 PlayDB 웹 사이트의 각 장르별 뮤지컬 목록을 가져온다
     * 2. 각 목차의 최대 페이지를 가져와서 처음부터 끝까지 MusicalId를 가져와서 저장한다.
     * 3. 뮤지컬 아이디에 해당하는 상세페이지에서 뮤지컬 정보와 배우정보를 가져온다.
     * 4. List에 뮤지컬과 배우 정보를 저장하고 500개 단위로 배우, 뮤지컬, 캐스팅 정보를 저장한다.
     *  */

    /**반복문으로 사이클을 돌릴 때 예외가 발생하면 다음으로 넘어가지 않고 했던 작업을 다시 진행*/
    public void task() {

        long startTime = System.currentTimeMillis();

        String[] genres = {Sub_category.LICENSE, Sub_category.ORIGINAL, Sub_category.CREATIVE, Sub_category.MUSICAL};
        String[] genreNames = {"라이센스", "오리지널", "창작", "뮤지컬"};
        String crawlingType;

        if (isFirst) {
            crawlingType = Sub_category.ALL;
            isFirst = false;
        } else {
            crawlingType = Sub_category.LATER;
        }

        String crawlingTypeLabel = Sub_category.ALL.equals(crawlingType) ? "전체" : "예정 공연";
        log.info("[크롤링 시작] 유형: {} (isFirst={})", crawlingTypeLabel, Sub_category.ALL.equals(crawlingType));

        crawlingStatus.setRunning(true);
        crawlingStatus.setCrawlingType(crawlingTypeLabel);
        crawlingStatus.setGenreTotal(genres.length);
        crawlingStatus.setStartedAt(LocalDateTime.now());

        for (int gi = 0; gi < genres.length; gi++) {
            String genre = genres[gi];
            String genreName = genreNames[gi];
            int genreNum = gi + 1;

            crawlingStatus.setGenreIndex(genreNum);
            crawlingStatus.setCurrentGenre(genreName);

            int maxPage = setMaxPage(genre, crawlingType);

            List<String> musicalIds = setMusicalIds(genre, crawlingType, maxPage);
            log.info("[{}/{}] {} — 최대 {}페이지 | {}개 ID 수집 완료", genreNum, genres.length, genreName, maxPage, musicalIds.size());

            getMusicalActorDtoAndSaveAll(musicalIds);
        }

        long endTime = System.currentTimeMillis();
        long elapsedSeconds = (endTime - startTime) / 1000;
        long hour = elapsedSeconds / 3600;
        long minute = (elapsedSeconds % 3600) / 60;
        long second = elapsedSeconds % 60;

        log.info("[크롤링 완료] 소요: {}h {}m {}s", hour, minute, second);

        crawlingStatus.setRunning(false);
        crawlingStatus.setCurrentGenre("-");
        crawlingStatus.setFinishedAt(LocalDateTime.now());
        crawlingStatus.setLastDurationSeconds(elapsedSeconds);
    }


    /*Timeout Exception 발생 시 다시 이전 작업을 최대 3번까지 수행*/
    public void getMusicalActorDtoAndSaveAll(List<String> musicalIds) {
        List<MusicalActorDto> musicalActorDtoList = new ArrayList<>();
        int maxRetries = 3;
        int retries = 0;

        for (int i = 0; i < musicalIds.size(); i++) {
            try{
                MusicalActorDto musicalActorDto = getMusicalActorDto(musicalIds.get(i));
                musicalActorDtoList.add(musicalActorDto);

                if ((musicalActorDtoList.size() != 0 && musicalActorDtoList.size() % 1000 == 0) || i == musicalIds.size() - 1) {
                    saveAll(musicalActorDtoList);
                    log.info("데이터 저장({}/{})", (i + 1), musicalIds.size());
                    musicalActorDtoList.clear();
                    retries = 0;
                }
            }
            catch (Exception e){
                log.error("예외 발생:" + e.getMessage());

                if(retries >= maxRetries){
                    break;
                }
                else {
                    i--;
                    retries++;
                }
            }
        }
    }

    @Transactional
    public void saveAll(List<MusicalActorDto> musicalActorDtoList) {
        for (MusicalActorDto musicalActorDto : musicalActorDtoList) {
            Musical musical = musicalActorDto.getMusical();
            musicalRepository.save(musical);

            saveActorsAndCastingForMusical(musicalActorDto, musical);
        }
    }

    private void saveActorsAndCastingForMusical(MusicalActorDto musicalActorDto, Musical musical) {
        for (ActorsByRoleDto actorsByRoleDto : musicalActorDto.getActorsByRoleDtoList()) {
            String role = actorsByRoleDto.getRole();
            List<Actor> actors = actorsByRoleDto.getActor();

            actorRepository.saveAll(actors);

            for (Actor actor : actors) {
                if (castingRepository.findByMusicalIdIdAndActorIdIdAndRole(musical.getId(), actor.getId(), role).isEmpty()) {
                    Casting casting = Casting.builder()
                            .actorId(actor)
                            .role(role)
                            .musicalId(musical)
                            .build();
                    castingRepository.save(casting);
                }
            }
        }
    }

    @SneakyThrows
    public MusicalActorDto getMusicalActorDto(String musicalId) {
        String url = URLs.MUSICAL_DETAIL_URL + musicalId;
        Document doc = getConnection(url).get();

        Musical musical = getMusical(doc, musicalId);
        List<ActorsByRoleDto> ActorsByRoleDtoList = getActors(doc);

        return MusicalActorDto.builder()
                .musical(musical)
                .actorsByRoleDtoList(ActorsByRoleDtoList)
                .build();
    }

    @SneakyThrows
    public Musical getMusical(Document doc, String musicalId) {
        Element element = doc.selectFirst(".pddetail");

        String poster = element.selectFirst("h2 > img").attr("src");

        String title = "";
        Element titleElement = element.selectFirst(".title");
        if (titleElement != null)
            title = titleElement.text();


        String temporary = element.selectFirst("img[alt=일시]").parent().nextElementSibling().text();
        Date stDate = null;
        Date edDate = null;

        if (temporary.length() == 23) {
            String[] dates = temporary.trim().split(" ~ ");
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");

            if (dates[0].length() == 10) {
                stDate = dateFormat.parse(dates[0]);
            }
            if (dates[1].length() == 10) {
                edDate = dateFormat.parse(dates[1]);
            }
        }

        String theater = element.selectFirst("img[alt=장소]").parent().nextElementSibling().text();

        Element viewAgeElement = element.selectFirst("img[alt=관람등급]");
        String viewAge = "";
        if (viewAgeElement != null)
            viewAge = viewAgeElement.parent().nextElementSibling().text();

        Element runningTimeElement = element.selectFirst("img[alt=관람시간]");
        String runningTime = "";
        if (runningTimeElement != null)
            runningTime = runningTimeElement.parent().nextElementSibling().text();

        Element mainCharacterElement = doc.selectFirst(".detail_contentsbox > table > tbody > tr b");
        String mainCharacter = "";
        if (mainCharacterElement != null)
            mainCharacter = mainCharacterElement.text();

        return Musical.builder()
                .id(musicalId)
                .title(title)
                .theater(theater)
                .posterImage(poster)
                .stDate(stDate)
                .edDate(edDate)
                .viewAge(viewAge)
                .runningTime(runningTime)
                .mainCharacter(mainCharacter)
                .build();
    }

    public List<ActorsByRoleDto> getActors(Document doc) {
        Elements actorListByRole = doc.select(".detail_contentsbox > table > tbody > tr > td > table > tbody > tr");
        List<ActorsByRoleDto> actorsByRoleDtos = new ArrayList<>();

        for (Element e : actorListByRole) {
            ActorsByRoleDto actorsByRoleDto = new ActorsByRoleDto();

            String role = e.select("td[width=120]").text();
            Elements profileImages = e.select("td[width=80] > a > img");
            Elements IdAndName = e.select("td[width=52] > a");

            actorsByRoleDto.setRole(role);

            for (int i = 0; i < profileImages.size(); i++) {
                String src = profileImages.get(i).attr("src");
                
                // 썸네일(_s.jpg)을 원본 고화질 이미지(.jpg)로 변환
                if (src != null && src.contains("_s.")) {
                    src = src.replace("_s.", ".");
                }
                
                String id = IdAndName.get(i).attr("href").split("=")[1];
                String name = IdAndName.get(i).text();

                actorsByRoleDto.getActor().add(new Actor(id, name, src));
            }

            actorsByRoleDtos.add(actorsByRoleDtos.size(), actorsByRoleDto);
        }

        return actorsByRoleDtos;
    }


    @SneakyThrows
    public List<String> setMusicalIds(String genre, String type, int maxPage) {
        String url = URLs.MUSICAL_URL + type + URLs.SUB_CATEGORY + genre + URLs.PAGE;
        List<String> musicalIds = new ArrayList<>();

        for (int currentPage=1; currentPage <= maxPage; currentPage++) {
            int retries = 0;
            String currentUrl = url + currentPage;
            while (retries < 3) {
                try {
                    Document doc = getConnection(currentUrl).get();

                    Element musicalElement = doc.selectFirst("#contents .container1 > table > tbody > tr:last-child");

                    if (musicalElement != null) {
                        List<String> idTags = musicalElement.select("a[onclick^=goDetail]").eachAttr("onclick");

                        for (String idTag : idTags) {
                            String id = idTag.substring(idTag.indexOf("'") + 1, idTag.lastIndexOf("'"));
                            musicalIds.add(id);
                        }
                    }
                    break;
                } catch (Exception e) {
                    retries++;
                    log.error("페이지 " + currentPage + " (" + currentUrl + ") 크롤링 실패. 재시도 중... (" + retries + "/3): " + e.getMessage());
                    Thread.sleep(2000); // 재시도 전 대기 시간 증가
                    if (retries == 3) throw e;
                }
            }
        }

        return musicalIds;
    }

    @SneakyThrows
    public int setMaxPage(String subCategory, String type) {
        String MUSICAL_URL = URLs.MUSICAL_URL + type + URLs.SUB_CATEGORY + subCategory + URLs.PAGE;

        int retries = 0;
        while (retries < 3) {
            try {
                Document doc = getConnection(MUSICAL_URL).get();
                Elements pageElements = doc.select("#contents .container1 > table > tbody > tr:last-child");

                if (pageElements.isEmpty()) return 1;

                String[] pageNums = pageElements.get(pageElements.size() - 1).text().split("/");
                if (pageNums.length < 2) return 1;

                int maxPage = Integer.parseInt(pageNums[1].replaceAll("\\D+", ""));

                return maxPage;
            } catch (Exception e) {
                retries++;
                log.error("최대 페이지 가져오기 실패 (" + MUSICAL_URL + "). 재시도 중... (" + retries + "/3): " + e.getMessage());
                Thread.sleep(2000);
                if (retries == 3) throw e;
            }
        }
        return 1;
    }

    private org.jsoup.Connection getConnection(String url) {
        return Jsoup.connect(url)
                .userAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36")
                .header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8")
                .header("Accept-Language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7")
                .header("Accept-Encoding", "identity") // GZIP 압축 해제 오류 방지를 위해 압축 사용 안함
                .header("Cache-Control", "no-cache")
                .header("Pragma", "no-cache")
                .maxBodySize(0) // 무제한 바디 사이즈 허용 (데이터 잘림 방지)
                .timeout(60000);
    }
}
