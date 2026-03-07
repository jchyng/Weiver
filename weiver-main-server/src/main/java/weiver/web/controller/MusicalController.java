package weiver.web.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import weiver.web.dto.PerformingMusical;
import weiver.web.dto.PoPularMusicalDTO;
import weiver.web.dto.ResponseCastingDTO;
import weiver.web.dto.SimpleMusicalDTO;
import weiver.domain.entity.Actor;
import weiver.domain.entity.Musical;
import weiver.domain.entity.Post;
import weiver.domain.entity.Subscribe;
import weiver.service.*;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
public class MusicalController {
    private final MusicalService musicalService;
    private final ActorService actorService;
    private final CommunityService communityService;
	private final SubscribeService subscribeService;
    
    @GetMapping("/main")
    public String getMainPage(Model model){
        List<PoPularMusicalDTO> poPularMusicalDTOs = musicalService.getLikedMusical();
        List<PerformingMusical> performingMusicals = musicalService.getPerformingMusical();
        
        //인기 게시글 리스트 가져오기.
		List<Post> bestPostList = communityService.getBestPostDesc();

		//댓글 개수 가져오기
		model.addAttribute("bestPost", bestPostList);

        // 오늘의 배우 뮤지컬 정보.
        try {
            Actor randomActor = actorService.getRandomActor();
            if (randomActor != null) {
                List<PerformingMusical> musicalList = actorService.getMusicalListByActorId(randomActor.getId());
                if (musicalList != null) {
                    List<PerformingMusical> limitedMusicalList = musicalList.subList(0, Math.min(musicalList.size(), 8));
                    model.addAttribute("limitedMusicalList", limitedMusicalList);
                }
                model.addAttribute("randomActor", randomActor);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }


		//인기 뮤지컬 추가
        model.addAttribute("popularMusicals", poPularMusicalDTOs);
        //공연 중인 뮤지컬 추가
        model.addAttribute("performingMusicals", performingMusicals);
        
        return "main";
    }
    
    @GetMapping("/musical-detail/{id}")
    public String getMusicalDetail(@PathVariable String id, Model model, HttpSession session){
    Optional<Musical> musical =  musicalService.getMusicalById(id);

    if(musical.isPresent()) {
    model.addAttribute("musical", musical.get());
    List<ResponseCastingDTO> castingList = actorService.getCastingByMusicalId(musical.get().getId());

            if (castingList != null) {
                List<ResponseCastingDTO> limitedCastingList = castingList.subList(0, Math.min(castingList.size(), 10));
                model.addAttribute("castingList", limitedCastingList);
            }

            // Youtube API 가져오기
            try {
                String title = musical.get().getTitle();
                // 제목에서 괄호 및 특수문자 제거하여 검색 정확도 향상
                String searchQuery = title.replaceAll("\\(.*?\\)", "").trim();
                // 제목이 이미 "뮤지컬"로 시작하지 않는 경우에만 접두어 추가
                if (!searchQuery.startsWith("뮤지컬")) {
                    searchQuery = "뮤지컬 " + searchQuery;
                }
                List<String> clips = GoogleAPIService.search(searchQuery);
                model.addAttribute("clips", clips);

            } catch (Exception e) {
                // YouTube API 실패 시에도 페이지는 정상 로드
                e.printStackTrace();
                model.addAttribute("clips", new java.util.ArrayList<String>());
            }
    } else {
            return "redirect:/main";
        }

    if(session.getAttribute("userId") != null) {
    Subscribe subscribeJjim = subscribeService.getSubscribe(session.getAttribute("userId").toString(), id, "찜했어요");
    model.addAttribute("subscribeJjim", subscribeJjim);
    Subscribe subscribeWatched = subscribeService.getSubscribe(session.getAttribute("userId").toString(), id, "봤어요");
    model.addAttribute("subscribeWatched", subscribeWatched);
    }

    return "musicalDetail";
    }
    
    @GetMapping("/musical-search")
    public String getMusicalSearch(@RequestParam(required = false) String keyword, Model model){
		if(keyword != null) {
			List<SimpleMusicalDTO> musicals = musicalService.getMusicalByKeyword(keyword);
			model.addAttribute("musicals", musicals);
		}

		return "musicalSearch";
    }
    
}
