<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="Connections/Database.asp" -->
<%
Dim hftspczp
Dim hftspczp_cmd
Dim hftspczp_numRows

Set hftspczp_cmd = Server.CreateObject ("ADODB.Command")
hftspczp_cmd.ActiveConnection = MM_Database_STRING
hftspczp_cmd.CommandText = "SELECT * FROM HFT_ZPCL" 
hftspczp_cmd.Prepared = true

Set hftspczp = hftspczp_cmd.Execute
hftspczp_numRows = 0
%>
<%
Dim spc__numRows
Dim spc__index

spc__numRows = -1
spc__index = 0
hftspczpc_numRows = hftspczp_numRows + spc__numRows
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset=gb2312">
	<title>SPC信息管理</title>
</head>
<body>
<!--#include file="nav.html"-->
<div id="way">
    <a href="spc.asp">SPC管制</a> >> <a href="spcdy.asp">电源制造部</a> >> 变压器组装段
</div>
<div id="content" style="height:800px">
  <hr style="border:1px solid red;width:1100px;">
  <table id="datascan" align="center">
  <caption>
    电源制造部变压器课装配段SPC控制线一览表<span style="background:white;font-size:15px;">(单位PPM）</span>
  </caption>
  <tr>
    <th height="23">线别</th>
    <th>料号</th>
    <th>LX大</th>
    <th>LX小</th>
    <th>LK</th>
    <th>DCR</th>
    <th>TR</th>
    <th>PS</th>
    <th>性能合计</th>
    <th>最后更新时间</th>
    </tr>
  <% 
While ((spc__numRows <> 0) AND (NOT hftspczp.EOF)) 
%>
  <tr>
    <td align="center"><%=(hftspczp.Fields.Item("线别").Value)%></td>
    <td align="center"><%=(hftspczp.Fields.Item("料号").Value)%></td>
    <td align="center"><%=formatnumber((hftspczp.Fields.Item("LX大").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftspczp.Fields.Item("LX小").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftspczp.Fields.Item("LK").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftspczp.Fields.Item("DCR").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftspczp.Fields.Item("TR").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftspczp.Fields.Item("PS").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftspczp.Fields.Item("性能合计").Value),5,-1,0,0)*1000000%></td>
    <td ><%=(hftspczp.Fields.Item("最后更新时间").Value)%></td>
  </tr>
  <% 
  spc__index=spc__index+1
  spc__numRows=spc__numRows-1
  hftspczp.MoveNext()
Wend
%>
  </table>
</div>
 <!--#include file="bottom.html"-->
</body>
</html>
<%
hftspczp.Close()
Set hftspczp = Nothing
%>
