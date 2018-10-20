<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="Connections/Database.asp" -->
<%
Dim hftzzspc
Dim hftzzspc_cmd
Dim hftzzspc_numRows

Set hftzzspc_cmd = Server.CreateObject ("ADODB.Command")
hftzzspc_cmd.ActiveConnection = MM_Database_STRING
hftzzspc_cmd.CommandText = "SELECT * FROM HFT_ZZCL" 
hftzzspc_cmd.Prepared = true

Set hftzzspc = hftzzspc_cmd.Execute
hftzzspc_numRows = 0
%>
<%
Dim spc__numRows
Dim spc__index

spc__numRows = -1
spc__index = 0
hftzzspc_numRows = hftzzspc_numRows + spc__numRows
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
    电源制造部变压器课组装段SPC控制线一览表<span style="background:white;font-size:15px;">(单位PPM）</span>
  </caption>
  <tr>
    <th>线别</th>
    <th>料号</th>
    <th>综测</th>
    <th>4200V</th>
    <th>1500V</th>
    <th>初级少锡</th>
    <th>次级少锡</th>
    <th>点胶不良</th>
    <th>绝缘线烫坏</th>
    <th>露绝缘线</th>
    <th>支点断</th>
    <th>脚歪</th>
    <th>脚脏</th>
    <th>胶带翘</th>
    <th>其他</th>
    <th>性能总计</th>
    <th>外观总计</th>
    <th>最后更新时间</th>
    </tr>
  <% 
While ((spc__numRows <> 0) AND (NOT hftzzspc.EOF)) 
%>
  <tr>
    <td align="center"><%=(hftzzspc.Fields.Item("线别").Value)%></td>
    <td align="center"><%=(hftzzspc.Fields.Item("料号").Value)%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("综测").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("4200V").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("1500V").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("初级少锡").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("次级少锡").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("点胶不良").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("绝缘线烫坏").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("露绝缘线").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("支点断").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("脚歪").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("脚脏").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("胶带翘").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("其它").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("性能总计").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("外观总计").Value),5,-1,0,0)*1000000%></td>
    <td ><%=(hftzzspc.Fields.Item("最后更新时间").Value)%></td>
  </tr>
  <% 
  spc__index=spc__index+1
  spc__numRows=spc__numRows-1
  hftzzspc.MoveNext()
Wend
%>
  </table>
</div>
 <!--#include file="bottom.html"-->
</body>
</html>
<%
hftzzspc.Close()
Set hftzzspc = Nothing
%>
