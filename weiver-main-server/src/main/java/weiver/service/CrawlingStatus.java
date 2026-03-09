package weiver.service;

import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
public class CrawlingStatus {
    private volatile boolean running = false;
    private String crawlingType = "-";
    private String currentGenre = "-";
    private int genreIndex = 0;
    private int genreTotal = 0;
    private LocalDateTime startedAt;
    private LocalDateTime finishedAt;
    private long lastDurationSeconds;

    public boolean isRunning() { return running; }
    public void setRunning(boolean running) { this.running = running; }

    public String getCrawlingType() { return crawlingType; }
    public void setCrawlingType(String crawlingType) { this.crawlingType = crawlingType; }

    public String getCurrentGenre() { return currentGenre; }
    public void setCurrentGenre(String currentGenre) { this.currentGenre = currentGenre; }

    public int getGenreIndex() { return genreIndex; }
    public void setGenreIndex(int genreIndex) { this.genreIndex = genreIndex; }

    public int getGenreTotal() { return genreTotal; }
    public void setGenreTotal(int genreTotal) { this.genreTotal = genreTotal; }

    public LocalDateTime getStartedAt() { return startedAt; }
    public void setStartedAt(LocalDateTime startedAt) { this.startedAt = startedAt; }

    public LocalDateTime getFinishedAt() { return finishedAt; }
    public void setFinishedAt(LocalDateTime finishedAt) { this.finishedAt = finishedAt; }

    public long getLastDurationSeconds() { return lastDurationSeconds; }
    public void setLastDurationSeconds(long lastDurationSeconds) { this.lastDurationSeconds = lastDurationSeconds; }
}
