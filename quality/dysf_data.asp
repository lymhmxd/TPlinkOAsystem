<!DOCTYPE html>
<!--#include virtual="/Connections/Database.asp" -->
<%
  set Cnn_Spc = Server.CreateObject ("ADODB.Connection")
  set Rs_Spc = server.CreateObject("ADODB.RecordSet")
  Cnn_Spc.Open Database_String
  SQL = "select * FROM PA_CL order by 线别"
  Rs_Spc.open SQL,cnn_Spc,1,1
%>
<%
  Rs_Spc.pagesize=80
  if request("page")<>"" then
    epage=Cint(request("page"))
    if epage<1 then epage=1
    if epage>Rs_Spc.pagecount then epage=Rs_Spc.pagecount
   else
    epage=1
   end if
   Rs_Spc.absolutepage=epage
%>
<head>
  <!--#include virtual="/nav.asp"-->
	<title>SPC信息管理</title>
</head>
<body>
<div id="way">
    <a href="/quality/spc.asp">SPC管制</a>>> 电源适配器/开放式电源板
</div>
<div id="content">
<hr>
<table id="datascan" align="center">
  <caption>
    电源制造部电源适配器/电源开放板SPC控制线一览表<span style="font-size:15px;">(单位PPM）</span>
  </caption>
  <tr>
    <th>线别</th>
    <th>料号</th>
    <th>ICT测试</th>
    <th>上电测试</th>
    <th>老化测试</th>
    <th>耐压测试</th>
    <th>综合测试</th>
    <th>最后更新时间</th>
  </tr>
  <% 
    for i=1 to Rs_Spc.pagesize
      if Rs_Spc.bof or Rs_Spc.eof then exit for
  %>
  <tr>
    <td align="center"><%=(Rs_Spc("线别"))%></td>
    <td align="center"><%=(Rs_Spc("料号"))%></td>
    <td align="center"><%=formatnumber(Rs_Spc("ICT测试"),5,-1,0,0)*1000000 %></td>
    <td align="center"><%=formatnumber(Rs_Spc("上电测试"),5,0,0,0)*1000000 %></td>
    <td align="center"><%=formatnumber(Rs_Spc("老化测试"),5,-1,0,0)*1000000 %></td>
    <td align="center"><%=formatnumber(Rs_Spc("耐压测试"),5,-1,0,0)*1000000 %></td>
    <td align="center"><%=formatnumber(Rs_Spc("综合测试"),5,-1,0,0)*1000000 %></td>
    <td><%=(Rs_Spc("最后更新时间"))%></td>
  </tr>
  <% Rs_Spc.MoveNext() 
     next
  %>
</table>
<p align="center">
<% if epage>1 and epage<Rs_Spc.pagecount then %>
  <a href="/quality/dysf_data.asp?page=1">首页</a>&nbsp;&nbsp;
  <a href="/quality/dysf_data.asp?page=<%=epage-1%>">上一页</a>&nbsp;&nbsp;
  <a href="/quality/dysf_data.asp?page=<%=epage+1%>">下一页</a>&nbsp;&nbsp;
  <a href="/quality/dysf_data.asp?page=<%=Rs_Spc.pagecount%>">末页</a>&nbsp;&nbsp;&nbsp;&nbsp;
<% elseif epage=1 and epage<Rs_Spc.pagecount then %>
  <a href="/quality/dysf_data.asp?page=<%=epage+1%>">下一页</a>&nbsp;&nbsp;
  <a href="/quality/dysf_data.asp?page=<%=Rs_Spc.pagecount%>">末页</a>&nbsp;&nbsp;&nbsp;&nbsp;
<% elseif epage>1 and epage=Rs_Spc.pagecount then %>
  <a href="/quality/dysf_data.asp?page=1">首页</a>&nbsp;&nbsp;
  <a href="/quality/dysf_data.asp?page=<%=epage-1%>">上一页</a>&nbsp;&nbsp;
<% end if %>
  <span align="center">第-<% =epage %>-页，共-<%=Rs_Spc.pagecount%>-页</span>
</p>
<p>&nbsp;</p>
<% Rs_Spc.Close() %>
<% Set Rs_Spc = Nothing %>
</div>
</body>
<!--#include virtual="/bottom.html"-->
</html>

