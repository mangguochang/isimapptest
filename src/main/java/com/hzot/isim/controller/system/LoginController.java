package com.hzot.isim.controller.system;

import com.google.common.collect.Maps;
import com.hzot.isim.annotation.SysLog;
import com.hzot.isim.base.BaseController;
import com.hzot.isim.util.Constants;
import com.hzot.isim.util.RestResponse;
import com.hzot.isim.util.VerifyCodeUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.UnauthorizedException;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Map;

@Controller
public class LoginController extends BaseController {
	private static final Logger LOGGER = LoggerFactory.getLogger(LoginController.class);

	@Value("${server.port}")
	private String port;

	@GetMapping("login")
	public String login(HttpServletRequest request) {
		String path = request.getContextPath();
		String scheme = request.getScheme();
		String serverName = request.getServerName();
		int port = request.getServerPort();
		String basePath = scheme + "://" + serverName + ":" + port + path;
		request.setAttribute("base", basePath);
		LOGGER.info("跳到这边的路径为:"+request.getRequestURI());
		Subject s = SecurityUtils.getSubject();
		LOGGER.info("是否记住登录--->"+s.isRemembered()+"<-----是否有权限登录----->"+s.isAuthenticated()+"<----");
		if(s.isAuthenticated()){
			return "redirect:index";
		}else {
			return "login";
		}
	}

	@PostMapping("login/main")
	@ResponseBody
	@SysLog("用户登录")
	public RestResponse loginMain(HttpServletRequest request) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String rememberMe = request.getParameter("rememberMe");
		String code = request.getParameter("code");
		if(StringUtils.isBlank(username) || StringUtils.isBlank(password)){
			return RestResponse.failure("用户名或者密码不能为空");
		}
		if(StringUtils.isBlank(rememberMe)){
			return RestResponse.failure("记住我不能为空");
		}
//		if(StringUtils.isBlank(code)){
//			return  RestResponse.failure("验证码不能为空");
//		}
		Map<String,Object> map = Maps.newHashMap();
		String error = null;
		HttpSession session = request.getSession();
		if(session == null){
			return RestResponse.failure("session超时");
		}
		String trueCode =  (String)session.getAttribute(Constants.VALIDATE_CODE);
//		if(StringUtils.isBlank(trueCode)){
//			return RestResponse.failure("验证码超时");
//		}
//		if(StringUtils.isBlank(code) || !trueCode.toLowerCase().equals(code.toLowerCase())){
//			error = "验证码错误";
//		}else {
			/*就是代表当前的用户。*/
			Subject user = SecurityUtils.getSubject();
			UsernamePasswordToken token = new UsernamePasswordToken(username,password,Boolean.valueOf(rememberMe));
			try {
				user.login(token);
				if (user.isAuthenticated()) {
					map.put("url","index");
				}
			}catch (IncorrectCredentialsException e) {
				error = "登录密码错误.";
			} catch (ExcessiveAttemptsException e) {
				error = "登录失败次数过多";
			} catch (LockedAccountException e) {
				error = "帐号已被锁定.";
			} catch (DisabledAccountException e) {
				error = "帐号已被禁用.";
			} catch (ExpiredCredentialsException e) {
				error = "帐号已过期.";
			} catch (UnknownAccountException e) {
				error = "帐号不存在";
			} catch (UnauthorizedException e) {
				error = "您没有得到相应的授权！";
			}
//		}
		//系统路径
		String path = request.getContextPath();
		String scheme = request.getScheme();
		String serverName = request.getServerName();
		int port = request.getServerPort();
		String basePath = scheme + "://" + serverName + ":" + port + path;
		request.setAttribute("base", basePath);
		if(StringUtils.isBlank(error)){
			return RestResponse.success("登录成功").setData(map);
		}else{
			return RestResponse.failure(error);
		}
	}

	@GetMapping("index")
	public String showView(Model model,HttpServletRequest request){
		//系统路径
		String path = request.getContextPath();
		String scheme = request.getScheme();
		String serverName = request.getServerName();
		int port = request.getServerPort();
		String basePath = scheme + "://" + serverName + ":" + port + path;
		request.setAttribute("base", basePath);
		return "index";
	}


	/**
	 * 获取验证码图片和文本(验证码文本会保存在HttpSession中)
	 */
	@GetMapping("/genCaptcha")
	public void genCaptcha(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//设置页面不缓存
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		String verifyCode = VerifyCodeUtil.generateTextCode(VerifyCodeUtil.TYPE_ALL_MIXED, 4, null);
		//将验证码放到HttpSession里面
		request.getSession().setAttribute(Constants.VALIDATE_CODE, verifyCode);
		LOGGER.info("本次生成的验证码为[" + verifyCode + "],已存放到HttpSession中");
		//设置输出的内容的类型为JPEG图像
		response.setContentType("image/jpeg");
		BufferedImage bufferedImage = VerifyCodeUtil.generateImageCode(verifyCode, 116, 36, 5, true, new Color(249,205,173), null, null);
		//写给浏览器
		ImageIO.write(bufferedImage, "JPEG", response.getOutputStream());
	}

	/**
	 *  空地址请求
	 * @return
	 */
	@GetMapping(value = "")
	public String index() {
		LOGGER.info("请求空地址路径");
		Subject s = SecurityUtils.getSubject();
		return s.isAuthenticated() ? "redirect:index" : "login";
	}

	@GetMapping("systemLogout")
	@SysLog("退出系统")
	public String logOut(){
		SecurityUtils.getSubject().logout();
		return "redirect:/login";
	}
}
