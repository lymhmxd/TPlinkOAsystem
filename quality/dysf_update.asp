<!DOCTYPE html>
<html>
<!--#include virtual="/Connections/Database.asp" -->
<%
  if not request.querystring("xb")="" and not request.querystring("lh")="" then
    dim a,b
    Set Cnn_Spc = Server.CreateObject ("ADODB.Connection")
    set Rs_Spc = server.CreateObject("ADODB.RecordSet")
    Cnn_Spc.Open Database_String
    SQL = "select * FROM PA_CL where �߱�='" & request.querystring("xb") & "'" & " and �Ϻ�=" & request.querystring("lh")
    Rs_Spc.open SQL,Cnn_Spc,3,3
  end if
%>
<%
  If Request.form("update")="update" Then
    Rs_Spc("ICT����")=request.form("upone")
    Rs_Spc("�ϵ����")=request.form("uptwo")
    Rs_Spc("�ϻ�����")=request.form("upthree")
    Rs_Spc("��ѹ����")=request.form("upfour")
    Rs_Spc("�ۺϲ���")=request.form("upfive")
    Rs_Spc("������ʱ��")=request.form("uptime")
    Rs_Spc.update
    response.write "<script>alert('���³ɹ���')</script>"
  end if
%>
<%
  If Request.form("add")="add" Then
    Rs_Spc.addnew
    Rs_Spc("�߱�")=request.querystring("xb")
    Rs_Spc("�Ϻ�")=request.querystring("lh")
    Rs_Spc("ICT����")=request.form("addone")
    Rs_Spc("�ϵ����")=request.form("addtwo")
    Rs_Spc("�ϻ�����")=request.form("addthree")
    Rs_Spc("��ѹ����")=request.form("addfour")
    Rs_Spc("�ۺϲ���")=request.form("addfive")
    Rs_Spc("������ʱ��")=request.form("addtime")
    Rs_Spc.update
    response.write "<script>alert('��������Ŀ�ɹ���')</script>"
  end if
%>
<head>
  <!--#include virtual="/nav.asp"-->
  <title>SPC��Ϣ����</title>
</head>
<body>
<div id="way">
    <a href="/spc/spc.asp">SPC����</a> >> ��Դ������/����ʽ��Դ�����ݸ���
</div>
<div id="content" style="height:1200px;">
<hr>
<% if session("name")<>"" then %>
  <% if at(1)=1 then %>
  <table id="silter" style="width:400px;">
    <caption style="font-size:16px;"> ��Դ������/����ʽ��Դ�����ݸ���</caption>
    <form method="get" action="<%=Request.ServerVariables("SCRIPT_NAME") & "?" & Request.QueryString%>">
    <tr><td>�߱�</td> <td><input type="text" name="xb" value=<% =request.querystring("xb") %>></td></tr>
    <tr><td>�Ϻ�</td> <td><input type="text" name="lh" value=<% =request.querystring("lh") %>></td></tr>
    <tr><td>&nbsp;</td> <td><input	class="an" type="submit" value="ƥ������"></td></tr>
    </form>
    <%if request.querystring("xb")<>"" and request.querystring("xb")<>"" then %>
      <% if Not Rs_Spc.EOF or Not Rs_Spc.BOF then %>
      <form method="post">
          <tr><td>һ�β���</td> <td><input type="text" name="upone" size="32" value=<%=Rs_Spc("ICT����")%>></td></tr>
          <tr><td>���β���</td> <td><input type="text" name="uptwo" size="32" value=<%=Rs_Spc("�ϵ����")%>></td></tr>
          <tr><td>���β���</td> <td><input type="text" name="upthree" size="32" value=<%=Rs_Spc("�ϻ�����")%>></td></tr>
          <tr><td>�Ķβ���</td> <td><input type="text" name="upfour" size="32" value=<%=Rs_Spc("��ѹ����")%>></td></tr>
          <tr><td>��β���</td> <td><input type="text" name="upfive" size="32" value=<%=Rs_Spc("�ۺϲ���")%>></td></tr>
          <tr><td>&nbsp;</td> <td><input type="submit" class="an" value="��������"></td></tr>
        <input type="hidden" name="update" value="update">
        <input type="hidden" name="uptime" value="<%=now()%>">
      </form>
      <% elseif Rs_Spc.EOF and Rs_Spc.BOF then %>
      <form method="post">
          <tr><td>N�β���</td> <td><input type="text" name="addone" size="32"></td></tr>
          <tr><td>���β���</td> <td><input type="text" name="addtwo" size="32"></td></tr>
          <tr><td>���β���</td> <td><input type="text" name="addthree" size="32"></td></tr>
          <tr><td>�Ķβ���</td> <td><input type="text" name="addfour" size="32"></td></tr>
          <tr><td>��β���</td> <td><input type="text" name="addfive" size="32"></td></tr>
          <tr><td>&nbsp;</td> <td><input type="submit" class="an" value="��������"></td></tr>
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
     <span class="stat">����Ȩ���޸ı����ݡ�</span>
  <%end if%>
<%else%>
    <br>
    <span class="stat">���¼���ٳ��Խ��뱾ҳ��</span>
<%end if%>

</div>
<!--#include virtual="/bottom.html"-->
</body>
</html>

