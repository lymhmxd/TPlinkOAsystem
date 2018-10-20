<!DOCTYPE html>
<html>
<head>
	<!--#include virtual="/nav.asp"-->
	<!--#include virtual="/Connections/Ebase.asp"-->
	<title>工具管理</title>
	<link href="/css/equip_tool.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="/js/equip_tool.js"></script>
    <%
        set cnn=createobject("adodb.connection")
	    set rs=createobject("adodb.recordset")
	    cnn.open Ebase_String
    %>
</head>
<body>
<!--操作界面开始-->
<div id="lay1"></div>
<div id="dataform" align="center">
	<h2><span onclick="cls1()">关闭 [X]</span></h2><br/>
	<form method="get" name="layform" onsubmit="return checked()">
		<table class="tb">
			<tr>
				<td>物料编码：</td><td><input type="text" maxlength="30" class="cl1" id="code" name="code"></td>
				<td>PN号码：</td><td><input style="width:100%;" type="text" maxlength="30" class="cl1" id="pn" name="pn"></td>
			</tr>
			<tr><td style="vertical-align:top;">物料描述：</td><td colspan="3" style="word-break:normal;"><textarea placeholder="123" style="width:100%;height:100px;" rows="6" class="cl1" id="des" name="des"></textarea></td></tr>
			<tr>
				<td>设备从属：</td><td><input type="text" maxlength="30" class="cl1" id="dev" name="dev"></td>
				<td>仓位：</td><td><input type="text" style="width:100%" maxlength="30" class="cl1" id="pos" name="pos"></td>
			</tr>
			<tr>
				<td id="contitle"></td><td><input type="text" maxlength="30" class="cl1" id="con" name="con"></td>
				<td id="limittitle"></td>
                <td id="limit1"><input style="width:100%;" type="text" maxlength="30" class="cl1" id="limit" name="limit"></td>
				<td id="remove1"><input style="width:100%;" type="text" maxlength="30" class="cl1" id="remove" name="remove"></td>
			</tr>
            <tr id="reas1">
                <td style="vertical-align:top;" id="reastitle"></td>
                <td colspan="3" style="word-break:normal;"><textarea placeholder="若为工具入库，则不填写该项目。" style="width:100%;height:50px;" class="cl1" id="reas" name="reas"></textarea></td>
            </tr>
		</table>
		<br>
		<hr>
        <input type="hidden" id="timeadd" name="timeadd" value="<%=date()%>" />
        <input type="hidden" id="check" name="check">
        <input type="hidden" id="id" name="id" />
        <input type="hidden" id="code1" name="code1" />
		<input type="submit" class="cl2" value="执行">
		<input type="reset" class="cl2" value="重置" id="reset">		
        <input type="button" class="cl2" value="修改全部" id="resetall" <%if at(17)=0 then%>disabled<%end if%>onclick="javascript:changeall()">
	</form>
	</div>
	<div id="queryform" align="center">
	<h2><span onclick="cls1()">关闭 [X]</span></h2><br/>
	<form method="get" name="layqueryform"  onsubmit="return checked()">
		<table class="tb">
			<tr>
				<td>查询类型：</td>
				<td colspan="3">
					&nbsp;<input type="radio" value="库存" name="leixing" checked="checked" onclick="kucun()">&nbsp;按库存
					&nbsp;&nbsp;<input type="radio" value="存取" name="leixing" onclick="cunqu()">按存取
				</td>
			</tr>
			<tr><td>物料编码：</td><td><input type="text" class="cl1" id="querycode" name="querycode"></td><td>PN号码：</td><td><input style="width:100%" type="text" class="cl1" id="querypn" name="querypn"></td></tr>
			<tr>	
				<td>设备：</td><td><input type="text" class="cl1" id="querydev" name="querydev"></td>
				<td>仓位：</td><td colspan="3"><input style="width:100%" type="text" class="cl1" id="querypos" name="querypos"></td>
			</tr>
			<tr>
				<td>物料描述：</td><td colspan="3"><input style="width:100%;" type="text" class="cl1" id="querydes" name="querydes"></td>
			</tr>
			<tr>
				<td>起始日期：</td><td><input type="text" class="cl1" disabled="disabled"" id="querytimein" name="querytimein" value="<%=date()-1%>"></td>
				<td>终止日期：</td><td><input style="width:100%" type="text" disabled="disabled" class="cl1" id="querytimeou" name="querytimeou" value="<%=date()%>"></td>
			</tr>
			<tr>
				<td>处理人：</td><td><input type="text" disabled="disabled" class="cl1" id="queryby" name="queryby"></td>
				<td>处理方式：</td>
				<td >
					<select style="width:100%;" disabled="disabled" class="cl1" id="querytype" name="querytype">
						<option value="不限制">不限制</option>
						<option value="出库">出库</option>
						<option value="入库">入库</option>
						<option value="维护">维护</option>
					</select>
				</td>
			</tr>
		</table>
		<br>
		<hr>
		<input type="submit" class="cl2" value="执行">
		<input type="reset" class="cl2" value="重置">
	</form>
	</div>
	<%
        if request("check")<>"" then
	        if request("check")="new" then
                newcheck=cnn.execute("select id from lists where code='" & request("code") & "'")(0)
                if newcheck<>"" then
                    response.Write "<script type='text/javascript'>alert('该料号已经存在！请重新确认。');</script>"
                else
                    sql="select * from lists"
                    rs.Open sql,cnn,3,3
                    rs.AddNew
                        rs("code")=request("code")
                        rs("p/n")=request("pn")
                        rs("description")=request("des")    
                        rs("device")=request("dev") 
                        rs("position")=request("pos")
                        rs("count")=request("con")
                        rs("limit")=request("limit")
                        rs("timeadd")=request("timeadd")
                    rs.update
                    rs.Close
                end if
	        elseif request("check")="change" then
                set rsget=createobject("adodb.recordset")
                sqlget="select * from gets"
				sql="select * from lists where id=" & request("id")        
                rsget.Open sqlget,cnn,3,3
				rs.open sql,cnn,3,3
                response.write rs("count")+request("con") < request("remove")
                if 0 then
                    response.write "<script type='text/javascript'>alert('库存量不足，更新失败！');</script>"
                else
                    rs("count")=rs("count")+request("con")-request("remove")
                    rs.update
                    if request("con")>0 then
                        rsget.AddNew
                            rsget("code")=request("code1")
                            rsget("time")=request("timeadd")
                            rsget("by")=session("name")
                            rsget("type")="入库"
                            rsget("number")=request("con")
                        rsget.update
                    end if
                    if request("remove")>0 then
                        rsget.AddNew
                            rsget("code")=request("code1")
                            rsget("time")=request("timeadd")
                            rsget("by")=session("name")
                            rsget("type")="出库"
                            rsget("number")=request("remove")
                            rsget("reason")=request("reas")
                        rsget.update
                    end if
                end if
                rs.Close
                rsget.close:set rsget=nothing
            elseif request("check")="reset" then
            	set rsget=createobject("adodb.recordset")
				sqlget="select * from gets"
				sql="select * from lists where id=" & request("id")
		        rsget.Open sqlget,cnn,3,3
				rs.open sql,cnn,3,3
				rs("count")=request("con")
				rs("p/n")=request("pn")
				rs("description")=request("des")    
				rs("device")=request("dev") 
				rs("position")=request("pos")
				rs("limit")=request("limit")
				rs("timeadd")=request("timeadd")
				rs.update
				rsget.AddNew
					rsget("code")=request("code1")
					rsget("time")=request("timeadd")
					rsget("by")=session("name")
					rsget("type")="维护"
					rsget("number")=request("con")
					rsget("reason")=request("reas")
				rsget.update
				rs.Close
				rsget.close:set rsget=nothing
            end if
            response.write "<script>location.href=window.location.pathname;</script>"
        end if
	%>
</div>
<!--操作界面结束-->
<div id="way">
    <a href="/index.asp">首页</a>>><a href="/equip/equip.asp">工装管理</a>>>工具管理
</div>
<div id="content" style="height:1200px;">
<hr>
<%if at(14) then%>
	<%
	if request("search1")<>"" then
		if request("searchcode")<>"" then wstring=" where code='" & request("searchcode") & "'"
		if request("searchdev")<>"" then wstring=" where device='" & request("searchdev") & "'"
		if request("searchdev")<>"" and request("searchcode")<>"" then wstring=" where code='" & request("searchcode") & "' and device='" & request("searchdev") & "'"
		sql="select * from lists" & wstring
	elseif request("search2")<>"" then
		if request("searchcode")<>"" then wstring=" where code='" & request("searchcode") & "'"
		if request("searchdev")<>"" then wstring=" where device='" & request("searchdev") & "'"
		if request("searchdev")<>"" and request("searchcode")<>"" then wstring=" where code='" & request("searchcode") & "' and device='" & request("searchdev") & "'"
		sql="select * from [gets_log]" & wstring & " order by time desc"
	elseif request("leixing")="存取" then
		wstring=" 1=1"
		if request("querycode")<>"" then wstring=wstring & " and code='" & request("querycode") & "'"
		if request("querypn")<>"" then wstring=wstring & " and [p/n]='" & request("querypn") & "'"
		if request("querydev")<>"" then wstring=wstring & "  and device='" & request("querydev") & "'"
		if request("querypos")<>"" then wstring=wstring & " and [position]='" & request("querypos") & "'"
		if request("querydes")<>"" then wstring=wstring & " and description like '%" & request("querydes") & "%'"
		if request("querytimein")<>"" and request("querytimeou")<>"" then wstring=wstring & " and time between  #" & request("querytimein") & "# and #" & request("querytimeou") & "#"
		if request("querytimein")<>"" and request("querytimein")="" then wstring=wstring & " and time>=#" & request("querytimein") & "#"
		if request("querytimein")="" and request("querytimeou")<>"" then wstring=wstring & " and time<=#" & request("querytimeou") & "#"
		if request("queryby")<>"" then wstring=wstring & " and by='" & request("queryby") & "'"
		if request("querytype")<>"不限制" then wstring=wstring & " and type='" & request("querytype") & "'"
		sql="select * from [gets_log] where" & wstring
	elseif request("leixing")="库存" then
		wstring=" 1=1"
		if request("querycode")<>"" then wstring=wstring & " and code='" & request("querycode") & "'"
		if request("querypn")<>"" then wstring=wstring & " and [p/n]='" & request("querypn") & "'"
		if request("querydev")<>"" then wstring=wstring & "  and device='" & request("querydev") & "'"
		if request("querypos")<>"" then wstring=wstring & " and [position]='" & request("querypos") & "'"
		if request("querydes")<>"" then wstring=wstring & " and description like '%" & request("querydes") & "%'"
		sql="select * from lists where" & wstring
	else
		if request("searchcode")<>"" then wstring=" where code='" & request("searchcode") & "'"
		if request("searchdev")<>"" then wstring=" where device='" & request("searchdev") & "'"
		if request("searchdev")<>"" and request("searchcode")<>"" then wstring=" where code='" & request("searchcode") & "' and device='" & request("searchdev") & "'"
		sql="select * from lists" & wstring
    end if
	rs.open sql,cnn,1,1
    if not (rs.EOF and rs.BOF) then
        Rs.pagesize=40
        if request("page")<>"" then
            epage=Cint(request("page"))
            if epage<1 then epage=1
            if epage>Rs.pagecount then epage=Rs.pagecount
        else
            epage=1 
        end if
        Rs.absolutepage=epage
    end if
	%>
	
    <form method="get">
	    <table style="margin:10px;text-wrap : none;">
			<tr style="width:100%">
				<td>物料编码：</td>
				<td><input type="text" name="searchcode" value="<%=request("searchcode")%>" style="border:1px solid #d22222;height: 30px;width: 100%;"></td>
				<td>&nbsp;</td>
				<td>设备：</td>
				<td><input type="text" name="searchdev" value="<%=request("searchdev")%>" style="border:1px solid #d22222;height: 30px;width: 100%;"></td>
				<td>&nbsp;</td>
				<td><input type="submit" name="search1" class="an" value="库存情况" style="width:100px;"></td>
				<td>&nbsp;</td>
				<td><input type="submit" name="search2" value="存取记录" class="an" style="width:100px;"></td>
				<td>&nbsp;</td>
                <td><input type="button" value="高级查询" class="an" style="width:100px;" onclick="advancedquery()"></td>
				<td>&nbsp;</td>
				<%if at(18) then%>
				<%urlsql=replace(replace(sql,"#","ttt"),"'","dyh")%>
				<td><input type="button" value="导出" class="an" style="width:40px;" onclick="window.open('/equip/tool_list.asp?sql=<%=urlsql%>')"></td>
                <%end if %>
				<%if at(15) then %>
				<td width="20px;">&nbsp;</td>
				<td><input type="button" class="an" value="新增工具信息" style="width:100px;" onclick="javascript:add()"></td>
                <td>&nbsp;</td>
                <td><input type="button" class="an" value="批量操作" style="width:80px;" onclick="window.open('/equip/tool_uplaod0.asp','','width=800,height=300')"></td>
                <%end if %>
			</tr>
        </table>
	</form>
	<table id="datascan" align="center">
    <%if request("search2")<>"" or request("leixing")="存取" then%>
        <tr>
			<th style="width:40px">序列</th>
			<th style="width:100px">日期</th>
            <th style="width:60px">物料编码</th>
			<th style="width:120px">处理人</th>
            <th style="width:60px">处理方式</th>
			<th style="width:60px">数量</th>
            <th style="width:300px">原因</th>
            <th>物料描述</th>
		</tr>
        <%if not rs.eof then
			for i=1 to rs.pagesize
                if rs.eof then exit for
        %>
        <tr align="center">
			<td><%=i%></td>
			<td><%=rs("time")%></td>
			<td><%=rs("code")%></td>
			<td><%=rs("by")%></td>
            <td><%=rs("type")%></td>
			<td><%=rs("number")%></td>
            <td title="<%=rs("reason")%>" style="text-align:left"><%=rs("reason")%></td>
            <td title="<%=rs("description")%>" style="text-align:left"><%=rs("description")%></td>
		</tr>
        <%
			rs.movenext()
			next
		else%>
        <tr>
			<td>无</td>
			<td>无</td>
			<td>无</td>
			<td>无</td>
			<td>无</td>
			<td>无</td>
			<td>无</td>
            <td>无</td>
		</tr>
		<%end if%>
    <%else%>
		<tr>
			<th style="width:40px">序列</th>
			<th style="width:60px">物料编码</th>
			<th>物料描述</th>
			<th style="width:100px">PN号码</th>
			<th style="width:100px">设备从属</th>
			<th style="width:60px">仓位</th>
			<th style="width:60px">现有量</th>
			<th style="width:60px">安全库存</th>
            <%if at(16) then %>
			<th style="width:60px">结余维护</th>
            <%end if %>
		</tr>
		<%if not rs.EOF then
		    for i=1 to rs.pagesize
                if rs.eof then exit for
			        if rs("limit")>rs("count") then
		%>
		<tr style="background-color:#f0f0f0;text-align:center;font-weight:bold;">
			        <%else%>
		<tr align="center">
			        <%end if%>
			<td><%=i%></td>
			<td><%=rs("code")%></td>
			<td title="<%=rs("description")%>" style="text-align:left"><%=rs("description")%></td>
			<td><%=rs("p/n")%></td>
			<td><%=rs("device")%></td>
			<td><%=rs("position")%></td>
			<td><%=rs("count")%></td>
			<td><%=rs("limit")%></td>
            <%if at(16) then %>
			<td><input type="button" class="an" style="height:24px;" value="存取" onclick="javascript: Change('<%=rs("code")%>', '<%=rs("p/n")%>', '<%=rs("description")%>', '<%=rs("device")%>', '<%=rs("position")%>', '<%=rs("count")%>', '<%=rs("limit")%>', '<%=rs("id")%>')"></td>
		    <%end if %>
        </tr>
		<%
			rs.movenext()
            next
		else
		%>
		<tr>
			<td>无</td>
			<td>无</td>
			<td>无</td>
			<td>无</td>
			<td>无</td>
			<td>无</td>
			<td>无</td>
			<td>无</td>
			<%if session("name")<>"" then %>
			<td>无</td>
			<%end if %>
		</tr>
		<%end if%>
    <%end if%>
	</table>
    <p align="center">
    <%
    if request("search2")<>"" then
        urlgo="/equip/tool.asp?search2='" & request("search2")
    else
        urlgo="/equip/tool.asp?search1='" & request("search1")
    end if
    if epage>1 and epage<Rs.pagecount then %>
      <a href="<% =urlgo & "&page=1" %>">首页</a>&nbsp;&nbsp;
      <a href="<% =urlgo & "&page=" & epage-1 %>" >上一页</a>&nbsp;&nbsp;
      <a href="<% =urlgo & "&page=" & epage+1%>">下一页</a>&nbsp;&nbsp;
      <a href="<% =urlgo & "&page=" & Rs.pagecount%>">末页</a>&nbsp;&nbsp;&nbsp;&nbsp;
    <% elseif epage=1 and epage<Rs.pagecount then %>
      <a href="<% =urlgo & "&page=" & epage+1 %>" >下一页</a>&nbsp;&nbsp;
      <a href="<% =urlgo & "&page=" & Rs.pagecount%>">末页</a>&nbsp;&nbsp;&nbsp;&nbsp;
    <% elseif epage>1 and epage=Rs.pagecount then %>
      <a href="<% =urlgo & "&page=1"%>">首页</a>&nbsp;&nbsp;
      <a href="<% =urlgo & "&page=" & epage-1%>">上一页</a>&nbsp;&nbsp;
    <% end if %>
      <span align="center">第-<% =epage %>-页，共-<%=Rs.pagecount%>-页</span>
    </p>
    <p>&nbsp;</p>
    <%
        rs.close:set rs=nothing
        cnn.close:set cnn=nothing
    %>
<%else%>
<br>
<span class="stat">您无权限进入权限管理页面。</span>
<%end if%>
</div>
<!--#include virtual="/bottom.html"-->
</body>
</html>