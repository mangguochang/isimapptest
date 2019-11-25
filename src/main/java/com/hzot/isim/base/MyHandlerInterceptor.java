package com.hzot.isim.base;

import com.hzot.isim.entity.system.SysUser;
import com.hzot.isim.service.system.SysUserService;
import org.apache.commons.lang3.StringUtils;
import org.keycloak.KeycloakPrincipal;
import org.slf4j.Logger;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by system_user on 2017/11/30.
 * todo:
 */
@Component
public class MyHandlerInterceptor implements HandlerInterceptor {
    private static final Logger LOGGER = org.slf4j.LoggerFactory.getLogger(MyHandlerInterceptor.class);

    @Autowired
    private SysUserService sysUserService;

    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) {
//        LOGGER.info("当前请求路径.."+httpServletRequest.getRequestURI());
		//系统路径
        String path = httpServletRequest.getContextPath();
        String scheme = httpServletRequest.getScheme();
        String serverName = httpServletRequest.getServerName();
        int port = httpServletRequest.getServerPort();
        String basePath = scheme + "://" + serverName + ":" + port + path;
        httpServletRequest.setAttribute("base", basePath);


        if (sysUserService == null) {//解决service为null无法注入问题
            BeanFactory factory = WebApplicationContextUtils.getRequiredWebApplicationContext(httpServletRequest.getServletContext());
            sysUserService = (SysUserService) factory.getBean("userService");
        }

        KeycloakPrincipal principal = (KeycloakPrincipal) httpServletRequest.getUserPrincipal();
        String userId = "";
        if(principal!=null){
            userId = principal.getKeycloakSecurityContext().getToken().getSubject();
        }

        if(StringUtils.isNotBlank(userId)&&StringUtils.isBlank(MySysUser.id())){
            SysUser user = sysUserService.findUserById(userId);
            if(user != null){
                httpServletRequest.getSession().setAttribute("currentUser",user);
            }
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) {

    }
}
