package com.ynyes.huizi;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.MultipartConfigElement;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.embedded.MultipartConfigFactory;
import org.springframework.boot.context.web.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.filter.CharacterEncodingFilter;

import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdUserService;





@Configuration
@ComponentScan
@EnableAutoConfiguration
public class Application extends SpringBootServletInitializer implements CommandLineRunner {
    @Autowired
    private TdUserService tdUserService;
    
    @Autowired
    private TdCommonService tdCommonService;
    
	@Bean
	public CharacterEncodingFilter encodingFilter() {
		CharacterEncodingFilter filter = new CharacterEncodingFilter();
		filter.setEncoding("UTF-8");
		filter.setForceEncoding(true);
		return filter;
	}

	@Bean
    MultipartConfigElement multipartConfigElement() {
        MultipartConfigFactory factory = new MultipartConfigFactory();
        factory.setMaxFileSize("10MB");
        factory.setMaxRequestSize("10MB");
        return factory.createMultipartConfig();
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
    
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        // Customize the application or call application.sources(...) to add sources
        // Since our example is itself a @Configuration class we actually don't
        // need to override this method.
        return application;
    }

	@Override
	public void run(String... args) throws Exception {
	    // 定时器
	    Timer timer = new Timer();
	    
	    // 定时任务
	    TimerTask task = new TimerTask() {
            @Override
            public void run() {
            	//清楚计数器
//            	TdUserService tdUserService = new TdUserService();
                tdUserService.resetCount();
                //删除无效购物车商品和对比商品
//                TdCommonService tdCommonService = new TdCommonService();
                tdCommonService.deletecartgoods();
                tdCommonService.deletecontrastgoods();
            }
        };
        
        Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH);
        int day = calendar.get(Calendar.DAY_OF_MONTH);
        calendar.set(year, month, day, 3, 0, 0);
        Date date = calendar.getTime();
        
        timer.schedule(task, date, 1000 * 60 * 60 * 24);

	}
}