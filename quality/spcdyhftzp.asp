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
	<title>SPC��Ϣ����</title>
</head>
<body>
<!--#include file="nav.html"-->
<div id="way">
    <a href="spc.asp">SPC����</a> >> <a href="spcdy.asp">��Դ���첿</a> >> ��ѹ����װ��
</div>
<div id="content" style="height:800px">
  <hr style="border:1px solid red;width:1100px;">
  <table id="datascan" align="center">
  <caption>
    ��Դ���첿��ѹ����װ���SPC������һ����<span style="background:white;font-size:15px;">(��λPPM��</span>
  </caption>
  <tr>
    <th height="23">�߱�</th>
    <th>�Ϻ�</th>
    <th>LX��</th>
    <th>LXС</th>
    <th>LK</th>
    <th>DCR</th>
    <th>TR</th>
    <th>PS</th>
    <th>���ܺϼ�</th>
    <th>������ʱ��</th>
    </tr>
  <% 
While ((spc__numRows <> 0) AND (NOT hftspczp.EOF)) 
%>
  <tr>
    <td align="center"><%=(hftspczp.Fields.Item("�߱�").Value)%></td>
    <td align="center"><%=(hftspczp.Fields.Item("�Ϻ�").Value)%></td>
    <td align="center"><%=formatnumber((hftspczp.Fields.Item("LX��").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftspczp.Fields.Item("LXС").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftspczp.Fields.Item("LK").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftspczp.Fields.Item("DCR").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftspczp.Fields.Item("TR").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftspczp.Fields.Item("PS").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftspczp.Fields.Item("���ܺϼ�").Value),5,-1,0,0)*1000000%></td>
    <td ><%=(hftspczp.Fields.Item("������ʱ��").Value)%></td>
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
