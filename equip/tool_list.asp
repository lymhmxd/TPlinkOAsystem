<!DOCTYPE html>
<html>
<head>
    <meta charset="gb2312">
    <title>Document</title>
    <!--#include virtual="/Connections/Ebase.asp"--> 
    <%
        response.contenttype="application/excel"
        response.addheader "content-disposition","attachment;filename=" & now() & ".xls"
        sql=replace(replace(request("sql"),"ttt","#"),"dyh","'")
        set cnn=createobject("adodb.connection")
        cnn.open ebase_String
        set rs=createobject("adodb.recordset")
        rs.open sql,cnn,1,1
	%>
</head>
<body>
<table border="1">
<%if instr(sql,"lists") then%>
    <tr align="center">
        <th style="width:100px">���ϱ���</th>
        <th style="width:600px">��������</th>
        <th style="width:100px">PN����</th>
        <th style="width:100px">�豸����</th>
        <th style="width:50px">��λ</th>
        <th style="width:100px">������</th>
        <th style="width:100px">��ȫ���</th>
    </tr>
    <%while not rs.eof%>
    <tr align="center">
        <td><%=rs("code")%></td>
        <td style="text-align:left"><%=rs("description")%></td>
        <td><%=rs("p/n")%></td>
        <td><%=rs("device")%></td>
        <td><%=rs("position")%></td>
        <td><%=rs("count")%></td>
        <td><%=rs("limit")%></td>
    </tr>
    <%
        rs.MoveNext() 
        wend
    %>
<%else%>
    <tr>
        <th style="width:100px">����</th>
        <th style="width:100px">���ϱ���</th>
        <th style="width:100px">������</th>
        <th style="width:100px">����ʽ</th>
        <th style="width:50px">����</th>
        <th style="width:200px">ԭ��</th>
        <th style="width:600px">��������</th>
    </tr>
    <%while not rs.eof%>
    <tr align="center">
        <td><%=rs("time")%></td>
        <td><%=rs("code")%></td>
        <td><%=rs("by")%></td>
        <td><%=rs("type")%></td>
        <td><%=rs("number")%></td>
        <td title="<%=rs("reason")%>" style="text-align:left"><%=rs("reason")%></td>
        <td title="<%=rs("description")%>" style="text-align:left"><%=rs("description")%></td>
    </tr>
    <%
        rs.movenext()
        wend
     %>
<%end if%>
</table>
<%
    rs.close:set rs=nothing
    cnn.close:set cnn=nothing
%>
</body>
</html>