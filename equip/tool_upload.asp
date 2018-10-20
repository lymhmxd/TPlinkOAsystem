<!DOCTYPE html>
<head>
<title>上传文件</title>
<!--#include virtual="/abilities/uploadfilm.asp"-->
<!--#include virtual="/connections/ebase.asp"-->
<link href="/css/main.css" rel="stylesheet" type="text/css" />
<style type="text/css">
    body{background-color:white}
    table{border:1px dotted grey;}
    table th{border:1px dotted grey}
    table td{border:1px dotted grey;text-align:center;height: 18px;}
    div{clear: both}
</style>
<%
if request.QueryString("name")<>"" then
    toolload_string="provider=microsoft.ace.oledb.12.0;Extended Properties=Excel 12.0;data source=" & server.mappath("\") & "\filelists\tool\" & request.QueryString("name")
    filename=request.QueryString("name")
elseif request.QueryString("upload")<>"" then
    toolload_string="provider=microsoft.ace.oledb.12.0;Extended Properties=Excel 12.0;data source=" & server.mappath("\") & "\filelists\tool\" & request.QueryString("upload")
    filename=request.QueryString("name")
else
    dim upfile 
    dim SaveFilename 
    set upfile=new upload_file
    upfile.GetData (5120000) 
    if upfile.isErr then
        select case upfile.isErr
            case 1 
                Response.Write "未上传数据" 
            case 2 
                Response.Write "你上传的文件超出我们的限制,最大5M" 
        end select
    else 
        Filename=upfile.AutoSave("file",server.mappath("\") & "\filelists\tool\") 
        response.write "<script>alert('上传成功！')</script>"
    end if
    toolload_string="provider=microsoft.ace.oledb.12.0;Extended Properties=Excel 12.0;data source=" & server.mappath("\") & "\filelists\tool\" & Filename
end if
%>
<%
dim toolload_string,iserr,intc
intc=0
iserr=0
set cnn=createobject("adodb.connection")
set cnn1=createobject("adodb.connection")
set rs=createobject("adodb.recordset")
cnn.open toolload_string
cnn1.Open Ebase_String
rs.open "select * from [lists$]",cnn,1,1
if not (rs.EOF and rs.BOF) then
    Rs.pagesize=8
    if request.querystring("page")<>"" then
        epage=Cint(request.querystring("page"))
        if epage<1 then epage=1
        if epage>Rs.pagecount then epage=Rs.pagecount
    else
        epage=1 
    end if
    Rs.absolutepage=epage
end if
%>
</head>
<body>
<%if request.QueryString("upload")="" then %>
    <div style="height:220px;">
        <table style="margin:10px auto;width:95%">
            <caption style="text-align:left;padding-bottom:10px;font-size:16px;font-weight:bold">您将执行以下操作：</caption>
            <tr>
                <th>操作</th>
                <th>物料编码</th>
                <th>PN号码</th>
                <th>设备从属</th>
                <th>仓位</th>
                <th>安全库存</th>
                <th>变更数量</th>
            </tr>
            <%if not rs.eof then
                for i=1 to rs.pagesize
                    if rs.eof then exit for
                  %>
            <tr>
                <td>
                    <%
                    select case rs("method")
                        case "add"
                            response.Write "补充"
                        case "need"
                            response.Write "取用"
                        case "create"
                            response.Write "新增"
                        case else
                            response.Write "Error！"
                            iserr=1
                    end select
                    %>
                </td>
                <td>
                <%
                    select case rs("method")
                        case "add"
                            if cnn1.Execute("select id from lists where code='" & rs("code") & "'").EOF then
                                response.write "Error！"
                                iserr=1 
                            else
                                response.Write rs("code")
                            end if
                        case "need"
                            if cnn1.Execute("select id from lists where code='" & rs("code") & "'").EOF then
                                response.write "Error！"
                                iserr=1 
                            else
                                response.Write rs("code")
                            end if
                        case "create"
                            if cnn1.Execute("select id from lists where code='" & rs("code") & "'").EOF then
                                response.Write rs("code")
                            else
                                response.write "Error！"
                                iserr=1 
                            end if
                        case else
                            response.write "Error！"
                            iserr=1
                    end select
                %>
                </td>
                <td><%=rs("p/n") %></td>
                <td style="text-align:left"><%=rs("device") %></td>
                <td><%=rs("position") %></td>
                <td>
                    <%
                        if isnull(rs("limit")) or (isnumeric(rs("limit"))=true and int(rs("limit"))=rs("limit")) then
                            response.write rs("limit")
                        else
                            response.write "Error！"
                            iserr=1
                        end if
                    %>
                </td>
                <td>
                <%
                   select case rs("method")
                        case "add"
                            if isnumeric(rs("count"))=false or int(rs("count"))<>rs("count") then
                                response.write "Error！"
                                iserr=1
                            else
                                response.Write rs("count")
                            end if
                        case "need"
                            if isnumeric(rs("count"))=false or int(rs("count"))<>rs("count") or cnn1.Execute("select count from lists where code='" & rs("code") & "'")(0) < rs("count") then
                                response.write "Error！"
                                iserr=1
                            else
                                response.Write rs("count")
                            end if
                        case "create"
                            if isnumeric(rs("count"))=false or int(rs("count"))<>rs("count") then
                                response.write "Error！"
                                iserr=1
                            else
                                response.Write rs("count")
                            end if
                        case else
                            response.write "Error！"
                            iserr=1
                    end select
                %>
                </td>
            </tr>
            <%
                rs.movenext
                next
            end if %>
        </table>
    </div>
    <hr style="width:95%">
    <div style="text-align:center;height:60px;margin-top:5px;" id="iserralert">
        <%urlgo=request.servervariables("script_name") & "?name=" & filename%>
        <%if epage>1 and epage < Rs.pagecount then %>
            <a href="<% =urlgo & "&page=1" %>">首页</a>&nbsp;&nbsp;
            <a href="<% =urlgo & "&page=" & epage-1 %>" >上一页</a>&nbsp;&nbsp;
            <a href="<% =urlgo & "&page=" & epage+1%>">下一页</a>&nbsp;&nbsp;
            <a href="<% =urlgo & "&page=" & Rs.pagecount%>">末页</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <% elseif epage=1 and epage < Rs.pagecount then %>
            <a href="<% =urlgo & "&page=" & epage+1 %>" >下一页</a>&nbsp;&nbsp;
            <a href="<% =urlgo & "&page=" & Rs.pagecount%>">末页</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <% elseif epage>1 and epage=Rs.pagecount then %>
            <a href="<% =urlgo & "&page=1"%>">首页</a>&nbsp;&nbsp;
            <a href="<% =urlgo & "&page=" & epage-1%>">上一页</a>&nbsp;&nbsp;
        <% end if %>
            <span align="center">第-<% =epage %>-页，共-<%=Rs.pagecount%>-页</span>
        <form method="get">
            <input style="margin:10px auto;width:95%" type="submit" value="提交" id="submit1" class="an" onclick="return confirm('是否确认进行批量操作？')">
            <input type="hidden" name="upload" value="<%=filename%>" />
        </form>
    </div>
    <%if iserr=1 then%>
    <script>
        document.getElementById("submit1").hidden="hidden";
        document.getElementById("iserralert").innerHTML="上传数据出现错误，请修正 Error 位置后再次尝试上传。";
    </script>
    <%else %>
    <script>
        document.getElementById("submit1").hidden="";
    </script>
    <% end if%>
<%else %>
    <div style="text-align:center;vertical-align:central;height:100%">
        正在上传，请稍等……
    </div>
    <%
        rs.MoveFirst
        if not rs.EOF then
            for i=1 to rs.recordcount
                select case rs("method")
                    case "add"
                        orign=cnn1.Execute("select count from lists where code='" & rs("code") & "'")(0)
                        a=orign+rs("count")
                        cnn1.Execute("update [lists] set [count]=" & a & " where [code]='" & rs("code") & "'")
                        cnn1.execute("insert into gets([code],[time],[by],[type],[number]) values('" & rs("code") & "',#" & date() & "#,'" & session("name") & "','入库'," & rs("count") & ")") 
                    case "need"
                        orign=cnn1.Execute("select count from lists where code='" & rs("code") & "'")(0)
                        b=orign-rs("count")
                        cnn1.Execute("update [lists] set [count]=" & b & " where [code]='" & rs("code") & "'")
                        cnn1.execute("insert into gets([code],[time],[by],[type],[number],[reason]) values('" & rs("code") & "',#" & date() & "#,'" & session("name") & "','出库'," & rs("count") & ",'批量领用')")
                    case "create"
                        cnn1.Execute("insert into lists ([code],[description],[p/n],[device],[position],[limit],[count]) values ('" & rs("code") & "','" & rs("description") & "','" & rs("p/n") & "','" & rs("device") & "','" &  rs("position" ) & "'," & rs("limit") & "," & rs("count") & ")")
                end select
            rs.MoveNext
            next
        end if
    %>
    <%response.Write "<script>alert('批量操作完成！请稍后刷新页面查看最新数据。');window.close();</script>"%>
<%end if%>
<%
rs.Close:set rs=nothing
cnn.Close:set cnn=nothing
cnn1.Close:set cnn1=nothing
%>
</body>
</html>