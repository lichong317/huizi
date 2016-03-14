package com.ynyes.huizi.touch;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdMessageService;
import com.ynyes.huizi.util.ClientConstant;

@Controller
public class TdTouchMessageController {
	@Autowired
	TdMessageService tdMessageService;
	
	@Autowired
	TdCommonService tdCommonService;
	
	@RequestMapping("/touch/message/list")
	public String messageList( Long typeId, 
            Integer page, 
            ModelMap map,
            HttpServletRequest req){

		tdCommonService.setHeader(map, req);
		
		String username = (String) req.getSession().getAttribute("username");
		
		if (null == username)
        {
            return "redirect:/touch/login";
        }
		
		if (null == typeId)
		{
			typeId = 0L;
		}
		
		if (null == page) {
			page = 0;
		}
		
		// 公告数量和 系统消息数量
		map.addAttribute("count_announcement", tdMessageService.countBytypeId(0L));
		map.addAttribute("count_system", tdMessageService.countBytypeId(1L));
		
		map.addAttribute("message_page", tdMessageService.findByTypeId(typeId, page, ClientConstant.pageSize));
		
		map.addAttribute("pageId", page);
		map.addAttribute("typeId", typeId);
		
		return "/touch/message_list";
	}
	
	
	@RequestMapping("/touch/message/edit")
	public String messageedit( Long messageId, 
            ModelMap map,
            HttpServletRequest req){

		tdCommonService.setHeader(map, req);
		
		String username = (String) req.getSession().getAttribute("username");
		
		if (null == username)
        {
            return "redirect:/touch/login";
        }

		if (null == messageId) {
			return "/touch/error_404";
		}
		
		map.addAttribute("tdMessage", tdMessageService.findOne(messageId));
		
		return "/touch/message_edit";
	}
}
