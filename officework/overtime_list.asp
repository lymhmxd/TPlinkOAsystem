<!DOCTYPE html>
<html>
<head>
    <meta charset="gb2312">
    <title>Document</title>
    <!--#include virtual="/Connections/Onlinework.asp"-->
    <!--#include virtual="/Connections/basic.asp"-->
    <%
        response.contenttype="application/excel"
        response.addheader "content-disposition","attachment;filename=" & now() & ".xls"
    %>
    <%
		set cnn_ot=server.createobject("adodb.connection")
        set cnn=server.createobject("adodb.connection")
		cnn_ot.open Onlinework_String
        cnn.open basic_String
		sql_ot="select * from overtime where datepart('ww',[����],2)=" & datepart("ww",date(),2)-1 & " order by account desc,�ύʱ�� asc"
		set rs_ot=server.createobject("adodb.recordset")
		rs_ot.open sql_ot,cnn_ot,1,1
	%>
</head>
<body>
<table border="1">
    <tr>
        <th>����</th>
        <th>����</th>
        <th>��λ</th>
        <th>�ڹ�����</th>
        <th>����</th>
        <th>Ԥ����ֹʱ��</th>
        <th>ʱ��</th>
        <th>ʵ����ֹʱ��</th>
        <th>ʱ��</th>
        <th>Ա��ǩ��</th>
        <th>˵��</th>
    </tr>
    <%while not rs_ot.eof%>
    <tr>
        <td><%=cnn.execute("select name from logmsg where account='" & rs_ot("account") & "'")(0)%></td>
		<td><%=cnn.execute("select accountid from logmsg where account='" & rs_ot("account") & "'")(0)%></td>
		<td><%=cnn.execute("select [position] from logmsg where account='" & rs_ot("account") & "'")(0)%></td>
        <td><%=rs_ot("�ڹ�����")%></td>
        <td><%=rs_ot("����")%></td>
        <td><%=rs_ot("Ԥ����ֹʱ��")%></td>
        <td><%=rs_ot("Ԥ��ʱ��")%></td>
        <td><%=rs_ot("ʵ����ֹʱ��")%></td>
        <td><%=rs_ot("ʵ��ʱ��")%></td>
        <td>&nbsp;</td>      
        <td><%=rs_ot("˵��")%></td>
    </tr>
    <%
        rs_ot.MoveNext() 
        wend
    %>
</table>
<%
    rs_ot.close():set rs_ot=nothing
    cnn_ot.close():set cnn_ot=nothing
    cnn.close():set cnn_ot=nothing
%>
</body>
</html>