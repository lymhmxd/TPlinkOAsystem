<!DOCTYPE html>
<html>
<head>
	<title>账号注册</title>
<!--#include virtual="/nav.asp"-->
<%
if request.form("account")<>"" then
	set cnn_re=server.createobject("adodb.connection")
	cnn_re.open basic_string
	sql_re="select * from logmsg where account='" & request.form("account") & "'"
	set rs_re=server.createobject("adodb.recordset")
	rs_re.open sql_re,cnn_re,1,3
	if rs_re.bof and rs_re.eof then
		if  trim(request.form("pwd1"))=trim(request.form("pwdc")) then
			a=trim(request.form("account"))
			b=trim(request.form("pwd1"))
			c=trim(request.form("accountid"))
			d=trim(request.form("dept"))
			e=trim(request.form("telephone"))
			f=trim(request.form("name"))
			g=trim(request.form("anwserkey"))
            h=trim(request.form("class"))
			if a="" or b="" or c="" or d="请选择你所在的部门" or e="" or f="" or g="" or h="请选择你所在的课别" then
				response.write "<script>alert('请输入完整的资料。');history.go(-1);</script>"
			else
				rs_re.addnew
					rs_re("account")=a
					rs_re("password")=b
					rs_re("account_id")=c
					rs_re("dept_id")=d
					rs_re("telephone")=e
					rs_re("name")=f
					rs_re("anwserkey")=g
                    rs_re("class_id")=h
					rs_re("authority")="0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
				rs_re.update
				response.write "<script>alert('注册成功！');history.go(-2);</script>"
			end if
		else
			response.write "<script>alert('两次密码不一致！请重新输入。');history.go(-1);</script>"
		end if
	else
		response.write "<script>alert('此账号已经注册!');history.go(-1);</script>"
	end if
	rs_re.close:set rs_re=nothing
end if
%>
<%
	set rs=createobject("adodb.recordset")
	set rs1=createobject("adodb.recordset")
	rs.open "select * from department",cnn,1,1
	rs1.open "select * from class",cnn,1,1
%>
<script>
function check()
{
    if( document.getElementById("account").value=="")
    {
        alert("请输入账号信息后再提交注册。");
        return(false);
    }
}
</script>
<script>
var a=0;
b=new Array;
<%
	i=0
	do while not rs1.eof
%>
b[<%=i%>]=new Array("<%=trim(rs1("class"))%>","<%=trim(rs1("dept_id"))%>","<%=trim(rs1("class_id"))%>");
<%
	i=i+1
	rs1.movenext
	loop
    rs1.close:set rs1=nothing
%>
a=<%=i%>
function dept0(deptid)
{
	document.getElementById("class").length=0;
	var j;
	for(j=0;j<a;j++)
	{
		if(b[j][1]==deptid)
		{
			document.getElementById("class").options[document.getElementById("class").length]=new Option(b[j][0],b[j][2]);
		}
	}
}
</script>
</head>
<body>
<div id="way">
    <a href="/index.asp">首页</a> >> 账号注册
</div>
<div id="content" style="height:1200px">
	<hr>
		<div class="stat">
		<ul>
			<li>此账号为您在该网站通行权限的凭证，请慎重对待。</li>
			<li>请输入您的个人邮箱,邮箱结尾为"tp-link.net"，请勿以他人邮箱注册。</li>
			<li>请勿重复注册个人账号。</li>
			<li>密码请勿输入特殊字符，如"`"、"?"、"." 等。</li>
			<li>密码KEY为您忘记密码时用以找回的口令，最多为20个字符，请务必记清楚。</li>
			<li>单次登陆时间为30分钟，若超过该时间需重新登陆，当前的表单数据也会被清空。因此请各位在30分钟内及时处理完个人事务。</li>
		</ul>
	</div>
	<form method="post" onsubmit="return check()">
		<table id="silter">
			<caption>&nbsp;</caption>
			<tr>
				<td style="width:80px;text-align:right">邮箱：</td><td colspan="2"><input type="text" name="account" id="account"></td>
			</tr>
			<tr>
				<td style="text-align:right">密码：</td><td colspan="2"><input type="password" name="pwd1"></td>
			</tr>
			<tr>
				<td style="text-align:right">确认密码：</td><td colspan="2"><input type="password" name="pwdc"></td>
			</tr>
			<tR>
				<td style="text-align:right">工号：</td><td colspan="2"><input type="text" name="accountid"></td>
			</tR>
			<tr>
				<td style="text-align:right">部门：</td>
				<td style="width:160px">
                    <select name="dept" id="dept" onchange="dept0(document.getElementById('dept').options[document.getElementById('dept').selectedIndex].value)">
						<option>请选择你所在的部门</option>
						<%for i=1 to rs.recordcount%>
						<option value="<%=rs("dept_id")%>"><%=rs("dept")%></option>
						<%
							rs.movenext
							next
							rs.close:set rs=nothing 
						%>
					</select>
				</td>
				<td>
					<select name="class" id="class">
						<option selected="selected">请选择你所在的课别</option>
					</select>
				</td>
			</tr>
			<tr>
				<td style="text-align:right">电话：</td><td colspan="2"><input type="text" name="telephone"></td>
			</tr>
			<tr>
				<td style="text-align:right">姓名：</td><td colspan="2"><input type="text" name="name"></td>
			</tr>
			<tr>
				<td style="text-align:right">密码KEY：</td><td colspan="2"><input type="text" name="anwserkey" maxlength="24"></td>
			</tr>
			<tr>
				<td colspan="3" style="border:none">
					<input type="submit" value="注册" name="zs" class="an" style="width:80%;float:left">
					<input type="reset" value="重置" class="an" style="width:20%;">
				</td>
			</tr>
		</table>
	</form>
</div >
<!--#include virtual="/bottom.html"-->
</body>
</html>