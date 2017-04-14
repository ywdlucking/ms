<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Java开源博客系统后台管理页面-Powered by java1234</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	function openTab(text,url,iconCls){
		if($("#tabs").tabs("exists",text)){
			$("#tabs").tabs("select",text);
		}else{
			var content="<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='/admin/"+url+"'></iframe>";
			$("#tabs").tabs("add",{
				title:text,
				iconCls:iconCls,
				closable:true,
				content:content
			});
		}
	}
	
	var url;
	function openPasswordModifyDialog(){
		$("#dlg").dialog("open").dialog("setTitle","修改密码");
		url="${pageContext.request.contextPath}/admin/blogger/updatePassword.do";
	}
	
	function modifyPassword(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				var newPassword=$("#newPassword").val();
				var newPassword2=$("#newPassword2").val();
				if(!$(this).form("validate")){
					return false;
				}
				if(newPassword!=newPassword2){
					$.messager.alert("系统提示","确认密码输入错误！");
					return false;
				}
				return true;
			},
			success:function(result){
				if(result){
					$.messager.alert("系统提示","密码修改成功,下一次登录生效！");
					resetValue();
					$("#dlg").dialog("close");
				}else{
					$.messager.alert("系统提示","密码修改失败！");
					return;
				}
			}
		});
	}
	
	function closePasswordModifyDialog(){
		resetValue();
		$("#dlg").dialog("close");
	}
	
	function resetValue(){
		$("#newPassword").val("");
		$("#newPassword2").val("");
	}
	
	function refreshSystem(){
		$.post("${pageContext.request.contextPath}/admin/system/refreshSystem.do",{},function(result){
			if(result){
				$.messager.alert("系统提示","已成功刷新系统缓存！");
			}else{
				$.messager.alert("系统提示","刷新系统缓存失败！");
			}
		},"json");
	}
	
	function logout(){
		$.messager.confirm("系统提示", "你确定要退出系统吗？", function(r){
			if(r){
				window.location.href="${pageContext.request.contextPath}/admin/blogger/logout.do";
			}
		});
	}
</script>
</head>
<body class="easyui-layout">
<div region="north" style="height: 82px;background-color: #E0ECFF">
	<table style="padding: 0px" width="100%">
		<tr>
			<td width="50%">
				<img alt="logo" src="/static/images/logo.png" style="height: 72px;margin-top: -14 x;">
			</td>
			<td valign="bottom" align="right" width="50%">
				<font size="3">&nbsp;&nbsp;<strong>欢迎：</strong>${currentUser.userName }</font>
			</td>
		</tr>
	</table>
</div>

<div region="center">
	<div class="easyui-tabs" fit="true" border="false" id="tabs">
		<div title="首页" data-options="iconCls:'icon-home'">
			<div align="center" style="padding-top: 100px"><font color="red" size="10">欢迎使用</font></div>
		</div>
	</div>
</div>

<div region="west" style="width: 200px" title="导航菜单" split="true">
	<div class="easyui-accordion" data-options="fit:true,border:false">
		<div title="常用操作" data-options="selected:true,iconCls:'icon-item'" style="padding: 10px">
			<a href="javascript:openTab('写博客','writeBlog.jsp','icon-writeblog')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-writeblog'" style="width: 150px">写博客</a>
			<a href="javascript:openTab('评论审核','commentReview.jsp','icon-review')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-review'" style="width: 150px">评论审核</a>
		</div>
		<div title="博客管理"  data-options="iconCls:'icon-bkgl'" style="padding:10px;">
			<a href="javascript:openTab('写博客','writeBlog.jsp','icon-writeblog')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-writeblog'" style="width: 150px;">写博客</a>
			<a href="javascript:openTab('博客信息管理','blogManage.jsp','icon-bkgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-bkgl'" style="width: 150px;">博客信息管理</a>
			<a href="javascript:openTab('写滚屏博客','writeScoll.jsp','icon-write-scoll')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-write-scoll'" style="width: 150px;">写滚屏博客</a>
			<a href="javascript:openTab('博客信息管理','scollManage.jsp','icon-scoll')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-scoll'" style="width: 150px;">滚屏博客信息管理</a>
			<a href="javascript:openTab('写时间轴','writeTime.jsp','icon-write-time')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-write-time'" style="width: 150px;">写时间轴</a>
			<a href="javascript:openTab('时间轴管理','timeManage.jsp','icon-time')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-time'" style="width: 150px;">时间轴管理</a>
		</div>
		<div title="博客类别管理" data-options="iconCls:'icon-bklb'" style="padding:10px">
			<a href="javascript:openTab('博客类别信息管理','blogTypeManage.jsp','icon-bklb')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-bklb'" style="width: 150px;">博客类别信息管理</a>
		</div>
		<div title="评论管理"  data-options="iconCls:'icon-plgl'" style="padding:10px">
			<a href="javascript:openTab('评论审核','commentReview.jsp','icon-review')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-review'" style="width: 150px">评论审核</a>
			<a href="javascript:openTab('评论信息管理','commentManage.jsp','icon-plgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-plgl'" style="width: 150px;">评论信息管理</a>
			<a href="javascript:openTab('反馈审核','recommendReview.jsp','icon-recommend-re')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-recommend-re'" style="width: 150px">反馈审核</a>
			<a href="javascript:openTab('反馈信息管理','recommendManage.jsp','icon-recommend-mg')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-recommend-mg'" style="width: 150px;">反馈信息管理</a>
			<a href="javascript:openTab('留言审核','wordsReview.jsp','icon-words-re')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-words-re'" style="width: 150px">留言审核</a>
			<a href="javascript:openTab('留言信息管理','wordsManage.jsp','icon-words-mg')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-words-mg'" style="width: 150px;">留言信息管理</a>
		</div>
		<div title="链接管理"  data-options="iconCls:'icon-link-system'" style="padding:10px">
			<a href="javascript:openTab('链接审核','linkReview.jsp','icon-link-review')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-link-review'" style="width: 150px">链接审核</a>
			<a href="javascript:openTab('友情链接管理','linkManage.jsp','icon-link')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-link'" style="width: 150px">友情链接管理</a>		</div>
		<div title="个人信息管理"  data-options="iconCls:'icon-grxx'" style="padding:10px">
			<a href="javascript:openTab('修改个人信息','modifyInfo.jsp','icon-grxxxg')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-grxxxg'" style="width: 150px;">修改个人信息</a>
		</div>
		<div title="系统管理"  data-options="iconCls:'icon-system'" style="padding:10px">		    
			<a href="javascript:openPasswordModifyDialog()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 150px;">修改密码</a>
			<a href="javascript:refreshSystem()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-refresh'" style="width: 150px;">刷新系统缓存</a>
			<a href="javascript:logout()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-exit'" style="width: 150px;">安全退出</a>
		</div>
	</div>
</div>

<div region="south" style="height: 25px;padding: 5px" align="center">
	Copyright © 2016 土豆说 版权所有
</div>

<div id="dlg" class="easyui-dialog" style="width: 400px;height: 200px;padding: 10px 20px" closed="true" buttons="#dlg-buttons">
	<form id="fm" method="post">
		<table cellspacing="8px">
			<tr>
				<td>用户名：</td>
				<td>
					<input type="text" id="userName" name="userName" value="${currentUser.userName }" readonly="readonly" style="width: 200px"/>
				</td>
			</tr>
			<tr>
				<td>新密码：</td>
				<td>
					<input type="password" id="newPassword" name="newPassword" class="easyui-validatebox" required="true" style="width: 200px"/>
				</td>
			</tr>
			<tr>
				<td>确认新密码：</td>
				<td>
					<input type="password" id="newPassword2" name="newPassword2" class="easyui-validatebox" required="true" style="width: 200px"/>
				</td>
			</tr>
		</table>
	</form>
</div>

<div id="dlg-buttons">
	<a href="javascript:modifyPassword()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closePasswordModifyDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>

</body>
</html>