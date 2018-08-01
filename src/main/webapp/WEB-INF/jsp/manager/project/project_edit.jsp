<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" import="java.util.*" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">  
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
	 <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<style type="text/css">
		#dialog-add,#dialog-message,#dialog-comment{width:100%; height:100%; position:fixed; top:0px; z-index:99999999; display:none;}
		.commitopacity{position:absolute; width:100%; height:700px; background:#7f7f7f; filter:alpha(opacity=50); -moz-opacity:0.5; -khtml-opacity: 0.5; opacity: 0.5; top:0px; z-index:99999;}
		.commitbox{width:100%; margin:0px auto; position:absolute; top:0px; z-index:99999;}
		.commitbox_inner{width:96%; height:255px;  margin:6px auto; background:#efefef; border-radius:5px;}
		.commitbox_top{width:100%; height:253px; margin-bottom:10px; padding-top:10px; background:#FFF; border-radius:5px; box-shadow:1px 1px 3px #e8e8e8;}
		.commitbox_top textarea{width:95%; height:195px; display:block; margin:0px auto; border:0px;}
		.commitbox_cen{width:95%; height:40px; padding-top:10px;}
		.commitbox_cen div.left{float:left;background-size:15px; background-position:0px 3px; padding-left:18px; color:#f77500; font-size:16px; line-height:27px;}
		.commitbox_cen div.left img{width:30px;}
		.commitbox_cen div.right{float:right; margin-top:7px;}
		.commitbox_cen div.right span{cursor:pointer;}
		.commitbox_cen div.right span.save{border:solid 1px #c7c7c7; background:#6FB3E0; border-radius:3px; color:#FFF; padding:5px 10px;}
		.commitbox_cen div.right span.quxiao{border:solid 1px #f77400; background:#f77400; border-radius:3px; color:#FFF; padding:4px 9px;}
		</style>
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<body class="no-skin">
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
					
					<form action="project/${msg }.do" name="Form" id="Form" method="post" enctype="multipart/form-data">
						<input type="hidden" name="PROJECT_ID" id="PROJECT_ID" value="${pd.PROJECT_ID}"/>
						
						<textarea name="PROJECT_DESC_DETAIL" id="PROJECT_DESC_DETAIL" style="display:none" ></textarea>
						<input type="hidden" name="TYPE" id="TYPE" value="2"/>
						
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">项目名:</td>
								<td><input type="text" name="PROJECT_NAME" id="PROJECT_NAME" value="${pd.PROJECT_NAME}" maxlength="40" placeholder="这里输入项目名" title="项目名" style="width:98%;"/></td>
							</tr>
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">项目描述:</td>
								<td style="padding-top: 3px;">
									<!--  <script id="editor" type="text/plain" style="width:643px;height:259px;"></script> -->
									 <textarea id="editor" name="editor"
										style="width: 800px; height: 400px; margin: 0 auto;">
										</textarea>
									 <label style="float:left;padding-left: 32px;"><input name="form-field-radio" id="form-field-radio1" onclick="setType('1');"  type="radio" class="ace" value="icon-edit"><span class="lbl">纯文本</span></label>
									<label style="float:left;padding-left: 5px;"><input name="form-field-radio" id="form-field-radio2" onclick="setType('2');" checked="checked" type="radio" value="icon-edit" class="ace" ><span class="lbl">带标签</span></label>
								</td>
							</tr>
							
							
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">公司名称:</td>
								<td><input type="text" name="COMPANY_NAME" id="COMPANY_NAME" value="${pd.COMPANY_NAME}" maxlength="100" placeholder="这里输入公司名称" title="公司名称" style="width:98%;"/></td>
							</tr>
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">名额限制(人数):</td>
								<td><input type="number" name="QUOTA_LIMIT" id="QUOTA_LIMIT" value="${pd.QUOTA_LIMIT}" maxlength="32" placeholder="这里输入名额限制" title="名额限制" style="width:98%;"/></td>
							</tr>
						
							<tr>
								<td style="width:300px;text-align: right;padding-top: 13px;">开始时间:</td>
								<td>
								<input  type="hidden" name="NOWTIME" id="NOWTIME" value="<fmt:formatDate value="<%=new Date()%>" pattern="yyyy-MM-dd HH:mm:ss"/>" type="text"
								 onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" placeholder="开始时间" title="开始时间" style="width:80%;"/>
								
								<%-- <input  name="START_TIME" id="START_TIME" value="${pd.START_TIME}" type="text"
								 onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'NOWTIME\')}',maxDate:'#F{$dp.$D(\'END_TIME\')}'})" readonly="readonly" placeholder="开始时间" title="开始时间" style="width:80%;"/>
								 --%><input  name="START_TIME" id="START_TIME" value="${pd.START_TIME}" type="text"
								 onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" placeholder="开始时间" title="开始时间" style="width:80%;"/>
								</td>
							</tr>
							<tr>
								<td style="width:300px;text-align: right;padding-top: 13px;">结束时间:</td>
								<td>
								<%-- <input  name="END_TIME" id="END_TIME" value="${pd.END_TIME}" type="text"
								 onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'START_TIME\')}',maxDate:'2130-10-01'})" readonly="readonly" placeholder="结束时间" title="结束时间" style="width:80%;"/></td>
								 --%><input  name="END_TIME" id="END_TIME" value="${pd.END_TIME}" type="text"
								 onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" placeholder="结束时间" title="结束时间" style="width:80%;"/></td>
							
							</tr>
							
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">项目状态:</td>
								<td>
									<select name="PROJECT_STATE" id="PROJECT_STATE" title="项目状态">
										<c:forEach items="${project_states}" var="projectStage">
											<option value="${projectStage.NAME_EN}" <c:if test="${projectStage.NAME_EN == pd.PROJECT_STATE }">selected</c:if>>${projectStage.NAME }</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">文章权限:</td>
								<td>
									<select name="VISIBLE_TYPE" id="VISIBLE_TYPE" title="文章权限">
										<c:forEach items="${isornots}" var="isornot">
											<option value="${isornot.NAME_EN}" <c:if test="${isornot.NAME_EN == pd.VISIBLE_TYPE }">selected</c:if>>${isornot.NAME }</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							
							<tr>
								<td style="width:50px;text-align: right;padding-top: 13px;">视频地址:</td>
								<td>
									<c:if test="${pd == null || pd.VIDEO_URL == '' || pd.VIDEO_URL == null }">
									<input type="file" id="tp" name="tp"  onchange=""/>
									</c:if>
									<c:if test="${pd != null && pd.VIDEO_URL != '' && pd.VIDEO_URL != null }">
										<a href="${pd.VIDEO_URL}" target="_blank">视频文件点击下载</a>
										<input type="button" class="btn btn-mini btn-danger" value="删除" onclick="delP('${pd.VIDEO_URL}','${pd.PROJECT_ID }');" />
										<input type="hidden" name="tpz" id="tpz" value="${pd.VIDEO_URL }"/>
									</c:if>
								</td>
							</tr>
								
							<tr>
								<td style="width:50px;text-align: right;padding-top: 13px;">文件地址:</td>
								<td>
									<c:if test="${pd == null || pd.FILE_URL == '' || pd.FILE_URL == null }">
									<input type="file" id="tp1" name="tp1"  onchange=""/>
									</c:if>
									<c:if test="${pd != null && pd.FILE_URL != '' && pd.FILE_URL != null }">
										<a href="${pd.FILE_URL}" target="_blank">文件点击查看</a>
										<input type="button" class="btn btn-mini btn-danger" value="删除" onclick="delP1('${pd.FILE_URL}','${pd.PROJECT_ID }');" />
										<input type="hidden" name="tpz1" id="tpz1" value="${pd.FILE_URL }"/>
									</c:if>
								</td>
							</tr>
							
							<tr>
								<td style="width:50px;text-align: right;padding-top: 13px;">图片地址:</td>
								<td>
									<c:if test="${pd == null || pd.COVER_PICTURE == '' || pd.COVER_PICTURE == null }">
									<input type="file" id="tp2" name="tp2"  onchange=""/>
									</c:if>
									<c:if test="${pd != null && pd.COVER_PICTURE != '' && pd.COVER_PICTURE != null }">
										<a href="${pd.COVER_PICTURE}" target="_blank">文件点击查看</a>
										<input type="button" class="btn btn-mini btn-danger" value="删除" onclick="delP2('${pd.COVER_PICTURE}','${pd.PROJECT_ID }');" />
										<input type="hidden" name="tpz2" id="tpz2" value="${pd.COVER_PICTURE }"/>
									</c:if>
								</td>
							</tr>
							
								
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">是否推荐:</td>
								<td>
									<select name="IS_RECOMMEND" id="IS_RECOMMEND" title="是否推荐">
										
										<c:forEach items="${visible_types}" var="types">
											<option value="${types.NAME_EN}" <c:if test="${types.NAME_EN == pd.IS_RECOMMEND }">selected</c:if>>${types.NAME }</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">浏览数:</td>
								<td><input type="number" name="BROWSE_NUM" id="BROWSE_NUM" value="${pd.BROWSE_NUM}" maxlength="32" placeholder="这里输入浏览数" title="浏览数" style="width:98%;"/></td>
							</tr> 
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">库存量:</td>
								<td><input type="number" name="STOCK_NUM" id="STOCK_NUM" value="${pd.STOCK_NUM}" maxlength="32" placeholder="这里输入库存量" title="库存量" style="width:98%;"/></td>
							</tr> 
							
							
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
					</form>
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
	<!-- /.main-content -->
</div>
<!-- /.main-container -->
	
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 编辑框-->
	<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=path%>/plugins/ueditor/";</script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!-- 上传控件 -->
	<script src="static/ace/js/ace/elements.fileinput.js"></script>
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<script src="plugins/My97DatePicker/WdatePicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		$(function() {
			//上传
			$('#tp').ace_file_input({
				no_file:'请选择视频 ...',
				btn_choose:'选择',
				btn_change:'更改',
				droppable:false,
				onchange:null,
				thumbnail:false
			});
			
			$('#tp1').ace_file_input({
				no_file:'请选择文件 ...',
				btn_choose:'选择',
				btn_change:'更改',
				droppable:false,
				onchange:null,
				thumbnail:false
			});
			
			$('#tp2').ace_file_input({
				no_file:'请选择图片 ...',
				btn_choose:'选择',
				btn_change:'更改',
				droppable:false,
				onchange:null,
				thumbnail:false
			});
		});
		
		
		//保存
		function save(){
			/* if(typeof($("#tpz").val()) == "undefined"){
				if($("#tp").val()=="" || document.getElementById("tp").files[0] =='请选择视频'){
					
					$("#tp").tips({
						side:3,
			            msg:'请选视频',
			            bg:'#AE81FF',
			            time:3
			        });
					return false;
				}
			}
			if(typeof($("#tpz1").val()) == "undefined"){
				if($("#tp1").val()=="" || document.getElementById("tp").files[0] =='请选择文件'){
					
					$("#tp1").tips({
						side:3,
			            msg:'请选文件',
			            bg:'#AE81FF',
			            time:3
			        });
					return false;
				}
			} */
			
			if($("#PROJECT_NAME").val()==""){
				$("#PROJECT_NAME").tips({
					side:3,
		            msg:'项目名不能为空！',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROJECT_NAME").focus();
			return false;
			}
			
			if($("#QUOTA_LIMIT").val()==""){
				$("#QUOTA_LIMIT").tips({
					side:3,
		            msg:'名额限制不能为空！',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#QUOTA_LIMIT").focus();
			return false;
			}
			
			if($("#START_TIME").val()==""){
				$("#START_TIME").tips({
					side:3,
		            msg:'开始时间不能为空！',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#START_TIME").focus();
			return false;
			}
			if($("#END_TIME").val()==""){
				$("#END_TIME").tips({
					side:3,
		            msg:'结束时间不能为空！',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#END_TIME").focus();
			return false;
			}
			if($("#BROWSE_NUM").val()==""){
				$("#BROWSE_NUM").tips({
					side:3,
		            msg:'浏览数不能为空！',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BROWSE_NUM").focus();
			return false;
			}
			if($("#STOCK_NUM").val()==""){
				$("#STOCK_NUM").tips({
					side:3,
		            msg:'库存量不能为空！',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STOCK_NUM").focus();
			return false;
			}
			
			
			if($("#TYPE").val()=="1"){
				$("#PROJECT_DESC_DETAIL").val(getContentTxt());
			}else{
				$("#PROJECT_DESC_DETAIL").val(getContent());
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		//删除视频
		function delP(VIDEO_URL,PROJECT_ID){
			 if(confirm("确定要删除视频？")){
				var url = "project/deltp.do?VIDEO_URL="+VIDEO_URL+"&PROJECT_ID="+PROJECT_ID+"&guid="+new Date().getTime();
				$.get(url,function(data){
					if(data=="success"){
						alert("删除视频成功!");
						document.location.reload();
					}
				});
			} 
		}
		//删除文件
		function delP1(FILE_URL,PROJECT_ID){
			 if(confirm("确定要删除文件？")){
				var url = "project/deltp1.do?FILE_URL="+FILE_URL+"&PROJECT_ID="+PROJECT_ID+"&guid="+new Date().getTime();
				$.get(url,function(data){
					if(data=="success"){
						alert("删除文件成功!");
						document.location.reload();
					}
				});
			} 
		}
		
		//删除文件
		function delP2(COVER_PICTURE,PROJECT_ID){
			 if(confirm("确定要删除图片？")){
			 var url = "project/deltp2.do?COVER_PICTURE="+COVER_PICTURE+"&PROJECT_ID="+PROJECT_ID+"&guid="+new Date().getTime();
				$.get(url,function(data){
					if(data=="success"){
						alert("删除文件成功!");
						document.location.reload();
					}
				});
			} 
		}
		
		/* //过滤类型
		function fileType(obj){
			var fileType=obj.value.substr(obj.value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
		    if(fileType != '.gif' && fileType != '.png' && fileType != '.jpg' && fileType != '.jpeg'){
		    	$("#tp").tips({
					side:3,
		            msg:'请上传图片格式的文件',
		            bg:'#AE81FF',
		            time:3
		        });
		    	$("#tp").val('');
		    	document.getElementById("tp").files[0] = '请选择图片';
		    }
		} */

		function setType(value){
			$("#TYPE").val(value);
		}
		function close(){
			top.Dialog.close();
		}

		//打开查看
		function dialog_open(){
			$("#PROJECT_NAME").val($("#PROJECT_NAME").val());
			$("#dialog-add").css("display","block");
		}
		//关闭查看
		function cancel_pl(){
			$("#dialog-add").css("display","none");
		}
		//ueditor纯文本
		function getContentTxt() {
		    var arr = [];
		    arr.push(UE.getEditor('editor').getContentTxt());
		    return arr.join("");
		}
		//ueditor有标签文本
		function getContent() {
		    var arr = [];
		    arr.push(UE.getEditor('editor').getContent());
		    return arr.join("");
		}

		setTimeout("ueditor()",10);
		function ueditor(){
			var ue = UE.getEditor('editor');
			 ue.ready(function() {//编辑器初始化完成再赋值  
		            //ue.setContent(contentVal);  //赋值给UEditor  
		           ue.setContent(""); 
		           ue.execCommand('insertHtml', '${pd.PROJECT_DESC_DETAIL}');
		     });  
			
		}
		
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>