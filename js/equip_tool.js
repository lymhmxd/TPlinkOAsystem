function checked()
{
    if (document.getElementById("check").value=="new")
    {
        if (document.getElementById("code").value == "")
        {
            alert("���벻��Ϊ�գ�");
            document.layform.code.focus();
            return (false);
        }
        if (document.getElementById("des").value == "") {
            alert("������������Ϊ�գ�");
            document.layform.des.focus();
            return (false);
        }
        if (document.getElementById("dev").value == "") {
            alert("���ϴ������Ͳ���Ϊ�գ�");
            document.layform.dev.focus();
            return (false);
        }
        if (document.getElementById("pos").value == "") {
            alert("�洢��λ����Ϊ�գ�");
            document.layform.pos.focus();
            return (false);
        }
        if (document.getElementById("con").value == "") {
            alert("���������Ϊ�գ�");
            document.layform.con.focus();
            return (false);
        }
        if (document.getElementById("limit").value == "") {
            alert("��ȫ��治��Ϊ�գ�");
            document.layform.limit.focus();
            return (false);
        }
        var strmsg2="�Ƿ�ȷ���������ϡ�"+document.getElementById("code").value+"����"
        return confirm(strmsg2);
    }
    if (document.getElementById("check").value=="change")
    {
        if (document.getElementById("con").value < 0 ) {
            alert("�����������Ϊ����");
            document.layform.con.focus();
            return (false);
        }
        if (document.getElementById("remove").value < 0) {
            alert("������������Ϊ����");
            document.layform.remove.focus();
            return (false);
        }
        if (document.getElementById("remove").value < 0) {
            alert("������������Ϊ����");
            document.layform.remove.focus();
            return (false);
        }
        if (document.getElementById("remove").value ==0 && document.getElementById("con").value==0) {
            alert("�������������ͬʱΪ0��");
            document.layform.remove.focus();
            return (false);
        }
        if (document.getElementById("remove").value >0 && document.getElementById("reas").value =="") {
            alert("����д����ԭ��");
            document.layform.reas.focus();
            return (false);
        }
        var strmsg="�����������ϡ�"+document.getElementById("code").value+"����"
            strmsg+="�����Ϊ��"+document.getElementById("con").value+"pcs����"
            strmsg+="������Ϊ��"+document.getElementById("remove").value+"pcs����\n"
            strmsg+="�����ȡ�����ɷ����޸ġ�"
        return confirm(strmsg);
    }
    if (document.getElementById("check").value == "reset") {
        if (document.getElementById("code").value == "") {
            alert("���벻��Ϊ�գ�");
            document.layform.code.focus();
            return (false);
        }
        if (document.getElementById("des").value == "") {
            alert("������������Ϊ�գ�");
            document.layform.des.focus();
            return (false);
        }
        if (document.getElementById("dev").value == "") {
            alert("���ϴ������Ͳ���Ϊ�գ�");
            document.layform.dev.focus();
            return (false);
        }
        if (document.getElementById("pos").value == "") {
            alert("�洢��λ����Ϊ�գ�");
            document.layform.pos.focus();
            return (false);
        }
        if (document.getElementById("con").value == "" || document.getElementById("con").value <0) {
            alert("���������Ϊ�ջ򸺣�");
            document.layform.con.focus();
            return (false);
        }
        if (document.getElementById("limit").value == "" || document.getElementById("limit").value <0) {
            alert("��ȫ��治��Ϊ�ջ��߸���");
            document.layform.limit.focus();
            return (false);
        }
        if (document.getElementById("reas").value == "") {
            alert("����д����ԭ��");
            document.layform.reas.focus();
            return (false);
        }
        var strmsg1="�Ƿ�ȷ�϶����ϡ�"+document.getElementById("code").value+"������ά����"
        return confirm(strmsg1);
    }
    if (document.getElementById("check").value=="querycheck")
    {
        if (document.getElementById("querytimein").value>document.getElementById("querytimeou").value)
        {
            alert("��ʼʱ�䲻�����ڽ���ʱ�䣡");
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
    document.getElementById("contitle").innerHTML = "�������";
    document.getElementById("limittitle").innerHTML = "��ȫ��棺";
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
    document.getElementById("contitle").innerHTML = "�������";
    document.getElementById("limittitle").innerHTML = "��������";
    document.getElementById("reastitle").innerHTML = "���ԭ��";
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
    document.getElementById("contitle").innerHTML = "�������";
    document.getElementById("limittitle").innerHTML = "��ȫ��棺";
    document.getElementById("reastitle").innerHTML = "ά��ԭ��";
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