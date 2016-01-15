package com.ynyes.huizi.controller.app;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/")
public class TdAppDownloadController {
	 // app启动页
    @RequestMapping(value="app/download")
    public String getStartImg(ModelMap map,
			  				  HttpServletRequest req){
    	
        return "/client/app_download";
    }
}
