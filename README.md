# CdpSvcLPE
Windows Local Privilege Escalation via CdpSvc service (Writeable SYSTEM path Dll Hijacking)

#### Short Description:
Connected Devices Platform Service (or CDPSvc) is a service which runs as `NT AUTHORITY\LOCAL SERVICE` and tries to load the missing **cdpsgshims.dll** DLL on startup with a call to `LoadLibrary()`, without specifying its absolute path. So, it can be hijack dll in the folder of Dll Search Order flow and we will get process or shell access with `NT AUTHORITY\LOCAL SERVICE` if we hijack the dll in SYSTEM PATH writable place such as `C:\python27`. Then, I just combine it with [@itm4n](https://twitter.com/itm4n)'s [PrintSpoofer](https://github.com/itm4n/PrintSpoofer) technique to get `NT AUTHORITY\SYSTEM` access.

#### Usage:
1. Find Writable SYSTEM PATH with acltest.ps1 (such as C:\python27)<br>
`C:\CdpSvcLPE> powershell -ep bypass ". .\acltest.ps1"`<br>
2. Copy cdpsgshims.dll to C:\python27 <br>
3. make C:\temp folder and copy impersonate.bin to C:\temp <br>
`C:\CdpSvcLPE> mkdir C:\temp`<br>
`C:\CdpSvcLPE> copy impersonate.bin C:\temp`<br>
4. Reboot (or stop/start CDPSvc as an administrator)<br>
5. cmd wil prompt up with `nt authority\system`.<br>

**Youtube**: https://youtu.be/Jfxfsc04H5o

![test1](https://github.com/sailay1996/CdpSvcLPE/blob/main/cdpsvcLPE_gif.gif)

**\m/ Note**: when you got system cmd prompt, stop the cdpsvc service and delete dll file and bin file.

**by [@404death](https://twitter.com/404death)**

#### Ref: <br>
http://zeifan.my/security/eop/2019/11/05/windows-service-host-process-eop.html <br>
https://itm4n.github.io/cdpsvc-dll-hijacking/ <br>
https://itm4n.github.io/printspoofer-abusing-impersonate-privileges/ <br>
https://github.com/itm4n/PrintSpoofer <br>
https://gist.github.com/wdormann/eb714d1d935bf454eb419a34be266f6f

