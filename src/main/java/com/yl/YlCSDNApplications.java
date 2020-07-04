package com.yl;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * @author kuiburen
 * @date 2020/7/3 22:06
 * @desc
 */
@SpringBootApplication(scanBasePackages = "com.yl")
@EnableScheduling
public class YlCSDNApplications {

    public static void main(String[] args){
        SpringApplication.run(YlCSDNApplications.class,args);
        System.out.println("yl System Start ....");
    }
}
