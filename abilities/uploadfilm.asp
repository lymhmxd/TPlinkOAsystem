<%
Class upload_file
Dim Form,File
Dim AllowExt_
Dim NoAllowExt_ 
Dim IsDebug_ 
Private oUpFileStream
Private isErr_ 
Private ErrMessage_
Private isGetData_
Public Property Get isErr
    isErr=isErr_ 
End Property 
Public Property Get ErrMessage
    ErrMessage=ErrMessage_ 
End Property 
Public Property Get AllowExt
    AllowExt=AllowExt_ 
End Property 
Public Property Let AllowExt(Value)
    AllowExt_=LCase(Value) 
End Property 
Public Property Get NoAllowExt
    NoAllowExt=NoAllowExt_ 
End Property 
Public Property Let NoAllowExt(Value)
    NoAllowExt_=LCase(Value) 
End Property 
Public Property Let IsDebug(Value)
    IsDebug_=Value 
End Property 
Private Sub Class_Initialize 
    isErr_ = 0 
    NoAllowExt=""
    NoAllowExt=LCase(NoAllowExt) 
    AllowExt="xls;xlsx"
    AllowExt=LCase(AllowExt) 
    isGetData_=false 
End Sub 
Private Sub Class_Terminate
    Form.RemoveAll 
    Set Form = Nothing 
    File.RemoveAll 
    Set File = Nothing 
    oUpFileStream.Close 
    Set oUpFileStream = Nothing 
    if Err.number<>0 then OutErr("清除类时发生错误!") 
End Sub 
Public Sub GetData (MaxSize)
    if isGetData_=false then 
        Dim RequestBinDate,sSpace,bCrLf,sInfo,iInfoStart,iInfoEnd,tStream,iStart,oFileInfo 
        Dim sFormValue,sFileName 
        Dim iFindStart,iFindEnd 
        Dim iFormStart,iFormEnd,sFormName 
        If Request.TotalBytes < 1 Then '如果没有数据上传 
            isErr_ = 1 
            ErrMessage_="没有数据上传,这是因为直接提交网址所产生的错误!" 
            OutErr("没有数据上传,这是因为直接提交网址所产生的错误!!") 
            Exit Sub 
        End If 
        If MaxSize > 0 Then '如果限制大小 
        If Request.TotalBytes > MaxSize Then 
            isErr_ = 2
            ErrMessage_="上传的数据超出限制大小!" 
            OutErr("上传的数据超出限制大小!") 
            Exit Sub 
        End If 
    End If 
    Set Form = Server.CreateObject ("Scripting.Dictionary") 
    Form.CompareMode = 1 
    Set File = Server.CreateObject ("Scripting.Dictionary") 
    File.CompareMode = 1 
    Set tStream = Server.CreateObject ("ADODB.Stream") 
    Set oUpFileStream = Server.CreateObject ("ADODB.Stream") 
    if Err.number<>0 then OutErr("创建流对象(ADODB.STREAM)时出错,可能系统不支持或没有开通该组件") 
    oUpFileStream.Type = 1 
    oUpFileStream.Mode = 3 
    oUpFileStream.Open 
    oUpFileStream.Write Request.BinaryRead (Request.TotalBytes) 
    oUpFileStream.Position = 0 
    RequestBinDate = oUpFileStream.Read 
    iFormEnd = oUpFileStream.Size 
    bCrLf = ChrB (13) & ChrB (10) 
    sSpace = MidB (RequestBinDate,1, InStrB (1,RequestBinDate,bCrLf)-1) 
    iStart = LenB(sSpace) 
    iFormStart = iStart+2 
    Do 
        iInfoEnd = InStrB (iFormStart,RequestBinDate,bCrLf & bCrLf)+3 
        tStream.Type = 1 
        tStream.Mode = 3 
        tStream.Open 
        oUpFileStream.Position = iFormStart 
        oUpFileStream.CopyTo tStream,iInfoEnd-iFormStart 
        tStream.Position = 0 
        tStream.Type = 2 
        tStream.CharSet = "gb2312" 
        sInfo = tStream.ReadText 
        '取得表单项目名称 
        iFormStart = InStrB (iInfoEnd,RequestBinDate,sSpace)-1 
        iFindStart = InStr (22,sInfo,"name=""",1)+6 
        iFindEnd = InStr (iFindStart,sInfo,"""",1) 
        sFormName = Mid(sinfo,iFindStart,iFindEnd-iFindStart) 
        '如果是文件 
        If InStr (45,sInfo,"filename=""",1) > 0 Then 
            Set oFileInfo = new FileInfo_Class 
            '取得文件属性 
            iFindStart = InStr (iFindEnd,sInfo,"filename=""",1)+10 
            iFindEnd = InStr (iFindStart,sInfo,""""&vbCrLf,1) 
            sFileName = Trim(Mid(sinfo,iFindStart,iFindEnd-iFindStart)) 
            oFileInfo.FileName = GetFileName(sFileName) 
            oFileInfo.FilePath = GetFilePath(sFileName) 
            oFileInfo.FileExt = GetFileExt(sFileName) 
            iFindStart = InStr (iFindEnd,sInfo,"Content-Type: ",1)+14 
            iFindEnd = InStr (iFindStart,sInfo,vbCr) 
            oFileInfo.FileMIME = Mid(sinfo,iFindStart,iFindEnd-iFindStart) 
            oFileInfo.FileStart = iInfoEnd 
            oFileInfo.FileSize = iFormStart -iInfoEnd -2 
            oFileInfo.FormName = sFormName 
            file.add sFormName,oFileInfo 
        else 
            '如果是表单项目 
            tStream.Close 
            tStream.Type = 1 
            tStream.Mode = 3 
            tStream.Open 
            oUpFileStream.Position = iInfoEnd 
            oUpFileStream.CopyTo tStream,iFormStart-iInfoEnd-2 
            tStream.Position = 0 
            tStream.Type = 2 
            tStream.CharSet = "gb2312" 
            sFormValue = tStream.ReadText 
            If Form.Exists (sFormName) Then 
                Form (sFormName) = Form (sFormName) & ", " & sFormValue 
            else 
                Form.Add sFormName,sFormValue 
            End If 
        End If 
        tStream.Close 
        iFormStart = iFormStart+iStart+2 
    Loop Until (iFormStart+2) >= iFormEnd 
    if Err.number<>0 then OutErr("分解上传数据时发生错误,可能客户端的上传数据不正确或不符合上传数据规则") 
        RequestBinDate = "" 
        Set tStream = Nothing 
        isGetData_=true 
    end if 
End Sub 
Public Function SaveToFile(Item,Path) 
    SaveToFile=SaveToFileEx(Item,Path,True) 
End Function
Public Function AutoSave(Item,Path) 
    AutoSave=SaveToFileEx(Item,Path,false) 
End Function 
Private Function SaveToFileEx(Item,Path,Over)
    Dim FileExt 
    if file.Exists(Item) then 
        Dim oFileStream 
        Dim tmpPath 
        isErr_=0 
        Set oFileStream = CreateObject ("ADODB.Stream") 
        oFileStream.Type = 1 
        oFileStream.Mode = 3 
        oFileStream.Open 
        oUpFileStream.Position = File(Item).FileStart 
        oUpFileStream.CopyTo oFileStream,File(Item).FileSize 
        tmpPath=Split(Path,".")(0) 
        FileExt=GetFileExt(Path) 
        if Over then 
            if isAllowExt(FileExt) then 
                oFileStream.SaveToFile tmpPath & "." & FileExt,2
                if Err.number<>0 then OutErr("保存文件时出错,请检查路径,是否存在该上传目录!该文件保存路径为" & tmpPath & "." & FileExt) 
            Else 
                isErr_=3 
                ErrMessage_="该后缀名的文件不允许上传!!!" & tmpPath & "." & FileExt
                OutErr("该后缀名的文件不允许上传") 
            End if 
        Else 
            Path=GetFilePath(Path) 
            dim fori 
            fori=1 
            if isAllowExt(File(Item).FileExt) then 
                do 
                fori=fori+1 
                Err.Clear() 
                tmpPath=Path&GetNewFileName()&"."&File(Item).FileExt 
                oFileStream.SaveToFile tmpPath 
                loop Until ((Err.number=0) or (fori>50)) 
                if Err.number<>0 then OutErr("自动保存文件出错,已经测试50次不同的文件名来保存,请检查目录是否存在!该文件最后一次保存时全路径为"&Path&GetNewFileName()&"."&File(Item).FileExt) 
            Else 
                isErr_=3 
                ErrMessage_="该后缀名的文件不允许上传!!!!" 
                OutErr("该后缀名的文件不允许上传") 
            End if 
        End if 
        oFileStream.Close 
        Set oFileStream = Nothing 
    else 
        ErrMessage_="不存在该对象(如该文件没有上传,文件为空)!" 
        OutErr("不存在该对象(如该文件没有上传,文件为空)") 
    end if 
    if isErr_=3 then SaveToFileEx="" else SaveToFileEx=GetFileName(tmpPath) 
End Function 
Public Function FileData(Item) 
    isErr_=0 
    if file.Exists(Item) then 
        if isAllowExt(File(Item).FileExt) then 
            oUpFileStream.Position = File(Item).FileStart 
            FileData = oUpFileStream.Read (File(Item).FileSize) 
        Else 
            isErr_=3 
            ErrMessage_="该后缀名的文件不允许上传" 
            OutErr("该后缀名的文件不允许上传") 
            FileData="" 
        End if 
    else 
        ErrMessage_="不存在该对象(如该文件没有上传,文件为空)!" 
        OutErr("不存在该对象(如该文件没有上传,文件为空)") 
    end if 
End Function 
Public function GetFilePath(FullPath) 
    If FullPath <> "" Then 
        GetFilePath = Left(FullPath,InStrRev(FullPath, "\")) 
    Else 
        GetFilePath = "" 
    End If 
End function 
Public Function GetFileName(FullPath) 
    If FullPath <> "" Then 
        GetFileName = mid(FullPath,InStrRev(FullPath, "\")+1) 
    Else 
        GetFileName = "" 
    End If 
End function 
Public Function GetFileExt(FullPath) 
    If (FullPath <> "") and (InStrRev(FullPath,".")>1) Then 
        GetFileExt = LCase(Mid(FullPath,InStrRev(FullPath, ".")+1)) 
    Else 
        GetFileExt = "" 
    End If 
End function 
Public Function GetNewFileName() 
    dim ranNum 
    dim dtNow 
    dtNow=Now() 
    randomize 
    ranNum=int(90000*rnd)+10000 
    GetNewFileName=year(dtNow) & right("0" & month(dtNow),2) & right("0" & day(dtNow),2) & right("0" & hour(dtNow),2) & right("0" & minute(dtNow),2) & right("0" & second(dtNow),2) & ranNum 
End Function 
Public Function isAllowExt(Ext) 
    if NoAllowExt="" then 
        isAllowExt=cbool(InStr(1,";"&AllowExt&";",LCase(";"&Ext&";")) or (AllowExt="") )
    else 
        isAllowExt=not CBool(InStr(1,";"&NoAllowExt&";",LCase(";"&Ext&";"))) 
    end if 
    if Ext="" then isAllowExt=false '如果文件没有扩展名，则不允许上传 
End Function 
End Class 
Public Sub OutErr(ErrMsg) 
    if IsDebug_=true then 
        Response.Write ErrMsg 
        Response.End 
    End if 
End Sub 
Class FileInfo_Class 
    Dim FormName,FileName,FilePath,FileSize,FileMIME,FileStart,FileExt 
End Class
%> 