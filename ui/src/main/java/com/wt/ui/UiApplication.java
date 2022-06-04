package com.wt.ui;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.ApplicationPidFileWriter;

@SpringBootApplication
public class UiApplication {

    public static void main(String[] args) {
        SpringApplication application = new SpringApplication(UiApplication.class);
        application.addListeners(new ApplicationPidFileWriter());
        application.run(args);
    }

}
