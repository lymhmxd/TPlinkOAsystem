<meta charset="gb2312">
<link href="/css/log.css" rel="stylesheet" type="text/css" />
<link href="/css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/js/login.js"></script>
<link rel="shortcut icon" href="/image/favicon.ico" />
<%
    loginout=CStr(Request.ServerVariables("SCRIPT_NAME")) & "?out=1"
    if request("out")=1 then
        session.contents.remove("name")
        session.contents.remove("account")
        session.contents.remove("authority")
        session.contents.remove("id")
        response.redirect("/index.asp")
    end if
%>
<%
	if session("authority")<>"" then
		str_a=cstr(session("authority"))
		at=split(str_a,",")
    else
        at=split("0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0",",")
	end if
%>
<!--#include virtual="/Connections/Basic.asp"-->
<!--��½���� -->
<div id="lay"></div>
<div id="log" align="center">
	<h2><span id="close" onclick="cls()">��½[X]</span></h2><br/>
	<form method="post">
		<input type="text" maxlength="30" class="cl1" name="act" id="act" value="<% =request.form("act")%>" placeholder="�������������"><br/>
		<input type="password" maxlength="30" class="cl1" id="pwd" name="pwd" placeholder="����������"><br/>
		<input type="submit" class="cl2" value="��½" id="logbt"  onclick="return logchk()">
		<input type="submit" class="cl2" value="ע��" id="regbt" onclick="action='/region.asp'"><br/>
        <table width="80%">
            <tr>
                <td width="50%"><span style="color:#f00" id="logerr">�˻����������!</span></td>
                <td style="text-align:right"><a href="#" style="color:blue">�������룿</a></td>
            </tr>
        </table>
	</form>
</div>
<!--��½������� -->
<div id="nav">
<ul class="nav">
    <li style="width:80px;"><a href="/index.asp" style="background:brown;color:white;font-weight:bold">��ҳ</a></li>
    <%
    dim i
    set cnn=createobject("adodb.connection")
    cnn.open Basic_String
    set rs=createobject("adodb.recordset")
    set rs2=createobject("adodb.recordset")
    sql="select * from topmenu"
    rs.open sql,cnn,1,1
    for i=2 to rs.recordcount
        if at(6*i-10)=1 then
        sql1="select * from topmenu where id=" & i
    %>
    <li><a href="<%=cnn.execute(sql1)(2)%>"><%=cnn.execute(sql1)(1)%></a>
        <ul>
            <%
            sql2="select * from nextmenu where first=" & i
            rs2.open sql2,cnn,1,1
            if rs2.recordcount>0 then
            for j=1 to rs2.recordcount
                sql3="select * from nextmenu where first=" & i & " and twice=" & j
            %>
            <li><a href="<%=cnn.execute(sql3)(4)%>"><%=cnn.execute(sql3)(3)%></a></li>
            <%
            next
            end if
            rs2.close
            %>
        </ul>
    </li>
    <%
        end if
    next
    rs.close:set rs=nothing
    set rs2=nothing
    %>
    <li style="float:right" id="denglu">
        <%
            if session("name")="" then
                if request.form("act")<>"" and request.form("pwd")<>"" then
                    on error resume next
                    SQL ="select * FROM logmsg WHERE account ='" & cstr(request.form("act")) & "' AND password ='" & cstr(request.form("pwd")) & "'"
                    set rs=server.CreateObject("ADODB.RecordSet")
                    rs.open sql,cnn,1,1
                    If rs.EOF Or rs.BOF Then
                        response.write "<script>logdata();</script>"
         %>     
         <a href="javascript:log()">��½</a>
         <%
                    else
                        session.Timeout=30
                        response.write "<script>sessionStorage.account=document.getElementById('act').value;logdata();</script>"
                        session("name")=rs("name") <!--��ʾ����-->
                        session("account")=rs("account") <!--��֤��½״̬-->
                        session("id")=rs("id") <!--��¼ID-->
                        session("authority")=rs("authority") <!--��ȡȨ��-->
                        session("dept_id")=rs("dept_id") <!--��ȡ����-->
                        session("class_id")=rs("class_id") <!--��ȡ�α�-->
                        response.redirect(Request.ServerVariables("SCRIPT_NAME"))
         %>
         <a href="#">
         <%             response.write "Hi," & Session("name") %>
                <ul>
                    <li><a href="#">��������</a></li>
                    <li><a onclick="javascript:return confirm('�Ƿ�ȷ���˳��˻���')" href="<%=loginout%>"%>ע������</a></li>
                </ul>
                    <% end if
                        rs.close
                        set rs=nothing
                        cnn.close
                        set cnn=nothing
                    %>
                <% else %>
                <a href="javascript:log()">��½</a>
                <% end if %>
         <% else %>
         <a href="#">
                    <% response.write "Hi," & Session("name")%>
            <ul>
                <li><a href="#">��������</a></li>
                <li><a onclick="javascript:return confirm('�Ƿ�ȷ���˳��˻���')" href="<%=loginout%>">ע������</a></li>
            </ul>
         <% end if %>
    </li>
</ul>
</div>
<br>
<br>