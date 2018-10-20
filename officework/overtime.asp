<!DOCTYPE html>
<html>
<head>
	<!--#include virtual="/nav.asp"-->
	<!--#include virtual="/Connections/Onlinework.asp"-->
	<SCRIPT lang="JavaScript" src="/js/jsdate.js"></SCRIPT>
	<%
		if session("account")<>"" then
			sqlstr="month(日期)=" & month(date()) & " and year(日期)=" & year(date())
			set cnn_ot=server.createobject("adodb.connection")
            set cnn=server.createobject("adodb.connection")
			cnn_ot.open Onlinework_String
            cnn.open Basic_String
			if at(1)=1 then
				if request.querystring("nm")<>"" then
					nm_sl=request.querystring("nm")
				else
					nm_sl=session("account")
				end if
				sql_ot="select * from overtime where " & sqlstr & " and account='" & nm_sl & "' order by account desc,日期 asc"
			else
				sql_ot="select * from overtime where " & sqlstr & " and account='" & session("account") & "'" & " order by account desc,日期 asc"
			end if
			set rs_ot=server.createobject("adodb.recordset")
			rs_ot.open sql_ot,cnn_ot,3,3
			sql_total_ot="select sum([实际时长]) as total_ot from overtime where " & sqlstr & " and account='" & session("account") & "'"
			sql_wk_ot="select sum([实际时长]) from overtime where " & sqlstr & " and datepart('ww',[日期],2)=" & datepart("ww",date(),2) & " and account='" & session("account") & "'"
            sql_wk1_ot="select sum([实际时长]) from overtime where " & sqlstr & " and datepart('ww',[日期],2) =" & datepart("ww",date(),2)-1 & " and account='" & session("account") & "'"
		end if
	%>
	<%
		if request.querystring("add")="add" then
			set rs_time_ot=server.createobject("adodb.recordset")
			sql_time_ot="select * from overtime where account='" & session("account") & "' and 日期=#" & request.querystring("date") & "#"
			rs_time_ot.open sql_time_ot,cnn_ot,1,1
			if rs_time_ot.bof and rs_time_ot.eof then
				if not (timevalue(request.querystring("pre-end-time"))>timevalue(request.querystring("pre-start-time")) and timevalue(request.querystring("act-end-time"))>timevalue(request.querystring("act-start-time"))) then
					response.write "<script>alert('开始时间不得晚于结束时间！');history.go(-1);</script>"
				else
					if (timevalue(request.querystring("pre-end-time")) =< timevalue("12:00")) or (timevalue(request.querystring("pre-start-time")) >= timevalue("13:20")) then
						a=(timevalue(request.querystring("pre-end-time"))-timevalue(request.querystring("pre-start-time")))*24
					else
						a=(timevalue(request.querystring("pre-end-time"))-timevalue(request.querystring("pre-start-time"))-timevalue("13:20")+timevalue("12:00"))*24
					end if
					if (timevalue(request.querystring("act-end-time")) =< timevalue("12:00")) or (timevalue(request.querystring("act-start-time")) >= timevalue("13:20")) then
						b=(timevalue(request.querystring("act-end-time"))-timevalue(request.querystring("act-start-time")))*24  
					else
						b=(timevalue(request.querystring("act-end-time"))-timevalue(request.querystring("act-start-time"))-timevalue("13:20")+timevalue("12:00"))*24
					end if
					rs_ot.addnew
						if request.querystring("account")="" then
							zh=session("account")
						else
							zh=request.querystring("account")
						end if
						rs_ot("account")=zh
						rs_ot("勤工内容")=request.querystring("con")
						rs_ot("日期")=request.querystring("date")
						rs_ot("预计起止时间")=request.querystring("pre-start-time") & "-" & request.querystring("pre-end-time")
						rs_ot("预计时长")=a
						rs_ot("实际起止时间")=request.querystring("act-start-time") & "-" & request.querystring("act-end-time")
						rs_ot("实际时长")=b
						rs_ot("说明")=request.querystring("alert")
					rs_ot.update
					response.redirect(Request.ServerVariables("SCRIPT_NAME"))
				end if
			else
				response.write "<script>alert('请勿重复提交加班钟！');history.go(-1);</script>"
			end if
			rs_time_ot.Close
			set rs_time_ot=nothing
		end if
	%>
	<%
	rs_irow= 0
	i=-1
	j=0
	rs_irow= rs_irow + i
	%>
	<%
		if request.querystring("id")<>"" then
			sql_del="delete * from overtime where id=" & request.querystring("id")
			cnn_ot.execute(sql_del)
			response.redirect(Request.ServerVariables("SCRIPT_NAME"))
		end if
	%>
	<title>加班管理</title>
</head>
<body>

<div id="way">
	<a href="/index.asp">首页</a>>>周末勤工加班提报
</div>
<div id="content" style="height:1200px;">
<hr>
<% if session("name")<>"" then %>
	<form method="get" onsubmit="javascript:return confirm('你确认提交吗？提交之后不可更改！');">
		<table id="silter" style="width:100%;">
			<caption  style="FONT-SIZE:18px;text-align:left">周末勤工提报</caption>
			<tr>
				<% if at(1)=1 then%>
				<th width="200px">邮箱</th>
				<%end if%>
				<th width="200px">勤工内容</th>
				<th width="150px">日期</th>
				<th width="100px">预计起时间</th>
				<th width="100px">预计止时间</th>
				<th width="100px">实际起时间</th>
				<th width="100px">实际止时间</th>
				<th>说明</th>
			</tr>
			<tr>
				<% if at(1)=1 then%>
				<td><input type="text" style="text-align:center" name="account" value="<%=session("account")%>"></td>
				<%end if%>
				<td><input style="text-align:center" type="text" name="con"  value="常规加班" maxlength="14"></td>
				<td><input style="text-align:center" type="text" value="<%=Date()%>" name="date" onClick="SelectDate(this,'yyyy/MM/dd')"></td>
				<td>
					<select name="pre-start-time">
						<option value="08:00">08:00</option>
						<option value="08:30">08:30</option>
						<option value="09:00">09:00</option>
						<option value="09:30">09:30</option>
						<option value="10:00">10:00</option>
						<option value="10:30">10:30</option>
						<option value="11:00">11:00</option>
						<option value="11:30">11:30</option>
						<option value="12:00">12:00</option>
						<option value="13:20">13:20</option>
						<option value="13:50">13:50</option>
						<option value="14:20">14:20</option>
						<option value="14:50">14:50</option>
						<option value="15:20">15:20</option>
						<option value="15:50">15:50</option>
						<option value="16:20">16:20</option>
						<option value="16:50">16:50</option>
						<option value="17:20">17:20</option>
					</select>
				</td>
				<td>
					<select name="pre-end-time">
						<option value="08:00">08:00</option>
						<option value="08:30">08:30</option>
						<option value="09:00">09:00</option>
						<option value="09:30">09:30</option>
						<option value="10:00">10:00</option>
						<option value="10:30">10:30</option>
						<option value="11:00">11:00</option>
						<option value="11:30">11:30</option>
						<option value="12:00">12:00</option>
						<option value="13:20">13:20</option>
						<option value="13:50">13:50</option>
						<option value="14:20">14:20</option>
						<option value="14:50">14:50</option>
						<option value="15:20">15:20</option>
						<option value="15:50">15:50</option>
						<option value="16:20">16:20</option>
						<option value="16:50">16:50</option>
						<option value="17:20" selected="selected">17:20</option>
					</select>
				</td>
				<td>
					<select name="act-start-time">
						<option value="08:00">08:00</option>
						<option value="08:30">08:30</option>
						<option value="09:00">09:00</option>
						<option value="09:30">09:30</option>
						<option value="10:00">10:00</option>
						<option value="10:30">10:30</option>
						<option value="11:00">11:00</option>
						<option value="11:30">11:30</option>
						<option value="12:00">12:00</option>
						<option value="13:20">13:20</option>
						<option value="13:50">13:50</option>
						<option value="14:20">14:20</option>
						<option value="14:50">14:50</option>
						<option value="15:20">15:20</option>
						<option value="15:50">15:50</option>
						<option value="16:20">16:20</option>
						<option value="16:50">16:50</option>
						<option value="17:20">17:20</option>
					</select>
				</td>
				<td>
					<select name="act-end-time">
						<option value="08:00">08:00</option>
						<option value="08:30">08:30</option>
						<option value="09:00">09:00</option>
						<option value="09:30">09:30</option>
						<option value="10:00">10:00</option>
						<option value="10:30">10:30</option>
						<option value="11:00">11:00</option>
						<option value="11:30">11:30</option>
						<option value="12:00">12:00</option>
						<option value="13:20">13:20</option>
						<option value="13:50">13:50</option>
						<option value="14:20">14:20</option>
						<option value="14:50">14:50</option>
						<option value="15:20">15:20</option>
						<option value="15:50">15:50</option>
						<option value="16:20">16:20</option>
						<option value="16:50">16:50</option>
						<option value="17:20" selected="selected">17:20</option>
					</select>
				</td>
				<td><input type="text" name="alert" maxlength="14" value="无"></td>
			</tr>
		</table>
	  <span style="text-align:center;display:block;">
		  <input type="submit" class="an" style="width:120px;" value="提交">&nbsp;&nbsp;&nbsp;&nbsp;
		  <input type="reset" class="an" style="width:120px;" value="重置">
	  </span>
	  <input type="hidden" name="add" value="add">
	</form>
	<br>
	<hr style="border:1px solid yellow">
	<br>
	<span class="stat">填写说明：</span>
	<div class="stat">
	<ol>
		<li>请按照标准要求填写该报单。</li>
		<li>请于每周一下午17：20前完成上周勤工的提报工作，并确认加班时间是否正确。</li>
		<li>最好与当日填报完毕自己的勤工事宜，以免遗忘。</li>
		<li>提报完成后，系统将无法修改。若确有需改必要，请联系>><a href="mailto:tankailang@tp-link.net?subject=【加班修正】删除错误数据" title="点此发邮件知会。">谭开朗</a><<删除错误数据，并重新填报。</li>
	</ol>
	</div>
	<hr style="border:1px solid yellow">
		<table id="datascan">
			<caption style="FONT-SIZE:16px;text-align:left;">
				<%if at(1)=1 then%>
					<form style="display:block;float:left;" method="get">
						<select style="width:80px;height:30px;" name="nm">
							<%
							if request.querystring("nm")<>"" then
							sql_sl="select name from logmsg where account='" & nm_sl & "'"
							%>
							<option value="<%=nm_sl%>"><%=cnn.execute(sql_sl)(0)%></option>
							<%else%>
							<option value="<%session("account")%>"><%=session("name")%> </option>
							<%end if%>
							<%
							Set cnn_sl=Server.CreateObject("ADODB.Connection")
							cnn_sl.open Basic_String
							sql_sl="select name,account from logmsg where account<>'" & nm_sl & "'"
							set rs_sl=server.CreateObject("ADODB.RecordSet")
							rs_sl.open sql_sl,cnn_sl,1,1
							%>
							<%while not rs_sl.eof%>
							<option value="<%=rs_sl("account") %>"><% =rs_sl("name") %></option>
							<%
							rs_sl.MoveNext()
							wend
							rs_sl.close
							set rs_sl=nothing
							cnn_sl.close
							set cnn_sl=nothing
							%>
						</select>
						<input type="submit" class="an" value="查询">
					</form>
                <%end if%>
                &nbsp;&nbsp;您本月合计加班时间为：<span class="stress"><%=cnn_ot.execute(sql_total_ot)(0)%>H</span>；
				本周加班时间：<span class="stress"><% =cnn_ot.execute(sql_wk_ot)(0)%>H</span>；
				上周加班时间：<span class="stress"><% =cnn_ot.execute(sql_wk1_ot)(0)%>H</span>。
				<% if at(1)=1 then %>
				请点击<a href="/officework/overtime_list.asp" class="stress">此处</a>下载上周（&nbsp;<%=datepart("ww",date(),2)-1%>&nbsp;周）本部门勤工清单。
				<% end if %>
			</caption>
			<tr>
				<th>姓名</th> 
				<th>工号</th>
				<th>岗位</th>
				<th>勤工内容</th>
				<th>日期</th>
				<th>预计起止时间</th>
				<th>预计时长</th>
				<th>实际起止时间</th>
				<th>实际时长</th>
				<th>说明</th>
				<% if at(1)=1 then %>
				<th>撤销</th>
				<%end if%>
			</tr>
			<% while not rs_ot.eof %>
			<tr align="center"> 
				<td><%=cnn.execute("select name from logmsg where account='" & nm_sl & "'")(0)%></td>
				<td><%=cnn.execute("select account_id from logmsg where account='" & nm_sl & "'")(0)%></td>
                <%
                m=cnn.execute("select class_id from logmsg where account='" & nm_sl & "'")(0)
                n=cnn.execute("select dept_id from logmsg where account='" & nm_sl & "'")(0)
                o=cnn.execute("select class from class where class_id=" & m & " and dept_id=" & n)(0)
                %>
				<td><%=o%></td>
				<td><%=rs_ot("勤工内容")%></td>
				<td><%=rs_ot("日期")%></td>
				<td><%=rs_ot("预计起止时间")%></td>
				<td><%=rs_ot("预计时长") & "H"%></td>
				<td><%=rs_ot("实际起止时间")%></td>
				<td><%=rs_ot("实际时长") & "H"%></td>
				<td><%=rs_ot("说明")%></td>
				<% if at(1)=1 then %>
				<td><a href="<%=CStr(Request.ServerVariables("SCRIPT_NAME")) & "?id=" & rs_ot("id")%>" onclick="javascript:return confirm('你确定要取消吗？')" >X</a></td>
				<%end if%>
			</tr>
			<%
				j=j+1
				i=i-1
				rs_ot.MoveNext() 
				wend
			%>
		</table>
        <%
        rs_ot.close():set rs_ot=nothing
        cnn_ot.close():set cnn_ot=nothing
        cnn.close():set cnn=nothing
        %>
<%else%>
<br>
<span class="stat">请登录后查看。</span>
<% end if%>
</div>
<!--#include virtual="/bottom.html"-->
</body>
</html>