package weiver;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class WeiverApplication {

	public static void main(String[] args) {
		SpringApplication.run(WeiverApplication.class, args);
	}

}
