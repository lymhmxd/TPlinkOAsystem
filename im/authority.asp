<!DOCTYPE html>
<html>
<head>
	<!--#include virtual="/nav.asp"-->
	<link href="/css/authority.css" rel="stylesheet" type="text/css" />
	<title>Ȩ�޹���</title>
</head>

<body>
<div id="way">
    <a href="/index.asp">��ҳ</a>>>Ȩ�޹���
</div>
<div id="content" style="height:1200px;">
	<hr>
<%if at(0) or at(1) then%>
<%
	set cnn=createobject("adodb.connection")
	set rs=createobject("adodb.recordset")
	cnn.open Basic_String
	if request("selectid")<>"" then
		sql="select * from logmsg where id=" & request("selectid")
	else
		sql="select * from logmsg where id=" & session("id")
	end if
	rs.open sql,cnn,1,3
	a=rs("account")
	b=rs("name")
	c=rs("dept_id")
	d=rs("class_id")
%>
<%
	if request("action")="����" then
		if request("ck" & 0)="" then
			mx=0
		else
			mx=1
		end if
		for i=1 to 31
			if request("ck" & i)="" then
				mx=mx & "," & 0
			else
				mx=mx & "," & request("ck" & i)
			end if
		next
		rs("authority")=mx
		rs.update
	end if
	m=rs("authority")
	atac=split(m,",")
%>
    <form method="get">
	    <table style="margin:10px;text-wrap:none">
			<tr>
				<td style="width:80px">�˺Ŷ�λ��</td>
				<td>
					<select name="selectid" id="selectid" style="width:100px;">
						<%
						set rs1=createobject("adodb.recordset")
						if at(0) then
							rs1.open "select * from logmsg",cnn,1,1
						else
							rs1.open "select * from logmsg where class_id=" & session("dept_id"),cnn,1,1
						end if
						if not rs1.eof then
							for i=1 to rs1.recordcount
						%>
						<option value="<%=rs1("id")%>" <%if rs1("account")=a then %>selected="selected"<%end if%>><%=rs1("name")%></option>
						<%
							rs1.movenext
							next
						end if
						rs1.close:set rs1=nothing
						%>
					</select>
				</td>
				<td>&nbsp;</td>
				<td>
					<input type="submit" value="��λ" class="an">
				</td>
			</tr>
        </table>
	</form>
	<form method="get" name="renew" id="renew">
		<table id="tbau">
			<tr>
				<td style="font-weight:bold;width:5%;">��ǰ�˺ţ�</td>
				<td style="width:20%"><%=a%></td>
				<td style="font-weight:bold;width:12.5%">������</td>
				<td style="width:12.5%"><%=b%></td>
				<td style="font-weight:bold;width:12.5%">���ţ�</td>
				<td style="width:12.5%"><%=cnn.execute("select dept from department where [dept_id]=" & c)(0)%></td>
				<td style="font-weight:bold;width:12.5%">�α�</td>
				<td style="width:12.5%"><%=cnn.execute("select class from class where [dept_id]=" & c & " and [class_id]=" & d)(0)%></td>
			</tr>
			<tr>
				<td style="font-weight:bold">Ȩ�޹���</td>
				<td>����Ȩ�ޣ�</td>
				<td><input type="checkbox" name="ck0" value="1" <%if at(0)=0 then%>onclick="return false"<%end if%><%if atac(0)=1 then%>checked="checked"<%end if%>> ȫ��Ȩ��</td>
				<td colspan="5"><input type="checkbox" name="ck1" value="1" <%if at(0)=0 then%>onclick="return false"<%end if%><%if atac(1)=1 then%>checked="checked"<%end if%>> ����Ȩ��</td>
			</tr>
			<tr>
				<td rowspan="5">&nbsp;</td>
				<td>��������</td>
				<td><input type="checkbox" name="ck2" value="1" <%if at(0) or c=2 then%><%else%>onclick="return false"<%end if%><%if atac(2)=1 then%>checked="checked"<%end if%>> ��ѯ����</td>
				<td><input type="checkbox" name="ck3" value="1" <%if at(0) or c=2 then%><%else%>onclick="return false"<%end if%><%if atac(3)=1 then%>checked="checked"<%end if%>> ��������</td>
				<td><input type="checkbox" name="ck4" value="1" <%if at(0) or c=2 then%><%else%>onclick="return false"<%end if%><%if atac(4)=1 then%>checked="checked"<%end if%>> ��ȡ����</td>
				<td><input type="checkbox" name="ck5" value="1" <%if at(0) or c=2 then%><%else%>onclick="return false"<%end if%><%if atac(5)=1 then%>checked="checked"<%end if%>> ά������</td>
				<td><input type="checkbox" name="ck6" value="1" <%if at(0) or c=2 then%><%else%>onclick="return false"<%end if%><%if atac(6)=1 then%>checked="checked"<%end if%>> ��������</td>
				<td><input type="checkbox" name="ck7" value="1" <%if at(0) or c=2 then%><%else%>onclick="return false"<%end if%><%if atac(7)=1 then%>checked="checked"<%end if%>> ����Ȩ��</td>
			</tr>
			<tr>
				<td>Ʒ�ʹ���</td>
				<td><input type="checkbox" name="ck8" value="1" <%if at(0) or c=4 then%><%else%>onclick="return false"<%end if%><%if atac(8)=1 then%>checked="checked"<%end if%>> ��ѯ����</td>
				<td><input type="checkbox" name="ck9" value="1" <%if at(0) or c=4 then%><%else%>onclick="return false"<%end if%><%if atac(9)=1 then%>checked="checked"<%end if%>> ��������</td>
				<td><input type="checkbox" name="ck10" value="1" <%if at(0) or c=4 then%><%else%>onclick="return false"<%end if%><%if atac(10)=1 then%>checked="checked"<%end if%>> ��ȡ����</td>
				<td><input type="checkbox" name="ck11" value="1" <%if at(0) or c=4 then%><%else%>onclick="return false"<%end if%><%if atac(11)=1 then%>checked="checked"<%end if%>> ά������</td>
				<td><input type="checkbox" name="ck12" value="1" <%if at(0) or c=4 then%><%else%>onclick="return false"<%end if%><%if atac(12)=1 then%>checked="checked"<%end if%>> ��������</td>
				<td><input type="checkbox" name="ck13" value="1" <%if at(0) or c=4 then%><%else%>onclick="return false"<%end if%><%if atac(13)=1 then%>checked="checked"<%end if%>> ����Ȩ��</td>
			</tr>
			<tr>
				<td>���̹���</td>
				<td><input type="checkbox" name="ck14" value="1" <%if at(0) or c=3 then%><%else%>onclick="return false"<%end if%><%if atac(14)=1 then%>checked="checked"<%end if%>> ��ѯ����</td>
				<td><input type="checkbox" name="ck15" value="1" <%if at(0) or c=3 then%><%else%>onclick="return false"<%end if%><%if atac(15)=1 then%>checked="checked"<%end if%>> ��������</td>
				<td><input type="checkbox" name="ck16" value="1" <%if at(0) or c=3 then%><%else%>onclick="return false"<%end if%><%if atac(16)=1 then%>checked="checked"<%end if%>> ��ȡ����</td>
				<td><input type="checkbox" name="ck17" value="1" <%if at(0) or c=3 then%><%else%>onclick="return false"<%end if%><%if atac(17)=1 then%>checked="checked"<%end if%>> ά������</td>
				<td><input type="checkbox" name="ck18" value="1" <%if at(0) or c=3 then%><%else%>onclick="return false"<%end if%><%if atac(18)=1 then%>checked="checked"<%end if%>> ��������</td>
				<td><input type="checkbox" name="ck19" value="1" <%if at(0) or c=3 then%><%else%>onclick="return false"<%end if%><%if atac(19)=1 then%>checked="checked"<%end if%>> ����Ȩ��</td>
			</tr>
			<tr>
				<td>�칫����</td>
				<td><input type="checkbox" name="ck20" value="1" <%if at(0) or c=1 then%><%else%>onclick="return false"<%end if%><%if atac(20)=1 then%>checked="checked"<%end if%>> ��ѯ����</td>
				<td><input type="checkbox" name="ck21" value="1" <%if at(0) or c=1 then%><%else%>onclick="return false"<%end if%><%if atac(21)=1 then%>checked="checked"<%end if%>> ��������</td>
				<td><input type="checkbox" name="ck22" value="1" <%if at(0) or c=1 then%><%else%>onclick="return false"<%end if%><%if atac(22)=1 then%>checked="checked"<%end if%>> ��ȡ����</td>
				<td><input type="checkbox" name="ck23" value="1" <%if at(0) or c=1 then%><%else%>onclick="return false"<%end if%><%if atac(23)=1 then%>checked="checked"<%end if%>> ά������</td>
				<td><input type="checkbox" name="ck24" value="1" <%if at(0) or c=1 then%><%else%>onclick="return false"<%end if%><%if atac(24)=1 then%>checked="checked"<%end if%>> ��������</td>
				<td><input type="checkbox" name="ck25" value="1" <%if at(0) or c=1 then%><%else%>onclick="return false"<%end if%><%if atac(25)=1 then%>checked="checked"<%end if%>> ����Ȩ��</td>
			</tr>
			<tr>
				<td>��Ϣά����</td>
				<td><input type="checkbox" name="ck26" value="1" <%if at(0) or c=1 then%><%else%>onclick="return false"<%end if%><%if atac(26)=1 then%>checked="checked"<%end if%>> ��ѯ����</td>
				<td><input type="checkbox" name="ck27" value="1" <%if at(0) or c=1 then%><%else%>onclick="return false"<%end if%><%if atac(27)=1 then%>checked="checked"<%end if%>> ��������</td>
				<td><input type="checkbox" name="ck28" value="1" <%if at(0) or c=1 then%><%else%>onclick="return false"<%end if%><%if atac(28)=1 then%>checked="checked"<%end if%>> ��ȡ����</td>
				<td><input type="checkbox" name="ck29" value="1" <%if at(0) or c=1 then%><%else%>onclick="return false"<%end if%><%if atac(29)=1 then%>checked="checked"<%end if%>> ά������</td>
				<td><input type="checkbox" name="ck30" value="1" <%if at(0) or c=1 then%><%else%>onclick="return false"<%end if%><%if atac(30)=1 then%>checked="checked"<%end if%>> ��������</td>
				<td><input type="checkbox" name="ck31" value="1" <%if at(0) or c=1 then%><%else%>onclick="return false"<%end if%><%if atac(31)=1 then%>checked="checked"<%end if%>> ����Ȩ��</td>
			</tr>
			<tr><td colspan="8">&nbsp;</td></tr>
			<tr>
				 
				<td colspan="3">&nbsp;</td>
				<td><input type="submit" class="an" value="����" name="action" style="width:80px;" onclick="return confirm('�Ƿ�ȷ������<%=b%>��Ȩ�ޣ�')"></td>
				<td><input type="reset" class="an" value="����" style="width:80px;"></td>
				<td colspan="3">&nbsp;</td>
			</tr>
		</table>
		<input type="hidden" name="selectid" value="<%=request("selectid")%>">
	</form>
<%
rs.close:set rs=nothing
%>
<%else%>
<br>
<span class="stat">����Ȩ�޽���Ȩ�޹���ҳ�档</span>
<%end if%>
</div>
<!--#include virtual="/bottom.html"-->
</body>
</html>