<!DOCTYPE html>
<html>
<head>
	<title>�˺�ע��</title>
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
			if a="" or b="" or c="" or d="��ѡ�������ڵĲ���" or e="" or f="" or g="" or h="��ѡ�������ڵĿα�" then
				response.write "<script>alert('���������������ϡ�');history.go(-1);</script>"
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
				response.write "<script>alert('ע��ɹ���');history.go(-2);</script>"
			end if
		else
			response.write "<script>alert('�������벻һ�£����������롣');history.go(-1);</script>"
		end if
	else
		response.write "<script>alert('���˺��Ѿ�ע��!');history.go(-1);</script>"
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
        alert("�������˺���Ϣ�����ύע�ᡣ");
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
    <a href="/index.asp">��ҳ</a> >> �˺�ע��
</div>
<div id="content" style="height:1200px">
	<hr>
		<div class="stat">
		<ul>
			<li>���˺�Ϊ���ڸ���վͨ��Ȩ�޵�ƾ֤�������ضԴ���</li>
			<li>���������ĸ�������,�����βΪ"tp-link.net"����������������ע�ᡣ</li>
			<li>�����ظ�ע������˺š�</li>
			<li>�����������������ַ�����"`"��"?"��"." �ȡ�</li>
			<li>����KEYΪ����������ʱ�����һصĿ�����Ϊ20���ַ�������ؼ������</li>
			<li>���ε�½ʱ��Ϊ30���ӣ���������ʱ�������µ�½����ǰ�ı�����Ҳ�ᱻ��ա�������λ��30�����ڼ�ʱ�������������</li>
		</ul>
	</div>
	<form method="post" onsubmit="return check()">
		<table id="silter">
			<caption>&nbsp;</caption>
			<tr>
				<td style="width:80px;text-align:right">���䣺</td><td colspan="2"><input type="text" name="account" id="account"></td>
			</tr>
			<tr>
				<td style="text-align:right">���룺</td><td colspan="2"><input type="password" name="pwd1"></td>
			</tr>
			<tr>
				<td style="text-align:right">ȷ�����룺</td><td colspan="2"><input type="password" name="pwdc"></td>
			</tr>
			<tR>
				<td style="text-align:right">���ţ�</td><td colspan="2"><input type="text" name="accountid"></td>
			</tR>
			<tr>
				<td style="text-align:right">���ţ�</td>
				<td style="width:160px">
                    <select name="dept" id="dept" onchange="dept0(document.getElementById('dept').options[document.getElementById('dept').selectedIndex].value)">
						<option>��ѡ�������ڵĲ���</option>
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
						<option selected="selected">��ѡ�������ڵĿα�</option>
					</select>
				</td>
			</tr>
			<tr>
				<td style="text-align:right">�绰��</td><td colspan="2"><input type="text" name="telephone"></td>
			</tr>
			<tr>
				<td style="text-align:right">������</td><td colspan="2"><input type="text" name="name"></td>
			</tr>
			<tr>
				<td style="text-align:right">����KEY��</td><td colspan="2"><input type="text" name="anwserkey" maxlength="24"></td>
			</tr>
			<tr>
				<td colspan="3" style="border:none">
					<input type="submit" value="ע��" name="zs" class="an" style="width:80%;float:left">
					<input type="reset" value="����" class="an" style="width:20%;">
				</td>
			</tr>
		</table>
	</form>
</div >
<!--#include virtual="/bottom.html"-->
</body>
</html>