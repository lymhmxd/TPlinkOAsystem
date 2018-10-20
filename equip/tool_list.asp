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
        <th style="width:100px">物料编码</th>
        <th style="width:600px">物料描述</th>
        <th style="width:100px">PN号码</th>
        <th style="width:100px">设备从属</th>
        <th style="width:50px">仓位</th>
        <th style="width:100px">现有量</th>
        <th style="width:100px">安全库存</th>
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
        <th style="width:100px">日期</th>
        <th style="width:100px">物料编码</th>
        <th style="width:100px">处理人</th>
        <th style="width:100px">处理方式</th>
        <th style="width:50px">数量</th>
        <th style="width:200px">原因</th>
        <th style="width:600px">物料描述</th>
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