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
    ��Դ���첿��ѹ������װ��SPC������һ����<span style="background:white;font-size:15px;">(��λPPM��</span>
  </caption>
  <tr>
    <th>�߱�</th>
    <th>�Ϻ�</th>
    <th>�۲�</th>
    <th>4200V</th>
    <th>1500V</th>
    <th>��������</th>
    <th>�μ�����</th>
    <th>�㽺����</th>
    <th>��Ե���̻�</th>
    <th>¶��Ե��</th>
    <th>֧���</th>
    <th>����</th>
    <th>����</th>
    <th>������</th>
    <th>����</th>
    <th>�����ܼ�</th>
    <th>����ܼ�</th>
    <th>������ʱ��</th>
    </tr>
  <% 
While ((spc__numRows <> 0) AND (NOT hftzzspc.EOF)) 
%>
  <tr>
    <td align="center"><%=(hftzzspc.Fields.Item("�߱�").Value)%></td>
    <td align="center"><%=(hftzzspc.Fields.Item("�Ϻ�").Value)%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("�۲�").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("4200V").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("1500V").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("��������").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("�μ�����").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("�㽺����").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("��Ե���̻�").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("¶��Ե��").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("֧���").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("����").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("����").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("������").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("����").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("�����ܼ�").Value),5,-1,0,0)*1000000%></td>
    <td align="center"><%=formatnumber((hftzzspc.Fields.Item("����ܼ�").Value),5,-1,0,0)*1000000%></td>
    <td ><%=(hftzzspc.Fields.Item("������ʱ��").Value)%></td>
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
