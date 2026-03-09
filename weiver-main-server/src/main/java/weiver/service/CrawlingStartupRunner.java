package weiver.service;

import lombok.RequiredArgsConstructor;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Component;

@Component
@ConditionalOnProperty(name = "crawling.startup.enabled", havingValue = "true")
@RequiredArgsConstructor
public class CrawlingStartupRunner implements ApplicationRunner {
    private final CrawlingService crawlingService;

    @Override
    public void run(ApplicationArguments args) {
        crawlingService.task();
    }
}
