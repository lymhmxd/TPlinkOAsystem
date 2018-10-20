<!DOCTYPE html>
<html>
<!--#include virtual="/Connections/Database.asp" -->
<%
  if not request.querystring("xb")="" and not request.querystring("lh")="" then
    dim a,b
    Set Cnn_Spc = Server.CreateObject ("ADODB.Connection")
    set Rs_Spc = server.CreateObject("ADODB.RecordSet")
    Cnn_Spc.Open Database_String
    SQL = "select * FROM PA_CL where 线别='" & request.querystring("xb") & "'" & " and 料号=" & request.querystring("lh")
    Rs_Spc.open SQL,Cnn_Spc,3,3
  end if
%>
<%
  If Request.form("update")="update" Then
    Rs_Spc("ICT测试")=request.form("upone")
    Rs_Spc("上电测试")=request.form("uptwo")
    Rs_Spc("老化测试")=request.form("upthree")
    Rs_Spc("耐压测试")=request.form("upfour")
    Rs_Spc("综合测试")=request.form("upfive")
    Rs_Spc("最后更新时间")=request.form("uptime")
    Rs_Spc.update
    response.write "<script>alert('更新成功！')</script>"
  end if
%>
<%
  If Request.form("add")="add" Then
    Rs_Spc.addnew
    Rs_Spc("线别")=request.querystring("xb")
    Rs_Spc("料号")=request.querystring("lh")
    Rs_Spc("ICT测试")=request.form("addone")
    Rs_Spc("上电测试")=request.form("addtwo")
    Rs_Spc("老化测试")=request.form("addthree")
    Rs_Spc("耐压测试")=request.form("addfour")
    Rs_Spc("综合测试")=request.form("addfive")
    Rs_Spc("最后更新时间")=request.form("addtime")
    Rs_Spc.update
    response.write "<script>alert('新增加项目成功！')</script>"
  end if
%>
<head>
  <!--#include virtual="/nav.asp"-->
  <title>SPC信息管理</title>
</head>
<body>
<div id="way">
    <a href="/spc/spc.asp">SPC管制</a> >> 电源适配器/开放式电源板数据更新
</div>
<div id="content" style="height:1200px;">
<hr>
<% if session("name")<>"" then %>
  <% if at(1)=1 then %>
  <table id="silter" style="width:400px;">
    <caption style="font-size:16px;"> 电源适配器/开放式电源板数据更新</caption>
    <form method="get" action="<%=Request.ServerVariables("SCRIPT_NAME") & "?" & Request.QueryString%>">
    <tr><td>线别</td> <td><input type="text" name="xb" value=<% =request.querystring("xb") %>></td></tr>
    <tr><td>料号</td> <td><input type="text" name="lh" value=<% =request.querystring("lh") %>></td></tr>
    <tr><td>&nbsp;</td> <td><input	class="an" type="submit" value="匹配数据"></td></tr>
    </form>
    <%if request.querystring("xb")<>"" and request.querystring("xb")<>"" then %>
      <% if Not Rs_Spc.EOF or Not Rs_Spc.BOF then %>
      <form method="post">
          <tr><td>一段测试</td> <td><input type="text" name="upone" size="32" value=<%=Rs_Spc("ICT测试")%>></td></tr>
          <tr><td>二段测试</td> <td><input type="text" name="uptwo" size="32" value=<%=Rs_Spc("上电测试")%>></td></tr>
          <tr><td>三段测试</td> <td><input type="text" name="upthree" size="32" value=<%=Rs_Spc("老化测试")%>></td></tr>
          <tr><td>四段测试</td> <td><input type="text" name="upfour" size="32" value=<%=Rs_Spc("耐压测试")%>></td></tr>
          <tr><td>五段测试</td> <td><input type="text" name="upfive" size="32" value=<%=Rs_Spc("综合测试")%>></td></tr>
          <tr><td>&nbsp;</td> <td><input type="submit" class="an" value="更新数据"></td></tr>
        <input type="hidden" name="update" value="update">
        <input type="hidden" name="uptime" value="<%=now()%>">
      </form>
      <% elseif Rs_Spc.EOF and Rs_Spc.BOF then %>
      <form method="post">
          <tr><td>N段测试</td> <td><input type="text" name="addone" size="32"></td></tr>
          <tr><td>二段测试</td> <td><input type="text" name="addtwo" size="32"></td></tr>
          <tr><td>三段测试</td> <td><input type="text" name="addthree" size="32"></td></tr>
          <tr><td>四段测试</td> <td><input type="text" name="addfour" size="32"></td></tr>
          <tr><td>五段测试</td> <td><input type="text" name="addfive" size="32"></td></tr>
          <tr><td>&nbsp;</td> <td><input type="submit" class="an" value="增加数据"></td></tr>
        <input type="hidden" name="add" value="add">
        <input type="hidden" name="addtime" value="<%=now()%>">
      </form>
      <%
        end if
        Rs_Spc.Close()
        Set Rs_Spc = Nothing
        Cnn_Spc.close()
        set Cnn_Spc=nothing
      end if
    %>
  </table>
  <%else%>
     <br>
     <span class="stat">您无权限修改本内容。</span>
  <%end if%>
<%else%>
    <br>
    <span class="stat">请登录后再尝试进入本页。</span>
<%end if%>

</div>
<!--#include virtual="/bottom.html"-->
</body>
</html>

