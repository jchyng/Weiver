package datasever.kopis;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import datasever.repository.ActorRepository;
import entity.Actor;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PlayDBService {

	private final ActorRepository actorRepository;
	
	// 배우 DB에 정보 추가
	public void saveActor() {
		// 최신화 하기 전에 기존 데이터를 모두 삭제한다.
		actorRepository.deleteAll();
		
		Document doc = null;
		// Casting.title에서 " - 지역이름" 을 제외하기 위한 키워드
		List<String> regions = new ArrayList<String>();
		
		try {
			
			String mainURL = "http://www.playdb.co.kr";
			String mainURL2 = "http://www.playdb.co.kr/artistdb/";
			// 뮤지컬 배우 첫 페이지

			int pageNo = 1; // 초기 페이지 넘버
			String ActorListURL = "https://www.playdb.co.kr/artistdb/list_iframe.asp?Page=" + pageNo + "&code=013003&sub_code=&ImportantSelect=&ClickCnt=Y&NameSort=&Country=Y&TKPower=&WeekClickCnt=&NameStart=&NameEnd=";
						
			// 뮤지컬 배우 첫 페이지 접근
			doc = Jsoup.connect(ActorListURL).get();			
			
			// 최대 페이지 알아내기
			Elements maxPages = doc.select("body > table > tbody > tr > td");
			int maxPage = Integer.parseInt(maxPages.get(maxPages.size()-1).text().split("/")[1].split("]")[0]);
			
			// 페이지 반복
			for(pageNo = 1; pageNo <= 1; pageNo++) {
				System.out.println("지금부터 " + pageNo + "페이지 데이터 처리 시작");
				
				// 페이지별로 배우 리스트 접근
				ActorListURL = "https://www.playdb.co.kr/artistdb/list_iframe.asp?Page=" + pageNo + "&code=013003&sub_code=&ImportantSelect=&ClickCnt=Y&NameSort=&Country=Y&TKPower=&WeekClickCnt=&NameStart=&NameEnd=";
				doc = Jsoup.connect(ActorListURL).get();
				
				// 각각 배우 상세로 들어가는 방법
				Elements imgSrcs = doc.select("body > table > tbody > tr > td > table > tbody > tr > td > table > tbody > tr > td > a");
				
				// 모든 배우에 대한 반복
				for(Element imgSrc : imgSrcs) {
					if((imgSrc.text()).equals("")) {
						String actorDetailURL = mainURL2 + imgSrc.attr("href");
						
						// 새로 연결
						doc = Jsoup.connect(actorDetailURL).get();
						
						// 배우 이미지 주소
						String actorImage = doc.select("#manImage").attr("src");
						
						// 배우 이름
						String actorName = doc.select(".title").get(0).text();
						
						// 출연 작품 : 이미지 .img_size4
						// iframe 접근을 위해 actorNo값을 알아낸다.
						String contentImageURL = "#detailcontents > iframe#iFrmContent";					
						String contentactorNo = (doc.select(contentImageURL).attr("src")).split("=")[2];
						
						// iframeURL
	//					http://www.playdb.co.kr/artistdb/Detail_Content_new.asp?TabKind=3&ManNo=45997
						String contentIframeURL = mainURL2 + "Detail_Content_new.asp?TabKind=3&ManNo=" + contentactorNo;
						// contentIframeURL로 연결
						doc = Jsoup.connect(contentIframeURL).get();
						
						// 전체 Casting 객체 생성
						ArrayList<Actor.Casting> actorAllCastings = new ArrayList<Actor.Casting>();
						
						// 출연 작품 이미지 정보
						String tableImageURL = ".detail_contentsbox > table > tbody > tr > td > table > tbody > tr > td > a > img.img_size4";
						Elements images = doc.select(tableImageURL);
						for(Element image : images) {
							actorAllCastings.add(Actor.Casting.builder()
													.posterImage(image.attr("src"))
													.build());
						}
						// 출연 작품 정보 (이미지 제외)
						String tableRoleURL = ".detail_contentsbox > table > tbody > tr > td > table > tbody > tr > td > table > tbody > tr > td";
						Elements roles = doc.select(tableRoleURL);
						
						for(int i = 0; i < roles.size(); i++) {
								
							switch(i % 5) {
								// 출연 작품 Title
								case(0):		
									String title = roles.get(i).text();
	//								System.out.println("제목 : " + title);
									actorAllCastings.get(i/5).setTitle(title);
									break;
								// 출연 작품 Date
								case(1):
									String date = roles.get(i).text();
								
									SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd");
									Date stDate = null, edDate = null;
									try {
										// 예외 처리
										if(roles.get(i).text().trim().split("~")[1].equals(" 오픈런")) {
											stDate = formatter.parse(roles.get(i).text().trim().split(" ~ ")[0]);
											edDate = new Date(); // 현재 시각으로 대체											
										}else {
											stDate = formatter.parse(roles.get(i).text().trim().split("~")[0]);
											edDate = formatter.parse(roles.get(i).text().trim().split("~")[1]);
											
										}
									} catch (ParseException e) {
										e.printStackTrace();
									}
									
									actorAllCastings.get(i/5).setStDate(stDate);
									actorAllCastings.get(i/5).setEdDate(edDate);
									break;
								// 출연 작품 장소
								case(2):
									String place = roles.get(i).text();
									actorAllCastings.get(i/5).setPlace(place);
									break;
								// 출연 작품 Role
								case(3):
									String role = roles.get(i).text();
									actorAllCastings.get(i/5).setRole(role);
									break;
								// 여백 처리
								case(4):
									String blank = roles.get(i).text();
									break;								
							} // switch
							
						} // for
						
						// 가져올 정보
//						배우 ID : contentactorNo
//						배우 이미지 주소 : actorImage
//						배우 이름 : actorName.split(" ")[0]
//						출연 작품 정보 : actorCastings
						
						// Casting에서 뮤지컬만 골라내기
						// "역" Casting 객체 생성
						ArrayList<Actor.Casting> actorCastings = new ArrayList<Actor.Casting>();
						for(Actor.Casting c : actorAllCastings) {
							if(c.getRole().endsWith("역")) {
								actorCastings.add(c);
							}
						}
						
						// Actor 객체 생성
						Actor actor = Actor.builder()
											._id(contentactorNo)
											.name(actorName.split(" ")[0])
											.profileImage(actorImage)
											.castings(actorCastings.toArray(Actor.Casting[]::new))
											.build();
						
						// 배우DB에 저장
						System.out.println(actorRepository.save(actor));
					}
				}
			}
				
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
}
