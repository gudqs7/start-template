package cn.gudqs;

import cn.gudqs.system.exception.ThreadExceptionHandler;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * @author wq
 */
@SpringBootApplication(scanBasePackages = {"cn.gudqs.*",})
@MapperScan({"cn.gudqs.**.mapper.**"})
@EnableScheduling
public class MainApplication {

	public static void main(String[] args) {
		Thread.setDefaultUncaughtExceptionHandler(threadExceptionHandler());
		SpringApplication.run(MainApplication.class, args);
	}

	private static ThreadExceptionHandler threadExceptionHandler() {
		return new ThreadExceptionHandler();
	}
}
