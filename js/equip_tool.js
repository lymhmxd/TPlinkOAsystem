function checked()
{
    if (document.getElementById("check").value=="new")
    {
        if (document.getElementById("code").value == "")
        {
            alert("编码不得为空！");
            document.layform.code.focus();
            return (false);
        }
        if (document.getElementById("des").value == "") {
            alert("物料描述不得为空！");
            document.layform.des.focus();
            return (false);
        }
        if (document.getElementById("dev").value == "") {
            alert("物料从属类型不得为空！");
            document.layform.dev.focus();
            return (false);
        }
        if (document.getElementById("pos").value == "") {
            alert("存储仓位不得为空！");
            document.layform.pos.focus();
            return (false);
        }
        if (document.getElementById("con").value == "") {
            alert("库存量不得为空！");
            document.layform.con.focus();
            return (false);
        }
        if (document.getElementById("limit").value == "") {
            alert("安全库存不得为空！");
            document.layform.limit.focus();
            return (false);
        }
        var strmsg2="是否确认新增物料【"+document.getElementById("code").value+"】？"
        return confirm(strmsg2);
    }
    if (document.getElementById("check").value=="change")
    {
        if (document.getElementById("con").value < 0 ) {
            alert("入库数量不得为负！");
            document.layform.con.focus();
            return (false);
        }
        if (document.getElementById("remove").value < 0) {
            alert("出库数量不得为负！");
            document.layform.remove.focus();
            return (false);
        }
        if (document.getElementById("remove").value < 0) {
            alert("出库数量不得为负！");
            document.layform.remove.focus();
            return (false);
        }
        if (document.getElementById("remove").value ==0 && document.getElementById("con").value==0) {
            alert("出入库数量不得同时为0！");
            document.layform.remove.focus();
            return (false);
        }
        if (document.getElementById("remove").value >0 && document.getElementById("reas").value =="") {
            alert("请填写领用原因！");
            document.layform.reas.focus();
            return (false);
        }
        var strmsg="即将调整物料【"+document.getElementById("code").value+"】，"
            strmsg+="入库量为【"+document.getElementById("con").value+"pcs】，"
            strmsg+="出库量为【"+document.getElementById("remove").value+"pcs】。\n"
            strmsg+="点击【取消】可返回修改。"
        return confirm(strmsg);
    }
    if (document.getElementById("check").value == "reset") {
        if (document.getElementById("code").value == "") {
            alert("编码不得为空！");
            document.layform.code.focus();
            return (false);
        }
        if (document.getElementById("des").value == "") {
            alert("物料描述不得为空！");
            document.layform.des.focus();
            return (false);
        }
        if (document.getElementById("dev").value == "") {
            alert("物料从属类型不得为空！");
            document.layform.dev.focus();
            return (false);
        }
        if (document.getElementById("pos").value == "") {
            alert("存储仓位不得为空！");
            document.layform.pos.focus();
            return (false);
        }
        if (document.getElementById("con").value == "" || document.getElementById("con").value <0) {
            alert("库存量不得为空或负！");
            document.layform.con.focus();
            return (false);
        }
        if (document.getElementById("limit").value == "" || document.getElementById("limit").value <0) {
            alert("安全库存不得为空或者负！");
            document.layform.limit.focus();
            return (false);
        }
        if (document.getElementById("reas").value == "") {
            alert("请填写调整原因！");
            document.layform.reas.focus();
            return (false);
        }
        var strmsg1="是否确认对物料【"+document.getElementById("code").value+"】进行维护？"
        return confirm(strmsg1);
    }
    if (document.getElementById("check").value=="querycheck")
    {
        if (document.getElementById("querytimein").value>document.getElementById("querytimeou").value)
        {
            alert("开始时间不得晚于结束时间！");
            document.layqueryform.querytimein.focus();
            return (false);
        }
    }
}
function add()
{
    var odataform = document.getElementById("dataform")
    var olay1=document.getElementById("lay1")
    var ochk = document.getElementById("check")
    var code = document.getElementById("code");
    var pn = document.getElementById("pn");
    var des = document.getElementById("des");
    var dev = document.getElementById("dev");
    var pos = document.getElementById("pos");
    var con = document.getElementById("con");
    var limit = document.getElementById("limit");
    olay1.style.display="block";
    odataform.style.display = "block";
    odataform.style.height = "325px";
    odataform.style.marginTop = "-163px";
    ochk.style.display = "none";
    document.getElementById("contitle").innerHTML = "库存量：";
    document.getElementById("limittitle").innerHTML = "安全库存：";
    document.getElementById("limit1").style.display = "table-cell";
    document.getElementById("remove1").style.display = "none";
    document.getElementById("reset").style.display = "inline-block";
    document.getElementById("resetall").style.display = "none";
    document.getElementById("reas1").style.display = "none";
    code.value = "";
    code.disabled = "";
    pn.value = "";
    pn.disabled = "";
    des.value = "";
    des.disabled = "";
    dev.value = "";
    dev.disabled = "";
    pos.value = "";
    pos.disabled = "";
    con.value = "";
    limit.value = "";
    limit.disabled = "";
    document.getElementById("check").value = "new";
    
}
function Change(a,b,c,d,e,f,g,h)
{
    var odataform = document.getElementById("dataform");
    var olay1 = document.getElementById("lay1");
    var code = document.getElementById("code");
    var pn = document.getElementById("pn");
    var des = document.getElementById("des");
    var dev = document.getElementById("dev");
    var pos = document.getElementById("pos");
    var con = document.getElementById("con");
    var rem = document.getElementById("remove");
    olay1.style.display = "block";
    odataform.style.display = "block";
    odataform.style.height = "380px";
    odataform.style.marginTop = "-190px";
    code.value = a;
    code.disabled = "disabled";
    pn.value = b;
    pn.disabled = "disabled";
    des.value = c;
    des.disabled = "disabled";
    dev.value = d;
    dev.disabled = "disabled";
    pos.value = e;
    pos.disabled = "disabled";
    con.value=0;
    rem.value=0;
    document.getElementById("contitle").innerHTML = "入库量：";
    document.getElementById("limittitle").innerHTML = "出库量：";
    document.getElementById("reastitle").innerHTML = "变更原因：";
    document.getElementById("limit1").style.display = "none";
    document.getElementById("remove1").style.display = "table-cell";
    document.getElementById("remove").focus();
    document.getElementById("reset").style.display = "none";
    document.getElementById("resetall").style.display = "inline-block";
    sessionStorage.con = f;
    sessionStorage.limit = g;
    document.getElementById("id").value = h;
    document.getElementById("code1").value = a;
    if (document.getElementById("check").value == "reset")
    {
    }
    else
    {
        document.getElementById("check").value = "change";
    }
    document.getElementById("reas1").style.display = "table-row";
}
function changeall()
{
    var pn = document.getElementById("pn");
    var des = document.getElementById("des");
    var dev = document.getElementById("dev");
    var pos = document.getElementById("pos");
    pn.disabled = "";
    des.disabled = "";
    dev.disabled = "";
    pos.disabled = "";
    document.getElementById("contitle").innerHTML = "库存量：";
    document.getElementById("limittitle").innerHTML = "安全库存：";
    document.getElementById("reastitle").innerHTML = "维护原因：";
    document.getElementById("limit1").style.display = "table-cell";
    document.getElementById("remove1").style.display = "none";
    document.getElementById("resetall").style.display = "none";
    document.getElementById("con").value = sessionStorage.con;
    document.getElementById("limit").value = sessionStorage.limit;
    document.getElementById("reas1").style.display = "table-row";
    document.getElementById("check").value = "reset";
}
function advancedquery()
{
    var olay1=document.getElementById("lay1")
    var oquery=document.getElementById("queryform")
    olay1.style.display="block";
    oquery.style.display="block";
    oquery.style.height="330px";
    oquery.style.marginTop="-165px";
    document.getElementById("check").value = "querycheck";
}
function cls1()
{
    var odataform=document.getElementById("dataform")
    var olay1=document.getElementById("lay1")
    var oquery=document.getElementById("queryform")
    olay1.style.display="none";
    odataform.style.display="none";
    oquery.style.display="none";
}
function kucun()
{
    document.getElementById("querytimein").disabled="disabled";
    document.getElementById("querytimeou").disabled="disabled";
    document.getElementById("queryby").disabled="disabled";
    document.getElementById("querytype").disabled="disabled";
}
function cunqu()
{
    document.getElementById("querytimein").disabled="";
    document.getElementById("querytimeou").disabled="";
    document.getElementById("queryby").disabled="";
    document.getElementById("querytype").disabled="";
}