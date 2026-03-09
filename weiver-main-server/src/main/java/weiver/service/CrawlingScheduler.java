package weiver.service;

import lombok.RequiredArgsConstructor;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
@ConditionalOnProperty(name = "crawling.schedule.enabled", havingValue = "true")
@RequiredArgsConstructor
public class CrawlingScheduler {
    private final CrawlingService crawlingService;

    @Scheduled(initialDelay = 60480000, fixedDelay = 60480000) // 7일 후 첫 실행, 이후 7일마다
    public void executeTask() {
        crawlingService.task();
    }
}
