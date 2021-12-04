
如果浏览器报错提示：ActiveXObject is not defined

Internet 选项 -> 安全 - >安全级别,调低级别
```js
function openFileIIs(){
try{
var obj=new ActiveXObject("wscript.shell");
if(obj){
obj.Run("c:/", 1, false );
//obj.run("osk");/*打开屏幕键盘*/
//obj.Run('"'+filename+'"');
obj=null;
}
}catch(e){
alert("请确定是否存在该盘符或文件");
}

}
openFileIIs()
```


avascript取得机器名，用户名，读写注册表，启动应用程序

//javascript有个特殊的对象ActiveXObject，通过它可以访问windows的本地文件系统和应用程序，

比如：有的时候我们需要得到用户的机器名，用户名，得到某个文件的信息，或者读写注册表，或者启动计算器、outlook等应用程序。

 

下面是一些常用的方法，每个都经过了测试。
 ```js
<script language="JavaScript">
 
//取得机器名，登录域及登录用户名
 
function getusername()
 
{
 
var WshNetwork = new ActiveXObject("WScript.Network");
 
alert("Domain = " + WshNetwork.UserDomain);
 
alert("Computer Name = " + WshNetwork.ComputerName);
 
alert("User Name = " + WshNetwork.UserName);
 
}
 ```
```js 
//取得系统目录
 
function getprocessnum()
 
{
 
var pnsys=new ActiveXObject("WScript.shell");
 
pn=pnsys.Environment("PROCESS");
 
alert(pn("WINDIR"));
 
}
 
//返回系统中特殊目录的路径
 
function getspecialfolder()
 
{
 
var mygetfolder=new ActiveXObject("WScript.shell");
 
if(mygetfolder.SpecialFolders("Fonts")!=null)
 
{
 
alert(mygetfolder.SpecialFolders("Fonts"));
 
}
 
}
 
//取得磁盘信息 传入参数如：getdiskinfo('c')
 
function getdiskinfo(para)
 
{
 
var fs=new ActiveXObject("scripting.filesystemobject");
 
d=fs.GetDrive(para);
 
s="卷标:" + d.VolumnName;
 
s+="------" + "剩余空间:" + d.FreeSpace/1024/1024 + "M";
 
s+="------" + "磁盘序列号:" + d.serialnumber;
 
alert(s)
 
}
 
//取得系统目录
 
function getprocessnum()
 
{
 
var pnsys=new ActiveXObject("WScript.shell");
 
pn=pnsys.Environment("PROCESS");
 
alert(pn("WINDIR"));
 
}
 
//启动计算器
 
function runcalc()
 
{
 
var calc=new ActiveXObject("WScript.shell");
 
calc.Run("calc");
 
}
 
//读取注册表中的值
 
function readreg()
 
{
 
var myreadreg=new ActiveXObject("WScript.shell");
 
try{
 
alert(myreadreg.RegRead ("HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\\NeroCheck"));
 
}
 
catch(e)
 
{
 
alert("读取的值不存在！");
 
}
 
}
 
//写注册表
 
function writereg()
 
{
 
var mywritereg=new ActiveXObject("WScript.shell");
 
try{
 
mywritereg.RegWrite("HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\\MyTest","c:\\mytest.exe");
 
alert("写入成功！");
 
}
 
catch(e)
 
{
 
alert("写入路径不正确！");
 
}
 
}
 
//删除注册表
 
function delreg()
 
{
 
var mydelreg=new ActiveXObject("WScript.shell");
 
if(confirm("是否真的删除？"))
 
{
 
try{
 
mydelreg.RegDelete("HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\\MyTest");
 
alert("删除成功！");
 
}
 
catch(e)
 
{
 
alert("删除路径不正确");
 
}
 
}
 
}
 
//取得文件信息 调用方式如：getfileinfo('c:\\test.pdf')
 
function getfileinfo(para)
 
{
 
var myfile=new ActiveXObject("scripting.filesystemobject");
 
var fi=myfile.GetFile(para);
 
alert("文件类型:"+fi.type+"文件大小:"+fi.size/1024/1024+"M"+"最后一次访问时间:"+fi.DateLastAccessed);
 
}
 
//取得客户端的信息
 
function clientInfo()
 
{
 
strClientInfo="availHeight= "+window.screen.availHeight+"\n"+
 
"availWidth= "+window.screen.availWidth+"\n"+
 
"bufferDepth= "+window.screen.bufferDepth+"\n"+
 
"colorDepth= "+window.screen.colorDepth+"\n"+
 
"colorEnable= "+window.navigator.cookieEnabled+"\n"+
 
"cpuClass= "+window.navigator.cpuClass+"\n"+
 
"height= "+window.screen.height+"\n"+
 
"javaEnable= "+window.navigator.javaEnabled()+"\n"+
 
"platform= "+window.navigator.platform+"\n"+
 
"systemLanguage= "+window.navigator.systemLanguage+"\n"+
 
"userLanguage= "+window.navigator.userLanguage+"\n"+
 
"width= "+window.screen.width;
 
alert(strClientInfo);
 
}
 
 
 
</script>
 
 
 
//另存为excel文件并写入值
 
function saveas(){
 
var ExcelApp = new ActiveXObject("Excel.Application");
 
var ExcelSheet = new ActiveXObject("Excel.Sheet")
 
ExcelSheet.Application.Visible = true;
 
ExcelSheet.ActiveSheet.Cells(1,1).Value = "This is column A, row 1";
 
ExcelSheet.SaveAs("C:\\TEST.XLS");
 
ExcelSheet.Application.Quit();
 
alert('ok')；
 
}
 
```

