<!DOCTYPE html>
<!--#include virtual="/Connections/Database.asp" -->
<%
  set Cnn_Spc = Server.CreateObject ("ADODB.Connection")
  set Rs_Spc = server.CreateObject("ADODB.RecordSet")
  Cnn_Spc.Open Database_String
  SQL = "select * FROM PA_CL order by �߱�"
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
	<title>SPC��Ϣ����</title>
</head>
<body>
<div id="way">
    <a href="/quality/spc.asp">SPC����</a>>> ��Դ������/����ʽ��Դ��
</div>
<div id="content">
<hr>
<table id="datascan" align="center">
  <caption>
    ��Դ���첿��Դ������/��Դ���Ű�SPC������һ����<span style="font-size:15px;">(��λPPM��</span>
  </caption>
  <tr>
    <th>�߱�</th>
    <th>�Ϻ�</th>
    <th>ICT����</th>
    <th>�ϵ����</th>
    <th>�ϻ�����</th>
    <th>��ѹ����</th>
    <th>�ۺϲ���</th>
    <th>������ʱ��</th>
  </tr>
  <% 
    for i=1 to Rs_Spc.pagesize
      if Rs_Spc.bof or Rs_Spc.eof then exit for
  %>
  <tr>
    <td align="center"><%=(Rs_Spc("�߱�"))%></td>
    <td align="center"><%=(Rs_Spc("�Ϻ�"))%></td>
    <td align="center"><%=formatnumber(Rs_Spc("ICT����"),5,-1,0,0)*1000000 %></td>
    <td align="center"><%=formatnumber(Rs_Spc("�ϵ����"),5,0,0,0)*1000000 %></td>
    <td align="center"><%=formatnumber(Rs_Spc("�ϻ�����"),5,-1,0,0)*1000000 %></td>
    <td align="center"><%=formatnumber(Rs_Spc("��ѹ����"),5,-1,0,0)*1000000 %></td>
    <td align="center"><%=formatnumber(Rs_Spc("�ۺϲ���"),5,-1,0,0)*1000000 %></td>
    <td><%=(Rs_Spc("������ʱ��"))%></td>
  </tr>
  <% Rs_Spc.MoveNext() 
     next
  %>
</table>
<p align="center">
<% if epage>1 and epage<Rs_Spc.pagecount then %>
  <a href="/quality/dysf_data.asp?page=1">��ҳ</a>&nbsp;&nbsp;
  <a href="/quality/dysf_data.asp?page=<%=epage-1%>">��һҳ</a>&nbsp;&nbsp;
  <a href="/quality/dysf_data.asp?page=<%=epage+1%>">��һҳ</a>&nbsp;&nbsp;
  <a href="/quality/dysf_data.asp?page=<%=Rs_Spc.pagecount%>">ĩҳ</a>&nbsp;&nbsp;&nbsp;&nbsp;
<% elseif epage=1 and epage<Rs_Spc.pagecount then %>
  <a href="/quality/dysf_data.asp?page=<%=epage+1%>">��һҳ</a>&nbsp;&nbsp;
  <a href="/quality/dysf_data.asp?page=<%=Rs_Spc.pagecount%>">ĩҳ</a>&nbsp;&nbsp;&nbsp;&nbsp;
<% elseif epage>1 and epage=Rs_Spc.pagecount then %>
  <a href="/quality/dysf_data.asp?page=1">��ҳ</a>&nbsp;&nbsp;
  <a href="/quality/dysf_data.asp?page=<%=epage-1%>">��һҳ</a>&nbsp;&nbsp;
<% end if %>
  <span align="center">��-<% =epage %>-ҳ����-<%=Rs_Spc.pagecount%>-ҳ</span>
</p>
<p>&nbsp;</p>
<% Rs_Spc.Close() %>
<% Set Rs_Spc = Nothing %>
</div>
</body>
<!--#include virtual="/bottom.html"-->
</html>

