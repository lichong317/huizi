package com.ynyes.huizi.controller.management;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ynyes.huizi.entity.TdCoupon;
import com.ynyes.huizi.entity.TdCouponType;
import com.ynyes.huizi.entity.TdGoods;
import com.ynyes.huizi.entity.TdOrder;
import com.ynyes.huizi.entity.TdPrize;
import com.ynyes.huizi.entity.TdPrizeCategory;
import com.ynyes.huizi.entity.TdRedEnvelope;
import com.ynyes.huizi.entity.TdRedEnvelopeType;
import com.ynyes.huizi.entity.TdSetting;
import com.ynyes.huizi.entity.TdUser;
import com.ynyes.huizi.entity.TdUserComment;
import com.ynyes.huizi.entity.TdUserComplain;
import com.ynyes.huizi.entity.TdUserConsult;
import com.ynyes.huizi.entity.TdUserLevel;
import com.ynyes.huizi.entity.TdUserPoint;
import com.ynyes.huizi.entity.TdUserReturn;
import com.ynyes.huizi.entity.TdUserWithdraw;
import com.ynyes.huizi.service.TdCouponService;
import com.ynyes.huizi.service.TdCouponTypeService;
import com.ynyes.huizi.service.TdGoodsService;
import com.ynyes.huizi.service.TdManagerLogService;
import com.ynyes.huizi.service.TdOrderService;
import com.ynyes.huizi.service.TdPrizeCategoryService;
import com.ynyes.huizi.service.TdPrizeService;
import com.ynyes.huizi.service.TdRedEnvelopeService;
import com.ynyes.huizi.service.TdRedEnvelopeTypeService;
import com.ynyes.huizi.service.TdSettingService;
import com.ynyes.huizi.service.TdUserCashRewardService;
import com.ynyes.huizi.service.TdUserCollectService;
import com.ynyes.huizi.service.TdUserCommentService;
import com.ynyes.huizi.service.TdUserComplainService;
import com.ynyes.huizi.service.TdUserConsultService;
import com.ynyes.huizi.service.TdUserLevelService;
import com.ynyes.huizi.service.TdUserPointService;
import com.ynyes.huizi.service.TdUserRecentVisitService;
import com.ynyes.huizi.service.TdUserReturnService;
import com.ynyes.huizi.service.TdUserService;
import com.ynyes.huizi.service.TdUserWithdrawService;
import com.ynyes.huizi.util.ClientConstant;
import com.ynyes.huizi.util.SiteMagConstant;

/**
 * 后台用户管理控制器
 * 
 * @author Sharon
 */

@Controller
@RequestMapping(value = "/Verwalter/user")
public class TdManagerUserController {

	@Autowired
	TdUserService tdUserService;

	@Autowired
	TdUserLevelService tdUserLevelService;

	@Autowired
	TdUserConsultService tdUserConsultService;

	@Autowired
	TdUserCommentService tdUserCommentService;

	@Autowired
	TdUserComplainService tdUserComplainService;

	@Autowired
	TdUserReturnService tdUserReturnService;

	@Autowired
	TdUserCollectService tdUserCollectService;

	@Autowired
	TdUserPointService tdUserPointService;

	@Autowired
	TdUserRecentVisitService tdUserRecentVisitService;

	@Autowired
	TdUserCashRewardService tdUserCashRewardService;

	@Autowired
	TdManagerLogService tdManagerLogService;

	@Autowired
	TdRedEnvelopeService tdRedEnvelopeService;

	@Autowired
	TdRedEnvelopeTypeService tdRedEnvelopeTypeService;

	@Autowired
	TdCouponTypeService tdCouponTypeService;

	@Autowired
	TdUserWithdrawService tdUserWithdrawService;

	@Autowired
	TdPrizeCategoryService tdPrizeCategoryService;

	@Autowired
	TdOrderService tdOrderService; // zhangji

	@Autowired
	TdCouponService tdCouponService;

	@Autowired
	TdPrizeService tdPrizeService;

	@Autowired
	TdGoodsService tdGoodsService;

	@Autowired
	TdSettingService tdSettingService;

	@RequestMapping(value = "/check", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> validateForm(String param, Long id) {
		Map<String, String> res = new HashMap<String, String>();

		res.put("status", "n");

		if (null == param || param.isEmpty()) {
			res.put("info", "该字段不能为空");
			return res;
		}

		if (null == id) {
			if (null != tdUserService.findByUsername(param)) {
				res.put("info", "已存在同名用户");
				return res;
			}
		} else {
			if (null != tdUserService.findByUsernameAndIdNot(param, id)) {
				res.put("info", "已存在同名用户");
				return res;
			}
		}

		res.put("status", "y");

		return res;
	}

	@RequestMapping(value = "/withdraw/list")
	public String withdrawList(Integer page, Integer size, String __EVENTTARGET, String __EVENTARGUMENT,
			String __VIEWSTATE, Long[] listId, Integer[] listChkId, HttpServletRequest req, ModelMap map) {
		String username = (String) req.getSession().getAttribute("manager");
		if (null == username) {
			return "redirect:/Verwalter/login";
		}

		if (null != __EVENTTARGET) {
			if (__EVENTTARGET.equalsIgnoreCase("btnPage")) {
				if (null != __EVENTARGUMENT) {
					page = Integer.parseInt(__EVENTARGUMENT);
				}
			} else if (__EVENTTARGET.equalsIgnoreCase("btnDelete")) {
				btnDelete("withdraw", listId, listChkId);
				tdManagerLogService.addLog("delete", "删除提现记录", req);
			}
		}

		if (null == page || page < 0) {
			page = 0;
		}

		if (null == size || size <= 0) {
			size = SiteMagConstant.pageSize;
			;
		}

		map.addAttribute("withdraw_page", tdUserWithdrawService.findAllOrderByIdDesc(page, ClientConstant.pageSize));

		return "/site_mag/user_withdraw_list";
	}

	@RequestMapping(value = "/withdraw/edit")
	public String withdrawEdit(Long id, String __VIEWSTATE, ModelMap map, HttpServletRequest req) {
		String username = (String) req.getSession().getAttribute("manager");
		if (null == username) {
			return "redirect:/Verwalter/login";
		}

		if (null != id) {
			map.addAttribute("userWithdrawId", id);
			map.addAttribute("user_withdraw", tdUserWithdrawService.findOne(id));

			TdUserWithdraw tdUserWithdraw = tdUserWithdrawService.findOne(id);
			if (null != tdUserWithdraw) {
				if (null != tdUserWithdraw.getUsername()) {
					map.addAttribute("user", tdUserService.findByUsernameAndIsEnabled(tdUserWithdraw.getUsername()));
				}
			}
		}

		map.addAttribute("__VIEWSTATE", __VIEWSTATE);

		return "/site_mag/user_withdraw_edit";
	}

	@RequestMapping(value = "/withdraw/save")
	public String withdrawSave(TdUserWithdraw tdUserWithdraw, String __VIEWSTATE, ModelMap map,
			HttpServletRequest req) {
		String username = (String) req.getSession().getAttribute("manager");
		if (null == username) {
			return "redirect:/Verwalter/login";
		}

		map.addAttribute("__VIEWSTATE", __VIEWSTATE);

		if (null == tdUserWithdraw.getId()) {
			tdManagerLogService.addLog("add", "修改用户提现", req);
		} else {
			tdManagerLogService.addLog("edit", "修改用户提现", req);
		}

		// 提现
		if (null != tdUserWithdraw.getStatusId() && tdUserWithdraw.getStatusId().equals(1L)) {
			TdUser tdUser = tdUserService.findByUsername(tdUserWithdraw.getUsername());

			if (null != tdUser.getRoleId()) {
				if (tdUser.getRoleId().equals(1L)) {
					if (null != tdUser.getTotalCashRewards()) {
						if ((long) (tdUser.getTotalCashRewards() - tdUserWithdraw.getTotalWithdraw()) < 0) {
							tdUser.setTotalCashRewards(0.00);
						} else {
							tdUser.setTotalCashRewards(
									(tdUser.getTotalCashRewards() - tdUserWithdraw.getTotalWithdraw()));
						}
						tdUserService.save(tdUser);
					}
				} else if (tdUser.getRoleId().equals(2L)) {
					if (null != tdUser.getVirtualCurrency()) {
						if (tdUser.getVirtualCurrency() - tdUserWithdraw.getTotalWithdraw() < 0) {
							tdUser.setVirtualCurrency(0.0);
						} else {
							tdUser.setVirtualCurrency(tdUser.getVirtualCurrency() - tdUserWithdraw.getTotalWithdraw());
						}
						tdUserService.save(tdUser);
					}
				} else if (tdUser.getRoleId().equals(3L)) {
					if (null != tdUser.getDirectSaleCashRewards()) {
						if (tdUser.getDirectSaleCashRewards() - tdUserWithdraw.getTotalWithdraw() < 0) {
							tdUser.setDirectSaleCashRewards(0.0);
						} else {
							tdUser.setDirectSaleCashRewards(
									tdUser.getDirectSaleCashRewards() - tdUserWithdraw.getTotalWithdraw());
						}
						tdUserService.save(tdUser);
					}
				}
			}

		}

		tdUserWithdrawService.save(tdUserWithdraw);

		return "redirect:/Verwalter/user/withdraw/list";
	}

	@RequestMapping(value = "/list")
	public String setting(Integer page, Integer size, String keywords, Long roleId, Long userLevelId,
			String exportAllUrl, String __EVENTTARGET, String __EVENTARGUMENT, String __VIEWSTATE, Long[] listId,
			Integer[] listChkId, ModelMap map, HttpServletRequest req, HttpServletResponse resp) {
		String username = (String) req.getSession().getAttribute("manager");
		if (null == username) {
			return "redirect:/Verwalter/login";
		}
		if (null != __EVENTTARGET) {
			if (__EVENTTARGET.equalsIgnoreCase("btnPage")) {
				if (null != __EVENTARGUMENT) {
					page = Integer.parseInt(__EVENTARGUMENT);
				}
			} else if (__EVENTTARGET.equalsIgnoreCase("btnDelete")) {
				btnDelete("user", listId, listChkId);
				tdManagerLogService.addLog("delete", "删除用户", req);
			} else if (__EVENTTARGET.equalsIgnoreCase("exportAll")) {
				exportAllUrl = SiteMagConstant.backupPath;
				tdManagerLogService.addLog("exportAll", "导出全部注册用户记录", req);
			}
		}

		if (null == page || page < 0) {
			page = 0;
		}

		if (null == size || size <= 0) {
			size = SiteMagConstant.pageSize;
			;
		}

		if (null != keywords) {
			keywords = keywords.trim();
		}

		map.addAttribute("page", page);
		map.addAttribute("size", size);
		map.addAttribute("keywords", keywords);
		map.addAttribute("roleId", roleId);
		map.addAttribute("userLevelId", userLevelId);
		map.addAttribute("__EVENTTARGET", __EVENTTARGET);
		map.addAttribute("__EVENTARGUMENT", __EVENTARGUMENT);
		map.addAttribute("__VIEWSTATE", __VIEWSTATE);

		if (null != exportAllUrl) {// 导出全部
			/**
			 * @author lc
			 * @注释：根据不同条件导出excel文件
			 */
			// 第一步，创建一个webbook，对应一个Excel文件
			HSSFWorkbook wb = new HSSFWorkbook();
			// 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
			HSSFSheet sheet = wb.createSheet("participant");
			// 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
			HSSFRow row = sheet.createRow((int) 0);
			// 第四步，创建单元格，并设置值表头 设置表头居中
			HSSFCellStyle style = wb.createCellStyle();
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式

			HSSFCell cell = row.createCell((short) 0);
			cell.setCellValue("用户名");
			cell.setCellStyle(style);
			cell = row.createCell((short) 1);
			cell.setCellValue("支付宝登录名");
			cell.setCellStyle(style);
			cell = row.createCell((short) 2);
			cell.setCellValue("qq登录名");
			cell.setCellStyle(style);
			cell = row.createCell((short) 3);
			cell.setCellValue("昵称");
			cell.setCellStyle(style);
			cell = row.createCell((short) 4);
			cell.setCellValue("真实姓名");
			cell.setCellStyle(style);
			cell = row.createCell((short) 5);
			cell.setCellValue("性别");
			cell.setCellStyle(style);
			cell = row.createCell((short) 6);
			cell.setCellValue("生日");
			cell.setCellStyle(style);
			cell = row.createCell((short) 7);
			cell.setCellValue("注册时间");
			cell.setCellStyle(style);
			cell = row.createCell((short) 8);
			cell.setCellValue("最后登录时间");
			cell.setCellStyle(style);
			cell = row.createCell((short) 9);
			cell.setCellValue("上次抢拍时间");
			cell.setCellStyle(style);
			cell = row.createCell((short) 10);
			cell.setCellValue("身份证");
			cell.setCellStyle(style);
			cell = row.createCell((short) 11);
			cell.setCellValue("手机号");
			cell.setCellStyle(style);
			cell = row.createCell((short) 12);
			cell.setCellValue("邮箱");
			cell.setCellStyle(style);
			cell = row.createCell((short) 13);
			cell.setCellValue("详细地址");
			cell.setCellStyle(style);
			cell = row.createCell((short) 14);
			cell.setCellValue("用户等级");
			cell.setCellStyle(style);
			cell = row.createCell((short) 15);
			cell.setCellValue("收藏商品总数");
			cell.setCellStyle(style);
			cell = row.createCell((short) 16);
			cell.setCellValue("积分总额");
			cell.setCellStyle(style);
			cell = row.createCell((short) 17);
			cell.setCellValue("评论总数");
			cell.setCellStyle(style);
			cell = row.createCell((short) 18);
			cell.setCellValue("用户类型");
			cell.setCellStyle(style);
			cell = row.createCell((short) 19);
			cell.setCellValue("上级用户");
			cell.setCellStyle(style);
			cell = row.createCell((short) 20);
			cell.setCellValue("下级用户总数");
			cell.setCellStyle(style);
			cell = row.createCell((short) 21);
			cell.setCellValue("返现总数");
			cell.setCellStyle(style);
			cell = row.createCell((short) 22);
			cell.setCellValue("冻结金额");
			cell.setCellStyle(style);
			cell = row.createCell((short) 23);
			cell.setCellValue("返现给上级用户金额");
			cell.setCellStyle(style);
			cell = row.createCell((short) 24);
			cell.setCellValue("银行卡号");
			cell.setCellStyle(style);
			cell = row.createCell((short) 25);
			cell.setCellValue("银行");
			cell.setCellStyle(style);
			cell = row.createCell((short) 26);
			cell.setCellValue("分销返利比例");
			cell.setCellStyle(style);
			cell = row.createCell((short) 27);
			cell.setCellValue("虚拟货币");
			cell.setCellStyle(style);
			cell = row.createCell((short) 28);
			cell.setCellValue("虚拟货币冻结金额");
			cell.setCellStyle(style);

			List<TdUser> tdUsers = tdUserService.findAllStatus();
			if (ImportAlluserData(tdUsers, row, cell, sheet)) {
				downloaduser(wb, exportAllUrl, resp);
			}
		}

		// 等级list
		map.addAttribute("userLevelId_list", tdUserLevelService.findIsEnableTrue());

		// 红包类别
		map.addAttribute("redEnvelopetype_list", tdRedEnvelopeTypeService.findAllOrderBySortId());

		// 奖项类别
		map.addAttribute("prizetype_list", tdPrizeCategoryService.findAllOrderBySortId());

		Page<TdUser> userPage = null;

		if (null == roleId) {
			if (null == keywords || "".equalsIgnoreCase(keywords)) {
				if (null == userLevelId) {
					userPage = tdUserService.findAllOrderByIdDesc(page, size);
				} else {
					userPage = tdUserService.findByUserLevelIdOrderByIdDesc(userLevelId, page, size);
				}
			} else {
				if (null == userLevelId) {
					userPage = tdUserService.searchAndOrderByIdDesc(keywords, page, size);
				} else {
					userPage = tdUserService.searchAndfindByUserLevelIdOrderByIdDesc(keywords, userLevelId, page, size);
				}
			}
		} else {
			if (null == keywords || "".equalsIgnoreCase(keywords)) {
				if (null == userLevelId) {
					userPage = tdUserService.findByRoleIdOrderByIdDesc(roleId, page, size);
				} else {
					userPage = tdUserService.findByRoleIdAndUserLevelIdOrderByIdDesc(roleId, userLevelId, page, size);
				}
			} else {
				if (null == userLevelId) {
					userPage = tdUserService.searchAndFindByRoleIdOrderByIdDesc(keywords, roleId, page, size);
				} else {
					userPage = tdUserService.searchAndFindByRoleIdAndUserLevelIdOrderByIdDesc(keywords, roleId,
							userLevelId, page, size);
				}
			}
		}

		map.addAttribute("user_page", userPage);

		return "/site_mag/user_list";
	}

	/**
	 * @author lc
	 * @注释：将list中的数据存入excel表格中
	 */
	@SuppressWarnings("deprecation")
	public boolean ImportAlluserData(List<TdUser> tdUsers, HSSFRow row, HSSFCell cell, HSSFSheet sheet) {

		for (int i = 0; i < tdUsers.size(); i++) {

			row = sheet.createRow((int) i + 1);
			TdUser tdUser = tdUsers.get(i);

			// 第四步，创建单元格，并设置值
			if (null != tdUser.getUsername()) {
				row.createCell((short) 0).setCellValue(tdUser.getUsername());
			}

			if (null != tdUser.getAlipayUserId()) {
				row.createCell((short) 1).setCellValue(tdUser.getAlipayUserId());
			}

			if (null != tdUser.getQqUserId()) {
				row.createCell((short) 2).setCellValue(tdUser.getQqUserId());
			}

			if (null != tdUser.getNickname()) {
				row.createCell((short) 3).setCellValue(tdUser.getQqUserId());
			}

			if (null != tdUser.getRealName()) {
				row.createCell((short) 4).setCellValue(tdUser.getRealName());
			}

			if (null != tdUser.getSex()) {
				row.createCell((short) 5).setCellValue(tdUser.getSex());
			}

			if (null != tdUser.getBirthday()) {
				cell = row.createCell((short) 6);
				cell.setCellValue(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(tdUser.getBirthday()));
			}

			if (null != tdUser.getRegisterTime()) {
				cell = row.createCell((short) 7);
				cell.setCellValue(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(tdUser.getRegisterTime()));
			}

			if (null != tdUser.getLastLoginTime()) {
				cell = row.createCell((short) 8);
				cell.setCellValue(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(tdUser.getLastLoginTime()));
			}

			if (null != tdUser.getLastFlashBuyTime()) {
				cell = row.createCell((short) 9);
				cell.setCellValue(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(tdUser.getLastFlashBuyTime()));
			}

			if (null != tdUser.getIdentity()) {
				row.createCell((short) 10).setCellValue(tdUser.getIdentity());
			}

			if (null != tdUser.getMobile()) {
				row.createCell((short) 11).setCellValue(tdUser.getMobile());
			}

			if (null != tdUser.getEmail()) {
				row.createCell((short) 12).setCellValue(tdUser.getEmail());
			}

			if (null != tdUser.getDetailAddress()) {
				row.createCell((short) 13).setCellValue(tdUser.getDetailAddress());
			}

			if (null != tdUser.getUserLevelTitle()) {
				row.createCell((short) 14).setCellValue(tdUser.getUserLevelTitle());
			}

			if (null != tdUser.getTotalCollectedGoods()) {
				row.createCell((short) 15).setCellValue(tdUser.getTotalCollectedGoods());
			}

			if (null != tdUser.getTotalPoints()) {
				row.createCell((short) 16).setCellValue(tdUser.getTotalPoints());
			}

			if (null != tdUser.getTotalComments()) {
				row.createCell((short) 17).setCellValue(tdUser.getTotalComments());
			}

			if (null != tdUser.getRoleId()) {
				if (tdUser.getRoleId().equals(0L)) {
					row.createCell((short) 18).setCellValue("普通用户");
				} else if (tdUser.getRoleId().equals(1L)) {
					row.createCell((short) 18).setCellValue("分销商用户");
				} else if (tdUser.getRoleId().equals(2L)) {
					row.createCell((short) 18).setCellValue("商城用户");
				}
			}

			if (null != tdUser.getUpperUsername()) {
				row.createCell((short) 19).setCellValue(tdUser.getUpperUsername());
			}

			if (null != tdUser.getTotalLowerUsers()) {
				row.createCell((short) 20).setCellValue(tdUser.getTotalLowerUsers());
			}

			if (null != tdUser.getTotalCashRewards()) {
				row.createCell((short) 21).setCellValue(tdUser.getTotalCashRewards());
			}

			if (null != tdUser.getCashRewardsFrozen()) {
				row.createCell((short) 22).setCellValue(tdUser.getCashRewardsFrozen());
			}

			if (null != tdUser.getTotalCashRewardsToUpuser()) {
				row.createCell((short) 23).setCellValue(tdUser.getTotalCashRewardsToUpuser());
			}

			if (null != tdUser.getBankCardCode()) {
				row.createCell((short) 24).setCellValue(tdUser.getBankCardCode());
			}

			if (null != tdUser.getBankTitle()) {
				row.createCell((short) 25).setCellValue(tdUser.getBankTitle());
			}

			if (null != tdUser.getReturnRation()) {
				row.createCell((short) 26).setCellValue(tdUser.getReturnRation());
			}

			if (null != tdUser.getVirtualCurrency()) {
				row.createCell((short) 27).setCellValue(tdUser.getVirtualCurrency());
			}

			if (null != tdUser.getFrozenCapital()) {
				row.createCell((short) 28).setCellValue(tdUser.getFrozenCapital());
			}
		}
		return true;
	}

	/**
	 * @author lc
	 * @注释：文件写入和下载
	 */
	public Boolean downloaduser(HSSFWorkbook wb, String exportUrl, HttpServletResponse resp) {
		try {
			FileOutputStream fout = new FileOutputStream(exportUrl + "users.xls");
			// OutputStreamWriter writer = new OutputStreamWriter(fout, "utf8");
			wb.write(fout);
			fout.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		OutputStream os;
		try {
			os = resp.getOutputStream();
			File file = new File(exportUrl + "users.xls");

			if (file.exists()) {
				try {
					resp.reset();
					resp.setHeader("Content-Disposition", "attachment; filename=" + "users.xls");
					resp.setContentType("application/octet-stream; charset=utf-8");
					os.write(FileUtils.readFileToByteArray(file));
					os.flush();
				} finally {
					if (os != null) {
						os.close();
					}
				}
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return true;
	}

	/**
	 * @author lc
	 * @注释：指定用户获取奖项
	 */
	@RequestMapping(value = "/lottery/appoint", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> lotteryAppoint(Long typeId, String username, ModelMap map, HttpServletRequest req) {
		Map<String, Object> res = new HashMap<String, Object>();

		res.put("code", 1);

		if (null == typeId) {
			res.put("message", "请选择奖项类型");
			return res;
		}

		if (null == username) {
			res.put("message", "请选择获奖用户");
			return res;
		}

		TdPrizeCategory tdPrizeCategory = tdPrizeCategoryService.findOne(typeId);

		TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);

		if (null != tdPrizeCategory && null != tdUser) {
			if (tdPrizeCategory.getLeftNumber().equals(0L)) {
				res.put("message", "奖品已抽完！");
				return res;
			}

			TdPrize tdPrize = new TdPrize();

			tdPrize.setGetTime(new Date());
			tdPrize.setUsername(username);
			tdPrize.setTypeId(tdPrizeCategory.getId());
			if (null != tdPrizeCategory.getTitle()) {
				tdPrize.setTypeTitle(tdPrizeCategory.getTitle());
			}

			if (null != tdPrizeCategory.getPrizeType()) {
				tdPrize.setPrizeType(tdPrizeCategory.getPrizeType());
				if (tdPrizeCategory.getPrizeType().equals(0L) && null != tdPrizeCategory.getPrizePoints()) {
					tdPrize.setPrizePoints(tdPrizeCategory.getPrizePoints());

					tdUser.setTotalPoints(tdPrizeCategory.getPrizePoints() + tdUser.getTotalPoints());
					TdUserPoint userPoint = new TdUserPoint();

					userPoint.setIsBackgroundShow(false);
					userPoint.setTotalPoint(tdUser.getTotalPoints());
					userPoint.setUsername(tdUser.getUsername());
					userPoint.setPoint(tdPrizeCategory.getPrizePoints());
					userPoint.setDetail("抽奖奖励");

					userPoint = tdUserPointService.save(userPoint);
				} else if (tdPrizeCategory.getPrizeType().equals(1L) && null != tdPrizeCategory.getCouponTypeId()) {
					tdPrize.setCouponTypeId(tdPrizeCategory.getCouponTypeId());
					TdCouponType tdCouponType = tdCouponTypeService.findOne(tdPrizeCategory.getCouponTypeId());
					tdPrize.setCouponTitle(tdCouponType.getTitle());

					TdCoupon getCoupon = new TdCoupon();

					getCoupon.setGetNumber(1L);
					getCoupon.setGetTime(new Date());

					if (null != tdCouponType && null != tdCouponType.getTotalDays()) {
						Calendar ca = Calendar.getInstance();
						ca.add(Calendar.DATE, tdCouponType.getTotalDays().intValue());
						getCoupon.setExpireTime(ca.getTime());
					}

					getCoupon.setIsDistributted(true);
					getCoupon.setIsUsed(false);
					if (null != tdUser.getMobile()) {
						getCoupon.setMobile(tdUser.getMobile());
					}
					if (null != tdCouponType.getDescription()) {
						getCoupon.setTypeDescription(tdCouponType.getDescription());
					}
					getCoupon.setTypeId(tdCouponType.getId());
					if (null != tdCouponType.getPicUri()) {
						getCoupon.setTypePicUri(tdCouponType.getPicUri());
					}
					if (null != tdCouponType.getTitle()) {
						getCoupon.setTypeTitle(tdCouponType.getTitle());
					}
					if (null != tdCouponType.getPrice()) {
						getCoupon.setPrice(tdCouponType.getPrice());
					}

					getCoupon.setUsername(username);

					tdCouponService.save(getCoupon);
				} else if (tdPrizeCategory.getPrizeType().equals(2L) && null != tdPrizeCategory.getPrizeGoodsId()) {
					tdPrize.setGoodsId(tdPrizeCategory.getPrizeGoodsId());
					TdGoods tdGoods = tdGoodsService.findOne(tdPrizeCategory.getPrizeGoodsId());
					tdPrize.setGoodsTitle(tdGoods.getTitle());
				}
			}

			tdUserService.save(tdUser);
			tdPrizeService.save(tdPrize);
			tdPrizeCategory.setLeftNumber(tdPrizeCategory.getLeftNumber() - 1);
			tdPrizeCategoryService.save(tdPrizeCategory);
		}

		res.put("code", 0);

		return res;
	}

	/**
	 * @author lc
	 * @注释：红包发送
	 */
	@RequestMapping(value = "/redEnevlope/send", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> sendRedEnvelope(Long typeId, String type, String username, ModelMap map,
			HttpServletRequest req) {
		Map<String, Object> res = new HashMap<String, Object>();

		res.put("code", 1);

		if (null == typeId) {
			res.put("message", "请选择红包类型");
			return res;
		}

		if (null == type) {
			res.put("message", "发送失败");
			return res;
		}

		// 红包类型
		TdRedEnvelopeType tdRedEnvelopeType = tdRedEnvelopeTypeService.findOne(typeId);

		if (null != tdRedEnvelopeType) {
			if (type.equalsIgnoreCase("sendtoAll")) {
				List<TdUser> tdUsers = tdUserService.findAll();
				for (TdUser tdUser : tdUsers) {
					TdRedEnvelope tdRedEnvelope = new TdRedEnvelope();

					tdRedEnvelope.setTypeId(tdRedEnvelopeType.getId());
					tdRedEnvelope.setTypeTitle(tdRedEnvelopeType.getTitle());
					tdRedEnvelope.setRedEnvelopeType(tdRedEnvelopeType.getRedEnvelopeType());

					if (tdRedEnvelopeType.getRedEnvelopeType().equals(0L)
							&& null != tdRedEnvelopeType.getPrizePoints()) {
						tdRedEnvelope.setPrizePoints(tdRedEnvelopeType.getPrizePoints());
					} else if (tdRedEnvelopeType.getRedEnvelopeType().equals(1L)
							&& null != tdRedEnvelopeType.getCouponTypeId()) {
						tdRedEnvelope.setCouponTypeId(tdRedEnvelopeType.getCouponTypeId());
						TdCouponType tdCouponType = tdCouponTypeService.findOne(tdRedEnvelopeType.getCouponTypeId());
						tdRedEnvelope.setCouponTitle(tdCouponType.getTitle());
					}

					tdRedEnvelope.setUsername(tdUser.getUsername());
					tdRedEnvelope.setIsGet(false);
					tdRedEnvelope.setSendTime(new Date());
					tdRedEnvelope.setPicUri(tdRedEnvelopeType.getPicUri());
					tdRedEnvelope.setIsGetPrize(false);

					tdRedEnvelopeService.save(tdRedEnvelope);
				}
			} else if (type.equalsIgnoreCase("sendtoOne")) {
				if (null == username) {
					res.put("message", "请选择发放用户");
					return res;
				}

				TdRedEnvelope tdRedEnvelope = new TdRedEnvelope();

				tdRedEnvelope.setTypeId(tdRedEnvelopeType.getId());
				tdRedEnvelope.setTypeTitle(tdRedEnvelopeType.getTitle());
				tdRedEnvelope.setRedEnvelopeType(tdRedEnvelopeType.getRedEnvelopeType());

				if (tdRedEnvelopeType.getRedEnvelopeType().equals(0L) && null != tdRedEnvelopeType.getPrizePoints()) {
					tdRedEnvelope.setPrizePoints(tdRedEnvelopeType.getPrizePoints());
				} else if (tdRedEnvelopeType.getRedEnvelopeType().equals(1L)
						&& null != tdRedEnvelopeType.getCouponTypeId()) {
					tdRedEnvelope.setCouponTypeId(tdRedEnvelopeType.getCouponTypeId());
					TdCouponType tdCouponType = tdCouponTypeService.findOne(tdRedEnvelopeType.getCouponTypeId());
					tdRedEnvelope.setCouponTitle(tdCouponType.getTitle());
				}

				tdRedEnvelope.setUsername(username);
				tdRedEnvelope.setIsGet(false);
				tdRedEnvelope.setSendTime(new Date());
				tdRedEnvelope.setPicUri(tdRedEnvelopeType.getPicUri());
				tdRedEnvelope.setIsGetPrize(false);
				tdRedEnvelopeService.save(tdRedEnvelope);
			}
		}

		res.put("code", 0);

		return res;
	}

	@RequestMapping(value = "/edit")
	public String orderEdit(Long id, Long roleId, String action, String __VIEWSTATE, ModelMap map,
			HttpServletRequest req) {
		String username = (String) req.getSession().getAttribute("manager");
		if (null == username) {
			return "redirect:/Verwalter/login";
		}

		map.addAttribute("__VIEWSTATE", __VIEWSTATE);
		map.addAttribute("roleId", roleId);
		if (null != id) {
			map.addAttribute("user", tdUserService.findOne(id));
		}
		map.addAttribute("user_level_list", tdUserLevelService.findIsEnableTrue());
		return "/site_mag/user_edit";
	}

	/**
	 * @author lc
	 * @注释：手动修改积分
	 */
	@RequestMapping(value = "/param/edit", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> paramEdit(Long userId, Long totalPoints, String data, String type,
			Boolean isBackgroundShow, ModelMap map, HttpServletRequest req) {

		Map<String, Object> res = new HashMap<String, Object>();

		res.put("code", 1);
		String username = (String) req.getSession().getAttribute("manager");
		if (null == username) {
			res.put("message", "请重新登录");
			return res;
		}
		if (null != userId && null != type && !type.isEmpty()) {
			TdUser tdUser = tdUserService.findOne(userId);

			if (type.equalsIgnoreCase("editPoint") && null != isBackgroundShow) {
				if (null != totalPoints) {
					tdUser.setTotalPoints(totalPoints);
					tdUserService.save(tdUser);
					TdUserPoint userPoint = new TdUserPoint();

					userPoint.setIsBackgroundShow(isBackgroundShow);
					userPoint.setTotalPoint(totalPoints);
					userPoint.setUsername(tdUser.getUsername());
					userPoint.setPoint(totalPoints);
					if (null != data) {
						userPoint.setDetail(data);
					}
					userPoint = tdUserPointService.save(userPoint);

					res.put("code", 0);
					return res;
				}
			} else if (type.equalsIgnoreCase("editTotalCashRewards")) {
				TdUser tdUser1 = tdUserService.findOne(userId);
				TdSetting tdSetting = tdSettingService.findTopBy();

				Double recharge = Double.parseDouble(data);

				Double prize = recharge * tdSetting.getRechargeRation();

				if (null != tdUser1.getRoleId()) {
					if (tdUser1.getRoleId().equals(1L)) {
						// 返现金额充值
						if (null != tdUser1.getTotalCashRewards()) {
							tdUser1.setTotalCashRewards((recharge + prize + tdUser1.getTotalCashRewards()));
						} else {
							tdUser1.setTotalCashRewards((recharge + prize));
						}

						// 冻结金额改变
						if (null != tdUser1.getCashRewardsFrozen()) {
							tdUser1.setCashRewardsFrozen((recharge + prize + tdUser1.getCashRewardsFrozen()));
						} else {
							tdUser1.setCashRewardsFrozen((recharge + prize));
						}
					} else if (tdUser1.getRoleId().equals(2L)) {
						// 返现金额充值
						if (null != tdUser1.getVirtualCurrency()) {
							tdUser1.setVirtualCurrency(recharge + prize + tdUser1.getVirtualCurrency());
						} else {
							tdUser1.setVirtualCurrency(recharge + prize);
						}

						// 冻结金额改变
						if (null != tdUser1.getFrozenCapital()) {
							tdUser1.setFrozenCapital(recharge + prize + tdUser1.getFrozenCapital());
						} else {
							tdUser1.setFrozenCapital(recharge + prize);
						}
					}
				}
				res.put("code", 0);
				tdUserService.save(tdUser1);
				return res;
			}
		}

		return res;
	}

	@RequestMapping(value = "/save")
	public String orderEdit(TdUser tdUser, String __VIEWSTATE, ModelMap map, HttpServletRequest req) {
		String username = (String) req.getSession().getAttribute("manager");
		if (null == username) {
			return "redirect:/Verwalter/login";
		}

		map.addAttribute("__VIEWSTATE", __VIEWSTATE);

		if (null == tdUser.getId()) {
			tdManagerLogService.addLog("add", "修改用户", req);
		} else {
			tdManagerLogService.addLog("edit", "修改用户", req);
		}

		tdUserService.save(tdUser);

		return "redirect:/Verwalter/user/list/";
	}

	@RequestMapping(value = "/level/edit")
	public String edit(Long id, String __VIEWSTATE, ModelMap map, HttpServletRequest req) {
		String username = (String) req.getSession().getAttribute("manager");
		if (null == username) {
			return "redirect:/Verwalter/login";
		}

		if (null != id) {
			map.addAttribute("userLevelId", id);
			map.addAttribute("user_level", tdUserLevelService.findOne(id));
		}

		map.addAttribute("__VIEWSTATE", __VIEWSTATE);

		return "/site_mag/user_level_edit";
	}

	@RequestMapping(value = "/level/save")
	public String levelSave(TdUserLevel tdUserLevel, String __VIEWSTATE, ModelMap map, HttpServletRequest req) {
		String username = (String) req.getSession().getAttribute("manager");
		if (null == username) {
			return "redirect:/Verwalter/login";
		}

		map.addAttribute("__VIEWSTATE", __VIEWSTATE);
		if (null == tdUserLevel.getId()) {
			tdManagerLogService.addLog("add", "添加用户等级", req);
		} else {
			tdManagerLogService.addLog("edit", "修改用户等级", req);
		}

		tdUserLevelService.save(tdUserLevel);

		return "redirect:/Verwalter/user/level/list";
	}

	@RequestMapping(value = "/level/check/{type}", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> validateForm(@PathVariable String type, String param, Long id) {
		Map<String, String> res = new HashMap<String, String>();

		res.put("status", "n");
		res.put("info", "通过");

		if (null != type) {
			if (type.equalsIgnoreCase("levelId")) {
				if (null == param || param.isEmpty()) {
					res.put("info", "该字段不能为空");
					return res;
				}

				if (null == id) {
					if (null != tdUserLevelService.findByLevelId(Long.parseLong(param))) {
						res.put("info", "该用户等级已存在");
						return res;
					}
				} else {
					if (null != tdUserLevelService.findByLevelIdAndIdNot(Long.parseLong(param), id)) {
						res.put("info", "该用户等级已存在");
						return res;
					}
				}

				res.put("status", "y");
			} else if (type.equalsIgnoreCase("title")) {
				if (null == param || param.isEmpty()) {
					res.put("info", "该字段不能为空");
					return res;
				}

				if (null == id) {
					if (null != tdUserLevelService.findByTitle(param)) {
						res.put("info", "该等级用户名称已存在");
						return res;
					}
				} else {
					if (null != tdUserLevelService.findByTitleAndIdNot(param, id)) {
						res.put("info", "该等级用户名称已存在");
						return res;
					}
				}

				res.put("status", "y");
			}
		}

		return res;
	}

	@RequestMapping(value = "/consult/edit")
	public String consultEdit(Long id, Long statusId, String __VIEWSTATE, ModelMap map, HttpServletRequest req) {
		String username = (String) req.getSession().getAttribute("manager");
		if (null == username) {
			return "redirect:/Verwalter/login";
		}

		if (null != id) {
			map.addAttribute("userConsultId", id);
			map.addAttribute("user_consult", tdUserConsultService.findOne(id));
		}

		map.addAttribute("__VIEWSTATE", __VIEWSTATE);
		map.addAttribute("statusId", statusId);

		return "/site_mag/user_consult_edit";
	}

	@RequestMapping(value = "/consult/save")
	public String consultSave(TdUserConsult tdUserConsult, String __VIEWSTATE, ModelMap map, HttpServletRequest req) {
		String username = (String) req.getSession().getAttribute("manager");
		if (null == username) {
			return "redirect:/Verwalter/login";
		}

		map.addAttribute("__VIEWSTATE", __VIEWSTATE);

		if (null == tdUserConsult.getIsReplied() || !tdUserConsult.getIsReplied()) {
			tdUserConsult.setIsReplied(true);
			tdUserConsult.setReplyTime(new Date());
		}

		if (null == tdUserConsult.getId()) {
			tdManagerLogService.addLog("add", "修改用户咨询", req);
		} else {
			tdManagerLogService.addLog("edit", "修改用户咨询", req);
		}

		tdUserConsultService.save(tdUserConsult);

		return "redirect:/Verwalter/user/consult/list?statusId=" + __VIEWSTATE;
	}

	@RequestMapping(value = "/comment/edit")
	public String commentEdit(Long id, Long statusId, String __VIEWSTATE, ModelMap map, HttpServletRequest req) {
		String username = (String) req.getSession().getAttribute("manager");
		if (null == username) {
			return "redirect:/Verwalter/login";
		}

		if (null != id) {
			map.addAttribute("userCommentId", id);
			map.addAttribute("user_comment", tdUserCommentService.findOne(id));
		}

		map.addAttribute("__VIEWSTATE", __VIEWSTATE);
		map.addAttribute("statusId", statusId);

		return "/site_mag/user_comment_edit";
	}

	@RequestMapping(value = "/comment/save")
	public String commentSave(TdUserComment tdUserComment, String __VIEWSTATE, ModelMap map, HttpServletRequest req) {
		String username = (String) req.getSession().getAttribute("manager");
		if (null == username) {
			return "redirect:/Verwalter/login";
		}

		map.addAttribute("__VIEWSTATE", __VIEWSTATE);

		if (null == tdUserComment.getIsReplied() || !tdUserComment.getIsReplied()) {
			tdUserComment.setIsReplied(true);
			tdUserComment.setReplyTime(new Date());
		}

		if (null == tdUserComment.getId()) {
			tdManagerLogService.addLog("add", "修改用户评论", req);
		} else {
			tdManagerLogService.addLog("edit", "修改用户评论", req);
		}

		tdUserCommentService.save(tdUserComment);

		return "redirect:/Verwalter/user/comment/list?statusId=" + __VIEWSTATE;
	}

	@RequestMapping(value = "/complain/edit")
	public String complainEdit(Long id, Long statusId, String __VIEWSTATE, ModelMap map, HttpServletRequest req) {
		String username = (String) req.getSession().getAttribute("manager");
		if (null == username) {
			return "redirect:/Verwalter/login";
		}

		if (null != id) {
			map.addAttribute("userComplainId", id);
			map.addAttribute("user_complain", tdUserComplainService.findOne(id));
		}

		map.addAttribute("__VIEWSTATE", __VIEWSTATE);
		map.addAttribute("statusId", statusId);

		return "/site_mag/user_complain_edit";
	}

	@RequestMapping(value = "/complain/save")
	public String complainSave(TdUserComplain tdUserComplain, String __VIEWSTATE, ModelMap map,
			HttpServletRequest req) {
		String username = (String) req.getSession().getAttribute("manager");
		if (null == username) {
			return "redirect:/Verwalter/login";
		}

		map.addAttribute("__VIEWSTATE", __VIEWSTATE);

		if (null == tdUserComplain.getIsReplied() || !tdUserComplain.getIsReplied()) {
			tdUserComplain.setIsReplied(true);
			tdUserComplain.setReplyTime(new Date());
		}

		if (null == tdUserComplain.getId()) {
			tdManagerLogService.addLog("add", "修改用户投诉", req);
		} else {
			tdManagerLogService.addLog("edit", "修改用户投诉", req);
		}

		tdUserComplainService.save(tdUserComplain);

		return "redirect:/Verwalter/user/complain/list?statusId=" + __VIEWSTATE;
	}

	@RequestMapping(value = "/return/edit")
	public String returnEdit(Long id, Long statusId, String __VIEWSTATE, ModelMap map, HttpServletRequest req) {
		String username = (String) req.getSession().getAttribute("manager");
		if (null == username) {
			return "redirect:/Verwalter/login";
		}

		if (null != id) {
			map.addAttribute("userReturnId", id);
			map.addAttribute("user_return", tdUserReturnService.findOne(id));
		}

		map.addAttribute("__VIEWSTATE", __VIEWSTATE);
		map.addAttribute("statusId", statusId);

		return "/site_mag/user_return_edit";
	}

	@RequestMapping(value = "/return/save")
	public String returnSave(TdUserReturn tdUserReturn, String __VIEWSTATE, ModelMap map, HttpServletRequest req) {
		String username = (String) req.getSession().getAttribute("manager");
		if (null == username) {
			return "redirect:/Verwalter/login";
		}

		map.addAttribute("__VIEWSTATE", __VIEWSTATE);

		if (null == tdUserReturn.getId()) {
			tdManagerLogService.addLog("add", "修改用户退换货", req);
		} else {
			tdManagerLogService.addLog("edit", "修改用户退换货", req);
		}

		tdUserReturnService.save(tdUserReturn);

		return "redirect:/Verwalter/user/return/list?statusId=" + __VIEWSTATE;
	}

	// zhangji
	@RequestMapping(value = "/cancel/edit")
	public String cancelEdit(Long id, Long statusId, String __VIEWSTATE, ModelMap map, HttpServletRequest req) {
		String username = (String) req.getSession().getAttribute("manager");
		if (null == username) {
			return "redirect:/Verwalter/login";
		}

		if (null != id) {
			map.addAttribute("id", id);
			map.addAttribute("user_cancel", tdOrderService.findOne(id));
		}

		map.addAttribute("__VIEWSTATE", __VIEWSTATE);
		map.addAttribute("statusId", statusId);

		return "/site_mag/user_cancel_edit";
	}

	@RequestMapping(value = "/cancel/save")
	public String cancelSave(Long id, Boolean isRefund, Double refund, String __VIEWSTATE, ModelMap map,
			HttpServletRequest req) {
		String username = (String) req.getSession().getAttribute("manager");
		if (null == username) {
			return "redirect:/Verwalter/login";
		}

		map.addAttribute("__VIEWSTATE", __VIEWSTATE);

		TdOrder order = tdOrderService.findOne(id);

		if (null == order.getIsRefund()) {
			tdManagerLogService.addLog("add", "修改用户取消订单", req);
		} else {
			tdManagerLogService.addLog("edit", "修改用户取消订单", req);
		}

		order.setRefundTime(new Date());
		order.setRefund(refund);
		order.setIsRefund(isRefund);
		tdOrderService.save(order);

		return "redirect:/Verwalter/user/cancel/list?statusId=" + __VIEWSTATE;
	}

	@RequestMapping(value = "/{type}/list")
	public String list(@PathVariable String type, Integer page, Integer size, Long userId, Long statusId,
			String keywords, Boolean isRefund, // zhangji
			String __EVENTTARGET, String __EVENTARGUMENT, String __VIEWSTATE, Long[] listId, Integer[] listChkId,
			Long[] listSortId, ModelMap map, HttpServletRequest req) {
		String username = (String) req.getSession().getAttribute("manager");
		if (null == username) {
			return "redirect:/Verwalter/login";
		}
		if (null != __EVENTTARGET) {
			if (__EVENTTARGET.equalsIgnoreCase("btnPage")) {
				if (null != __EVENTARGUMENT) {
					page = Integer.parseInt(__EVENTARGUMENT);
				}
			} else if (__EVENTTARGET.equalsIgnoreCase("btnDelete")) {
				btnDelete(type, listId, listChkId);
			} else if (__EVENTTARGET.equalsIgnoreCase("btnSave")) {
				btnSave(type, listId, listSortId);
			} else if (__EVENTTARGET.equalsIgnoreCase("btnVerify")) {
				btnVerify(type, listId, listChkId);
			}
		}

		if (null == page || page < 0) {
			page = 0;
		}

		if (null == size || size <= 0) {
			size = SiteMagConstant.pageSize;
			;
		}

		if (null != keywords) {
			keywords = keywords.trim();
		}

		map.addAttribute("isRefund", isRefund); // zhangji
		map.addAttribute("page", page);
		map.addAttribute("size", size);
		map.addAttribute("userId", userId);
		map.addAttribute("statusId", statusId);
		map.addAttribute("keywords", keywords);
		map.addAttribute("__EVENTTARGET", __EVENTTARGET);
		map.addAttribute("__EVENTARGUMENT", __EVENTARGUMENT);
		map.addAttribute("__VIEWSTATE", __VIEWSTATE);

		if (null != type) {
			if (type.equalsIgnoreCase("point")) // 积分
			{
				if (null == userId) {
					return "/site_mag/error_404";
				}

				TdUser user = tdUserService.findOne(userId);

				if (null == user || null == user.getUsername()) {
					return "/site_mag/error_404";
				}

				map.addAttribute("user_point_page", tdUserPointService.findByUsername(user.getUsername(), page, size));
				return "/site_mag/user_point_list";
			} else if (type.equalsIgnoreCase("collect")) // 关注
			{
				if (null == userId) {
					return "/site_mag/error_404";
				}

				TdUser user = tdUserService.findOne(userId);

				if (null == user || null == user.getUsername()) {
					return "/site_mag/error_404";
				}

				map.addAttribute("user_collect_page",
						tdUserCollectService.findByUsername(user.getUsername(), page, size));
				return "/site_mag/user_collect_list";
			} else if (type.equalsIgnoreCase("recent")) // 最近浏览
			{
				if (null == userId) {
					return "/site_mag/error_404";
				}

				TdUser user = tdUserService.findOne(userId);

				if (null == user || null == user.getUsername()) {
					return "/site_mag/error_404";
				}

				map.addAttribute("user_recent_page",
						tdUserRecentVisitService.findByUsernameOrderByVisitTimeDesc(user.getUsername(), page, size));
				return "/site_mag/user_recent_list";
			} else if (type.equalsIgnoreCase("reward")) // 返现
			{
				if (null == userId) {
					return "/site_mag/error_404";
				}

				TdUser user = tdUserService.findOne(userId);

				if (null == user || null == user.getUsername()) {
					return "/site_mag/error_404";
				}

				map.addAttribute("user_reward_page",
						tdUserCashRewardService.findByUsernameOrderByIdDesc(user.getUsername(), page, size));
				return "/site_mag/user_reward_list";
			} else if (type.equalsIgnoreCase("level")) // 用户等级
			{
				map.addAttribute("user_level_page", tdUserLevelService.findAllOrderBySortIdAsc(page, size));
				return "/site_mag/user_level_list";
			} else if (type.equalsIgnoreCase("consult")) // 用户咨询
			{
				map.addAttribute("user_consult_page", findTdUserConsult(statusId, keywords, page, size));
				return "/site_mag/user_consult_list";
			} else if (type.equalsIgnoreCase("comment")) // 用户评论
			{
				map.addAttribute("user_comment_page", findTdUserComment(statusId, keywords, page, size));
				return "/site_mag/user_comment_list";
			} else if (type.equalsIgnoreCase("return")) // 退换货
			{
				map.addAttribute("user_return_page", findTdUserReturn(statusId, keywords, page, size));
				return "/site_mag/user_return_list";
			} else if (type.equalsIgnoreCase("complain")) // 投诉
			{
				map.addAttribute("user_complain_page", findTdUserComplain(statusId, keywords, page, size));
				return "/site_mag/user_complain_list";
			} else if (type.equalsIgnoreCase("cancel")) // 取消订单 zhangji
			{
				map.addAttribute("user_cancel_page", findTdUserCancel(isRefund, page, size));
				return "/site_mag/user_cancel_list";
			}
		}

		return "/site_mag/error_404";
	}

	@ModelAttribute
	public void getModel(@RequestParam(value = "userId", required = false) Long userId,
			@RequestParam(value = "userLevelId", required = false) Long userLevelId,
			@RequestParam(value = "userConsultId", required = false) Long userConsultId,
			@RequestParam(value = "userCommentId", required = false) Long userCommentId,
			@RequestParam(value = "userReturnId", required = false) Long userReturnId,
			@RequestParam(value = "userComplainId", required = false) Long userComplainId,
			@RequestParam(value = "userWithdrawId", required = false) Long userWithdrawId, Model model) {
		if (null != userId) {
			TdUser tdUser = tdUserService.findOne(userId);
			model.addAttribute("tdUser", tdUser);
		}

		if (null != userLevelId) {
			model.addAttribute("tdUserLevel", tdUserLevelService.findOne(userLevelId));
		}

		if (null != userConsultId) {
			model.addAttribute("tdUserConsult", tdUserConsultService.findOne(userConsultId));
		}

		if (null != userCommentId) {
			model.addAttribute("tdUserComment", tdUserCommentService.findOne(userCommentId));
		}

		if (null != userReturnId) {
			model.addAttribute("tdUserReturn", tdUserReturnService.findOne(userReturnId));
		}

		if (null != userComplainId) {
			model.addAttribute("tdUserComplain", tdUserComplainService.findOne(userComplainId));
		}
		if (null != userWithdrawId) {
			model.addAttribute("tdUserWithdraw", tdUserWithdrawService.findOne(userWithdrawId));
		}
	}

	private Page<TdUserConsult> findTdUserConsult(Long statusId, String keywords, int page, int size) {
		Page<TdUserConsult> dataPage = null;

		if (null == statusId) {
			if (null == keywords || "".equalsIgnoreCase(keywords)) {
				dataPage = tdUserConsultService.findAllOrderByIdDesc(page, size);
			} else {
				dataPage = tdUserConsultService.searchAndOrderByIdDesc(keywords, page, size);
			}
		} else {
			if (null == keywords || "".equalsIgnoreCase(keywords)) {
				dataPage = tdUserConsultService.findByStatusIdOrderByIdDesc(statusId, page, size);
			} else {
				dataPage = tdUserConsultService.searchAndFindByStatusIdOrderByIdDesc(keywords, statusId, page, size);
			}
		}

		return dataPage;
	}

	private Page<TdUserComment> findTdUserComment(Long statusId, String keywords, int page, int size) {
		Page<TdUserComment> dataPage = null;

		if (null == statusId) {
			if (null == keywords || "".equalsIgnoreCase(keywords)) {
				dataPage = tdUserCommentService.findAllOrderByIdDesc(page, size);
			} else {
				dataPage = tdUserCommentService.searchAndOrderByIdDesc(keywords, page, size);
			}
		} else {
			if (null == keywords || "".equalsIgnoreCase(keywords)) {
				dataPage = tdUserCommentService.findByStatusIdOrderByIdDesc(statusId, page, size);
			} else {
				dataPage = tdUserCommentService.searchAndFindByStatusIdOrderByIdDesc(keywords, statusId, page, size);
			}
		}

		return dataPage;
	}

	private Page<TdUserComplain> findTdUserComplain(Long statusId, String keywords, int page, int size) {
		Page<TdUserComplain> dataPage = null;

		if (null == statusId) {
			if (null == keywords || "".equalsIgnoreCase(keywords)) {
				dataPage = tdUserComplainService.findAllOrderByIdDesc(page, size);
			} else {
				dataPage = tdUserComplainService.searchAndOrderByIdDesc(keywords, page, size);
			}
		} else {
			if (null == keywords || "".equalsIgnoreCase(keywords)) {
				dataPage = tdUserComplainService.findByStatusIdOrderByIdDesc(statusId, page, size);
			} else {
				dataPage = tdUserComplainService.searchAndFindByStatusIdOrderByIdDesc(keywords, statusId, page, size);
			}
		}

		return dataPage;
	}

	private Page<TdUserReturn> findTdUserReturn(Long statusId, String keywords, int page, int size) {
		Page<TdUserReturn> dataPage = null;

		if (null == statusId) {
			if (null == keywords || "".equalsIgnoreCase(keywords)) {
				dataPage = tdUserReturnService.findAllOrderByIdDesc(page, size);
			} else {
				dataPage = tdUserReturnService.searchAndOrderByIdDesc(keywords, page, size);
			}
		} else {
			if (null == keywords || "".equalsIgnoreCase(keywords)) {
				dataPage = tdUserReturnService.findByStatusIdOrderByIdDesc(statusId, page, size);
			} else {
				dataPage = tdUserReturnService.searchAndFindByStatusIdOrderByIdDesc(keywords, statusId, page, size);
			}
		}

		return dataPage;
	}

	/**
	 * @author Zhangji
	 * @param isRefund
	 * @param page
	 * @param size
	 * @return
	 */
	private Page<TdOrder> findTdUserCancel(Boolean isRefund, int page, int size) {
		Page<TdOrder> dataPage = null;

		if (null == isRefund) {
			dataPage = tdOrderService.findByIsCancelTrue(page, size);
		} else if (true == isRefund) {
			dataPage = tdOrderService.findByIsCancelTrueAndIsRefundTrue(page, size);
		} else if (false == isRefund) {
			dataPage = tdOrderService.findByIsCancelTrueAndIsRefundFalse(page, size);
		}

		return dataPage;
	}

	private void btnSave(String type, Long[] ids, Long[] sortIds) {
		if (null == ids || null == sortIds || ids.length < 1 || sortIds.length < 1 || null == type || "".equals(type)) {
			return;
		}

		for (int i = 0; i < ids.length; i++) {
			Long id = ids[i];

			if (type.equalsIgnoreCase("user")) // 用户
			{
				TdUser e = tdUserService.findOne(id);

				if (null != e) {
					if (sortIds.length > i) {
						e.setSortId(sortIds[i]);
						tdUserService.save(e);
					}
				}
			} else if (type.equalsIgnoreCase("level")) // 用户等级
			{
				TdUserLevel e = tdUserLevelService.findOne(id);

				if (null != e) {
					if (sortIds.length > i) {
						e.setSortId(sortIds[i]);
						tdUserLevelService.save(e);
					}
				}
			} else if (type.equalsIgnoreCase("consult")) // 咨询
			{
				TdUserConsult e = tdUserConsultService.findOne(id);

				if (null != e) {
					if (sortIds.length > i) {
						e.setSortId(sortIds[i]);
						tdUserConsultService.save(e);
					}
				}
			} else if (type.equalsIgnoreCase("comment")) // 评论
			{
				TdUserComment e = tdUserCommentService.findOne(id);

				if (null != e) {
					if (sortIds.length > i) {
						e.setSortId(sortIds[i]);
						tdUserCommentService.save(e);
					}
				}
			} else if (type.equalsIgnoreCase("complain")) // 投诉
			{
				TdUserComplain e = tdUserComplainService.findOne(id);

				if (null != e) {
					if (sortIds.length > i) {
						e.setSortId(sortIds[i]);
						tdUserComplainService.save(e);
					}
				}
			} else if (type.equalsIgnoreCase("return")) // 退换货
			{
				TdUserReturn e = tdUserReturnService.findOne(id);

				if (null != e) {
					if (sortIds.length > i) {
						e.setSortId(sortIds[i]);
						tdUserReturnService.save(e);
					}
				}
			}
		}
	}

	private void btnDelete(String type, Long[] ids, Integer[] chkIds) {
		if (null == ids || null == chkIds || ids.length < 1 || chkIds.length < 1 || null == type || "".equals(type)) {
			return;
		}

		for (int chkId : chkIds) {
			if (chkId >= 0 && ids.length > chkId) {
				Long id = ids[chkId];

				if (type.equalsIgnoreCase("user")) // 用户
				{
					tdUserService.delete(id);
				} else if (type.equalsIgnoreCase("level")) // 用户等级
				{
					tdUserLevelService.delete(id);
				} else if (type.equalsIgnoreCase("consult")) // 咨询
				{
					tdUserConsultService.delete(id);
				} else if (type.equalsIgnoreCase("comment")) // 评论
				{
					tdUserCommentService.delete(id);
				} else if (type.equalsIgnoreCase("complain")) // 投诉
				{
					tdUserComplainService.delete(id);
				} else if (type.equalsIgnoreCase("return")) // 退换货
				{
					tdUserReturnService.delete(id);
				} else if (type.equalsIgnoreCase("withdraw")) // 退换货
				{
					tdUserWithdrawService.delete(id);
				}
			}
		}
	}

	private void btnVerify(String type, Long[] ids, Integer[] chkIds) {
		if (null == ids || null == chkIds || ids.length < 1 || chkIds.length < 1 || null == type || "".equals(type)) {
			return;
		}

		for (int chkId : chkIds) {
			if (chkId >= 0 && ids.length > chkId) {
				Long id = ids[chkId];

				if (type.equalsIgnoreCase("consult")) // 咨询
				{
					TdUserConsult e = tdUserConsultService.findOne(id);

					if (null != e) {
						e.setStatusId(1L);
						tdUserConsultService.save(e);
					}
				} else if (type.equalsIgnoreCase("comment")) // 评论
				{
					TdUserComment e = tdUserCommentService.findOne(id);

					if (null != e) {
						e.setStatusId(1L);
						tdUserCommentService.save(e);
					}
				} else if (type.equalsIgnoreCase("complain")) // 投诉
				{
					TdUserComplain e = tdUserComplainService.findOne(id);

					if (null != e) {
						e.setStatusId(1L);
						tdUserComplainService.save(e);
					}
				} else if (type.equalsIgnoreCase("return")) // 退换货
				{
					TdUserReturn e = tdUserReturnService.findOne(id);

					if (null != e) {
						e.setStatusId(1L);
						tdUserReturnService.save(e);
					}
				}
			}
		}
	}
}
