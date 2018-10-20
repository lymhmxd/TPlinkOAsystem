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
		sql_ot="select * from overtime where datepart('ww',[日期],2)=" & datepart("ww",date(),2)-1 & " order by account desc,提交时间 asc"
		set rs_ot=server.createobject("adodb.recordset")
		rs_ot.open sql_ot,cnn_ot,1,1
	%>
</head>
<body>
<table border="1">
    <tr>
        <th>姓名</th>
        <th>工号</th>
        <th>岗位</th>
        <th>勤工内容</th>
        <th>日期</th>
        <th>预计起止时间</th>
        <th>时长</th>
        <th>实际起止时间</th>
        <th>时长</th>
        <th>员工签名</th>
        <th>说明</th>
    </tr>
    <%while not rs_ot.eof%>
    <tr>
        <td><%=cnn.execute("select name from logmsg where account='" & rs_ot("account") & "'")(0)%></td>
		<td><%=cnn.execute("select accountid from logmsg where account='" & rs_ot("account") & "'")(0)%></td>
		<td><%=cnn.execute("select [position] from logmsg where account='" & rs_ot("account") & "'")(0)%></td>
        <td><%=rs_ot("勤工内容")%></td>
        <td><%=rs_ot("日期")%></td>
        <td><%=rs_ot("预计起止时间")%></td>
        <td><%=rs_ot("预计时长")%></td>
        <td><%=rs_ot("实际起止时间")%></td>
        <td><%=rs_ot("实际时长")%></td>
        <td>&nbsp;</td>      
        <td><%=rs_ot("说明")%></td>
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