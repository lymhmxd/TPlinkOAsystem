{
function dept_lay(i)
    var deptlay=document.getElementById("dept_lay")
    var depttop=document.getElementById("dept_top")
    var deptorititle=document.getElementById("dept_ori_title")
    var deptnewtitle=document.getElementById("dept_new_title")
    var deptcheck=document.getElementById("dept_check")
    var deptori=document.getElementById("dept_ori")
    var deptnew=document.getElementById("dept_new")
    var classori=document.getElementById("class_ori")
    var classnew=document.getElementById("class_new")
    var classorititle=document.getElementById("class_ori_title");
    var classnewtitle = document.getElementById("class_new_title");
    deptlay.style.display="block";
    depttop.style.display="block";
    deptori.style.display="table-row";
    classori.style.display="table-row";
    deptnew.style.display="table-row";
    classnew.style.display="table-row";
    if(i==1)
    {   
        deptorititle.innerHTML="Ҫ�޸ĵĲ��ţ�";
        classori.style.display="none";
        classnew.style.display="none";
        depttop.style.height="200px";
        depttop.style.margin="-102px 0 0 -202px";
        deptnewtitle.innerHTML="�µĲ������ƣ�";
        deptnew.disabled="";
    }
    else if(i==2)
    {
        deptori.style.display="none";
        classori.style.display="none";
        classnew.style.display="none";
        depttop.style.height="160px";
        depttop.style.margin="-82px 0 0 -202px";
        deptnewtitle.innerHTML="�����Ĳ������ƣ�";
    }
    else if(i==3)
    {
        classori.style.display="none";
        classnew.style.display="none";
        deptnew.style.display="none";
        depttop.style.height="160px";
        depttop.style.margin="-82px 0 0 -202px";
        deptorititle.innerHTML="Ҫɾ���Ĳ��ţ�";
    }
    else if(i==4)
    {
        deptorititle.innerHTML="Ҫ�޸ĵĲ��ţ�";
        classorititle.innerHTML="Ҫ�޸ĵĿα���";
        classnewtitle.innerHTML="�µĿα����ƣ�";
        deptnew.style.display = "none";
        depttop.style.height = "240px";
        depttop.style.margin = "-122px 0 0 -202px";
    }
    else if(i==5)
    {
        deptorititle.innerHTML="Ҫ�޸ĵĲ��ţ�";
        classori.style.display="none";
        deptnew.style.display="none";
        classnewtitle.innerHTML="�����Ŀα����ƣ�";
        depttop.style.height="200px";
        depttop.style.margin="-102px 0 0 -202px";
        
    }
    else if(i==6)
    {
        depttop.style.height="200px";
        depttop.style.margin="-102px 0 0 -202px";
        deptorititle.innerHTML="Ҫ�޸ĵĲ��ţ�";
        classorititle.innerHTML="Ҫɾ���Ŀα���";
        deptnew.style.display="none";
        classnew.style.display="none";
        
    }
    deptcheck.value=i;
}
function dept_cls()
{
    var deptlay=document.getElementById("dept_lay")
    var depttop=document.getElementById("dept_top")
    deptlay.style.display="none";
    depttop.style.display="none";
}
function dept_datacheck()
{
    if (document.getElementById("dept_check").value == 1)
    {
        if (document.getElementById("top_dept").value=="")
        {
            alert("��ѡ��Ҫ�޸ĵĲ��ţ�");
            return false;
        }
        if(document.getElementById("dept_new_value").value=="")
        {
            alert("����д�µĲ������ƣ�");
            return false;
        }
    }
    else if(document.getElementById("dept_check").value == 2)
    {
        if (document.getElementById("dept_new_value").value == "") {
            alert("����д�µĲ������ƣ�");
            return false;
        }
    }
    else if (document.getElementById("dept_check").value == 3)
    {
        if (document.getElementById("top_dept").value == "") {
            alert("��ѡ��Ҫɾ���Ĳ��ţ�");
            return false;
        }
    }
    else if (document.getElementById("dept_check").value == 4)
    {
        if (document.getElementById("top_dept").value == "") {
            alert("��ѡ��Ҫ�޸ĵĲ��ţ�");
            return false;
        }
        if (document.getElementById("class_ori_value_slt").value == "") {
            alert("����д�µĲ������ƣ�");
            return false;
        }
        if (document.getElementById("class_new_value").value == "") {
            alert("����д�µĿα����ƣ�");
            return false;
        }
    }
    else if (document.getElementById("dept_check").value == 5) {
        if (document.getElementById("top_dept").value == "") {
            alert("��ѡ��Ҫ�޸ĵĲ��ţ�");
            return false;
        }
        if (document.getElementById("class_new_value").value == "") {
            alert("����д�µĿα����ƣ�");
            return false;
        }
    }
    else if (document.getElementById("dept_check").value == 6) {
        if (document.getElementById("top_dept").value == "") {
            alert("��ѡ��Ҫ�޸ĵĲ��ţ�");
            return false;
        }
        if (document.getElementById("class_ori_value_slt").value == "") {
            alert("��ѡ��Ҫɾ���Ŀα����ƣ�");
            return false;
        }
    }
    return confirm("����ִ�������޸ģ���������ȷ�ϡ�ִ�У�������������ȡ������\n���棺����Ҫɾ�����ţ���ȷ�ϲ����ڵ���Ա�Ѿ����·������������š�")
}