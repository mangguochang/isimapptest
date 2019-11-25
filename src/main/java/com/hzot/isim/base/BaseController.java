package com.hzot.isim.base;

import com.baomidou.mybatisplus.plugins.Page;

import com.hzot.isim.entity.system.SysUser;
import com.hzot.isim.service.connector.DatabaseConnectorService;
import com.hzot.isim.service.meta.ServiceMetadataClassService;
import com.hzot.isim.service.meta.SysNameListService;
import com.hzot.isim.service.service.*;
import com.hzot.isim.service.system.*;
import com.hzot.isim.util.PageList;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Map;

public class BaseController {

	public SysUser getCurrentUser() {
		HttpServletRequest request = ((ServletRequestAttributes)
				RequestContextHolder.getRequestAttributes()).getRequest();
		SysUser currentUser = (SysUser)request.getSession().getAttribute("currentUser");
		return currentUser;
	}

	@Autowired
	protected SysUserService sysUserService;

	@Autowired
	protected DatabaseConnectorService dbConnectorService;

	@Autowired
	protected SysRoleService roleService;

	@Autowired
	protected SysSLARuleService slaRuleService;

	@Autowired
	protected ServiceMetadataClassService serviceMetadataClassService;

	@Autowired
	protected ServiceInfoService serviceInfoService;

	@Autowired
	protected ServiceRequestParamsService serviceRequestParamsService;

	@Autowired
	protected ServiceResponseParamsService serviceResponseParamsService;

	@Autowired
	protected SysNameListService sysNameListService;

	@Autowired
	protected ServiceInterfaceInfoService serviceInterfaceInfoService;

	@Autowired
	protected ServiceApplicationInfoService serviceApplicationInfoService;

	@Autowired
	protected ServiceCamelInfoService serviceCamelInfoService;

	@Autowired
	protected ServiceAuthInfoService serviceAuthInfoService;

	@Autowired
	protected LogService logService;

	@Autowired
	protected QuartzTaskService quartzTaskService;

	@Autowired
	protected QuartzTaskLogService quartzTaskLogService;


	/**
	 *@Description:
	 *@Param: 设置创建者及更新者信息
	 *@Author: lolipopjy
	 *@date: 2019/8/21 16:11
	 *@return:
	 */
	protected void setCreatorUpdater(Page<?> page){
		try {
			for(Object obj : page.getRecords()){
				Class<?> clz = obj.getClass();
				Method getCreateId = (Method) obj.getClass().getMethod("getCreateId");
				Method setCreateUser = (Method) obj.getClass().getMethod("setCreateUser",SysUser.class);
				String creatorId = (String) getCreateId.invoke(obj);
				if(StringUtils.isNotBlank(creatorId)){
					SysUser creator = sysUserService.findUserById(creatorId);
					//隐藏不必要信息
					SysUser creatorNew = new SysUser();
					creatorNew.setRealName(creator.getRealName());
					setCreateUser.invoke(obj,creatorNew);
				}


				Method getUpdateId = (Method) obj.getClass().getMethod("getUpdateId");
				Method setUpdateUser = (Method) obj.getClass().getMethod("setUpdateUser",SysUser.class);
				String updateById = (String) getUpdateId.invoke(obj);
				if(StringUtils.isNotBlank(updateById)) {
					SysUser updater = sysUserService.findUserById(updateById);
					//隐藏不必要信息
					SysUser updaterNew = new SysUser();
					updaterNew.setRealName(updater.getRealName());
					setUpdateUser.invoke(obj, updaterNew);
				}


			}
		}catch (Exception e){
			e.printStackTrace();
		}
	}

	/**
	 *@Description:
	 *@Param: 设置创建者及更新者信息
	 *@Author: lolipopjy
	 *@date: 2019/8/21 16:11
	 *@return:
	 */
	protected void setCreatorUpdaterByMap(Page<Map<String,Object>> page){
		try {
			for(Map<String,Object> obj : page.getRecords()){
				String creatorId = (String) obj.get("createId");
				if(StringUtils.isNotBlank(creatorId)){
					SysUser creator = sysUserService.findUserById(creatorId);
					//隐藏不必要信息
					SysUser creatorNew = new SysUser();
					creatorNew.setRealName(creator.getRealName());
					obj.put("createUser",creatorNew);
				}


				String updateById = (String) obj.get("updateId");
				if(StringUtils.isNotBlank(updateById)) {
					SysUser updater = sysUserService.findUserById(updateById);
					//隐藏不必要信息
					SysUser updaterNew = new SysUser();
					updaterNew.setRealName(updater.getRealName());
					obj.put("updateUser", updaterNew);
				}


			}
		}catch (Exception e){
			e.printStackTrace();
		}
	}

	protected void setPageInfo(PageList pageList,Page<?> pageInfo,Integer pageSize,Integer pageNumber){
		pageList.setContent(pageInfo.getRecords());
		int lastPage=pageInfo.getTotal()%pageSize==0?pageInfo.getTotal()/pageSize:
				pageInfo.getTotal()/pageSize+1;
		pageList.setTotalPages(pageInfo.getTotal()%pageSize==0?pageInfo.getTotal()/pageSize:
				pageInfo.getTotal()/pageSize+1);
		pageList.setFirst(pageNumber==1?true:false);
		pageList.setLast(pageNumber==lastPage?true:false);
		pageList.setNumber(pageNumber);
		pageList.setNumberOfElements(pageSize);
		pageList.setSort(null);
		pageList.setSize(pageSize);
		pageList.setTotalElements(pageInfo.getTotal());
	}

}
