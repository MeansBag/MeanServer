package com.fh.controller.manager.orderinfo;

import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Dictionaries;
import com.fh.service.manager.orderinfo.OrderInfoManager;
import com.fh.service.manager.project.ProjectManager;
import com.fh.service.system.dictionaries.impl.DictionariesService;
import com.fh.util.AppUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;

/** 
 * 说明：订单管理
 * 创建人：FH Q313596790
 * 创建时间：2017-12-21
 */
@Controller
@RequestMapping(value="/orderinfo")
public class OrderInfoController extends BaseController {
	
	String menuUrl = "orderinfo/list.do"; //菜单地址(权限用)
	@Resource(name="orderinfoService")
	private OrderInfoManager orderinfoService;
	@Resource(name="dictionariesService")
	private DictionariesService dictionariesService;
	@Resource(name="projectService")
	private ProjectManager projectService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增OrderInfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ORDERINFO_ID", this.get32UUID());	//主键
		orderinfoService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除OrderInfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		orderinfoService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改OrderInfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String project_id = pd.getString("PROJECT_ID");
		String order_status = pd.getString("ORDER_STATUS");
		
		if(StringUtils.isNotEmpty(order_status)&&order_status.equals("2")){
			String new_num = pd.getString("NEW_NUM");
			PageData projectPd = new PageData();
			projectPd.put("PROJECT_ID", project_id);
			projectPd =projectService.findById(projectPd);
			String stock_num = projectPd.get("STOCK_NUM").toString(); 
			String exchange_num = projectPd.get("EXCHANGE_NUM").toString();
			BigDecimal new_num_val = new BigDecimal(new_num);
			BigDecimal stock_num_val = new BigDecimal(stock_num);
			BigDecimal exchange_num_val = new BigDecimal(exchange_num);
			if( stock_num_val.subtract(new_num_val).doubleValue()<0){ //库存不足
				mv.addObject("msg","failed");
			}else{
				projectPd.put("STOCK_NUM", stock_num_val.subtract(new_num_val).doubleValue());
				projectPd.put("EXCHANGE_NUM", exchange_num_val.add(new_num_val).doubleValue());
				projectService.edit(projectPd);
				orderinfoService.edit(pd);
				mv.addObject("msg","success");
			}
		}else{
			orderinfoService.edit(pd);
			mv.addObject("msg","success");
		}
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表OrderInfo");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = orderinfoService.list(page);	//列出OrderInfo列表
		mv.setViewName("manager/orderinfo/orderinfo_list");
		List<Dictionaries>	order_statuss = dictionariesService.listSubDictByParentId("8f21300103624210969e51122fb02b4a"); //订单状态
		List<Dictionaries>	currencys = dictionariesService.listSubDictByParentId("b90241d67570474e905b58c6d18c9495"); //币种
		mv.addObject("currencys", currencys);
		mv.addObject("order_statuss", order_statuss);
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("manager/orderinfo/orderinfo_edit");
		List<Dictionaries>	order_statuss = dictionariesService.listSubDictByParentId("8f21300103624210969e51122fb02b4a"); //订单状态
		List<Dictionaries>	currencys = dictionariesService.listSubDictByParentId("b90241d67570474e905b58c6d18c9495"); //币种
		mv.addObject("currencys", currencys);
		mv.addObject("order_statuss", order_statuss);
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = orderinfoService.findById(pd);	//根据ID读取
		mv.setViewName("manager/orderinfo/orderinfo_edit");
		List<Dictionaries>	order_statuss = dictionariesService.listSubDictByParentId("8f21300103624210969e51122fb02b4a"); //订单状态
		List<Dictionaries>	currencys = dictionariesService.listSubDictByParentId("b90241d67570474e905b58c6d18c9495"); //币种
		mv.addObject("currencys", currencys);
		mv.addObject("order_statuss", order_statuss);
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除OrderInfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			orderinfoService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出OrderInfo到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("用户名");	//1
		titles.add("兑换币种");	//2
		titles.add("兑换数量");	//3
		titles.add("新资产数量");	//4
		titles.add("联系邮箱");	//5
		titles.add("联系电话");	//6
		titles.add("兑换订单时间");	//7
		titles.add("订单状态");	//8
		dataMap.put("titles", titles);
		List<PageData> varOList = orderinfoService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		List<Dictionaries>	order_statuss = dictionariesService.listSubDictByParentId("8f21300103624210969e51122fb02b4a"); //订单状态
		List<Dictionaries>	currencys = dictionariesService.listSubDictByParentId("b90241d67570474e905b58c6d18c9495"); //币种
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("USER_NAME"));	    //1
			String currency ="";
			if(!StringUtils.isBlank(varOList.get(i).getString("ORDER_TYPE"))){
				for(Dictionaries  dic :  currencys){
					if(dic.getNAME_EN().equals(varOList.get(i).getString("ORDER_TYPE"))){
						currency = dic.getNAME();
						break;
					}
				}
			}
			vpd.put("var2", currency);	    //2
			vpd.put("var3", varOList.get(i).getString("NUM"));	    //3
			vpd.put("var4", varOList.get(i).getString("NEW_NUM"));	    //4
			vpd.put("var5", varOList.get(i).getString("EMAIL"));	    //5
			vpd.put("var6", varOList.get(i).getString("TEL"));	    //6
			vpd.put("var7", varOList.get(i).getString("ORDER_TIME"));	    //7
			String ORDER_STATUS ="";
			if(!StringUtils.isBlank(varOList.get(i).getString("ORDER_STATUS"))){
				for(Dictionaries  dic :  order_statuss){
					if(dic.getNAME_EN().equals(varOList.get(i).getString("ORDER_STATUS"))){
						ORDER_STATUS = dic.getNAME();
						break;
					}
				}
			}
			vpd.put("var8", ORDER_STATUS);	    //8
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
