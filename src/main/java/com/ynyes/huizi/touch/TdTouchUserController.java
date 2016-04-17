package com.ynyes.huizi.touch;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.multipart.MultipartFile;

import com.ynyes.huizi.entity.TdCoupon;
import com.ynyes.huizi.entity.TdCouponType;
import com.ynyes.huizi.entity.TdGoods;
import com.ynyes.huizi.entity.TdOrder;
import com.ynyes.huizi.entity.TdOrderGoods;
import com.ynyes.huizi.entity.TdPrize;
import com.ynyes.huizi.entity.TdProductCategory;
import com.ynyes.huizi.entity.TdRedEnvelope;
import com.ynyes.huizi.entity.TdRedEnvelopeType;
import com.ynyes.huizi.entity.TdSetting;
import com.ynyes.huizi.entity.TdShippingAddress;
import com.ynyes.huizi.entity.TdUser;
import com.ynyes.huizi.entity.TdUserCashReward;
import com.ynyes.huizi.entity.TdUserCollect;
import com.ynyes.huizi.entity.TdUserComment;
import com.ynyes.huizi.entity.TdUserComplain;
import com.ynyes.huizi.entity.TdUserConsult;
import com.ynyes.huizi.entity.TdUserPoint;
import com.ynyes.huizi.entity.TdUserRecentVisit;
import com.ynyes.huizi.entity.TdUserReturn;
import com.ynyes.huizi.entity.TdUserWithdraw;
import com.ynyes.huizi.service.TdCommonService;
import com.ynyes.huizi.service.TdCouponService;
import com.ynyes.huizi.service.TdCouponTypeService;
import com.ynyes.huizi.service.TdGoodsService;
import com.ynyes.huizi.service.TdOrderGoodsService;
import com.ynyes.huizi.service.TdOrderService;
import com.ynyes.huizi.service.TdPrizeService;
import com.ynyes.huizi.service.TdProductCategoryService;
import com.ynyes.huizi.service.TdRedEnvelopeService;
import com.ynyes.huizi.service.TdRedEnvelopeTypeService;
import com.ynyes.huizi.service.TdSettingService;
import com.ynyes.huizi.service.TdShippingAddressService;
import com.ynyes.huizi.service.TdUserCashRewardService;
import com.ynyes.huizi.service.TdUserCollectService;
import com.ynyes.huizi.service.TdUserCommentService;
import com.ynyes.huizi.service.TdUserComplainService;
import com.ynyes.huizi.service.TdUserConsultService;
import com.ynyes.huizi.service.TdUserPointService;
import com.ynyes.huizi.service.TdUserRecentVisitService;
import com.ynyes.huizi.service.TdUserReturnService;
import com.ynyes.huizi.service.TdUserService;
import com.ynyes.huizi.service.TdUserWithdrawService;
import com.ynyes.huizi.util.ClientConstant;
import com.ynyes.huizi.util.QRCodeUtils;
import com.ynyes.huizi.util.SiteMagConstant;

/**
 * 用户中心
 * 
 * @author Sharon
 *
 */
@Controller
@RequestMapping("/touch")
public class TdTouchUserController {

	@Autowired
	private TdUserService tdUserService;

	@Autowired
	private TdGoodsService tdGoodsService;

	@Autowired
	private TdUserReturnService tdUserReturnService;

	@Autowired
	private TdOrderService tdOrderService;

	@Autowired
	private TdUserPointService tdUserPointService;

	@Autowired
	private TdUserCollectService tdUserCollectService;

	@Autowired
	private TdUserConsultService tdUserConsultService;

	@Autowired
	private TdUserCommentService tdUserCommentService;

	@Autowired
	private TdCouponService tdCouponService;

	@Autowired
	private TdUserRecentVisitService tdUserRecentVisitService;

	@Autowired
	private TdShippingAddressService tdShippingAddressService;

	@Autowired
	private TdOrderGoodsService tdOrderGoodsService;

	@Autowired
	private TdUserCashRewardService tdUserCashRewardService;

	@Autowired
	private TdCommonService tdCommonService;

	@Autowired
	private TdProductCategoryService tdProductCategoryService;

	@Autowired
	private TdUserComplainService tdUserComplainService;

	@Autowired
	private TdRedEnvelopeService tdRedEnvelopeService;

	@Autowired
	private TdRedEnvelopeTypeService tdRedEnvelopeTypeService;

	@Autowired
	private TdCouponTypeService tdCouponTypeService;

	@Autowired
	private TdUserWithdrawService tdUserWithdrawService;

	@Autowired
	private TdSettingService tdSettingService;

	@Autowired
	private TdPrizeService tdPrizeService;

	@RequestMapping(value = "/user")
	public String user(HttpServletRequest req, String username, ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}
		tdCommonService.setHeader(map, req);
		req.getSession().setAttribute("username", username);
		map.addAttribute("server_ip", req.getLocalName());
		map.addAttribute("server_port", req.getLocalPort());
		TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);
		if (null == tdUser) {
			return "/touch/error_404";
		}

		map.addAttribute("user", tdUser);
		map.addAttribute("order_page", tdOrderService.findByUsername(username, 0, ClientConstant.pageSize));
		map.addAttribute("collect_page", tdUserCollectService.findByUsername(username, 0, ClientConstant.pageSize));
		map.addAttribute("recent_page",
				tdUserRecentVisitService.findByUsernameOrderByVisitTimeDesc(username, 0, ClientConstant.pageSize));
		map.addAttribute("total_unpayed", tdOrderService.countByUsernameAndStatusId(username, 2));
		map.addAttribute("total_undelivered", tdOrderService.countByUsernameAndStatusId(username, 3));
		map.addAttribute("total_unreceived", tdOrderService.countByUsernameAndStatusId(username, 4));
		map.addAttribute("total_uncommented", tdOrderService.countByUsernameAndStatusId(username, 5));
		map.addAttribute("total_finished", tdOrderService.countByUsernameAndStatusId(username, 6));
		map.addAttribute("recommend_goods_page",
				tdGoodsService.findByIsRecommendTypeTrueAndIsOnSaleTrueOrderByIdDesc(0, ClientConstant.pageSize));

		return "/touch/user_index";
	}

	@RequestMapping(value = "/user/center/headImg", method = RequestMethod.POST)
	public String uploadImg(@RequestParam MultipartFile Filedata, String username, HttpServletRequest req) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}
		// String username = (String) req.getSession().getAttribute("username");
		TdUser user = tdUserService.findByUsername(username);
		if (null == user) {
			return "redirect:/touch/login";
		}

		String name = Filedata.getOriginalFilename();

		String ext = name.substring(name.lastIndexOf("."));

		try {
			byte[] bytes = Filedata.getBytes();

			Date dt = new Date(System.currentTimeMillis());
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			String fileName = sdf.format(dt) + ext;

			String uri = SiteMagConstant.imagePath + "/" + fileName;

			File file = new File(uri);

			BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(file));
			stream.write(bytes);
			stream.close();
			user.setHeadImageUri("/images/" + fileName);
			tdUserService.save(user);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/touch/user";

	}

	@RequestMapping(value = "/user/center/qrcode", method = RequestMethod.GET)
	public String getqrcode(HttpServletRequest req, String username, ModelMap map, Integer app) {
		// String username = (String) req.getSession().getAttribute("username");
		// if (null == username) {
		// return "redirect:/touch/login";
		// }
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}
		tdCommonService.setHeader(map, req);
		TdUser user = tdUserService.findByUsername(username);
		map.addAttribute("user", user);
		if (null == user.getQrCodeUri() || user.getQrCodeUri().length() < 5) {
			try {

				Date dt = new Date(System.currentTimeMillis());
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
				String fileName = sdf.format(dt) + ".png";

				String uri = SiteMagConstant.imagePath + "/" + fileName;

				File file = new File(uri);

				QRCodeUtils qr = new QRCodeUtils();
				qr.getQRCodeForsharer("http://www.huizhidian.com/touch/regid?shareId=" + user.getId(), 300, file);

				// BufferedOutputStream stream = new BufferedOutputStream(new
				// FileOutputStream(file));
				// stream.write(bytes);
				// stream.close();
				user.setQrCodeUri("/images/" + fileName);
				tdUserService.save(user);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/user_qrcode";

	}

	@RequestMapping(value = "/user/redenvelope/list")
	public String redenvelopeList(Integer statusId, Long redenvelopeId, Integer page, String username,
			HttpServletRequest req, Integer app, ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		if (null == page) {
			page = 0;
		}

		if (null == statusId) {
			statusId = 0;
		}

		TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", tdUser);
		map.addAttribute("status_id", statusId);

		Page<TdRedEnvelope> redenvelopePage = null;

		if (0 == statusId) {
			redenvelopePage = tdRedEnvelopeService.findByUsername(username, page, ClientConstant.pageSize);
		} else if (1 == statusId) {
			redenvelopePage = tdRedEnvelopeService.findByUsernameAndIsGetFalse(username, page, ClientConstant.pageSize);
		} else if (2 == statusId) {
			redenvelopePage = tdRedEnvelopeService.findByUsernameAndIsGetTrue(username, page, ClientConstant.pageSize);
		}

		map.addAttribute("redenvelope_page", redenvelopePage);

		// 查询红包信息
		if (null != redenvelopeId) {
			TdRedEnvelope tdRedEnvelope = tdRedEnvelopeService.findOne(redenvelopeId);

			map.addAttribute("tdRedEnvelope", tdRedEnvelope);
		}

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/user_redenvelope_list";
	}

	@RequestMapping(value = "/user/redenvelope/edit")
	public String redenvelopeList(Long redenvelopeId, HttpServletRequest req, String username, Integer app,
			ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		if (null == redenvelopeId) {
			return "/touch/error_404";
		}

		TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", tdUser);

		TdRedEnvelope tdRedEnvelope = tdRedEnvelopeService.findOne(redenvelopeId);

		map.addAttribute("tdRedEnvelope", tdRedEnvelope);

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/user_redenvelope_edit";
	}

	@RequestMapping(value = "/user/redenvelope/get", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> redEnvelopeGet(Long redenvelopeId, // 订单id
			ModelMap map, HttpServletRequest req) {

		Map<String, Object> res = new HashMap<String, Object>();

		res.put("code", 1);

		String username = (String) req.getSession().getAttribute("username");

		if (null == username) {
			res.put("message", "请登录！！");
			return res;
		}

		tdCommonService.setHeader(map, req);

		if (null != redenvelopeId) {
			TdRedEnvelope tdRedEnvelope = tdRedEnvelopeService.findOne(redenvelopeId);
			TdRedEnvelopeType tdRedEnvelopeType = tdRedEnvelopeTypeService.findOne(tdRedEnvelope.getTypeId());

			if (null != tdRedEnvelope && null != tdRedEnvelopeType) {
				if (tdRedEnvelopeType.getLeftNumber() > 0) {
					TdUser tdUser = tdUserService.findByUsername(username);

					tdRedEnvelope.setIsGet(true);
					tdRedEnvelopeType.setLeftNumber(tdRedEnvelopeType.getLeftNumber() - 1);

					// 红包奖励
					if (tdRedEnvelopeType.getRedEnvelopeType().equals(0L)) {
						if (null != tdRedEnvelopeType.getPrizePoints()) {
							tdUser.setTotalPoints(tdRedEnvelopeType.getPrizePoints() + tdUser.getTotalPoints());
							TdUserPoint userPoint = new TdUserPoint();

							userPoint.setIsBackgroundShow(false);
							userPoint.setTotalPoint(tdRedEnvelopeType.getPrizePoints() + tdUser.getTotalPoints());
							userPoint.setUsername(tdUser.getUsername());
							userPoint.setPoint(tdRedEnvelopeType.getPrizePoints());
							userPoint.setDetail("红包奖励");

							userPoint = tdUserPointService.save(userPoint);
						}
					} else if (tdRedEnvelopeType.getRedEnvelopeType().equals(1L)) {
						if (null != tdRedEnvelopeType.getCouponTypeId()) {
							TdCouponType tdCouponType = tdCouponTypeService
									.findOne(tdRedEnvelopeType.getCouponTypeId());

							TdCoupon getCoupon = new TdCoupon();

							// getCoupon.setDiySiteId(leftCoupon.getDiySiteId());
							// getCoupon.setDiySiteTitle(leftCoupon.getDiySiteTitle());
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
						}
					}

					tdRedEnvelope.setIsGetPrize(true);

					tdRedEnvelopeService.save(tdRedEnvelope);
					tdRedEnvelopeTypeService.save(tdRedEnvelopeType);

					res.put("isGetPrize", true);
					res.put("isGet", true);
				} else {
					tdRedEnvelope.setIsGetPrize(false);
					tdRedEnvelope.setIsGet(true);

					tdRedEnvelopeService.save(tdRedEnvelope);

					res.put("isGetPrize", false);
					res.put("isGet", true);
				}

				res.put("code", 0);
				return res;
			}
		}
		res.put("message", "参数错误！！");
		return res;
	}

	@RequestMapping(value = "/user/order/list/{statusId}")
	public String orderList(@PathVariable Integer statusId, Integer page, String keywords, Integer timeId,
			HttpServletRequest req, String username, Integer app, ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}
		req.getSession().setAttribute("username", username);
		// if (null == username)
		// {
		// return "redirect:/touch/login";
		// }

		tdCommonService.setHeader(map, req);

		if (null == page) {
			page = 0;
		}

		if (null == timeId) {
			timeId = 0;
		}

		if (null == statusId) {
			statusId = 0;
		}

		TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", tdUser);
		map.addAttribute("status_id", statusId);
		map.addAttribute("time_id", timeId);

		Page<TdOrder> orderPage = null;

		if (statusId.equals(0)) {
			if (null != keywords && !keywords.isEmpty()) {
				// orderPage = tdOrderService.findByUsernameAndSearch(username,
				// keywords, page, ClientConstant.pageSize);
				orderPage = tdOrderService.findByUsernameAndStatusIdNotAndSearch(username, 8L, keywords, page,
						ClientConstant.pageSize);
			} else {
				// orderPage = tdOrderService.findByUsername(username, page,
				// ClientConstant.pageSize);
				orderPage = tdOrderService.findByUsernameAndStatusIdNot(username, 8L, page, ClientConstant.pageSize);
			}
		} else {
			if (null != keywords && !keywords.isEmpty()) {
				orderPage = tdOrderService.findByUsernameAndStatusIdAndSearch(username, statusId, keywords, page,
						ClientConstant.pageSize);
			} else {
				orderPage = tdOrderService.findByUsernameAndStatusId(username, statusId, page, ClientConstant.pageSize);
			}
		}

		map.addAttribute("order_page", orderPage);

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/user_order_list";
	}

	@RequestMapping(value = "/user/order/list/more/{statusId}")
	public String orderListmore(@PathVariable Integer statusId, Integer page, String keywords, Integer timeId,
			String username, HttpServletRequest req, Integer app, ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		if (null == page) {
			page = 0;
		}

		if (null == statusId) {
			statusId = 0;
		}

		TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", tdUser);
		map.addAttribute("status_id", statusId);

		Page<TdOrder> orderPage = null;

		if (statusId.equals(0)) {
			if (null != keywords && !keywords.isEmpty()) {
				// orderPage = tdOrderService.findByUsernameAndSearch(username,
				// keywords, page, ClientConstant.pageSize);
				orderPage = tdOrderService.findByUsernameAndStatusIdNotAndSearch(username, 8L, keywords, page,
						ClientConstant.pageSize);
			} else {
				// orderPage = tdOrderService.findByUsername(username, page,
				// ClientConstant.pageSize);
				orderPage = tdOrderService.findByUsernameAndStatusIdNot(username, 8L, page, ClientConstant.pageSize);
			}
		} else {
			if (null != keywords && !keywords.isEmpty()) {
				orderPage = tdOrderService.findByUsernameAndStatusIdAndSearch(username, statusId, keywords, page,
						ClientConstant.pageSize);
			} else {
				orderPage = tdOrderService.findByUsernameAndStatusId(username, statusId, page, ClientConstant.pageSize);
			}
		}

		map.addAttribute("order_page", orderPage);

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/user_order_list_more";
	}

	/**
	 * 用户中心确认收货
	 * 
	 * @author Zhangji
	 * @param id
	 * @param map
	 * @param req
	 * @return
	 */
	@RequestMapping(value = "/user/order/receive", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> orderReceive(Long id, // 订单id
			ModelMap map, HttpServletRequest req) {

		Map<String, Object> res = new HashMap<String, Object>();

		res.put("code", 1);

		String username = (String) req.getSession().getAttribute("username");

		if (null == username) {
			res.put("message", "请登录！！");
			return res;
		}
		tdCommonService.setHeader(map, req);

		if (null != id) {
			TdOrder order = tdOrderService.findOne(id);
			if (order.getStatusId().equals(4L)) {
				order.setStatusId(5L);
				order.setReceiveTime(new Date());
			}
			tdOrderService.save(order);
			// if (!order.getIsOnlinePay()) {
			if (order.getTotalPrice() == 0) {
				if (null != order.getTypeId() && order.getTypeId().equals(5L)) {
					// pointOrderafterPaySuccess(order);
				} else {
					afterPaySuccess(order);
				}
				// }
			}

			res.put("code", 0);
			res.put("message", "确认收货成功！！");
			return res;
		}
		res.put("message", "参数错误！！");
		return res;
	}

	@RequestMapping(value = "/user/return/list")
	public String returnList(HttpServletRequest req, Integer timeId, Integer page, String keywords, String username,
			Integer app, ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		if (null == timeId) {
			timeId = 0;
		}

		if (null == page) {
			page = 0;
		}

		TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", tdUser);
		map.addAttribute("time_id", timeId);

		Page<TdOrder> orderPage = null;

		if (null != keywords && !keywords.isEmpty()) {
			orderPage = tdOrderService
					.findByUsernameAndOrderNumberAndStatusIdOrUsernameAndOrderNumberAndStatusIdOrUsernameAndOrderNumberAndStatusId(
							username, keywords, 4L, username, keywords, 5L, username, keywords, 6L, page,
							ClientConstant.pageSize);
		} else {
			orderPage = tdOrderService.findByUsernameAndStatusIdOrUsernameAndStatusIdOrUsernameAndStatusIdOrderByIdDesc(
					username, 4L, username, 5L, username, 6L, page, ClientConstant.pageSize);
		}

		map.addAttribute("return_page", orderPage);
		map.addAttribute("keywords", keywords);

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/user_return_list";
	}

	/**
	 * 取消订单
	 * 
	 * @author Zhangji
	 * @param page
	 * @param req
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/user/cancel/list")
	public String orderList(Integer page, HttpServletRequest req, String username, Integer app, ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		if (null == page) {
			page = 0;
		}

		TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", tdUser);

		Page<TdOrder> cancelPage = null;

		cancelPage = tdOrderService.findByUsernameAndIsCancelTrue(username, page, ClientConstant.pageSize);

		map.addAttribute("cancel_page", cancelPage);

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/user_cancel_list";
	}

	@RequestMapping(value = "/user/cancel")
	public String cancel(Long id, HttpServletRequest req, String username, Integer app, ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", tdUser);

		if (null != id) {
			map.addAttribute("order", tdOrderService.findOne(id));
		}

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/user_cancel_detail";
	}

	/**
	 * 订单取消申请
	 * 
	 * @author Zhangji
	 * @param id
	 * @param req
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/user/cancel/edit")
	public String cancelEdit(Long id, HttpServletRequest req, String username, Integer app, ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", tdUser);

		TdOrder order = tdOrderService.findOne(id);
		Long statusId = order.getStatusId();
		if (1L == statusId || 2L == statusId || 3L == statusId) {
			// 判断是否为app链接
			if (null == app) {
				Integer isApp = (Integer) req.getSession().getAttribute("app");
				if (null != isApp) {
					map.addAttribute("app", isApp);
				}
			} else {
				map.addAttribute("app", app);
			}

			map.addAttribute("orderId", id);
			map.addAttribute("statusId", statusId);
			map.addAttribute("order", order);
			return "/client/user_cancel_edit";
		}

		return "/touch/error_404";
	}

	@RequestMapping(value = "/user/cancel/save", method = RequestMethod.POST)
	public String cancelSave(HttpServletRequest req, Long id, // 订单ID
			String cancelReason, ModelMap map) {
		String username = (String) req.getSession().getAttribute("username");

		if (null == username) {
			return "redirect:/touch/login";
		}

		tdCommonService.setHeader(map, req);

		if (null != id) {
			TdOrder order = tdOrderService.findOne(id);

			if (null != order) {
				if (null == order.getIsCancel() && 3L == order.getStatusId()
						|| false == order.getIsCancel() && 3L == order.getStatusId()) {
					// 退货时间及原因
					order.setCancelReason(cancelReason);
					order.setCancelApplyTime(new Date());
					order.setIsCancel(true);
					// 保存
					tdOrderService.save(order);
				}
			}
		}

		return "redirect:/touch/user/cancel/list";
	}

	@RequestMapping(value = "/user/cancel/direct")
	public String cancelDirect(HttpServletRequest req, Long id, // 订单ID
			String cancelReason, String username, ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		if (null != id) {
			TdOrder order = tdOrderService.findOne(id);

			if (null != order) {
				if (1L == order.getStatusId() || 2L == order.getStatusId()) {
					if (null == order.getIsCancel() || false == order.getIsCancel()) {
						order.setStatusId(7L);
						order.setCancelApplyTime(new Date());
						order.setIsCancel(true);
						order.setIsRefund(true);
						// 保存
						tdOrderService.save(order);
					}
				}
			}
		}

		return "redirect:/touch/user/order/list/0";
	}

	@RequestMapping(value = "/user/order/delete")
	public String orderdelete(Long id, HttpServletRequest req, ModelMap map) {
		String username = (String) req.getSession().getAttribute("username");
		if (null == username) {
			return "redirect:/touch/login";
		}

		tdCommonService.setHeader(map, req);

		if (null == id) {
			return "/touch/error_404";
		}

		TdOrder tdOrder = tdOrderService.findOne(id);

		if (null != tdOrder) {
			tdOrder.setStatusId(8L);
			tdOrderService.save(tdOrder);
		}

		return "redirect:/touch/user/order/list/0";
	}

	@RequestMapping(value = "/user/order")
	public String order(Long id, HttpServletRequest req, Integer app, ModelMap map) {
		String username = (String) req.getSession().getAttribute("username");
		if (null == username) {
			return "redirect:/touch/login";
		}

		tdCommonService.setHeader(map, req);

		TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", tdUser);

		if (null != id) {
			map.addAttribute("order", tdOrderService.findOne(id));
		}

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/user_order_detail";
	}

	@RequestMapping(value = "/user/collect/list")
	public String collectList(HttpServletRequest req, Integer page, String keywords, String username, Integer app,
			ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		if (null == page) {
			page = 0;
		}

		TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", tdUser);

		Page<TdUserCollect> collectPage = null;

		if (null == keywords || keywords.isEmpty()) {
			collectPage = tdUserCollectService.findByUsername(username, page, ClientConstant.pageSize);
		} else {
			collectPage = tdUserCollectService.findByUsernameAndSearch(username, keywords, page,
					ClientConstant.pageSize);
		}

		map.addAttribute("collect_page", collectPage);
		map.addAttribute("keywords", keywords);

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/user_collect_list";
	}

	@RequestMapping(value = "/user/collect/del")
	public String collectDel(HttpServletRequest req, Long id, ModelMap map) {
		String username = (String) req.getSession().getAttribute("username");

		if (null == username) {
			return "redirect:/touch/login";
		}

		if (null != id) {
			TdUserCollect collect = tdUserCollectService.findByUsernameAndGoodsId(username, id);

			// 删除收藏
			if (null != collect) {
				tdUserCollectService.delete(collect);
			}
		}

		return "redirect:/touch/user/collect/list";
	}

	@RequestMapping(value = "/user/collect/add", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> collectAdd(HttpServletRequest req, Long goodsId, ModelMap map) {

		Map<String, Object> res = new HashMap<String, Object>();
		res.put("code", 1);

		if (null == goodsId) {
			res.put("message", "参数错误");
			return res;
		}

		String username = (String) req.getSession().getAttribute("username");

		if (null == username) {
			res.put("message", "请先登录");
			return res;
		}

		res.put("code", 0);

		// 没有收藏
		if (null == tdUserCollectService.findByUsernameAndGoodsId(username, goodsId)) {
			TdGoods goods = tdGoodsService.findOne(goodsId);

			if (null == goods) {
				res.put("message", "商品不存在");
				return res;
			}

			TdUserCollect collect = new TdUserCollect();

			collect.setUsername(username);
			collect.setGoodsId(goods.getId());
			collect.setGoodsCoverImageUri(goods.getCoverImageUri());
			collect.setGoodsTitle(goods.getTitle());
			collect.setGoodsSalePrice(goods.getSalePrice());
			collect.setCollectTime(new Date());
			collect.setLeftNumber(goods.getLeftNumber()); // 库存zhangji

			tdUserCollectService.save(collect);

			res.put("message", "添加成功");

			return res;
		}

		res.put("message", "您已收藏了该商品");

		return res;
	}

	@RequestMapping(value = "/user/recent/list")
	public String recentList(HttpServletRequest req, Long categoryId, Integer page, String keywords, Integer app,
			ModelMap map) {
		String username = (String) req.getSession().getAttribute("username");

		if (null == username) {
			return "redirect:/touch/login";
		}

		tdCommonService.setHeader(map, req);

		if (null == page) {
			page = 0;
		}

		TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", tdUser);

		Page<TdUserRecentVisit> recentPage = null;

		if (null == categoryId) {
			recentPage = tdUserRecentVisitService.findByUsernameOrderByVisitTimeDesc(username, page,
					ClientConstant.pageSize);
		} else {
			recentPage = tdUserRecentVisitService.findByUsernameAndCategoryIdOrderByVisitTimeDesc(username, categoryId,
					page, ClientConstant.pageSize);
		}
		// if (null == keywords || keywords.isEmpty())
		// {
		// recentPage =
		// tdUserRecentVisitService.findByUsernameOrderByVisitTimeDesc(username,
		// page, ClientConstant.pageSize);
		// }
		// else
		// {
		// recentPage =
		// tdUserRecentVisitService.findByUsernameAndSearchOrderByVisitTimeDesc(username,
		// keywords, page, ClientConstant.pageSize);
		// }
		Date today = new Date();
		Calendar calendar = Calendar.getInstance();// 日历对象
		calendar.setTime(today);// 设置当前日期
		calendar.add(Calendar.DATE, -1);
		Date yesterday = calendar.getTime();
		calendar.add(Calendar.DATE, -1);
		Date tdby = calendar.getTime();

		map.addAttribute("today", today);
		map.addAttribute("yesterday", yesterday);
		map.addAttribute("tdby", tdby);
		map.addAttribute("categoryId", categoryId); // 商品分类id zhangji
		map.addAttribute("recent_page", recentPage);
		map.addAttribute("keywords", keywords);

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/user_recent_list";
	}

	/*
	 * 删除历史记录
	 * 
	 * @zhangji
	 */
	@RequestMapping(value = "/user/recent/delete/{id}")
	public String recentDelete(HttpServletRequest req, ModelMap map, @PathVariable Long id, String date) {
		String username = (String) req.getSession().getAttribute("username");

		if (null == username) {
			return "redirect:/touch/login";
		}
		if (0 == id && null != date) {
			List<TdUserRecentVisit> recentList = tdUserRecentVisitService.findByUsernameAndVisitDate(username, date);
			tdUserRecentVisitService.delete(recentList);

		} else if (-1 == id && null != date) {
			List<TdUserRecentVisit> recentList = tdUserRecentVisitService.findByUsername(username);
			tdUserRecentVisitService.delete(recentList);
		} else {
			TdUserRecentVisit recent = tdUserRecentVisitService.findOne(id);
			tdUserRecentVisitService.delete(id);
		}
		return "redirect:/touch/user/recent/list";
	}

	// listId 0-全部，1-未使用，2-已使用，3-已过期
	@RequestMapping(value = "/user/coupon/list/{listId}")
	public String couponList(HttpServletRequest req, Integer page, @PathVariable Integer listId, String username,
			Integer app, ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		if (null == page) {
			page = 0;
		}

		TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", tdUser);

		List<TdCoupon> coupanList = null;

		switch (listId) {
		case 0:
			coupanList = tdCouponService.findByMoblie(tdUser.getMobile()); // 全部优惠券
			break;
		case 1:
			coupanList = tdCouponService.findByMobileAndIsUseable(tdUser.getMobile()); // 未使用的优惠券
			break;
		case 2:
			coupanList = tdCouponService.findByMobileAndIsUsedTrue(tdUser.getMobile()); // 已使用的优惠券
			break;
		case 3:
			coupanList = tdCouponService
					.findByMobileAndExpireTimeBeforeAndIsDistributtedTrueAndIsUsedFalse(tdUser.getMobile()); // 已过期的优惠券
			break;
		default:
			coupanList = tdCouponService.findByMoblie(tdUser.getMobile()); // 全部优惠券
		}

		// 取得剩余天数 zhangji
		Date today = new Date();
		Calendar calendar1 = Calendar.getInstance();
		calendar1.setTime(today);
		if (null != coupanList) {
			for (TdCoupon cl : coupanList) {
				Date deadline = cl.getExpireTime();
				Calendar calendar2 = Calendar.getInstance();
				calendar2.setTime(deadline);
				Long num = calendar2.getTimeInMillis() - calendar1.getTimeInMillis();
				Double hourLeft = new Double(num / (1000 * 60 * 60)).doubleValue();
				Long dateLeft = new Long(num / (1000 * 24 * 60 * 60)).longValue();
				cl.setHourLeft(hourLeft);
				cl.setDateLeft(dateLeft);
			}
		}
		map.addAttribute("listId", listId);
		map.addAttribute("coupan_list", coupanList);

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}
		if (2L == listId.longValue()) {
			return "/touch/user_coupon_unuse";
		}
		return "/touch/user_coupon_useful";
	}

	/**
	 * @author lc
	 * @注释：优惠券详细信息
	 */
	@RequestMapping(value = "/user/coupon/edit")
	public String couponEdit(HttpServletRequest req, Integer page, String username, Integer app, Long couponId,
			ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		if (null != couponId) {
			TdCoupon tdCoupon = tdCouponService.findOne(couponId);
			map.addAttribute("tdCoupon", tdCoupon);

			if (null != tdCoupon) {
				TdCouponType tdCouponType = tdCouponTypeService.findOne(tdCoupon.getTypeId());
				map.addAttribute("tdCouponType", tdCouponType);
			}

		}

		return "/touch/user_coupon_edit";
	}

	/**
	 * 触屏版，跳转到抢券的页面
	 * 
	 * @author DengXiao
	 */
	@RequestMapping(value = "/user/get/coupon")
	public String userGetCoupon(HttpServletRequest req, ModelMap map) {
		String username = (String) req.getSession().getAttribute("username");
		if (null == username) {
			return "redirect:/touch/login";
		}
		// 优惠券种类
		List<TdCouponType> couponTypeList = tdCouponTypeService.findAllOrderBySortIdAsc();

		map.addAttribute("coupon_type_list", couponTypeList);

		if (null != couponTypeList) {
			for (TdCouponType ct : couponTypeList) {
				List<TdCoupon> couponList = tdCouponService.findByTypeIdAndIsDistributtedFalse(ct.getId());

				List<TdCoupon> disCouponList = tdCouponService
						.findByTypeIdAndIsDistributtedTrueOrderByIdDesc(ct.getId());

				if (null != couponList) {
					// 未领取优惠券
					map.addAttribute("coupon_" + ct.getId() + "_list", couponList);
				}

				// 已领取优惠券
				map.addAttribute("distributed_coupon_" + ct.getId() + "_list", disCouponList);
			}
		}
		// 传入用户信息
		TdUser tdUser = tdUserService.findByUsername(username);
		if (null != tdUser) {
			map.addAttribute("user", tdUser);
		}
		return "/touch/user_coupon_get";
	}

	/**
	 * 触屏抢券的方法
	 * 
	 * @author DengXiao
	 */
	@RequestMapping(value = "/user/get/coupon/add")
	@ResponseBody
	public Map<String, Object> userAddCoupon(HttpServletRequest req, ModelMap map, Long couponId, String username) {
		Map<String, Object> res = new HashMap<>();
		res.put("status", -1);

		if (null == couponId) {
			res.put("message", "未选择优惠券");
			return res;
		}

		TdCoupon leftCoupon = tdCouponService.findOne(couponId);

		TdUser tdUser = tdUserService.findByUsername(username);

		if (null == leftCoupon || leftCoupon.getLeftNumber().compareTo(1L) < 0) {
			res.put("message", leftCoupon.getTypeTitle() + "已被领完");
			return res;
		}

		TdCoupon coupon = tdCouponService
				.findByTypeIdAndUsernameAndIsDistributtedTrueAndIsOwnTrue(leftCoupon.getTypeId(), username);

		if (null != coupon) {
			res.put("message", "每个用户限领一张同类型优惠券");
			return res;
		}

		leftCoupon.setLeftNumber(leftCoupon.getLeftNumber() - 1L);
		leftCoupon.setGetNumber(leftCoupon.getGetNumber() + 1L);
		tdCouponService.save(leftCoupon);

		TdCouponType ctype = tdCouponTypeService.findOne(leftCoupon.getTypeId());

		TdCoupon getCoupon = new TdCoupon();

		// getCoupon.setDiySiteId(leftCoupon.getDiySiteId());
		// getCoupon.setDiySiteTitle(leftCoupon.getDiySiteTitle());
		getCoupon.setGetNumber(1L);
		getCoupon.setGetTime(new Date());

		if (null != ctype && null != ctype.getTotalDays()) {
			Calendar ca = Calendar.getInstance();
			ca.add(Calendar.DATE, ctype.getTotalDays().intValue());
			getCoupon.setExpireTime(ca.getTime());
		}

		getCoupon.setIsDistributted(true);
		getCoupon.setIsUsed(false);
		getCoupon.setIsOwn(true);
		if (null != tdUser.getMobile()) {
			getCoupon.setMobile(tdUser.getMobile());
		}
		if (null != leftCoupon.getTypeDescription()) {
			getCoupon.setTypeDescription(leftCoupon.getTypeDescription());
		}
		getCoupon.setTypeId(leftCoupon.getTypeId());
		if (null != leftCoupon.getTypePicUri()) {
			getCoupon.setTypePicUri(leftCoupon.getTypePicUri());
		}
		if (null != leftCoupon.getTypeTitle()) {
			getCoupon.setTypeTitle(leftCoupon.getTypeTitle());
		}
		if (null != leftCoupon.getPrice()) {
			getCoupon.setPrice(leftCoupon.getPrice());
		}
		if (null != leftCoupon.getTypeDescription()) {
			getCoupon.setTypeDescription(leftCoupon.getTypeDescription());
		}

		getCoupon.setUsername(username);

		tdCouponService.save(getCoupon);

		res.put("status", 0);
		return res;
	}

	/*
	 * 删除优惠券记录
	 * 
	 * @zhangji
	 */
	@RequestMapping(value = "/user/coupon/del")
	public String couponDel(HttpServletRequest req, Integer listId, Long id, Integer app, ModelMap map) {
		String username = (String) req.getSession().getAttribute("username");

		if (null == username) {
			return "redirect:/touch/login";
		}

		tdCommonService.setHeader(map, req);

		TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", tdUser);

		tdCouponService.delete(id);

		List<TdCoupon> coupanList = null;

		switch (listId) {
		case 0:
			coupanList = tdCouponService.findByMoblie(tdUser.getMobile()); // 全部优惠券
			break;
		case 1:
			coupanList = tdCouponService.findByMobileAndIsUseable(tdUser.getMobile()); // 未使用的优惠券
			break;
		case 2:
			coupanList = tdCouponService.findByMobileAndIsUsedTrue(tdUser.getMobile()); // 已使用的优惠券
			break;
		case 3:
			coupanList = tdCouponService
					.findByMobileAndExpireTimeBeforeAndIsDistributtedTrueAndIsUsedFalse(tdUser.getMobile()); // 已过期的优惠券
			break;
		default:
			coupanList = tdCouponService.findByMoblie(tdUser.getMobile()); // 全部优惠券
		}

		// 取得剩余天数 zhangji
		Date today = new Date();
		Calendar calendar1 = Calendar.getInstance();
		calendar1.setTime(today);

		for (TdCoupon cl : coupanList) {
			Date deadline = cl.getExpireTime();
			Calendar calendar2 = Calendar.getInstance();
			calendar2.setTime(deadline);
			Long num = calendar2.getTimeInMillis() - calendar1.getTimeInMillis();
			Double hourLeft = new Double(num / (1000 * 60 * 60)).doubleValue();
			Long dateLeft = new Long(num / (1000 * 24 * 60 * 60)).longValue();
			cl.setHourLeft(hourLeft);
			cl.setDateLeft(dateLeft);
		}

		map.addAttribute("coupan_list", coupanList);

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/user_coupon_list_detail";
	}

	@RequestMapping(value = "/user/point/list")
	public String pointList(HttpServletRequest req, Integer page, String username, Integer app, ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		if (null == page) {
			page = 0;
		}

		TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", tdUser);

		Page<TdUserPoint> pointPage = null;

		pointPage = tdUserPointService.findByUsername(username, page, ClientConstant.pageSize);

		map.addAttribute("point_page", pointPage);

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/user_point_list";
	}

	@RequestMapping(value = "/user/return/{orderId}")
	public String userReturn(HttpServletRequest req, @PathVariable Long orderId, Long id, // 商品ID
			String method, Integer app, String username, ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", tdUser);
		map.addAttribute("telephone", tdUser.getMobile());

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		if (null != orderId) {
			TdOrder tdOrder = tdOrderService.findOne(orderId);
			map.addAttribute("order", tdOrder);

			if (null != tdOrder && null != id) {
				for (TdOrderGoods tog : tdOrder.getOrderGoodsList()) {
					if (tog.getId().equals(id)) {
						// 已经退换货
						if (null != tog.getIsReturnApplied() && tog.getIsReturnApplied()) {
							map.addAttribute("has_returned", true);
							String orderNumber = tdOrder.getOrderNumber();
							TdUserReturn userReturn = tdUserReturnService
									.findByUsernameAndOrderNumberAndGoodsId(username, orderNumber, tog.getGoodsId());
							map.addAttribute("return", userReturn);
						}

						map.addAttribute("goodsId", tog.getGoodsId());
						map.addAttribute("orderId", orderId);
						map.addAttribute("order_goods", tog);

						return "/touch/user_return_edit";
					}
				}
			}
		}

		return "/touch/user_return_list";
	}

	@RequestMapping(value = "/user/return/save", method = RequestMethod.POST)
	public String returnSave(HttpServletRequest req, Boolean isReturn, Long goodsId, Long id, // 订单ID
			String reason, String telephone, ModelMap map) {
		String username = (String) req.getSession().getAttribute("username");

		if (null == username) {
			return "redirect:/touch/login";
		}

		tdCommonService.setHeader(map, req);

		if (null != id && null != goodsId) {
			TdOrder order = tdOrderService.findOne(id);

			if (null != order) {
				for (TdOrderGoods tog : order.getOrderGoodsList()) {
					if (goodsId.equals(tog.getGoodsId())) {
						TdUserReturn tdReturn = new TdUserReturn();

						tdReturn.setIsReturn(isReturn);

						// 用户
						tdReturn.setUsername(username);
						tdReturn.setTelephone(telephone);
						;

						// 退货订单商品
						tdReturn.setOrderNumber(order.getOrderNumber());
						tdReturn.setGoodsId(goodsId);
						tdReturn.setGoodsTitle(tog.getGoodsTitle());
						tdReturn.setGoodsPrice(tog.getPrice());
						tdReturn.setGoodsCoverImageUri(tog.getGoodsCoverImageUri());

						// 退货时间及原因
						tdReturn.setReason(reason);
						tdReturn.setReturnTime(new Date());

						tdReturn.setStatusId(0L);
						tdReturn.setReturnNumber(1L);

						// 保存
						tdUserReturnService.save(tdReturn);

						// 该商品已经退换货
						tog.setIsReturnApplied(true);
						tdOrderGoodsService.save(tog);
						break;
					}
				}
			}
		}

		return "redirect:/touch/user/return/list";
	}

	// zhangji
	@RequestMapping(value = "/user/comment/add", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> commentAdd(HttpServletRequest req, TdUserComment tdComment,
			String[] hid_photo_name_show360, Long orderId, Long ogId, String code, ModelMap map) {
		Map<String, Object> res = new HashMap<String, Object>();
		res.put("code", 1);

		String username = (String) req.getSession().getAttribute("username");

		if (null == username) {
			res.put("message", "请先登录！");
			return res;
		}

		if (null == tdComment.getGoodsId()) {
			res.put("message", "商品ID不能为空！");
			return res;
		}

		TdGoods goods = tdGoodsService.findOne(tdComment.getGoodsId());

		if (null == goods) {
			res.put("message", "评论的商品不存在！");
			return res;
		}

		// zhangji 图片uri
		String uris = parsePicUris(hid_photo_name_show360);

		tdComment.setShowPictures(uris);

		tdComment.setCommentTime(new Date());
		tdComment.setGoodsCoverImageUri(goods.getCoverImageUri());
		tdComment.setGoodsTitle(goods.getTitle());
		tdComment.setIsReplied(false);
		tdComment.setNegativeNumber(0L);
		tdComment.setPositiveNumber(0L);
		tdComment.setUsername(username);

		tdComment = tdUserCommentService.save(tdComment);

		// 设置订单信息
		if (null != orderId) {
			TdOrder tdOrder = tdOrderService.findOne(orderId);

			if (null != tdOrder) {
				tdComment.setOrderNumber(tdOrder.getOrderNumber());

				List<TdOrderGoods> ogList = tdOrder.getOrderGoodsList();

				for (TdOrderGoods og : ogList) {
					if (og.getId().equals(ogId)) {
						og.setIsCommented(true);
						og.setCommentId(tdComment.getId());
						tdOrder = tdOrderService.save(tdOrder);
						break;
					}
				}

				// 判断订单是否完成
				boolean allIsCommented = true;
				for (TdOrderGoods og : tdOrder.getOrderGoodsList()) {
					if (null == og.getIsCommented() || !og.getIsCommented()) {
						allIsCommented = false;
						break;
					}
				}

				if (allIsCommented) {
					tdOrder.setStatusId(6L);
					tdOrder = tdOrderService.save(tdOrder);
				}
			}
		}

		TdUser user = tdUserService.findByUsernameAndIsEnabled(username);

		if (null != user) {
			tdComment.setUserHeadUri(user.getHeadImageUri());
		}

		tdComment.setStatusId(0L);

		tdComment = tdUserCommentService.save(tdComment);

		if (null == goods.getTotalComments()) {
			goods.setTotalComments(1L);
		} else {
			goods.setTotalComments(goods.getTotalComments() + 1L);
		}

		res.put("code", 0);

		return res;
	}

	@RequestMapping(value = "/user/comment/sec")
	public String commentSec(HttpServletRequest req, Long commentId, Integer app, ModelMap map) {

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/comment_sec";
	}

	@RequestMapping(value = "/user/comment/edit")
	public String commentedit(Long goodsId, Long orderId, Integer app, String username, HttpServletRequest req,
			ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		if (null == orderId) {
			return "/touch/error_404";
		}
		tdCommonService.setHeader(map, req);

		// TdOrderGoods tdOrderGoods = tdOrderGoodsService.findOne(goodsId);
		// if (null == tdOrderGoods) {
		// return "/touch/error_404";
		// }
		// map.addAttribute("tdOrderGoods", tdOrderGoods);
		// map.addAttribute("orderId", orderId);
		//
		// if (null != tdOrderGoods && null != tdOrderGoods.getCommentId()) {
		// TdUserComment uc = tdUserCommentService
		// .findOne(tdOrderGoods.getCommentId());
		// map.addAttribute("comment", uc);
		// }

		// 查找订单所有商品
		TdOrder tdOrder = tdOrderService.findOne(orderId);
		map.addAttribute("order", tdOrder);
		if (null != tdOrder && null != tdOrder.getOrderGoodsList()) {
			map.addAttribute("order_goods_list", tdOrder.getOrderGoodsList());
			for (int i = 0; i < tdOrder.getOrderGoodsList().size(); i++) {
				TdOrderGoods tdOrderGoods = tdOrder.getOrderGoodsList().get(i);
				if (null != tdOrderGoods.getCommentId()) {
					TdUserComment uc = tdUserCommentService.findOne(tdOrderGoods.getCommentId());
					map.addAttribute("comment_" + i, uc);
				}
			}
		}

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/user_comment_edit";
	}

	@RequestMapping(value = "/user/comment/list")
	public String commentList(HttpServletRequest req, Integer page, Integer app, String username, Integer statusId, // 0表示未评价,
																													// 1表示已评价
			String keywords, ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		if (null == page) {
			page = 0;
		}

		if (null == statusId) {
			statusId = 0;
		}

		TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", tdUser);

		if (null != tdUser) {
			if (0 == statusId) {
				// 查找该用户的未评价订单
				if (null != keywords) {
					Page<TdOrder> orderPage = tdOrderService.findByUsernameAndSearch(username, keywords, page,
							ClientConstant.pageSize);
					map.addAttribute("order_page", orderPage);
					if (null != orderPage) {
						for (TdOrder tdOrder : orderPage.getContent()) {
							if (null != tdOrder) {
								for (TdOrderGoods og : tdOrder.getOrderGoodsList()) {
									if (null != og && null != og.getCommentId()) {
										TdUserComment uc = tdUserCommentService.findOne(og.getCommentId());
										map.addAttribute("comment_" + tdOrder.getId() + "_" + og.getId(), uc);
									}
								}
							}
						}
					}
				} else {
					Page<TdOrder> orderPage = tdOrderService.findByUsernameAndStatusId(username, 5L, page,
							ClientConstant.pageSize);
					map.addAttribute("order_page", orderPage);
					if (null != orderPage) {
						for (TdOrder tdOrder : orderPage.getContent()) {
							if (null != tdOrder) {
								for (TdOrderGoods og : tdOrder.getOrderGoodsList()) {
									if (null != og && null != og.getCommentId()) {
										TdUserComment uc = tdUserCommentService.findOne(og.getCommentId());
										map.addAttribute("comment_" + tdOrder.getId() + "_" + og.getId(), uc);
									}
								}
							}
						}
					}
				}
				// map.addAttribute("order_page", tdOrderService
				// .findByUsernameAndStatusId(username, 5L, page,
				// ClientConstant.pageSize));
			} else {
				// 查找该用户的已评价订单
				Page<TdOrder> orderPage = tdOrderService.findByUsernameAndStatusId(username, 6L, page,
						ClientConstant.pageSize);
				map.addAttribute("order_page", orderPage);

				if (null != orderPage) {
					for (TdOrder tdOrder : orderPage.getContent()) {
						if (null != tdOrder) {
							for (TdOrderGoods og : tdOrder.getOrderGoodsList()) {
								if (null != og && null != og.getCommentId()) {
									TdUserComment uc = tdUserCommentService.findOne(og.getCommentId());
									map.addAttribute("comment_" + tdOrder.getId() + "_" + og.getId(), uc);
								}
							}
						}
					}
				}
			}
		}

		map.addAttribute("statusId", statusId);

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/user_comment_list";
	}

	@RequestMapping(value = "/user/consult/add", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> consultAdd(HttpServletRequest req,
			// TdUserConsult tdConsult,
			Long goodsId, String content, String code, ModelMap map) {
		Map<String, Object> res = new HashMap<String, Object>();
		res.put("code", 1);

		String username = (String) req.getSession().getAttribute("username");

		if (null == username) {
			res.put("message", "请先登录！");
			return res;
		}

		// if (null == tdConsult.getGoodsId())
		// {
		// res.put("message", "商品ID不能为空！");
		// return res;
		// }

		// TdGoods goods = tdGoodsService.findOne(tdConsult.getGoodsId());

		if (null == goodsId) {
			res.put("message", "商品ID不能为空！");
			return res;
		}
		if (null == content) {
			res.put("message", "请输入咨询内容！");
			return res;
		}

		TdGoods goods = tdGoodsService.findOne(goodsId);
		if (null == goods) {
			res.put("message", "咨询的商品不存在！");
			return res;
		}

		// String codeBack = (String)
		// req.getSession().getAttribute("RANDOMVALIDATECODEKEY");
		//
		// if (!codeBack.equalsIgnoreCase(code))
		// {
		// res.put("message", "验证码不匹配！");
		// return res;
		// }
		TdUserConsult tdConsult = new TdUserConsult();
		tdConsult.setGoodsId(goodsId);
		tdConsult.setContent(content);
		tdConsult.setConsultTime(new Date());
		tdConsult.setGoodsCoverImageUri(goods.getCoverImageUri());
		tdConsult.setGoodsTitle(goods.getTitle());
		tdConsult.setIsReplied(false);
		tdConsult.setStatusId(0L);
		tdConsult.setUsername(username);

		TdUser user = tdUserService.findByUsernameAndIsEnabled(username);
		if (null != user) {
			tdConsult.setUserHeadImageUri(user.getHeadImageUri());
		}

		tdUserConsultService.save(tdConsult);

		res.put("code", 0);

		return res;
	}

	@RequestMapping(value = "/user/consult/list")
	public String consultList(HttpServletRequest req, Integer page, String keywords, Integer app, String username,
			ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		if (null == page) {
			page = 0;
		}

		TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", tdUser);

		Page<TdUserConsult> consultPage = null;

		if (null == keywords || keywords.isEmpty()) {
			consultPage = tdUserConsultService.findByUsername(username, page, ClientConstant.pageSize);
		} else {
			consultPage = tdUserConsultService.findByUsernameAndSearch(username, keywords, page,
					ClientConstant.pageSize);
		}

		map.addAttribute("consult_page", consultPage);
		map.addAttribute("keywords", keywords);

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/user_consult_list";
	}

	/*
	 * 投诉
	 * 
	 * @zhangji
	 */
	@RequestMapping(value = "/user/complain/list")
	public String complainList(HttpServletRequest req, Integer page, String keywords, Integer app, String username,
			ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		if (null == page) {
			page = 0;
		}

		TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", tdUser);

		Page<TdOrder> complainPage = null;

		if (null != keywords && !keywords.isEmpty()) {
			complainPage = tdOrderService.findByUsernameAndSearch(username, keywords, page, ClientConstant.pageSize);
		} else {
			complainPage = tdOrderService.findByUsername(username, page, ClientConstant.pageSize);
		}

		map.addAttribute("complain_page", complainPage);
		map.addAttribute("keywords", keywords);

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/user_complain_list";
	}

	@RequestMapping(value = "/user/complain/add", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> complainAdd(HttpServletRequest req, TdUserComplain tdComplain, String code,
			ModelMap map) {
		Map<String, Object> res = new HashMap<String, Object>();
		res.put("code", 1);

		String username = (String) req.getSession().getAttribute("username");

		if (null == username) {
			res.put("message", "请先登录！");
			return res;
		}

		if (null != tdUserComplainService.findByUsernameAndOrderId(username, tdComplain.getOrderId())) {
			res.put("message", "该订单已提交投诉，请勿重复提交。");
			return res;
		}
		if (null == tdComplain.getOrderId()) {
			res.put("message", "订单ID不能为空！");
			return res;
		}

		TdOrder order = tdOrderService.findOne(tdComplain.getOrderId());

		if (null == order) {
			res.put("message", "投诉的订单不存在！");
			return res;
		}

		tdComplain.setConsultTime(new Date());
		tdComplain.setOrderId(order.getId());
		tdComplain.setOrderNumber(order.getOrderNumber());
		tdComplain.setIsReplied(false);
		tdComplain.setStatusId(0L);
		tdComplain.setUsername(username);

		TdUser user = tdUserService.findByUsernameAndIsEnabled(username);
		if (null != user) {
			tdComplain.setUserHeadImageUri(user.getHeadImageUri());
		}

		tdUserComplainService.save(tdComplain);

		res.put("code", 0);
		return res;
	}

	/**
	 * @author lc @注释：
	 */
	@RequestMapping(value = "/user/addressAdd")
	public String address(Long addressId, Long manage, Long pointGoodsId, HttpServletRequest req, String username,
			ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		if (null != addressId) {
			map.addAttribute("address", tdShippingAddressService.findOne(addressId));
		}

		// 判断是否为积分商品订单
		if (null != pointGoodsId) {
			map.addAttribute("pointGoodsId", pointGoodsId);
		}

		map.addAttribute("manage", manage);

		return "/touch/user_address_add";
	}

	@RequestMapping(value = "/user/address/ajax/add")
	@ResponseBody
	public Map<String, Object> addAddress(String receiverName, Long manage, Long addressId, String prov, String city,
			String dist, String detail, String postcode, String mobile, Boolean isDefaultAddress,
			HttpServletRequest req) {
		Map<String, Object> res = new HashMap<String, Object>();

		res.put("code", 1);

		String username = (String) req.getSession().getAttribute("username");

		if (null == username) {
			res.put("message", "请先登录");
			return res;
		}

		TdUser user = tdUserService.findByUsernameAndIsEnabled(username);

		if (null == user) {
			res.put("message", "该用户不存在");
			return res;
		}

		if (null != addressId) {
			TdShippingAddress address = tdShippingAddressService.findOne(addressId);

			address.setReceiverName(receiverName);
			address.setProvince(prov);
			address.setCity(city);
			address.setDisctrict(dist);
			address.setDetailAddress(detail);
			address.setPostcode(postcode);
			address.setReceiverMobile(mobile);

			// 判断是否为默认地址
			if (null != user.getShippingAddressList() && !user.getShippingAddressList().isEmpty()
					&& null != isDefaultAddress && isDefaultAddress) {
				for (TdShippingAddress tdShippingAddress : user.getShippingAddressList()) {
					if (tdShippingAddress.getId().equals(addressId)) {
						tdShippingAddress.setIsDefaultAddress(true);
					} else {
						tdShippingAddress.setIsDefaultAddress(false);
					}
					tdShippingAddressService.save(tdShippingAddress);
				}
			}

			tdShippingAddressService.save(address);

			res.put("code", 2);
			return res;
		} else {
			TdShippingAddress address = new TdShippingAddress();

			address.setReceiverName(receiverName);
			address.setProvince(prov);
			address.setCity(city);
			address.setDisctrict(dist);
			address.setDetailAddress(detail);
			address.setPostcode(postcode);
			address.setReceiverMobile(mobile);

			// 判断是否为默认地址
			if (null != user.getShippingAddressList() && !user.getShippingAddressList().isEmpty()
					&& null != isDefaultAddress && isDefaultAddress) {
				for (TdShippingAddress tdShippingAddress : user.getShippingAddressList()) {

					tdShippingAddress.setIsDefaultAddress(false);

					tdShippingAddressService.save(tdShippingAddress);
				}

			}

			address.setIsDefaultAddress(isDefaultAddress);

			user.getShippingAddressList().add(address);

			tdShippingAddressService.save(address);

			tdUserService.save(user);
		}

		res.put("code", 0);

		if (null != manage) {
			res.put("code", 2);
		}

		return res;
	}

	/**
	 * @author lc
	 * @注释：专用于订单提交
	 */
	@RequestMapping(value = "/user/address/ajax/changedefault")
	@ResponseBody
	public Map<String, Object> addAddress(Long id, HttpServletRequest req) {
		Map<String, Object> res = new HashMap<String, Object>();

		res.put("code", 1);

		String username = (String) req.getSession().getAttribute("username");

		if (null == username) {
			res.put("message", "请先登录");
			return res;
		}

		TdUser user = tdUserService.findByUsernameAndIsEnabled(username);

		if (null == user) {
			res.put("message", "用户不存在");
			return res;
		}

		if (null != user.getShippingAddressList() && !user.getShippingAddressList().isEmpty() && null != id) {
			for (TdShippingAddress tdShippingAddress : user.getShippingAddressList()) {
				if (tdShippingAddress.getId().equals(id)) {
					tdShippingAddress.setIsDefaultAddress(true);
				} else {
					tdShippingAddress.setIsDefaultAddress(false);
				}
				tdShippingAddressService.save(tdShippingAddress);
			}
		}

		res.put("code", 0);

		return res;
	}

	/**
	 * @author lc @注释：
	 */

	@RequestMapping(value = "/user/address/{method}")
	public String address(HttpServletRequest req, Long manage, Long pointGoodsId, @PathVariable String method, Long id,
			TdShippingAddress tdShippingAddress, Integer app, String username, ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		TdUser user = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", user);

		if (null != user) {
			List<TdShippingAddress> addressList = user.getShippingAddressList();

			if (null != method && !method.isEmpty()) {
				if (method.equalsIgnoreCase("update")) {
					if (null != id) {
						// map.addAttribute("address", s)
						for (TdShippingAddress add : addressList) {
							if (add.getId().equals(id)) {
								map.addAttribute("address", add);
							}
						}
					}
				} else if (method.equalsIgnoreCase("delete")) {
					if (null != id) {
						for (TdShippingAddress add : addressList) {
							if (add.getId().equals(id)) {
								addressList.remove(id);
								user.setShippingAddressList(addressList);
								tdShippingAddressService.delete(add);
								if (null != manage) {
									return "redirect:/touch/user/addressManage";
								}
								if (null != pointGoodsId) {
									return "redirect:/touch/user/address/list?pointGoodsId=" + pointGoodsId;
								}
								return "redirect:/touch/user/address/list";
							}
						}
					}
				} else if (method.equalsIgnoreCase("save")) {
					// 修改
					if (null != tdShippingAddress.getId()) {
						tdShippingAddressService.save(tdShippingAddress);
					}
					// 新增
					else {
						addressList.add(tdShippingAddressService.save(tdShippingAddress));
						user.setShippingAddressList(addressList);
						tdUserService.save(user);
					}

					return "redirect:/touch/user/address/list";
				}
			}

			map.addAttribute("address_list", user.getShippingAddressList());
		}

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		// 判断是否为 积分商品订单
		if (null != pointGoodsId) {
			map.addAttribute("pointGoodsId", pointGoodsId);
		}

		return "/touch/user_address_list";
	}

	/**
	 * @author lc
	 * @注释：个人中心地址管理
	 */
	@RequestMapping(value = "/user/addressManage")
	public String addressmanage(HttpServletRequest req, String username, Long id, Integer app, ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		TdUser user = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", user);
		if (null != user) {
			List<TdShippingAddress> addressList = user.getShippingAddressList();

			map.addAttribute("address_list", addressList);
		}

		return "/touch/user_address_manage";
	}

	// /**
	// * @author lc
	// * @注释：
	// */
	// @RequestMapping(value = "/user/addressmanageAdd")
	// public String address(Long addressId, HttpServletRequest req, ModelMap
	// map){
	// String username = (String) req.getSession().getAttribute("username");
	//
	// if (null == username)
	// {
	// return "redirect:/touch/login";
	// }
	//
	// tdCommonService.setHeader(map, req);
	//
	// if (null != addressId) {
	// map.addAttribute("address", tdShippingAddressService.findOne(addressId));
	// }
	//
	// return "/touch/user_addressmanage_edit";
	// }

	@RequestMapping(value = "/user/distributor/return")
	public String distributorReturnList(HttpServletRequest req, String username, Integer page, Integer app,
			ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		if (null == page) {
			page = 0;
		}

		TdUser user = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", user);
		map.addAttribute("reward_page",
				tdUserCashRewardService.findByUsernameOrderByIdDesc(username, page, ClientConstant.pageSize));

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/user_distributor_return";
	}

	@RequestMapping(value = "/user/distributor/lower")
	public String distributorLowerList(HttpServletRequest req, Integer app, String username, Integer page,
			ModelMap map) {

		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		if (null == page) {
			page = 0;
		}

		TdUser user = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", user);
		map.addAttribute("lower_page",
				tdUserService.findByUpperUsernameAndIsEnabled(username, page, ClientConstant.pageSize));

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/user_distributor_lower";
	}

	@RequestMapping(value = "/user/distributor/bankcard")
	public String distributorLowerList(HttpServletRequest req, Integer app, String username, ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		TdUser user = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", user);

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/user_distributor_bankcard";
	}

	/**
	 * 返现商品列表
	 * 
	 * @param req
	 * @param page
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/user/distributor/goods")
	public String distributorGoodsList(HttpServletRequest req, String keywords, Integer page, Integer app,
			String username, ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		if (null == page) {
			page = 0;
		}

		TdUser user = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", user);

		if (null == keywords || keywords.isEmpty()) {
			map.addAttribute("goods_page",
					tdGoodsService.findByReturnPriceNotZeroAndIsOnSaleTrue(page, ClientConstant.pageSize));
		} else {
			map.addAttribute("goods_page", tdGoodsService.findByReturnPriceNotZeroAndSearchAndIsOnSaleTrue(page,
					ClientConstant.pageSize, keywords));
		}

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/user_distributor_goods";
	}

	@RequestMapping(value = "/user/info", method = RequestMethod.GET)
	public String userInfo(HttpServletRequest req, String username, Integer app, ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		TdUser user = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", user);

		map.addAttribute("recommend_goods_page",
				tdGoodsService.findByIsRecommendTypeTrueAndIsOnSaleTrueOrderByIdDesc(0, ClientConstant.pageSize));

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/user_info";
	}

	@RequestMapping(value = "/user/info", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> userInfo(HttpServletRequest req, String realName, String sex, String email,
			String mobile, String province, String city, String disctrict, String bankCardCode, String bankTitle,
			ModelMap map) {
		Map<String, Object> res = new HashMap<String, Object>();
		res.put("code", 1);

		String username = (String) req.getSession().getAttribute("username");

		if (null == username) {
			res.put("msg", "登录超时！");
			return res;
		}

		TdUser user = tdUserService.findByUsernameAndIsEnabled(username);

		if (null != email && null != mobile) {
			user.setRealName(realName);
			user.setSex(sex);
			user.setEmail(email);
			user.setMobile(mobile);
			// user.setProvince(province);
			// user.setCity(city);
			// user.setDistrict(disctrict);
			user.setBankCardCode(bankCardCode);
			user.setBankTitle(bankTitle);
			user = tdUserService.save(user);

		}

		res.put("code", 0);
		return res;
	}

	@RequestMapping(value = "/user/password", method = RequestMethod.GET)
	public String userPassword(HttpServletRequest req, String username, Integer app, ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		TdUser user = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", user);

		// 判断是否为app链接
		if (null == app) {
			Integer isApp = (Integer) req.getSession().getAttribute("app");
			if (null != isApp) {
				map.addAttribute("app", isApp);
			}
		} else {
			map.addAttribute("app", app);
		}

		return "/touch/user_change_password";
	}

	@RequestMapping(value = "/user/password", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> userPassword(HttpServletRequest req, String oldPassword, String newPassword,
			ModelMap map) {
		Map<String, Object> res = new HashMap<String, Object>();
		res.put("code", 1);

		String username = (String) req.getSession().getAttribute("username");

		if (null == username) {
			res.put("msg", "请先登录！");
			return res;
		}

		TdUser user = tdUserService.findByUsernameAndIsEnabled(username);

		if (user.getPassword().equals(oldPassword)) {
			user.setPassword(newPassword);
		}

		map.addAttribute("user", tdUserService.save(user));

		res.put("code", 0);
		return res;
	}

	/**
	 * @author lc
	 * @注释：下级用户列表
	 */
	@RequestMapping(value = "/user/junioruser/list")
	public String junioruserList(Integer page, HttpServletRequest req, String username, ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		if (null == page) {
			page = 0;
		}

		TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", tdUser);

		Page<TdUser> userPage = null;

		userPage = tdUserService.findByUpperUsernameAndIsEnabled(username, page, ClientConstant.pageSize);
		map.addAttribute("junioruser_page", userPage);

		return "/touch/user_junioruser_list";
	}

	@RequestMapping(value = "/user/lowerusers/order/list")
	public String lowerUsersOrderList(Integer page, String lowerusername, HttpServletRequest req, String username,
			ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		if (null == lowerusername) {
			return "/touch/error_404";
		}

		tdCommonService.setHeader(map, req);

		if (null == page) {
			page = 0;
		}

		map.addAttribute("order_page", tdOrderService.findByUsername(lowerusername, page, ClientConstant.pageSize));
		TdSetting tdSetting = tdSettingService.findTopBy();
		map.addAttribute("setting", tdSetting);
		return "/touch/loweruser_order_list";
	}

	/**
	 * @author lc
	 * @注释：账户信息
	 */
	@RequestMapping(value = "/user/account/info")
	public String accountInfo(Integer page, HttpServletRequest req, String username, ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		if (null == page) {
			page = 0;
		}

		tdCommonService.setHeader(map, req);
		TdUser tdUser = tdUserService.findByUsername(username);

		map.addAttribute("user", tdUser);

		map.addAttribute("withdraw_page",
				tdUserWithdrawService.findByUsernameOrderByIdDesc(username, page, ClientConstant.pageSize));

		return "/touch/user_account_info";
	}

	/**
	 * @author lc
	 * @注释：申请提现
	 */
	@RequestMapping(value = "/user/withdraw/edit")
	public String cashreward(HttpServletRequest req, String username, ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		TdUser tdUser = tdUserService.findByUsername(username);

		map.addAttribute("user", tdUser);

		return "/touch/user_withdraw_request";
	}

	@RequestMapping(value = "/user/withdraw/request", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> cashreward(Double withdraw, String realName, String bankTitle, String bankCardCode,
			String mobile, HttpServletRequest req, ModelMap map) {
		Map<String, Object> res = new HashMap<String, Object>();

		res.put("code", 1);
		String username = (String) req.getSession().getAttribute("username");

		if (null == username) {
			res.put("msg", "请重新登录！");
			return res;
		}

		if (null == withdraw) {
			res.put("msg", "提交失败！");
			return res;
		}

		TdSetting tdSetting = tdSettingService.findTopBy();
		if (null != tdSetting.getMinWithdraw()) {
			if (withdraw < tdSetting.getMinWithdraw()) {
				res.put("msg", "提现金额必须大于" + tdSetting.getMinWithdraw());
				return res;
			}
			if (withdraw % 100 != 0) {
				res.put("msg", "提现金额必须为100的整数倍");
				return res;
			}
		}

		// tdCommonService.setHeader(map, req);
		TdUser tdUser = tdUserService.findByUsername(username);

		map.addAttribute("user", tdUser);

		if (null != withdraw && null != realName && null != bankTitle && null != bankCardCode && null != mobile) {

			// 根据用户角色不同来判断提现内容 用户提现角色分为 分销用户提现和 商城会员提现
			if (null != tdUser.getRoleId()) {
				if (tdUser.getRoleId().equals(1L)) { // 分销用户提现
					if (null != tdUser.getTotalCashRewards()) {
						if (withdraw > tdUser.getTotalCashRewards()) {
							// 金额为小于返现的最大100整数倍
							Double temp = (double) (tdUser.getTotalCashRewards() % 100);

							withdraw = tdUser.getTotalCashRewards() - temp;
						} else if (withdraw < 0) {
							withdraw = 0.0;
						}

						TdUserWithdraw tdUserWithdraw = new TdUserWithdraw();

						tdUserWithdraw.setUsername(username);
						tdUserWithdraw.setRealName(realName);
						tdUserWithdraw.setWithdrawTime(new Date());
						tdUserWithdraw.setTotalWithdraw(withdraw);
						tdUserWithdraw.setBankName(bankTitle);
						tdUserWithdraw.setBankCardNumber(bankCardCode);
						tdUserWithdraw.setMobile(mobile);
						tdUserWithdraw.setSortId(99L);
						tdUserWithdraw.setIsReplied(false);
						tdUserWithdraw.setStatusId(0L);
						tdUserWithdraw.setRoleId(1L);
						tdUserWithdrawService.save(tdUserWithdraw);

						res.put("code", 0);
						return res;
						// tdUser.setTotalCashRewards((long)
						// (tdUser.getTotalCashRewards() - withdraw));
						// tdUserService.save(tdUser);
					}
				} else if (tdUser.getRoleId().equals(2L)) { // 商城用户提现
					if (null != tdUser.getFrozenCapital() && null != tdUser.getVirtualCurrency()) {
						// 提现金额
						Double canWithdraw = 0.0;
						canWithdraw = tdUser.getVirtualCurrency() - tdUser.getFrozenCapital();
						if (canWithdraw < 0) {
							canWithdraw = 0.0;
						}

						if (withdraw > canWithdraw) {
							Double temp = canWithdraw % 100;
							withdraw = canWithdraw - temp;
						} else if (withdraw < 0) {
							withdraw = 0.0;
						}

						TdUserWithdraw tdUserWithdraw = new TdUserWithdraw();

						tdUserWithdraw.setUsername(username);
						tdUserWithdraw.setRealName(realName);
						tdUserWithdraw.setWithdrawTime(new Date());
						tdUserWithdraw.setTotalWithdraw(withdraw);
						tdUserWithdraw.setBankName(bankTitle);
						tdUserWithdraw.setBankCardNumber(bankCardCode);
						tdUserWithdraw.setMobile(mobile);
						tdUserWithdraw.setSortId(99L);
						tdUserWithdraw.setIsReplied(false);
						tdUserWithdraw.setStatusId(0L);
						tdUserWithdraw.setRoleId(2L);
						tdUserWithdrawService.save(tdUserWithdraw);

						res.put("code", 0);
						return res;
					}
				} else if (tdUser.getRoleId().equals(3L)) {
					if (null != tdUser.getDirectSaleCashRewards()) {
						if (withdraw > tdUser.getDirectSaleCashRewards()) {

							// 金额为小于返现的最大100整数倍
							Double temp = (double) (tdUser.getDirectSaleCashRewards() % 100);

							withdraw = tdUser.getDirectSaleCashRewards() - temp;
						} else if (withdraw < 0) {
							withdraw = 0.0;
						}

						TdUserWithdraw tdUserWithdraw = new TdUserWithdraw();

						tdUserWithdraw.setUsername(username);
						tdUserWithdraw.setRealName(realName);
						tdUserWithdraw.setWithdrawTime(new Date());
						tdUserWithdraw.setTotalWithdraw(withdraw);
						tdUserWithdraw.setBankName(bankTitle);
						tdUserWithdraw.setBankCardNumber(bankCardCode);
						tdUserWithdraw.setMobile(mobile);
						tdUserWithdraw.setSortId(99L);
						tdUserWithdraw.setIsReplied(false);
						tdUserWithdraw.setStatusId(0L);
						tdUserWithdraw.setRoleId(3L);
						tdUserWithdrawService.save(tdUserWithdraw);

						res.put("code", 0);
						return res;
						// tdUser.setTotalCashRewards((long)
						// (tdUser.getTotalCashRewards() - withdraw));
						// tdUserService.save(tdUser);
					}
				}
			}

		}
		return res;
	}

	@RequestMapping(value = "/user/myprize/list")
	public String prizeList(HttpServletRequest req, Integer page, String username, ModelMap map) {
		if (null == username) {
			username = (String) req.getSession().getAttribute("username");
			if (null == username) {
				return "redirect:/touch/login";
			}
		}

		tdCommonService.setHeader(map, req);

		if (null == page) {
			page = 0;
		}

		TdUser tdUser = tdUserService.findByUsernameAndIsEnabled(username);

		map.addAttribute("user", tdUser);

		Page<TdPrize> prizePage = null;

		prizePage = tdPrizeService.findByUsername(page, ClientConstant.pageSize, username);

		map.addAttribute("prize_page", prizePage);

		return "/touch/user_prize_list";
	}

	@ModelAttribute
	public void getModel(@RequestParam(value = "addressId", required = false) Long addressId, Model model) {
		if (addressId != null) {
			model.addAttribute("tdShippingAddress", tdShippingAddressService.findOne(addressId));
		}
	}

	/**
	 * 图片地址字符串整理，多张图片用,隔开
	 * 
	 * @param params
	 * @return
	 */
	private String parsePicUris(String[] uris) {
		if (null == uris || 0 == uris.length) {
			return null;
		}

		String res = "";

		for (String item : uris) {
			String uri = item.substring(item.indexOf("|") + 1, item.indexOf("|", 2));

			if (null != uri) {
				res += uri;
				res += ",";
			}
		}

		return res;
	}

	/**
	 * 订单支付成功后步骤
	 * 
	 * @param tdOrder
	 *            订单
	 */
	private void afterPaySuccess(TdOrder tdOrder) {
		if (null == tdOrder) {
			return;
		}

		// 用户
		TdUser tdUser = tdUserService.findByUsername(tdOrder.getUsername());

		if (null == tdUser) {
			return;
		}

		// 设置消费总额
		if (null != tdUser.getTotalSpendCash()) {
			tdUser.setTotalSpendCash(tdUser.getTotalSpendCash() + tdOrder.getTotalPrice());
		} else {
			tdUser.setTotalSpendCash(tdOrder.getTotalPrice());
		}

		// 设置抢购最后时间
		if (null != tdOrder.getTypeId() && tdOrder.getTypeId().equals(3L)) {
			Date nextTime = new Date();

			Calendar calendar = Calendar.getInstance();

			calendar.setTime(nextTime);

			calendar.add(Calendar.DATE, 30);

			tdUser.setLastFlashBuyTime(calendar.getTime());
			tdUser = tdUserService.save(tdUser);
		}

		if (tdOrder.getStatusId().equals(2L)) {
			tdOrder.setPayTime(new Date()); // 设置付款时间
		}

		// 待发货
		if (tdOrder.getStatusId().equals(2L)) {
			tdOrder.setStatusId(3L);
		}
		tdOrder = tdOrderService.save(tdOrder);

		// 虚拟货币扣除
		// if (null != tdOrder.getVirtualCurrencyUse() && null !=
		// tdUser.getVirtualCurrency()) {
		// if (tdUser.getVirtualCurrency() > tdOrder.getVirtualCurrencyUse()) {
		// tdUser.setVirtualCurrency(tdUser.getVirtualCurrency() -
		// tdOrder.getVirtualCurrencyUse());
		// }else {
		// tdUser.setVirtualCurrency(0.0);
		// }
		// tdUserService.save(tdUser);
		// }
		// 虚拟货币扣除

		// 分享用户

		// 分销用户返利（下级用户返利给上级用户）
		if (null != tdUser.getUpperUsername()) {
			TdUser tdUser2 = tdUserService.findByUsername(tdUser.getUpperUsername());
			TdSetting tdSetting = tdSettingService.findTopBy();
			if (null != tdSetting && null != tdSetting.getReturnRation() && null != tdUser2
					&& null != tdUser2.getRoleId() && tdUser2.getRoleId().equals(1L)) {
				// 返现记录
				TdUserCashReward tdUserCashReward = new TdUserCashReward();

				tdUserCashReward.setLowerUsername(tdOrder.getUsername());
				tdUserCashReward.setUsername(tdUser.getUpperUsername());
				tdUserCashReward.setRewardTime(new Date());

				// 返现金额分情况计算
				if (null != tdUser2.getReturnRation()) {
					tdUserCashReward.setCashReward(tdOrder.getTotalGoodsPrice() * tdUser2.getReturnRation());
				} else {
					tdUserCashReward.setCashReward(tdOrder.getTotalGoodsPrice() * tdSetting.getReturnRation());
				}

				if (null != tdUser.getTotalCashRewards()) {
					if (null != tdUser2.getReturnRation()) {
						tdUserCashReward.setTotalCashReward((long) (tdUser.getTotalCashRewards()
								+ tdOrder.getTotalGoodsPrice() * tdUser2.getReturnRation()));
					} else {
						tdUserCashReward.setTotalCashReward((long) (tdUser.getTotalCashRewards()
								+ tdOrder.getTotalGoodsPrice() * tdSetting.getReturnRation()));
					}

				} else {
					if (null != tdUser2.getReturnRation()) {
						tdUserCashReward
								.setTotalCashReward((long) (tdOrder.getTotalGoodsPrice() * tdUser2.getReturnRation()));
					} else {
						tdUserCashReward
								.setTotalCashReward((long) (tdOrder.getTotalGoodsPrice() * tdSetting.getReturnRation()));
					}

				}
				tdUserCashReward.setOrderNumber(tdOrder.getOrderNumber());

				if (null != tdUser.getBankTitle()) {
					tdUserCashReward.setBankName(tdUser.getBankTitle());
				}
				if (null != tdUser.getBankCardCode()) {
					tdUserCashReward.setBankCardNumber(tdUser.getBankCardCode());
				}

				tdUserCashReward.setOrderPrice(tdOrder.getTotalPrice());
				tdUserCashReward.setSortId(99L);

				tdUserCashRewardService.save(tdUserCashReward);

				Double totalReturn = 0.0;
				if (null != tdUser2.getReturnRation()) {
					totalReturn = tdOrder.getTotalGoodsPrice() * tdUser2.getReturnRation();
				} else {
					totalReturn = tdOrder.getTotalGoodsPrice() * tdSetting.getReturnRation();
				}

				if (totalReturn < 0) {
					totalReturn = 0.0;
				}

				TdUser upperuser = tdUserService.findByUsername(tdUser.getUpperUsername());
				if (null != upperuser) {
					// 返现总笔数
					if (null != upperuser.getTotalCashRewardsNumber()) {
						upperuser.setTotalCashRewardsNumber(upperuser.getTotalCashRewardsNumber() + 1);
					} else {
						upperuser.setTotalCashRewardsNumber(1L);
					}

					// 返现金额
					if (null != upperuser.getTotalCashRewards()) {
						upperuser.setTotalCashRewards((long) (upperuser.getTotalCashRewards() + totalReturn));
					} else {
						upperuser.setTotalCashRewards((long) (totalReturn + 0L));
					}
				}

				tdUserService.save(upperuser);

				// 返现给上级用户总数
				if (null != tdUser.getTotalCashRewardsToUpuser()) {
					tdUser.setTotalCashRewardsToUpuser((long) (tdUser.getTotalCashRewardsToUpuser() + totalReturn));
				} else {
					tdUser.setTotalCashRewardsToUpuser((long) (totalReturn + 0L));
				}

				tdUserService.save(tdUser);
			}
		}

		// 分销用户自己返利
		if (null != tdUser.getRoleId() && tdUser.getRoleId().equals(1L)) {
			TdSetting tdSetting = tdSettingService.findTopBy();
			if (null != tdSetting && null != tdSetting.getReturnRation()) {
				// 返现记录
				TdUserCashReward tdUserCashReward = new TdUserCashReward();

				tdUserCashReward.setLowerUsername(tdOrder.getUsername());
				tdUserCashReward.setUsername(tdUser.getUsername());
				tdUserCashReward.setRewardTime(new Date());

				// 返现金额分情况计算
				if (null != tdUser.getReturnRation()) {
					tdUserCashReward.setCashReward(tdOrder.getTotalGoodsPrice() * tdUser.getReturnRation());
				} else {
					tdUserCashReward.setCashReward(tdOrder.getTotalGoodsPrice() * tdSetting.getReturnRation());
				}

				if (null != tdUser.getTotalCashRewards()) {
					if (null != tdUser.getReturnRation()) {
						tdUserCashReward.setTotalCashReward((long) (tdUser.getTotalCashRewards()
								+ tdOrder.getTotalGoodsPrice() * tdUser.getReturnRation()));
					} else {
						tdUserCashReward.setTotalCashReward((long) (tdUser.getTotalCashRewards()
								+ tdOrder.getTotalGoodsPrice() * tdSetting.getReturnRation()));
					}

				} else {
					if (null != tdUser.getReturnRation()) {
						tdUserCashReward
								.setTotalCashReward((long) (tdOrder.getTotalGoodsPrice() * tdUser.getReturnRation()));
					} else {
						tdUserCashReward
								.setTotalCashReward((long) (tdOrder.getTotalGoodsPrice() * tdSetting.getReturnRation()));
					}

				}
				tdUserCashReward.setOrderNumber(tdOrder.getOrderNumber());

				if (null != tdUser.getBankTitle()) {
					tdUserCashReward.setBankName(tdUser.getBankTitle());
				}
				if (null != tdUser.getBankCardCode()) {
					tdUserCashReward.setBankCardNumber(tdUser.getBankCardCode());
				}

				tdUserCashReward.setOrderPrice(tdOrder.getTotalPrice());
				tdUserCashReward.setSortId(99L);

				tdUserCashRewardService.save(tdUserCashReward);

				Double totalReturn = 0.0;
				if (null != tdUser.getReturnRation()) {
					totalReturn = tdOrder.getTotalGoodsPrice() * tdUser.getReturnRation();
				} else {
					totalReturn = tdOrder.getTotalGoodsPrice() * tdSetting.getReturnRation();
				}

				if (totalReturn < 0) {
					totalReturn = 0.0;
				}

				// TdUser upperuser =
				// tdUserService.findByUsername(tdUser.getUpperUsername());

				// 返现总笔数
				if (null != tdUser.getTotalCashRewardsNumber()) {
					tdUser.setTotalCashRewardsNumber(tdUser.getTotalCashRewardsNumber() + 1);
				} else {
					tdUser.setTotalCashRewardsNumber(1L);
				}

				// 返现金额
				if (null != tdUser.getTotalCashRewards()) {
					tdUser.setTotalCashRewards((long) (tdUser.getTotalCashRewards() + totalReturn));
				} else {
					tdUser.setTotalCashRewards((long) (totalReturn + 0L));
				}

				tdUserService.save(tdUser);

				// 返现给上级用户总数
				// if (null != tdUser.getTotalCashRewardsToUpuser()) {
				// tdUser.setTotalCashRewardsToUpuser((long)
				// (tdUser.getTotalCashRewardsToUpuser() + totalReturn));
				// }else {
				// tdUser.setTotalCashRewardsToUpuser((long) (totalReturn +
				// 0L));
				// }
				//
				// tdUserService.save(tdUser);
			}
		}

		// 直营会员给自己返利
		if (null != tdUser.getRoleId() && tdUser.getRoleId().equals(3L)) {
			TdSetting tdSetting = tdSettingService.findTopBy();
			if (null != tdSetting && null != tdSetting.getReturnRation()) {
				// 返现记录
				TdUserCashReward tdUserCashReward = new TdUserCashReward();

				tdUserCashReward.setLowerUsername(tdOrder.getUsername());
				tdUserCashReward.setUsername(tdUser.getUsername());
				tdUserCashReward.setRewardTime(new Date());

				// 返现金额分情况计算
				Double totalReturn = 0.0;
				Boolean isAllCategoryReturnRationNotNull = true;
				if (null != tdOrder.getOrderGoodsList()) {
					for (TdOrderGoods tdOrderGoods : tdOrder.getOrderGoodsList()) {
						TdGoods tdGoods = tdGoodsService.findOne(tdOrderGoods.getGoodsId());
						// 取第一级别类别的返利比例 后续可扩展至全类别
						TdProductCategory tdProductCategory = null; // 第一级别类别
						TdProductCategory tdProductCategorytemp = null;
						tdProductCategorytemp = tdProductCategoryService.findOne(tdGoods.getCategoryId());
						if (null == tdProductCategorytemp.getParentId()) {
							tdProductCategory = tdProductCategorytemp;
						} else {
							tdProductCategorytemp = tdProductCategoryService
									.findOne(tdProductCategorytemp.getParentId());
							if (null == tdProductCategorytemp.getParentId()) {
								tdProductCategory = tdProductCategorytemp;
							} else {
								tdProductCategorytemp = tdProductCategoryService
										.findOne(tdProductCategorytemp.getParentId());
								if (null == tdProductCategorytemp.getParentId()) {
									tdProductCategory = tdProductCategorytemp;
								}
							}
						}

						if (null != tdProductCategory.getReturnRation()) {
							//邮费不参与返利计算
//							if (null != tdGoods.getIsFeeNot()) {
//								if (tdGoods.getIsFeeNot()) {
//									totalReturn += tdGoods.getSalePrice() * tdProductCategory.getReturnRation();
//								} else {
//									totalReturn += (tdGoods.getSalePrice() + tdGoods.getPostage())
//											* tdProductCategory.getReturnRation();
//								}
//							} else {
								totalReturn += tdGoods.getSalePrice() * tdProductCategory.getReturnRation();
//							}
						} else {
							isAllCategoryReturnRationNotNull = false;
						}
					}
				}

				if (totalReturn < 0) {
					totalReturn = 0.0;
				}

				// 如果所有订单商品的类别返利比例都不为空 就用商品类别返利比例计算 返利总额 否则则用平台统一返利比例
				if (isAllCategoryReturnRationNotNull) {
					tdUserCashReward.setCashReward(totalReturn);
				} else {
					tdUserCashReward.setCashReward(tdOrder.getTotalGoodsPrice() * tdSetting.getReturnRation());
				}

				if (null != tdUser.getDirectSaleCashRewards()) {
					if (isAllCategoryReturnRationNotNull) {
						tdUserCashReward.setTotalCashReward((long) (totalReturn + tdUser.getDirectSaleCashRewards()));
					} else {
						tdUserCashReward.setTotalCashReward((long) (tdUser.getTotalCashRewards()
								+ tdOrder.getTotalGoodsPrice() * tdSetting.getReturnRation()));
					}

				} else {
					if (isAllCategoryReturnRationNotNull) {
						tdUserCashReward.setTotalCashReward((long) (totalReturn + 0));
					} else {
						tdUserCashReward
								.setTotalCashReward((long) (tdOrder.getTotalGoodsPrice() * tdSetting.getReturnRation()));
					}

				}

				tdUserCashReward.setOrderNumber(tdOrder.getOrderNumber());

				if (null != tdUser.getBankTitle()) {
					tdUserCashReward.setBankName(tdUser.getBankTitle());
				}
				if (null != tdUser.getBankCardCode()) {
					tdUserCashReward.setBankCardNumber(tdUser.getBankCardCode());
				}

				tdUserCashReward.setOrderPrice(tdOrder.getTotalPrice());
				tdUserCashReward.setSortId(99L);

				tdUserCashRewardService.save(tdUserCashReward);

				// 返现总笔数
				if (null != tdUser.getTotalCashRewardsNumber()) {
					tdUser.setTotalCashRewardsNumber(tdUser.getTotalCashRewardsNumber() + 1);
				} else {
					tdUser.setTotalCashRewardsNumber(1L);
				}

				// 返现金额
				if (null != tdUser.getDirectSaleCashRewards()) {
					if (isAllCategoryReturnRationNotNull) {
						tdUser.setDirectSaleCashRewards(tdUser.getDirectSaleCashRewards() + totalReturn);
					} else {
						tdUser.setDirectSaleCashRewards(tdUser.getDirectSaleCashRewards()
								+ tdOrder.getTotalGoodsPrice() * tdSetting.getReturnRation());
					}

				} else {
					if (isAllCategoryReturnRationNotNull) {
						tdUser.setDirectSaleCashRewards(totalReturn);
					} else {
						tdUser.setDirectSaleCashRewards(tdOrder.getTotalGoodsPrice() * tdSetting.getReturnRation());
					}
				}

				tdUserService.save(tdUser);
			}
		}

		// 购买商品积分奖励
		Long totalPoints = 0L; // 总用户返利
		// 返利总额
		List<TdOrderGoods> tdOrderGoodsList = tdOrder.getOrderGoodsList();
		if (null != tdOrderGoodsList) {
			for (TdOrderGoods tog : tdOrderGoodsList) {
				TdGoods tdGoods = tdGoodsService.findOne(tog.getGoodsId());

				if (null != tdGoods && null != tdGoods.getReturnPoints()) {
					totalPoints += tdGoods.getReturnPoints() * tog.getQuantity();

				}
			}

			final Long totalPointsDely = totalPoints;
			final TdUser tdUserDely = tdUser;
			final TdOrder tdOrderDely = tdOrder;
			// 用户返利
			if (null != tdUser) {
				Timer timer = new Timer();
				timer.schedule(new TimerTask() {
					public void run() {
						// System.out.println("-------设定要指定任务--------");
						TdUserPoint userPoint = new TdUserPoint();
						TdOrder tdOrder1 = tdOrderService.findByOrderNumber(tdOrderDely.getOrderNumber());

						userPoint.setDetail("购买商品赠送积分");
						userPoint.setOrderNumber(tdOrderDely.getOrderNumber());
						userPoint.setPoint(totalPointsDely);
						userPoint.setPointTime(new Date());
						userPoint.setTotalPoint(tdUserDely.getTotalPoints() + totalPointsDely);
						userPoint.setUsername(tdUserDely.getUsername());

						userPoint = tdUserPointService.save(userPoint);

						tdUserDely.setTotalPoints(userPoint.getTotalPoint());

						// tdOrder1.setIsReturnPoints(true);
						tdOrderService.save(tdOrder1);
						tdUserService.save(tdUserDely);
					}
				}, 0);// 设定指定的时间time,

			}
		}
	}

	/**
	 * 积分商品订单支付成功后步骤
	 * 
	 * @param tdOrder
	 *            订单
	 */
	private void pointOrderafterPaySuccess(TdOrder tdOrder) {
		if (null == tdOrder) {
			return;
		}

		// 用户
		TdUser tdUser = tdUserService.findByUsername(tdOrder.getUsername());

		if (null == tdUser) {
			return;
		}

		// 设置消费总额
		if (null != tdUser.getTotalSpendCash()) {
			tdUser.setTotalSpendCash(tdUser.getTotalSpendCash() + tdOrder.getTotalPrice());
		} else {
			tdUser.setTotalSpendCash(tdOrder.getTotalPrice());
		}

		// 设置抢购最后时间

		if (tdOrder.getStatusId().equals(2L)) {
			tdOrder.setPayTime(new Date()); // 设置付款时间
		}

		// 待发货
		tdOrder.setStatusId(3L);
		tdOrder = tdOrderService.save(tdOrder);

		Long pointUse = 0L;

		if (null != tdOrder.getOrderGoodsList().get(0).getPointUse()) {
			pointUse = tdOrder.getOrderGoodsList().get(0).getPointUse();
		}

		// 积分扣除
		if (null != tdUser) {
			if (pointUse.compareTo(0L) >= 0 && tdUser.getTotalPoints().compareTo(pointUse) >= 0) {
				TdUserPoint userPoint = new TdUserPoint();
				userPoint.setDetail("积分兑换商品");
				userPoint.setOrderNumber(tdOrder.getOrderNumber());
				userPoint.setPoint(0 - pointUse);
				userPoint.setPointTime(new Date());
				userPoint.setUsername(tdUser.getUsername());
				userPoint.setTotalPoint(tdUser.getTotalPoints() - pointUse);
				tdUserPointService.save(userPoint);

				tdUser.setTotalPoints(tdUser.getTotalPoints() - pointUse);
				tdUserService.save(tdUser);
			}
		}

	}

	/**
	 * 扣除虚拟货币的方法
	 * 
	 * @author DengXiao
	 */
	public void costVirtual(TdOrder tdOrder, TdUser tdUser) {
		if (null != tdOrder.getVirtualCurrencyUse()) {
			if (null != tdUser.getRoleId()) {
				if (tdUser.getRoleId().equals(1L) && null != tdUser.getTotalCashRewards()) {
					if (tdUser.getTotalCashRewards() > tdOrder.getVirtualCurrencyUse()) {
						tdUser.setTotalCashRewards(
								(long) (tdUser.getTotalCashRewards() - tdOrder.getVirtualCurrencyUse()));
					} else {
						tdUser.setTotalCashRewards(0L);
					}
				} else if (tdUser.getRoleId().equals(2L) && null != tdUser.getVirtualCurrency()) {
					if (tdUser.getVirtualCurrency() > tdOrder.getVirtualCurrencyUse()) {
						tdUser.setVirtualCurrency(tdUser.getVirtualCurrency() - tdOrder.getVirtualCurrencyUse());
					} else {
						tdUser.setVirtualCurrency(0.0);
					}
				} else if (tdUser.getRoleId().equals(3L) && null != tdUser.getDirectSaleCashRewards()) {
					if (tdUser.getDirectSaleCashRewards() > tdOrder.getVirtualCurrencyUse()) {
						tdUser.setDirectSaleCashRewards(
								tdUser.getDirectSaleCashRewards() - tdOrder.getVirtualCurrencyUse());
					} else {
						tdUser.setDirectSaleCashRewards(0.0);
					}
				}
				tdUserService.save(tdUser);
			}
		}
	}
}