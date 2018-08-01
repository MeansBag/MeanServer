package com.fh.controller.manager.user;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;


import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Menu;
import com.fh.service.manager.user.UserDetailService;
import com.fh.util.AjaxResponse;
import com.fh.util.Const;
import com.fh.util.MD5Util;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;

/** 
 * 类名称：UserController
 * 创建人：FH 
 * 创建时间：2014年6月28日
 * @version  11
 */
@Controller
@RequestMapping(value="/userdetail")
public class UserDetailController extends BaseController {
	
	@Resource(name="userDetailService")
	private UserDetailService userDetailService;
	
	/**
	 * 列表
	 */
	@RequestMapping(value="/userbuyListPage")
	public ModelAndView userbuyListPage(Page page) throws Exception{
		logBefore(logger, "查询会员列表");
		ModelAndView mv = this.getModelAndView();
		try{
		    PageData pd = new PageData();
		    pd = this.getPageData();
			page.setPd(pd);
			List<PageData> list = userDetailService.listPageUserDetail(page);
			System.out.println("-----------------------------------------"+list.size());
			//调用权限
			this.getHC(); //================================================================================
			//调用权限
			mv.setViewName("manager/user/userbuy_list");
			mv.addObject("varList", list);
			mv.addObject("pd", pd);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	@RequestMapping(value="/getUserDetail",produces = "text/html;charset=UTF-8")
	public ModelAndView getUserDetail(Page page) throws Exception{
	    logBefore(logger, "查询下级会员列表");
	    ModelAndView mv = this.getModelAndView();
	    try{
	        PageData pd = new PageData();
	        pd = this.getPageData();
	        //查询用户详细信息
//	        PageData userDetail = userDetailService.findByPhone(pd);
	        PageData userDetail = userDetailService.findUserInfoByUserName(pd.getString("user_name"));
	        if(userDetail!=null){
	            String total_amnt = userDetail.get("total_amnt")==null?"0.0000":String.format("%.4f",new BigDecimal(userDetail.get("total_amnt").toString()));
	            String avb_amnt = userDetail.get("avb_amnt")==null?"0.0000":String.format("%.4f",new BigDecimal(userDetail.get("avb_amnt").toString()));
	            String froze_amnt = userDetail.get("froze_amnt")==null?"0.0000":String.format("%.4f",new BigDecimal(userDetail.get("froze_amnt").toString()));
	            String reward = userDetail.get("reward")==null?"0.0000":String.format("%.4f",new BigDecimal(userDetail.get("reward").toString()));//下级会员购买获得的奖励
	            String bonuses = userDetail.get("bonuses")==null?"0.0000":String.format("%.4f",new BigDecimal(userDetail.get("bonuses").toString()));//发放的SAN
	            
	            userDetail.put("total_amnt", total_amnt); 
	            userDetail.put("avb_amnt", avb_amnt); 
	            userDetail.put("froze_amnt", froze_amnt); 
	            userDetail.put("reward", reward); 
	            userDetail.put("bonuses", bonuses); 
	            pd.put("user_code", userDetail.get("user_code").toString());
	            //查询会员数量
	            PageData vip = userDetailService.findcount(pd);
	            
	            //查询会员奖励列表
	            page.setPd(pd);
	            List<PageData> list = userDetailService.listPageVIP(page);
	            
	            System.out.println("-----------------------------------------"+list.size());
	            mv.addObject("vip", vip);
	            mv.addObject("userDetail", userDetail);
	            mv.addObject("varList", list); 
	        }
	        //调用权限
            this.getHC(); //================================================================================
            //调用权限
            mv.setViewName("business/user/userDetail");
	        mv.addObject("pd", pd);
	    } catch(Exception e){
	        logger.error(e.toString(), e);
	    }
	    return mv;
	}
	/*@RequestMapping(value="/getUserDetail")
	public ModelAndView getUserDetail(Page page) throws Exception{
	    logBefore(logger, "查询会员详情");
	    ModelAndView mv = this.getModelAndView();
	    try{
	        PageData pd = new PageData();
	        pd = this.getPageData();
	        page.setPd(pd);
	        PageData userDetail = userDetailService.findByPhone(pd);
	        //调用权限
	        this.getHC(); //================================================================================
	        //调用权限
	        mv.setViewName("business/user/userDetail");
	        mv.addObject("userDetail", userDetail);
	    } catch(Exception e){
	        logger.error(e.toString(), e);
	    }
	    return mv;
	}*/
	
	/**
	 * @describe:修改购买标识
	 * @author: kezhiyi
	 * @date: 2016年9月25日下午5:48:27
	 * @throws Exception
	 * @return: ModelAndView
	 */
	@RequestMapping(value="/updatebuyStatus")
	@ResponseBody
	public AjaxResponse updatebuyStatus() throws Exception{
	    logBefore(logger, "更新用户购买状态");
	    AjaxResponse ar = new AjaxResponse();
	    try{
	        PageData pd = new PageData();
	        pd = this.getPageData();
	        userDetailService.updateBuyStatus(pd);
	        ar.setSuccess(true);
	        ar.setMessage("更新完毕！");
	    } catch(Exception e){
	        logger.error(e.toString(), e);
	        ar.setSuccess(false);
            ar.setMessage("系统异常，审核失败！");
	    }
	    return ar;
	}
	@RequestMapping(value="/disableStatus")
	@ResponseBody
	public AjaxResponse disableStatus() throws Exception{
	    logBefore(logger, "修改用户状态");
	    AjaxResponse ar = new AjaxResponse();
	    try{
	        PageData pd = new PageData();
	        pd = this.getPageData();
	        userDetailService.updateUserStatus(pd);
	        ar.setSuccess(true);
	    } catch(Exception e){
	        logger.error(e.toString(), e);
	        ar.setSuccess(false);
	        ar.setMessage("系统异常，修改失败！");
	    }
	    return ar;
	}
	
	
	@RequestMapping(value="/changeusertype")
	@ResponseBody
	public AjaxResponse changeUsertype() throws Exception{
	    logBefore(logger, "修改用户类型");
	    AjaxResponse ar = new AjaxResponse();
	    try{
	        PageData pd = new PageData();
	        pd = this.getPageData();
	        userDetailService.updateUserType(pd);
	        ar.setSuccess(true);
	    } catch(Exception e){
	        logger.error(e.toString(), e);
	        ar.setSuccess(false);
	        ar.setMessage("系统异常，修改失败！");
	    }
	    return ar;
	}
	
	@RequestMapping(value="/resetPassword")
	@ResponseBody
	public AjaxResponse resetPassword() throws Exception{
	    logBefore(logger, "重置密码");
	    AjaxResponse ar = new AjaxResponse();
	    try{
	        //密码重置为000000
	        PageData pd = new PageData();
	        pd = this.getPageData();
	        pd.put("pwdhash", MD5Util.getMd5Code("s111111"));
	        userDetailService.resetPassword(pd);
	        ar.setSuccess(true);
	        ar.setMessage("密码重置成功");
	    } catch(Exception e){
	        logger.error(e.toString(), e);
	        ar.setSuccess(false);
	        ar.setMessage("系统异常，修改失败！");
	    }
	    return ar;
	}
	@InitBinder
    public void initBinder(WebDataBinder binder){
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
    }
    

    /* ===============================权限================================== */
    public void getHC(){
        ModelAndView mv = this.getModelAndView();
        //shiro管理的session
        Subject currentUser = SecurityUtils.getSubject();  
        Session session = currentUser.getSession();
        Map<String, String> map = (Map<String, String>)session.getAttribute(Const.SESSION_QX);
        mv.addObject(Const.SESSION_QX,map); //按钮权限
        List<Menu> menuList = (List)session.getAttribute(Const.SESSION_menuList);
        mv.addObject(Const.SESSION_menuList, menuList);//菜单权限
    }
    /* ===============================权限================================== */
    /*
     * 导出用户信息到EXCEL
     * @return
     */
    @RequestMapping(value="/excel")
    public ModelAndView exportExcel(){
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try{
            
            Map<String,Object> dataMap = new HashMap<String,Object>();
            List<String> titles = new ArrayList<String>();
            System.out.println("excel down");
            titles.add("用户名");      //1
            titles.add("真实姓名");      //2
            titles.add("手机号");       //3
            titles.add("推介人用户名");           //4
            titles.add("推介人手机号");           //5
            titles.add("注册时间");           //6
            titles.add("购买数额");   //7
            titles.add("用户类型");   //8
            titles.add("会员状态");   //9
            
            dataMap.put("titles", titles);
            
            List<PageData> userList = userDetailService.listUserDetail(pd);
            List<PageData> varList = new ArrayList<PageData>();
            for(int i=0;i<userList.size();i++){
                PageData vpd = new PageData();
                vpd.put("var1", userList.get(i).getString("user_name"));     //1
                vpd.put("var2", userList.get(i).getString("real_name"));     //1
                vpd.put("var3", userList.get(i).getString("phone"));       //2
                vpd.put("var4", userList.get(i).getString("ref_username"));         //3
                vpd.put("var5", userList.get(i).getString("ref_phone"));    //4
                vpd.put("var6", userList.get(i).getString("create_time1"));        //5
                vpd.put("var7", userList.get(i).get("total_amnt")==null?"0.0000":String.format("%.4f",new BigDecimal(userList.get(i).get("total_amnt").toString())));        //8
                vpd.put("var8", userList.get(i).getString("user_type1"));           //13
                vpd.put("var9", userList.get(i).getString("status"));           //14
                varList.add(vpd);
            }           
            dataMap.put("varList", varList);
            
            ObjectExcelView erv = new ObjectExcelView();                    //执行excel操作
            
            mv = new ModelAndView(erv,dataMap);
        } catch(Exception e){
            logger.error(e.toString(), e);
        }
        return mv;
    }
}
