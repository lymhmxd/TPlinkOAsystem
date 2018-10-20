function logchk()
{
    if( document.getElementById("act").value=="")
    {
        alert("«Î ‰»Îµ«¬º” œ‰£°")
        return (false);
    }
    if(document.getElementById("pwd").value=="")
    {
        alert("«Î ‰»Î√‹¬Î£°")
        return (false);
    }
}
function logdata()
{
    var olog=document.getElementById("log")
    var olay=document.getElementById("lay")
    var ologerr=document.getElementById("logerr")
    if (sessionStorage.account==undefined)
    {
        olay.style.display="block";
        olog.style.display="block";
        ologerr.style.display="block";
    }
    else
    {
        olay.style.display="none";
        olog.style.display="none";
    }
}
function log()
{
    var olog=document.getElementById("log")
    var olay=document.getElementById("lay")
    var ologerr=document.getElementById("logerr")
    olay.style.display="block";
    olog.style.display="block";
    ologerr.style.display="none";    
}
function cls()
{
    var olog=document.getElementById("log")
    var olay=document.getElementById("lay")
    olay.style.display="none";
    olog.style.display="none";
    document.getElementById("act").value="";
    document.getElementById("pwd").value="";
}
function menuFix()
{
    var lists = document.getElementById("nav").getElementsByTagName("li");
    for (var i=0; i<lists.length; i++) 
    {
        lists[i].onmouseover=function() {this.className+=(this.className.length>0? " ": "") + "sfhover";}
        lists[i].onmouseout=function() {this.className=this.className.replace(new RegExp("( ?|^)sfhover\\b"),"");}
    }
}