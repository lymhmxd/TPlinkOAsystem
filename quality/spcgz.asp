<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="Connections/spcng.asp" -->
<%
Dim spcngwork
Dim spcngwork_cmd
Dim spcngwork_numRows

Set spcngwork_cmd = Server.CreateObject ("ADODB.Command")
spcngwork_cmd.ActiveConnection = MM_spcng_STRING
spcngwork_cmd.CommandText = "SELECT * FROM eventlogs ORDER BY ID DESC" 
spcngwork_cmd.Prepared = true

Set spcngwork = spcngwork_cmd.Execute
spcngwork_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
spcngwork_numRows = spcngwork_numRows + Repeat1__numRows
%>
<!DOCTYPE html>
<head>
	<meta charset=gb2312">
	<title>SPC信息管理</title>
</head>
<body>
<!--#include file="nav.html"-->
<div id="way">
    <a href="spc.asp">SPC管制</a>
</div>
<hr style="border:1px solid red;width:1100px;">
<div id="content" style="height:1000px">
<table id="datascan">
  <caption>SPC管制记录</caption>
  <tr>
    <th>产品线</th>
    <th>日期</th>
    <th>时间</th>
    <th>线别</th>
    <th>MO单</th>
    <th>料号</th>
    <th>记录人</th>
    <th>测试段</th>
    <th>测试</br>总量</th>
    <th>上限</th>
    <th>不良量</th>
    <th>备注</th>
    <th>分析人</th>
    <th>责任</br>归属</th>
    <th>措施</br>提供</th>
    <th>跟进人</th>
    <th>跟进</br>效果</th>
    </tr>
  <% 
While ((Repeat1__numRows <> 0) AND (NOT spcngwork.EOF)) 
%>
  <tr align="center">
    <td><%=(spcngwork.Fields.Item("产品线").Value)%></td>
    <td><%=(spcngwork.Fields.Item("日期").Value)%></td>
    <td><%=(spcngwork.Fields.Item("时间段").Value)%></td>
    <td><%=(spcngwork.Fields.Item("线别").Value)%></td>
    <td><%=(spcngwork.Fields.Item("MO").Value)%></td>
    <td><%=(spcngwork.Fields.Item("料号").Value)%></td>
    <td><%=(spcngwork.Fields.Item("记录人").Value)%></td>
    <td><%=(spcngwork.Fields.Item("测试段").Value)%></td>
    <td><%=(spcngwork.Fields.Item("测试总量").Value)%></td>
    <td><%=(spcngwork.Fields.Item("上限").Value)%></td>
    <td><%=(spcngwork.Fields.Item("不良数").Value)%></td>
    <td><%=(spcngwork.Fields.Item("备注").Value)%></td>
    <td><%=(spcngwork.Fields.Item("分析人").Value)%></td>
    <td><%=(spcngwork.Fields.Item("责任归属").Value)%></td>
    <td><%=(spcngwork.Fields.Item("措施提供").Value)%></td>
    <td><%=(spcngwork.Fields.Item("跟进人").Value)%></td>
    <td><%=(spcngwork.Fields.Item("跟进效果").Value)%></td>
  </tr>
  <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  spcngwork.MoveNext()
Wend
%>
</table>

</div >
<!--#include file="bottom.html"-->
</body>
</html>
<%
spcngwork.Close()
Set spcngwork = Nothing
%>
