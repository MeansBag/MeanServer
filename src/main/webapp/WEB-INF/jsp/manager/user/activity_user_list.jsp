<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
 
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
	</head> 
<body>
<div class="container-fluid" id="main-container">
<div id="breadcrumbs">
<ul class="breadcrumb">
	<li><i class="icon-home"></i> <a>活动管理</a><span class="divider"><i class="icon-angle-right"></i></span></li>
	<li class="active">已报名用户</li>
</ul><!--.breadcrumb-->

<div id="nav-search">
	
</div><!--#nav-search-->
	<c:if test="${QX.cha == 1 }">
		<td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="icon-download-alt"></i></a></td>
	</c:if>
</div><!--#breadcrumbs-->


<div id="page-content" class="clearfix">
  <div class="row-fluid">
	<div class="row-fluid">
			<table id="table_report" class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th>序号${var.user_order_id}</th>
						<th>支付宝订单号</th>
						<th>商户订单号</th>
						<th>用户名</th>
						<th>用户电话</th>
						<!-- <th>报名场馆</th> -->
						<th>报名状态</th>
						<th>是否线上支付</th>
						<th>订单状态</th>
						<th>订单价格</th>
						<th><i class="icon-time hidden-phone"></i>创建时间</th>
					</tr>
				</thead>
				<tbody>
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty userList}">
						<c:if test="${QX.cha == 1 }">
						<c:forEach items="${userList}" var="var" varStatus="vs">
							<tr>
								<td class='center' style="width: 30px;">${vs.index+1}</td>
								<td>${var.uo_trade_no}</td>
								<td>${var.user_order_number}</td>
								<td>${var.nick_name}</td>
								<td>${var.user_mobile}</td>
								<%-- <td>${var.venue_public_account_nickname}</td> --%>
								<c:if test="${var.uaa_pay_status == 1}">
									<td>报名成功</td>
								</c:if>
								<c:if test="${var.uaa_pay_status != 1}">
									<td>报名失败</td>
								</c:if>
								<c:if test="${var.uaa_ispay == 1}">
									<td>是</td>
								</c:if>
								<c:if test="${var.uaa_ispay != 1}">
									<td>否</td>
								</c:if>
								<td>
									<c:if test="${var.uaa_ispay == 1}">
										<select name="uo_status" id="uo_status"  onchange="updateStatus(this,${var.user_order_id})" style="width:100px;">
											<option value="1" <c:if test="${var.uo_status==1}">selected="selected"</c:if>>已付款</option>
											<option value="2" <c:if test="${var.uo_status==2}">selected="selected"</c:if>>已消费</option>
											<option value="3" <c:if test="${var.uo_status==3}">selected="selected"</c:if>>已关闭</option>
											<option value="4" <c:if test="${var.uo_status==4}">selected="selected"</c:if>>已过期</option>
											<option value="5" <c:if test="${var.uo_status==5}">selected="selected"</c:if>>已退款</option>
											<option value="6" <c:if test="${var.uo_status==6}">selected="selected"</c:if>>未付款</option>
										</select>
									</c:if>
									<c:if test="${var.uaa_ispay != 1}">
										<label >线下支付</label>
									</c:if>
								</td>
								<%-- <c:if test="${var.uo_status != 1}">
									<td>无需支付</td>
								</c:if>
								<c:if test="${var.uo_status == 1}">
									<td>支付成功</td>
								</c:if> --%>
								<td>${var.uo_total_price}</td>
								<td>${var.uaa_create_datetime}</td>
							</tr>
						</c:forEach>
						</c:if>
						<c:if test="${QX.cha == 0 }">
							<tr>
								<td colspan="100" class="center">您无权查看</td>
							</tr>
						</c:if>
					</c:when>
					<c:otherwise>
						<tr class="main_info">
							<td colspan="100" class="center" >没有相关数据</td>
						</tr>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
		<div class="page-header position-relative">
		<table style="width:100%;">
			<tr>
				<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
			</tr>
		</table>
		</div>
	</div>
	<!-- PAGE CONTENT ENDS HERE -->
  </div><!--/row-->
	
</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->
		<input type="hidden" value="${pd.activity_id}" id="activityid">
		<!-- 返回顶部  -->
		<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
			<i class="icon-double-angle-up icon-only"></i>
		</a>
		
		<!-- 引入 -->
		<script src="1.9.1/jquery.min.js"></script>
		<script type="text/javascript">window.jQuery || document.write("<script src='js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/ace-elements.min.js"></script>
		<script src="js/ace.min.js"></script>
		
		<script type="text/javascript" src="js/chosen.jquery.min.js"></script><!-- 单选框 -->
		<script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		
		<script type="text/javascript">
		
		$(window.parent.hangge());
		
		//检索
		function search(){
			$("#Form").submit();
		}
		
		//新增 contestant/clistAll.do?activity_id=${activity_id}
		function add(){
			window.parent.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = 'contestant/goAdd.do?activity_id='+$('#activityid').val();
			 diag.Width = 800;
			 diag.Height = 650;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 window.parent.jzts();
						 setTimeout("self.location.reload()",100);
					 }else{
						 nextPage(${page.currentPage});
					 }
				}
				diag.close();
			 };
			 diag.show();
		}
		function updateStatus(obj,id){
			alert(23)
			bootbox.confirm("确定要修改吗?", function(result) {
				if(result) {
					//alert("$().val()="+$(obj).val()+">>>>>>"+id)
					var url = "useractivityapply/updateStatus.do?uo_status="+$(obj).val()+"&user_order_id="+id;
					$.post(url,function(data){
						if(data=="success"){
							nextPage(${page.currentPage});
						}
					});
				}
			});
		}
		
		//修改
		function edit(id){
			window.parent.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = 'link/goEdit.do?id='+id;
			 diag.Width = 800;
			 diag.Height = 650;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function del(id){
			bootbox.confirm("确定要删除该记录?", function(result) {
				if(result) {
					var url = "link/delete.do?id="+id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						if(data=="success"){
							nextPage(${page.currentPage});
						}
					});
				}
			});
		}
		
		</script>
		
		<script type="text/javascript">
		
		$(function() {
			
			//单选框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//日期框
			$('.date-picker').datepicker();
			
		});
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>/useractivityapply/excel.do?activity_id=${pd.activity_id}&&venue_public_account_id=${pd.venue_public_account_id}';
		}
		
		</script>
		
	</body>
</html>

