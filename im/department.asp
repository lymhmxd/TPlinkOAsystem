<!DOCTYPE html>
<html style="height:100%">
<head>
	<!--#include virtual="/nav.asp"-->
    <link href="/css/department.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="/js/department.js"></script>
	<title>部门管理</title>
    <%
    set cnn=createobject("adodb.connection")
    set rs=createobject("adodb.recordset")
    set rs1=createobject("adodb.recordset")
    cnn.open Basic_String
    rs.open "select * from department",cnn,1,3
    rs1.open "select * from class",cnn,1,3
    %>
    <%
    if request("dept_check")<>"" then
        select case request("dept_check")
            case 1
                if cnn.Execute("select id from department where dept='" & request("dept_new_value") & "'").EOF then
                sql="update department set dept='" & request("dept_new_value") & "' where dept_id=" & request("top_dept")
                else
                response.Write "<script>alert('该部门已经存在，请勿重复添加！');</script>"
                end if
            case 2
                if cnn.Execute("select id from department where dept='" & request("dept_new_value") & "'").EOF then
                a=cnn.execute("select max(dept_id) from department")(0)+1
                sql="insert into department(dept_id,dept) values(" & a & ",'" & request("dept_new_value") & "')"
                else
                response.Write "<script>alert('该部门已经存在，请勿重复添加！');</script>"
                end if
            case 3
                if cnn.Execute("select id from logmsg where dept_id=" & request("top_dept")).EOF then
                cnn.Execute("delete from class where dept_id=" & request("top_dept"))
                sql="delete from department where dept_id=" & request("top_dept")
                else
                response.Write "<script>alert('该部门已经被使用，无法删除！若需强制删除，请联系DBA管理员。');</script>"
                end if
            case 4
                if cnn.Execute("select id from class where dept_id=" & request("top_dept") & " and [class]='" & request("class_new_value") & "'").EOF then
                sql="update class set [class]='" & request("class_new_value") & "' where dept_id=" & request("top_dept") & " and class_id=" & request("class_ori_value_slt")
                else
                response.Write "<script>alert('该课别已经存在，请勿重复添加！');</script>"
                end if
            case 5
                if cnn.Execute("select id from class where dept_id=" & request("top_dept") & " and [class]='" & request("class_new_value") & "'").EOF then
                sql="select max(class_id) from class where dept_id=" & request("top_dept")
                a=cnn.Execute(sql)(0)+1
                sql="insert into class(dept_id,class_id,class) values(" & request("top_dept") & "," & a & ",'" & request("class_new_value") & "')"
                else
                response.Write "<script>alert('该课别已经存在，请勿重复添加！');</script>"
                end if
            case 6
                if cnn.Execute("select id from logmsg where class_id=" & request("class_ori_value_slt")).EOF then
                sql="delete from class where dept_id=" & request("top_dept") & " and class_id=" & request("class_ori_value_slt")
                else
                response.Write "<script>alert('该课别已经被使用，无法删除！若需强制删除，请联系DBA管理员。');</script>"
                end if
        end select
        if sql<>"" then cnn.Execute(sql)
        response.Write "<script>location.href=window.location.pathname;</script>"
    end if
    %>
    <script lang="text/javascript">
        var a=0;
        b=new Array;
        <%
            i=0
            do while not rs1.eof
        %>
        b[<%=i%>]=new Array("<%=trim(rs1("class"))%>","<%=trim(rs1("dept_id"))%>","<%=trim(rs1("class_id"))%>");
        <%
            i=i+1
            rs1.movenext
            loop
            rs1.close
        %>
        a=<%=i%>
        function dept0(deptid)
        {
            document.getElementById("class_ori_value_slt").length=0;
            var j;
            for(j=0;j<a;j++)
            {
                if(b[j][1]==deptid)
                {
                    document.getElementById("class_ori_value_slt").options[document.getElementById("class_ori_value_slt").length]=new Option(b[j][0],b[j][2]);
                }
            }
        }
    </script>
</head>
<body style="height:100%">
<div id="dept_lay"></div>
    <div id="dept_top" align="center">
        <h2><span id="close" onclick="dept_cls()">关闭[X]</span></h2><br/>
        <form method="GET">
            <table id="dept_top_tb">
                <input type="hidden" id="dept_check" name="dept_check">
                <tr id="dept_ori">
                    <td id="dept_ori_title"></td>
                    <td>
                        <select name="top_dept" id="top_dept" onchange="dept0(document.getElementById('top_dept').options[document.getElementById('top_dept').selectedIndex].value)">
                            <option value="">--请选择要修改的部门--</option>
                            <%
                            if at(0)=1 then
                                for i=1 to rs.recordcount
                                   
                            %>
                            <option value="<%=rs("dept_id")%>"><%=rs("dept")%></option>
                            <%
                                rs.movenext
                                next
                            else
                                for i=1 to rs.recordcount
                                    if rs("dept_id")=session("dept_id") then
                            %>
                            <option value="<%=rs("dept_id")%>"><%=rs("dept")%></option>
                            <%
                                end if
                                rs.movenext
                                next
                            end if
                            rs.movefirst
                            %>
                        </select>
                    </td>
                </tr>
                <tr id="class_ori"><td id="class_ori_title"></td><td>
                    <select name="class_ori_value_slt" id="class_ori_value_slt">
                        <option value="">--请选择要修改的课别--</option>
                    </select></td>
                </tr>
                <tr id="dept_new"><td id="dept_new_title"></td><td><input type="text" name="dept_new_value" id="dept_new_value"></td></tr>
                <tr id="class_new"><td id="class_new_title"></td><td><input type="text" name="class_new_value" id="class_new_value"></td></tr>
            </table>
            <br>
            <hr style="width:100%"><br>
            <input type="submit" value="执行" class="an" style="width:100px;" onclick="return dept_datacheck()">&nbsp;&nbsp;<input type="reset" value="重置" class="an" style="width:100px;">
        </form>
    </div>
<div id="way">
    <a href="/index.asp">首页</a>>>部门管理
</div>
<div id="content">
<hr>
<%if at(0) or at(1) then%>
<table id="dept_scan">
    <caption>&nbsp;</caption>
    <tr><th>部门</th><%if at(0)=1 then %><th>部门操作</th><%end if %><th colspan="6">课别</th><th style="width:10%">课别操作</th></tr>
    <%
    for i=1 to rs.recordcount
    rs1.open "select * from class where dept_id=" & i,cnn,1,3
    if int(rs1.recordcount/6)<rs1.recordcount/6 then
        a=int(rs1.recordcount/6)+1
    else
        a=int(rs1.recordcount/6)
    end if
    if a=0 then a=1
    %>
    <tr>
        <td rowspan="<%=a%>"><%=rs("dept")%></td>
        <%if at(0)=1 and i=1 then%>
        <td rowspan="100" style="text-align:center;width:10%">
            <input type="button" value="更名" class="an" style="width:90px;" onclick="dept_lay(1)"><br><br>
            <input type="button" value="新增" class="an" style="width:90px;" onclick="dept_lay(2)"><br><br>
            <input type="button" value="删除" class="an" style="width:90px;" onclick="dept_lay(3)">
        </td>
        <%end if%>
    <%
    for j=1 to 6*a
        if j mod 7=0 then    
    %>
    </tr>
    <tr>
            <%if not rs1.eof then%>
        <td style="text-align:center"><%=rs1("class")%></td>
            <%else%>
        <td>&nbsp;</td>
    <%        end if
        else
            if not rs1.eof then
    %>
        <td style="text-align:center"><%=rs1("class")%></td>
            <%else%>
        <td>&nbsp;</td>
    <%
            end if
        end if
        if i=1 and j=6 then
    %>
        <td rowspan="100" style="text-align:center">
            <input type="button" value="更名" class="an" style="width:90px;" onclick="dept_lay(4)"><br><br>
            <input type="button" value="新增" class="an" style="width:90px;" onclick="dept_lay(5)"><br><br>
            <input type="button" value="删除" class="an" style="width:90px;" onclick="dept_lay(6)">
        </td>
    <%
        end if
        if not rs1.eof then rs1.movenext
    next

    %>
    </tr>
    <%
    rs1.close
    rs.movenext
    next
    %>
</table>
<%else%>
<br>
<span class="stat">您无权限访问该页面。</span>
<%end if%>
</div>
<!--#include virtual="/bottom.html"-->
</body>
</html>