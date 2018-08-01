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
	<base href="<%=basePath%>"><!-- jsp文件头和头部 -->
<!-- jsp文件头和头部 -->
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />

    <style type="text/css">
        .right{text-align: right;}
    </style>
	</head>
<body>
		
<div class="container-fluid" id="main-container">

	<div id="breadcrumbs">
	
	<ul class="breadcrumb">
		<li><i class="icon-home"></i> <a>会员管理</a><span class="divider"><i class="icon-angle-right"></i></span></li>
		<li class="active"><a>会员列表</a></li>
	</ul><!--.breadcrumb-->
	
	<div id="nav-search">
	</div><!--#nav-search-->
	
	</div><!--#breadcrumbs-->

<div id="page-content" class="clearfix">
						
  <div class="row-fluid">

	<div class="row-fluid">
	
			<!-- 检索  -->
			<form action="userdetail/userbuyListPage.do" method="post" name="Form" id="Form">
			<table class="searchTable" style="width: 1300px;">
				<tr>
					<!-- <td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="n_title"  placeholder="这里输入标题" />
							<i id="nav-search-icon" class="icon-search"></i>
						</span>
					</td> -->
                     <td ><span>用户名:</span><input class="span20" name="user_name" id="username" value="${pd.user_name}" type="text" style="width:200px;" placeholder="用户名"/></td>   
                    <td ><span>姓名:</span><input class="span20" name="real_name" id="realname" value="${pd.real_name}" type="text" style="width:200px;" placeholder="姓名"/></td>  
                    <td ><span>手机号:</span><input class="span20" name="phone" id="phone" value="${pd.phone}" type="text" style="width:200px;" placeholder="手机号"/></td>	
                    <td ><span>推荐人用户名:</span><input class="span20" name="ref_username" id="refusername" value="${pd.ref_username}" type="text" style="width:200px;" placeholder="推荐人"/></td>   
				</tr>
                <tr>

                        <span>会员状态:</span>
                        <select class="chzn-select" name="status" id="status" data-placeholder="请选择" style="vertical-align:top;width: 120px;">
                            <option style="text-align: center;" value=""  <c:if test="${pd.status =='' }">selected='selected'</c:if>>--请选择--</option>
                            <option style="text-align: center;" value="1" <c:if test="${pd.status =='1' }">selected='selected'</c:if>>有效</option>
                            <option style="text-align: center;" value="0" <c:if test="${pd.status =='0' }">selected='selected'</c:if>>无效</option>
                        </select>
                    </td>
                    <td >
                    <span>注册时间:</span><input class="span10 date-picker" name="startTime" id="startTime" value="${pd.startTime}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期"/>-
                    <input class="span10 date-picker" name="endTime" id="endTime" value="${pd.endTime}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期"/></td>
                    <td >
                    <button class="btn btn-mini btn-light" onclick="search();"  title="检索">查询</button>
                   <%--  <c:if test="${QX.cha == 1 }"> --%>
                        <a class="btn btn-mini btn-light" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="icon-download-alt"></i></a>
                   <%--  </c:if> --%>
                    <input class="btn btn-mini btn-light" type="button" onclick="clearValue()" value="重置"></input>
                    </td>
                </tr>
			</table>
			<!-- 检索  -->
		
			<table id="table_report" class="table table-striped table-bordered table-hover">
				
				<thead>
					<tr >
						<!-- <th class="center">
						<label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
						</th> -->
						<th>序号</th>
						<th>用户名</th>
						<th>真实姓名</th>
						<th>邮箱</th>
						<th>手机号</th>						
						<th>推荐人用户名</th>
						<th>注册时间</th>
						<th>累计新币数量</th>
						<th>密码重置</th>
						<th>用户类型</th>
						<th>会员状态</th>
						<th>操作</th>
						<!-- <th class="center">操作</th> -->
					</tr>
				</thead>
										
				<tbody>
					
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty varList}">
					<%-- 	<c:if test="${QX.cha == 1 }"> --%>
						<c:forEach items="${varList}" var="var" varStatus="vs">
							<tr>
								<%-- <td class='center' style="width: 30px;">
									<label><input type='checkbox' name='ids' value="${var.news_id}" /><span class="lbl"></span></label>
								</td> --%>
								<td class='center' style="width: 30px;">${vs.index+1}</td>
								<td>${var.user_name }</td>
								<td>${var.real_name }</td>
								<%-- <td><a href="javascript:getUserDetail('${var.email }')">${var.email }</a></td> --%>
								<td>${var.email }</a></td>
								<td>${var.phone }</a></td>
								<td>${var.ref_username }</td>
								<td><fmt:formatDate value="${var.create_time}" type="both"/></td>
								<td>${var.total_amnt }</td>
								<td><a href="javascript:resetPassword('${var.user_code }')">密码重置</a></td>

                                <td>
                                    <c:if test="${var.user_type == 1}">普通会员</c:if>
                                    <c:if test="${var.user_type == 2}">VIP会员</c:if>
                                </td>
                                <td><c:if test="${var.status ==1 }">有效</c:if><c:if test="${var.status ==0 }">禁用</c:if></td>
                                <td class="center">
                                    <c:if test="${var.status ==1 }"><font color="grey">已启用</font>&nbsp;|&nbsp;<a href="javascript:disableStatus('${var.user_code }','0')"><font color="red">禁用 </a></font></c:if>
                                    <c:if test="${var.status ==0 }"><a href="javascript:disableStatus('${var.user_code }','1')">启用</a>&nbsp;|&nbsp;<font color="grey">已禁用</font></c:if>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <c:if test="${var.user_type ==1 }"><font color="grey">普通会员</font>&nbsp;|&nbsp;<a href="javascript:changeUsertype('${var.user_code }','2')"><font color="red">VIP会员 </a></font></c:if>
                                    <c:if test="${var.user_type ==2 }"><a href="javascript:changeUsertype('${var.user_code }','1')">VIP会员</a>&nbsp;|&nbsp;<font color="grey">普通会员</font></c:if>
                                    
                                    
                                </td>
								
								<%-- <td style="width: 30px;" class="center">
									<div class='hidden-phone visible-desktop btn-group'>
										<c:if test="${QX.edit != 1}">
										<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限"></i></span>
										</c:if>
										<div class="inline position-relative">
										<button class="btn btn-mini btn-info" data-toggle="dropdown"><i class="icon-cog icon-only"></i></button>
										<ul class="dropdown-menu dropdown-icon-only dropdown-light pull-right dropdown-caret dropdown-close">
											<c:if test="${QX.edit == 1 }">
                                            
                                                  <li><a style="cursor:pointer;" title="编辑" onclick="toEdit('${var.id}');" class="tooltip-success" data-rel="tooltip" title="" data-placement="left"><span class="green"><i class="icon-edit"></i></span></a></li>
                                          
		
                                                  <li><a style="cursor:pointer;" title="查看" onclick="toEdit('${var.id}');" class="tooltip-success" data-rel="tooltip" title="" data-placement="left"><span class="green"><i class="icon-search"></i></span></a></li>
                                            
											</c:if>
											<c:if test="${QX.del == 1 }">
											<li><a style="cursor:pointer;" title="删除" onclick="del('${var.id}');" class="tooltip-error" data-rel="tooltip" title="" data-placement="left"><span class="red"><i class="icon-trash"></i></span> </a></li>
											</c:if>
										</ul>
										</div>
									</div>
								</td> --%>
							</tr>
						
						</c:forEach>
						<%-- </c:if> --%>
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
                <%-- <td style="vertical-align:top;">
                    <c:if test="${QX.add == 1 }">
                    <a class="btn btn-small btn-success" onclick="add();">新增</a>
                    </c:if>
                </td> --%>
                <td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
            </tr>
        </table>
        </div>
		</form>
	</div>
	<!-- PAGE CONTENT ENDS HERE -->
  </div><!--/row-->
	
</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->
		
		<!-- 返回顶部  -->
		<!-- <a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
			<i class="icon-double-angle-up icon-only"></i>
		</a> -->
		
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/ace/js/jquery.js'>\x3C/script>");</script>
		<script src="static/ace/js/bootstrap.js"></script>
		<script src="static/ace/js/ace-elements.js"></script>
     
        <!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
        
		<script type="text/javascript">
		$(top.hangge());//关闭加载状态
	
		/* $(window.parent.hangge()); */
		//检索
		function search(){
			
// 			window.parent.jzts();
			$("#Form").attr("action","<%=basePath%>userdetail/userbuyListPage.do"); 
			$("#Form").submit();
		}
		function clearValue(){
			$("input").not("input[type='button']").val("");
			setChosenValue('status','');
		}
		function setChosenValue(selector,value){
            var selectObj = $("#"+selector);
            selectObj.parent().children().remove('div');
            selectObj.removeClass();
            $("#"+selector).val(value); 
            selectObj.addClass("chzn-select");  
            selectObj.chosen();
        }
		function updateFlag(id,buy_flag){
			$.post('<%=basePath%>userdetail/updatebuyStatus.do',{'id':id,'buy_flag':buy_flag},function(data){
                if(data.success){
                	window.location.reload();
                }else{
                	bootbox.alert(data.message);
                }
            });
		}
		function toEdit(id){
			window.parent.jzts();
			window.location.href='<%=basePath%>userdetail/toEdit.do?id='+id;
		}
		function del(id){
			$.post('<%=basePath%>trade/del.do',{'id':id},function(data){
				if(data.success){
					window.location.reload();
				}else{
					bootbox.alert(data.message);
				}
			});
        }
		function getUserDetail(phone){
			var f = document.createElement("form");
	        document.body.appendChild(f);
	        var i = document.createElement("input");
	        i.type = "hidden";
	        f.appendChild(i);
	        i.value = phone;
	        i.name = "phone";
	        f.action = "<%=basePath%>userdetail/getUserDetail.do";
	        f.submit();
		}
		function disableStatus(user_code,status){			
			 var url = "<%=basePath%>userdetail/disableStatus.do";	
			
			 /* $.ajax({
					type: "POST",
					url: 'http://127.0.0.1:8080/MVNFHM/userdetail/disableStatus.do?user_code=10000000307&status=1',
			    	data: {},
					dataType:'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data){
						alert(data);
						if(data.success){
							window.location.reload();
						}else{
							alert(data.message);
						}
					}
				}); */
			 
			 
			 $.post(url,{'user_code':user_code,'status':status},function(data){
				if(data.success){
					window.location.reload();
				}else{
					alert(data.message);
				}
			}); 
		}
		
		function changeUsertype(user_code,userType){			
			 var url = "<%=basePath%>userdetail/changeusertype.do";	
			
			/*  $.ajax({
					type: "POST",
					url: 'http://127.0.0.1:8080/MVNFHM/userdetail/changeusertype.do?user_code=10000000307&userType=2',
			    	data: {},
					dataType:'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data){
						alert(data);
						if(data.success){
							window.location.reload();
						}else{
							alert(data.message);
						}
					}
				}); */
			 
			 
			  $.post(url,{'user_code':user_code,'userType':userType},function(data){
				if(data.success){
					window.location.reload();
				}else{
					alert(data.message);
				}
			}); 
		}
		
		
		function resetPassword(user_code){
			 bootbox.confirm("确定要重置吗？", function (result) {  
                if(result) {  
                	var url = "<%=basePath%>userdetail/resetPassword.do";
                    $.post(url,{'user_code':user_code},function(data){
                        bootbox.alert(data.message);
                    });
                }
             });  
		}
	    $(function() {
            
            //下拉框
            $(".chzn-select").chosen(); 
            $(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
            
            //日期框
            $('.date-picker').datepicker();
            
            //复选框
            /* $('table th input:checkbox').click(function(){
                var that = this;
                $(this).closest('table').find('tr > td:first-child input:checkbox')
                .each(function(){
                    this.checked = that.checked;
                    $(this).closest('tr').toggleClass('selected');
                });
                    
            }); */
            
        });
        //导出excel
        function toExcel(){
<%--             window.location.href='<%=basePath%>/business/user/excel.do'; --%>
            $("form").attr("action","<%=basePath%>userdetail/excel.do");
            $("form").submit();
        }
        function testTriger(){
        	$.post("<%=basePath%>trade/testTriger.do",function(data){
        		alert(data.message);
        	});
        }
		</script>
		
	</body>
</html>

