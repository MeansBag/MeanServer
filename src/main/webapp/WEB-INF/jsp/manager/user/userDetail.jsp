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
    <%@ include file="../../system/admin/top.jsp"%> 
    </head>
<body>
        
<div class="container-fluid" id="main-container">

    <div id="breadcrumbs">
    
    <ul class="breadcrumb">
        <li><i class="icon-home"></i> <a>会员管理</a><span class="divider"><i class="icon-angle-right"></i></span></li>
        <li class="active"><a>会员详情</a></li>
    </ul><!--.breadcrumb-->
    
    <div id="nav-search">
    </div><!--#nav-search-->
    
    </div><!--#breadcrumbs-->

<div id="page-content" class="clearfix">
                        
  <div class="row-fluid">
    <div class="span9">
        <div class="widget-box">
            <div class="widget-header">
                <h5>基本信息</h5>
                <div class="widget-toolbar">
<!--                     <a href="#" data-action="settings"><i class="icon-cog"></i></a> -->
<!--                     <a href="#" data-action="reload"><i class="icon-refresh"></i></a> -->
                    <a href="#" data-action="collapse"><i class="icon-chevron-up"></i></a>
<!--                     <a href="#" data-action="close"><i class="icon-remove"></i></a> -->
                </div>
            </div>
            
            <div class="widget-body">
             <div class="widget-main">
                <!-- <p class="alert alert-info">
                    Nunc aliquam enim ut arcu aliquet adipiscing. Fusce dignissim volutpat justo non consectetur. Nulla fringilla eleifend consectetur.
                </p>
                <p class="alert alert-success">
                    Raw denim you probably haven't heard of them jean shorts Austin.
                </p> -->
                <div class="row-fluid">
                <div class="span4">
                    <ul>
                   	    <li class="text-info">用户名：${userDetail.user_name }</li>
                        <li class="text-info">注册时间：${userDetail.create_time }</li>
                        <li class="text-info">会员类型：<c:if test="${userDetail.user_type==1 }">普通会员</c:if><c:if test="${userDetail.user_type==2 }">VIP会员</c:if></li>
                        <li class="text-info">姓名：${userDetail.real_name }</li>
                        <li class="text-info">手机号：${userDetail.phone }</li>
                        <li class="text-info">身份证号：${userDetail.idno }</li>
                       <!--  <li><strong>List Item in strong tag</strong></li>
                        <li><em>List Item in emphasis tag</em></li> -->
                    </ul>
                </div>
                <div class="span4">
                    <ul>
                        <li class="text-info">推介人：${userDetail.ref_username }</li>
                       <%--  <li class="text-info">微信号：${userDetail.wxnum }</li>
                        <li class="text-info">支付宝账号：${userDetail.bankaccno }</li>
                        <li class="text-info">通信地址：${userDetail.mail_addrss }</li>
                        <li class="text-info">邮政编码：${userDetail.zip_code }</li> --%>
                        <!-- <li>Ordered List Item # 1</li>
                        <li class="text-info">.text-info Ordered List Item</li>
                        <li class="text-error">.text-error Ordered List Item</li>
                        
                        <li class="text-success"><b>.text-success</b> Ordered List Item</li>
                        <li class="text-warning">.text-warning Ordered List Item</li>
                        <li class="muted">.muted Ordered List Item</li> -->
                    </ul>
                </div>
                <div class="span4">
                    <ul>
                        <li class="text-info">账户总额：${userDetail.total_amnt }</li>
                     <%--    <li class="text-info">可用余额：${userDetail.avb_amnt }</li>
                        <li class="text-info">冻结余额：${userDetail.froze_amnt }</li>
                        <li class="text-info">获得奖励：${userDetail.bonuses }</li>
                        <li class="text-info">获得发放：${userDetail.reward }</li> --%>
                    </ul>
                </div>
               </div>
             </div>
            </div>
        </div>
    </div>
    <div class="row-fluid">
      <div class="span9">
          <div class="widget-box">
              <div class="widget-header">
                  <h5>团队信息</h5>
                  <div class="widget-toolbar">
<!--                       <a href="#" data-action="settings"><i class="icon-cog"></i></a> -->
<!--                       <a href="#" data-action="reload"><i class="icon-refresh"></i></a> -->
                      <a href="#" data-action="collapse"><i class="icon-chevron-up"></i></a>
<!--                       <a href="#" data-action="close"><i class="icon-remove"></i></a> -->
                  </div>
              </div>
              
              <div class="widget-body">
               <div class="widget-main">
                  <!-- <p class="alert alert-info">
                      Nunc aliquam enim ut arcu aliquet adipiscing. Fusce dignissim volutpat justo non consectetur. Nulla fringilla eleifend consectetur.
                  </p>
                  <p class="alert alert-success">
                      Raw denim you probably haven't heard of them jean shorts Austin.
                  </p> -->
<!--                   <table class="alert alert-success"> -->
                  <table id="table_report" class="table table-striped table-bordered table-hover">
                    <tr>
                      <td>推介会员：<c:if test="${vip.tNum ==null}">0</c:if><c:if test="${vip.tNum !=null}">${vip.tNum }</c:if> </td>
                      <td>A级会员：<c:if test="${vip.aNum ==null}">0</c:if><c:if test="${vip.aNum !=null}">${vip.aNum }</c:if> </td>
                      <td>B级会员：<c:if test="${vip.bNum ==null}">0</c:if><c:if test="${vip.bNum !=null}">${vip.bNum }</c:if> </td>
                      <td>C级会员：<c:if test="${vip.cNum ==null}">0</c:if><c:if test="${vip.cNum !=null}">${vip.cNum }</c:if> </td>
                    </tr>
                </table>
               </div>
              </div>
          </div>
      </div> 
    </div>
             <form action="userdetail/getUserDetail.do" method="post" name="Form" id="Form">
             <input type="hidden" name="user_name" value="${userDetail.user_name }"/>
            <!-- 检索  -->
        
            <table id="table_report" class="table table-striped table-bordered table-hover">
                
                <thead>
                    <tr >
                        <!-- <th class="center">
                        <label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
                        </th> -->
                        <th>序号</th>
                        <th>会员账号</th>
                        <th>会员名称</th>
                        <th>会员类型</th>
                        <th>购买数量</th>
                        <th>注册时间</th>
                        <th>会员级别</th>
                        <th>会员状态</th>
                        <th>推介奖励SAN</th>
                    </tr>
                </thead>
                                        
                <tbody>
                    
                <!-- 开始循环 -->   
                <c:choose>
                    <c:when test="${not empty varList}">
                        <c:if test="${QX.cha == 1 }">
                        <c:forEach items="${varList}" var="var" varStatus="vs">
                            <tr>
                                <td class='center' style="width: 30px;">${vs.index+1}</td>
                                <td>${var.phone }</td>
                                <td>${var.real_name }</td>
                                <td><c:if test="${var.user_type ==1 }">普通用户</c:if><c:if test="${var.user_type ==4 }">投资机构</c:if> </td>
                                <td>${var.total_buyNum }</td>
                                <td>${var.create_time }</td>
                                <td>${var.rela_level}</td>
                                <td>
                                <c:if test="${var.status=='1'}">有效</c:if>
                                <c:if test="${var.status=='0'}">无效</c:if>
                                </td>
                                <td>${var.total_reward }</td>
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
        <a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
            <i class="icon-double-angle-up icon-only"></i>
        </a>
        
        <!-- 引入 -->
        <script type="text/javascript">window.jQuery || document.write("<script src='js/jquery-1.9.1.min.js'>\x3C/script>");</script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/ace-elements.min.js"></script>
        <script src="js/ace.min.js"></script>
        
        <script type="text/javascript" src="js/chosen.jquery.min.js"></script><!-- 下拉框 -->
        <script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
        <script type="text/javascript" src="js/bootbox.min.js"></script><!-- 确认窗口 -->
        <!-- 引入 -->
        <script type="text/javascript" src="js/jquery.tips.js"></script><!--提示框-->
        <script type="text/javascript" src="js/jquery.cookie.js"></script>
        <script type="text/javascript">
        
    
        $(window.parent.hangge());
        //检索
        function search(){
            window.parent.jzts();
            $("#Form").submit();
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
            window.location.href='<%=basePath%>/trade/excel.do';
        }
        </script>
        
    </body>
</html>

