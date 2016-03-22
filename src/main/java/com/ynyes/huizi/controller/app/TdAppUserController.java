package com.ynyes.huizi.controller.app;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ynyes.huizi.entity.TdAdType;
import com.ynyes.huizi.entity.TdSetting;
import com.ynyes.huizi.entity.TdUser;
import com.ynyes.huizi.service.TdUserService;
import com.ynyes.huizi.util.SiteMagConstant;

@Controller
public class TdAppUserController {
	@Autowired
	TdUserService tdUserService;
	
	String ImageRoot = SiteMagConstant.imagePath;
	
	/**
	 * @author lc
	 * @注释：头像更换接口 图片接收
	 */
	 @RequestMapping(value = "/app/changeHeadUrl", method = RequestMethod.POST)
	 @ResponseBody
	    public Map<String, Object> uploadclient(String action, String username,
	            @RequestParam MultipartFile Filedata, HttpServletRequest req) {
	        Map<String, Object> res = new HashMap<String, Object>();
	        res.put("status", 1);
	       
	        if (null == username) {
	            res.put("msg", "用户名不存在");
	            return res;
	        }

	        if (null == Filedata || Filedata.isEmpty()) {
	            res.put("msg", "图片不存在");
	            return res;
	        }

	        String name = Filedata.getOriginalFilename();
//	        String contentType = Filedata.getContentType();

	        String ext = name.substring(name.lastIndexOf("."));

	        try {
	            byte[] bytes = Filedata.getBytes();

	            Date dt = new Date(System.currentTimeMillis());
	            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	            String fileName = sdf.format(dt) + ext;

	            String uri = ImageRoot + "/" + fileName;

	            File file = new File(uri);

	            BufferedOutputStream stream = new BufferedOutputStream(
	                    new FileOutputStream(file));
	            stream.write(bytes);
	            stream.close();

	            TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);
		        
	            if (null != tdUser) {
	            	tdUser.setHeadImageUri("/images/" + fileName);
			        
			        tdUserService.save(tdUser);
				}
		        	            
	            res.put("status", 0);
	            res.put("msg", "上传文件成功！");
	            res.put("path", "/images/" + fileName);
	            res.put("thumb", "/images/" + fileName);
	            res.put("name", name);
	            res.put("size", Filedata.getSize());
	            res.put("ext", ext.substring(1));

	        } catch (Exception e) {
	            res.put("status", 1);
	            res.put("msg", "上传文件失败！");
	        }

	        return res;

	  }
	
	 
	 /**
	 * @author lc
	 * @注释：头像更换
	 */
	// app引导页
	 @RequestMapping(value="app/updateHeadUrl", method = RequestMethod.GET)
	 @ResponseBody
	    public Map<String, Object> getGuideImg(ModelMap map,String username, String headImgUrl,
				  								HttpServletRequest req){
	    	Map<String, Object> res = new HashMap<String, Object>();
	        
	        res.put("status", 1);
	        
	        if (null == username || null == headImgUrl ) {
				res.put("msg", "用户名或头像地址为空");
				return res;
			}
	        
	        TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);
	        
	        tdUser.setHeadImageUri(headImgUrl);
	        
	        tdUserService.save(tdUser);
	        
	        res.put("status", 0);
	        
	        return res;
	    }
}
