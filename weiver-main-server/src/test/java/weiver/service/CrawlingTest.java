package weiver.service;

import weiver.constant.Sub_category;
import weiver.constant.URLs;
import weiver.domain.entity.Actor;
import weiver.domain.entity.Musical;
import weiver.domain.repository.ActorRepository;
import weiver.domain.repository.CastingRepository;
import weiver.domain.repository.MusicalRepository;
import weiver.web.dto.ActorsByRoleDto;
import lombok.SneakyThrows;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.List;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;

public class CrawlingTest {

    @Mock private MusicalRepository musicalRepository;
    @Mock private ActorRepository actorRepository;
    @Mock private CastingRepository castingRepository;
    @Mock private CrawlingStatus crawlingStatus;

    @InjectMocks
    private CrawlingService crawlingService;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void 뮤지컬_페이지_정보가져오기() {
        int maxPage = crawlingService.setMaxPage(Sub_category.ORIGINAL, Sub_category.LATER);

        assertThat(maxPage).isGreaterThan(0);
    }

    @Test
    public void 뮤지컬_아이디_가져오기() {
        List<String> ids = crawlingService.setMusicalIds(Sub_category.ORIGINAL, Sub_category.ALL, 3);

        assertThat("186763").isIn(ids);
    }

    @SneakyThrows
    @Test
    public void 뮤지컬정보_가져오기() {
        String url = URLs.MUSICAL_DETAIL_URL + 188550;
        Document doc = Jsoup.connect(url).timeout(30000).get();
        Musical musical = crawlingService.getMusical(doc, "188550");

        assertThat(musical.getTitle()).isEqualTo("멤피스");
    }

    @SneakyThrows
    @Test
    public void 배우정보가_가져오기() {
        String url = URLs.MUSICAL_DETAIL_URL + 188550;

        Document doc = Jsoup.connect(url).timeout(30000).get();
        List<ActorsByRoleDto> actors = crawlingService.getActors(doc);

        Actor actor = actors.get(0).getActor().get(0);
        System.out.println(actor);

        assertThat(actor.getName()).isEqualTo("박강현");
    }
}
