package com.fh.controller.manager.project;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Dictionaries;
import com.fh.service.manager.project.ProjectManager;
import com.fh.service.system.dictionaries.impl.DictionariesService;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.DelAllFile;
import com.fh.util.FileUpload;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.PathUtil;
import com.fh.util.Tools;

/** 
 * 说明：项目管理
 * 创建人：FH Q313596790
 * 创建时间：2017-12-21
 */
@Controller
@RequestMapping(value="/project")
public class ProjectController extends BaseController {
	
	String menuUrl = "project/list.do"; //菜单地址(权限用)
	@Resource(name="projectService")
	private ProjectManager projectService;
	@Resource(name="dictionariesService")
	private DictionariesService dictionariesService;
	
	/**删除视频
	 * @param out
	 * @throws Exception 
	 */
	@RequestMapping(value="/deltp")
	public void deltp(PrintWriter out) throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		String PATH = pd.getString("VIDEO_URL");	
		if(Tools.notEmpty(pd.getString("VIDEO_URL").trim())){//图片路径
			DelAllFile.delFolder(PathUtil.getClasspath()+ Const.FILEPATHIMG + pd.getString("VIDEO_URL")); 	//删除图片
		}
		if(PATH != null){
			projectService.delTp(pd);																//删除数据库中图片数据
		}	
		out.write("success");
		out.close();
	}
	
	/**删除文件
	 * @param out
	 * @throws Exception 
	 */
	@RequestMapping(value="/deltp1")
	public void deltp1(PrintWriter out) throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		String PATH = pd.getString("FILE_URL");	
		if(Tools.notEmpty(pd.getString("FILE_URL").trim())){//图片路径
			DelAllFile.delFolder(PathUtil.getClasspath()+ Const.FILEPATHIMG + pd.getString("FILE_URL")); 	//删除图片
		}
		if(PATH != null){
			projectService.delTp1(pd);																//删除数据库中图片数据
		}	
		out.write("success");
		out.close();
	}
	
	@RequestMapping(value="/deltp2")
	public void deltp2(PrintWriter out) throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		String PATH = pd.getString("COVER_PICTURE");	
		if(Tools.notEmpty(pd.getString("COVER_PICTURE").trim())){//图片路径
			DelAllFile.delFolder(PathUtil.getClasspath()+ Const.FILEPATHIMG + pd.getString("COVER_PICTURE")); 	//删除图片
		}
		if(PATH != null){
			projectService.delTp2(pd);																//删除数据库中图片数据
		}	
		out.write("success");
		out.close();
	}
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save(
			HttpServletRequest request,
			@RequestParam(value="tp",required=false) MultipartFile file,
			@RequestParam(value="tp1",required=false) MultipartFile file1,
			@RequestParam(value="tp2",required=false) MultipartFile file2,
			@RequestParam(value="tpz",required=false) String tpz,
			@RequestParam(value="tpz1",required=false) String tpz1,
			@RequestParam(value="tpz2",required=false) String tpz2,
			@RequestParam(value="PROJECT_NAME",required=false) String PROJECT_NAME,
			@RequestParam(value="PROJECT_DESC_DETAIL",required=false) String PROJECT_DESC_DETAIL,
			@RequestParam(value="COMPANY_NAME",required=false) String COMPANY_NAME,
			@RequestParam(value="QUOTA_LIMIT",required=false) String QUOTA_LIMIT,
			@RequestParam(value="START_TIME",required=false) String START_TIME,
			@RequestParam(value="END_TIME",required=false) String END_TIME,
			@RequestParam(value="PROJECT_STATE",required=false) String PROJECT_STATE,
			@RequestParam(value="VISIBLE_TYPE",required=false) String VISIBLE_TYPE,      
			@RequestParam(value="IS_RECOMMEND",required=false) String IS_RECOMMEND,
			@RequestParam(value="BROWSE_NUM",required=false) String BROWSE_NUM,
			@RequestParam(value="STOCK_NUM",required=false) String STOCK_NUM
			
			) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Project");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(null == tpz){tpz = "";}
		String  ffile = DateUtil.getDays(), fileName = "";
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/uploads"+"/";
		
		if (null != file && !file.isEmpty()) {
			String filePath = PathUtil.getClasspath1() + Const.FILEPATHVIDEO + ffile;	//视频上传路径
			fileName = FileUpload.fileUp(file, filePath, this.get32UUID());			//执行上传
			pd.put("VIDEO_URL", basePath+Const.FILEPATHVIDEO+ffile + "/" + fileName);									//路径
			//pd.put("NAME", fileName);
		}else{
			pd.put("VIDEO_URL", tpz);
		}
		
		if(null == tpz1){tpz1 = "";}
		if (null != file1 && !file1.isEmpty()) {
			String filePath = PathUtil.getClasspath1() + Const.FILEPATHFILE + ffile;	//文件上传路径
			fileName = FileUpload.fileUp(file1, filePath, this.get32UUID());			//执行上传
			pd.put("FILE_URL", basePath+Const.FILEPATHFILE+ffile + "/" + fileName);										//路径
			//pd.put("NAME", fileName);
		}else{
			pd.put("FILE_URL", tpz1);
		}
		//String path = request.getContextPath();
		if(null == tpz2){tpz2 = "";}
		if (null != file2 && !file2.isEmpty()) {
			String filePath = PathUtil.getClasspath1() + Const.FILEPATHFILE + ffile;	//图片
			fileName = FileUpload.fileUp(file2, filePath, this.get32UUID());			//执行上传
			pd.put("COVER_PICTURE", basePath+Const.FILEPATHFILE+ffile + "/" + fileName);									//路径
			//pd.put("NAME", fileName);
		}else{
			pd.put("COVER_PICTURE", tpz1);
		}
		
		pd.put("PROJECT_NAME", PROJECT_NAME);
		pd.put("PROJECT_DESC_DETAIL", PROJECT_DESC_DETAIL);
		pd.put("COMPANY_NAME", COMPANY_NAME);
		pd.put("QUOTA_LIMIT", QUOTA_LIMIT);
		pd.put("START_TIME", START_TIME);
		pd.put("END_TIME", END_TIME);
		pd.put("PROJECT_STATE", PROJECT_STATE);
		pd.put("VISIBLE_TYPE", VISIBLE_TYPE);
		pd.put("IS_RECOMMEND", IS_RECOMMEND);
		pd.put("BROWSE_NUM", BROWSE_NUM);
		pd.put("STOCK_NUM", STOCK_NUM);
		
		pd.put("PROJECT_ID", this.get32UUID());	//主键
		projectService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除Project");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		projectService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit(	
			HttpServletRequest request,
			@RequestParam(value="tp",required=false) MultipartFile file,
			@RequestParam(value="tp1",required=false) MultipartFile file1,
			@RequestParam(value="tp2",required=false) MultipartFile file2,
			@RequestParam(value="tpz",required=false) String tpz,
			@RequestParam(value="tpz1",required=false) String tpz1,
			@RequestParam(value="tpz2",required=false) String tpz2,
			@RequestParam(value="PROJECT_ID",required=false) String PROJECT_ID,
			@RequestParam(value="PROJECT_NAME",required=false) String PROJECT_NAME,
			@RequestParam(value="PROJECT_DESC_DETAIL",required=false) String PROJECT_DESC_DETAIL,
			@RequestParam(value="COMPANY_NAME",required=false) String COMPANY_NAME,
			@RequestParam(value="QUOTA_LIMIT",required=false) String QUOTA_LIMIT,
			@RequestParam(value="START_TIME",required=false) String START_TIME,
			@RequestParam(value="END_TIME",required=false) String END_TIME,
			@RequestParam(value="PROJECT_STATE",required=false) String PROJECT_STATE,
			@RequestParam(value="VISIBLE_TYPE",required=false) String VISIBLE_TYPE,      
			@RequestParam(value="IS_RECOMMEND",required=false) String IS_RECOMMEND,
			@RequestParam(value="BROWSE_NUM",required=false) String BROWSE_NUM,
			@RequestParam(value="STOCK_NUM",required=false) String STOCK_NUM
			) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Project");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		if(Jurisdiction.buttonJurisdiction(menuUrl, "edit")){
			String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/uploads"+"/";
							//备注
			if(null == tpz){tpz = "";}
			String  ffile = DateUtil.getDays(), fileName = "";
			if (null != file && !file.isEmpty()) {
				String filePath = PathUtil.getClasspath1() + Const.FILEPATHVIDEO + ffile;	//视频上传路径
				fileName = FileUpload.fileUp(file, filePath, this.get32UUID());			//执行上传
				pd.put("VIDEO_URL", basePath+Const.FILEPATHVIDEO+ffile + "/" + fileName);									//路径
				//pd.put("NAME", fileName);
			}else{
				pd.put("VIDEO_URL", tpz);
			}
			
			if(null == tpz1){tpz1 = "";}
			if (null != file1 && !file1.isEmpty()) {
				String filePath = PathUtil.getClasspath1() + Const.FILEPATHFILE + ffile;	//文件上传路径
				fileName = FileUpload.fileUp(file1, filePath, this.get32UUID());			//执行上传
				pd.put("FILE_URL", basePath+Const.FILEPATHFILE+ffile + "/" + fileName);										//路径
				//pd.put("NAME", fileName);
			}else{
				pd.put("FILE_URL", tpz1);
			}
			//String path = request.getContextPath();
			if(null == tpz2){tpz2 = "";}
			if (null != file2 && !file2.isEmpty()) {
				String filePath = PathUtil.getClasspath1() + Const.FILEPATHFILE + ffile;	//图片
				fileName = FileUpload.fileUp(file2, filePath, this.get32UUID());			//执行上传
				pd.put("COVER_PICTURE", basePath+Const.FILEPATHFILE+ffile + "/" + fileName);										//路径
				//pd.put("NAME", fileName);
			}else{
				pd.put("COVER_PICTURE", tpz1);
			}
			
			pd.put("PROJECT_ID", PROJECT_ID);
			pd.put("PROJECT_NAME", PROJECT_NAME);
			pd.put("PROJECT_DESC_DETAIL", PROJECT_DESC_DETAIL);
			pd.put("COMPANY_NAME", COMPANY_NAME);
			pd.put("QUOTA_LIMIT", QUOTA_LIMIT);
			pd.put("START_TIME", START_TIME);
			pd.put("END_TIME", END_TIME);
			pd.put("PROJECT_STATE", PROJECT_STATE);
			pd.put("VISIBLE_TYPE", VISIBLE_TYPE);
			pd.put("IS_RECOMMEND", IS_RECOMMEND);
			pd.put("BROWSE_NUM", BROWSE_NUM);
			pd.put("STOCK_NUM", STOCK_NUM);
			projectService.edit(pd);				//执行修改数据库
		}
		
		
		//projectService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Project");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = projectService.list(page);	//列出Project列表
		mv.setViewName("manager/project/project_list");
		mv.addObject("varList", varList);
		
		List<Dictionaries>	visible_types = dictionariesService.listSubDictByParentId("a8e31a032f6d48439d498abbc266457a"); //是否
		List<Dictionaries>	isornots = dictionariesService.listSubDictByParentId("cbd1759b353341f785827593a95791a9");  //项目文章权限
		List<Dictionaries>	project_states = dictionariesService.listSubDictByParentId("3230acdf68ae4f38a429afd9b5b3d8bb"); //项目状态
		
		mv.addObject("visible_types", visible_types);
		mv.addObject("isornots", isornots);
		mv.addObject("project_states", project_states);
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
		mv.setViewName("manager/project/project_edit");
		mv.addObject("msg", "save");
		List<Dictionaries>	visible_types = dictionariesService.listSubDictByParentId("a8e31a032f6d48439d498abbc266457a"); //是否
		List<Dictionaries>	isornots = dictionariesService.listSubDictByParentId("cbd1759b353341f785827593a95791a9");  //项目文章权限
		List<Dictionaries>	project_states = dictionariesService.listSubDictByParentId("3230acdf68ae4f38a429afd9b5b3d8bb"); //项目状态
		
		mv.addObject("visible_types", visible_types);
		mv.addObject("isornots", isornots);
		mv.addObject("project_states", project_states);
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
		pd = projectService.findById(pd);	//根据ID读取
		mv.setViewName("manager/project/project_edit");
		List<Dictionaries>	visible_types = dictionariesService.listSubDictByParentId("a8e31a032f6d48439d498abbc266457a"); //是否
		List<Dictionaries>	isornots = dictionariesService.listSubDictByParentId("cbd1759b353341f785827593a95791a9");  //项目文章权限
		List<Dictionaries>	project_states = dictionariesService.listSubDictByParentId("3230acdf68ae4f38a429afd9b5b3d8bb"); //项目状态
		
		mv.addObject("visible_types", visible_types);
		mv.addObject("isornots", isornots);
		mv.addObject("project_states", project_states);
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Project");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			projectService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Project到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("项目名");	//1
		titles.add("项目所属阶段");	//2
		titles.add("公司名称");	//3
		titles.add("項目介紹");	//4
		titles.add("名额限制");	//5
		titles.add("开始时间");	//6
		titles.add("结束时间");	//7
		titles.add("1即将开始、2进行中、3已完成、4已结束");	//8
		titles.add("可见类型:0-全部;1-普通会员;2-VIP会员");	//9
		titles.add("创建时间");	//10
		titles.add("视频地址");	//11
		titles.add("文件地址");	//12
		titles.add("是否推荐（1 推荐 ；2不推荐）");	//13
		titles.add("浏览数");	//14
		dataMap.put("titles", titles);
		List<PageData> varOList = projectService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("PROJECT_NAME"));	    //1
			vpd.put("var2", varOList.get(i).get("PROJECT_STAGE").toString());	//2
			vpd.put("var3", varOList.get(i).getString("COMPANY_NAME"));	    //3
			vpd.put("var4", varOList.get(i).getString("PROJECT_DESC_DETAIL"));	    //4
			vpd.put("var5", varOList.get(i).get("QUOTA_LIMIT").toString());	//5
			vpd.put("var6", varOList.get(i).getString("START_TIME"));	    //6
			vpd.put("var7", varOList.get(i).getString("END_TIME"));	    //7
			vpd.put("var8", varOList.get(i).get("PROJECT_STATE").toString());	//8
			vpd.put("var9", varOList.get(i).getString("VISIBLE_TYPE"));	    //9
			vpd.put("var10", varOList.get(i).getString("CREATE_TIME"));	    //10
			vpd.put("var11", varOList.get(i).getString("VIDEO_URL"));	    //11
			vpd.put("var12", varOList.get(i).getString("FILE_URL"));	    //12
			vpd.put("var13", varOList.get(i).getString("IS_RECOMMEND"));	    //13
			vpd.put("var14", varOList.get(i).get("BROWSE_NUM").toString());	//14
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
