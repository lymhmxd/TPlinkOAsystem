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
	<title>SPC��Ϣ����</title>
</head>
<body>
<!--#include file="nav.html"-->
<div id="way">
    <a href="spc.asp">SPC����</a>
</div>
<hr style="border:1px solid red;width:1100px;">
<div id="content" style="height:1000px">
<table id="datascan">
  <caption>SPC���Ƽ�¼</caption>
  <tr>
    <th>��Ʒ��</th>
    <th>����</th>
    <th>ʱ��</th>
    <th>�߱�</th>
    <th>MO��</th>
    <th>�Ϻ�</th>
    <th>��¼��</th>
    <th>���Զ�</th>
    <th>����</br>����</th>
    <th>����</th>
    <th>������</th>
    <th>��ע</th>
    <th>������</th>
    <th>����</br>����</th>
    <th>��ʩ</br>�ṩ</th>
    <th>������</th>
    <th>����</br>Ч��</th>
    </tr>
  <% 
While ((Repeat1__numRows <> 0) AND (NOT spcngwork.EOF)) 
%>
  <tr align="center">
    <td><%=(spcngwork.Fields.Item("��Ʒ��").Value)%></td>
    <td><%=(spcngwork.Fields.Item("����").Value)%></td>
    <td><%=(spcngwork.Fields.Item("ʱ���").Value)%></td>
    <td><%=(spcngwork.Fields.Item("�߱�").Value)%></td>
    <td><%=(spcngwork.Fields.Item("MO").Value)%></td>
    <td><%=(spcngwork.Fields.Item("�Ϻ�").Value)%></td>
    <td><%=(spcngwork.Fields.Item("��¼��").Value)%></td>
    <td><%=(spcngwork.Fields.Item("���Զ�").Value)%></td>
    <td><%=(spcngwork.Fields.Item("��������").Value)%></td>
    <td><%=(spcngwork.Fields.Item("����").Value)%></td>
    <td><%=(spcngwork.Fields.Item("������").Value)%></td>
    <td><%=(spcngwork.Fields.Item("��ע").Value)%></td>
    <td><%=(spcngwork.Fields.Item("������").Value)%></td>
    <td><%=(spcngwork.Fields.Item("���ι���").Value)%></td>
    <td><%=(spcngwork.Fields.Item("��ʩ�ṩ").Value)%></td>
    <td><%=(spcngwork.Fields.Item("������").Value)%></td>
    <td><%=(spcngwork.Fields.Item("����Ч��").Value)%></td>
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
