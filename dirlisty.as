#module
#uselib "kernel32.dll"
#func __FindFirstFileA "FindFirstFileA" int,int
#func __FindNextFileA "FindNextFileA" int,int
#deffunc dirlisty var prm_0,str prm_1,int prm_2
prm_0=""
attr=0
counts=0
if (prm_2&1) {attr|=16}
if (prm_2&2) {attr|=6}
FileName=prm_1
sdim FileName4list,4096
__FindFirstFileA varptr(FileName),varptr(FileName4list)
hFind=stat
dupptr FileName4listx,varptr(FileName4list)+0x2c,2048,2
repeat
__FindNextFileA hFind,varptr(FileName4list)
if stat=0{break}
if ((lpeek(FileName4list,0)&attr)!0)=((prm_2&4)!0){
if FileName4listx!=".."{
prm_0+=FileName4listx+"\n"
counts++
}
}
loop
return counts
#global
