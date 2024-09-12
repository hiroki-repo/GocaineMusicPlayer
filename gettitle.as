#ifndef _GOCAINE_IDCHK_
#include "id3.as"
#include "flac.as"
#include "ogg.as"
#include "m4a.as"
#include "encode.as"

#define global ctype    utf16n2sjis(%1)        _ToSJIS@mod_encode(%1, CODEPAGE_UNICODE,  CODEPAGE_S_JIS)
#define global ctype    utf16ben2sjis(%1)        _ToSJIS@mod_encode(%1, CODEPAGE_UNICODE_BE,  CODEPAGE_S_JIS)

#module _GOCAINE_IDCHK_
#define BE2LE32(%1) ((((%1>>(8*0))&0xFF)<<(8*3))|(((%1>>(8*1))&0xFF)<<(8*2))|(((%1>>(8*2))&0xFF)<<(8*1))|(((%1>>(8*3))&0xFF)<<(8*0)))
#define BE2LE24(%1) ((((%1>>(8*0))&0xFF)<<(8*2))|(((%1>>(8*1))&0xFF)<<(8*1))|(((%1>>(8*2))&0xFF)<<(8*0)))
#deffunc GetTagArray str prm_0_str,array prm_1_array
statue=-1
GetID3Array prm_0_str,prm_1_array
statue=stat
if statue=-1{
GetFLACArray prm_0_str,prm_1_array
statue=stat
if statue=-1{
GetOGGArray prm_0_str,prm_1_array
statue=stat
if statue=-1{
GetM4AArray prm_0_str,prm_1_array
statue=stat
}
}
}
return statue
#defcfunc GetTitleName array prm_0
flac=0
sdim data,4096
sdim data4trans,4096
memset data,0,4096,0:memset data4trans,0,4096,0:sdim result,64
result=""
cntx=-1
repeat length(prm_0):if prm_0(cnt,0)="TIT2"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="TT2"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="TITLE"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="©nam"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if flac=1{result=utf8n2sjis@(data)}else{
if peek(data,0)<32{
memcpy data4trans,data,4095,0,1
result=data4trans
if peek(data,0)==0{result=eucjp2sjis@(data4trans)}
if peek(data,0)==1{memcpy data4trans,data,4093,0,3:result=utf16n2sjis(data4trans)}
if peek(data,0)==2{memcpy data4trans,data,4093,0,3:result=utf16ben2sjis(data4trans)}
if peek(data,0)==3{result=utf8n2sjis@(data4trans)}
}
}
return result
#defcfunc GetArtistName array prm_0
flac=0
sdim data,4096
sdim data4trans,4096
memset data,0,4096,0:memset data4trans,0,4096,0:sdim result,64
result=""
cntx=-1
repeat length(prm_0):if prm_0(cnt,0)="TPE1"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="TP1"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="ARTIST"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="©ART"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if flac=1{result=utf8n2sjis@(data)}else{
if peek(data,0)<32{
memcpy data4trans,data,4095,0,1
result=data4trans
if peek(data,0)==0{result=eucjp2sjis@(data4trans)}
if peek(data,0)==1{memcpy data4trans,data,4093,0,3:result=utf16n2sjis(data4trans)}
if peek(data,0)==2{memcpy data4trans,data,4093,0,3:result=utf16ben2sjis(data4trans)}
if peek(data,0)==3{result=utf8n2sjis@(data4trans)}
}
}
if result=""{
sdim data,4096
sdim data4trans,4096
memset data,0,4096,0:memset data4trans,0,4096,0:sdim result,64
cntx=-1
result=""
repeat length(prm_0):if prm_0(cnt,0)="TPE2"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="TP2"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="ALBUMARTIST"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if flac=1{result=utf8n2sjis@(data)}else{
if peek(data,0)<32{
memcpy data4trans,data,4095,0,1
result=data4trans
if peek(data,0)==0{result=eucjp2sjis@(data4trans)}
if peek(data,0)==1{memcpy data4trans,data,4093,0,3:result=utf16n2sjis(data4trans)}
if peek(data,0)==2{memcpy data4trans,data,4093,0,3:result=utf16ben2sjis(data4trans)}
if peek(data,0)==3{result=utf8n2sjis@(data4trans)}
}
}
}
if result=""{
sdim data,4096
sdim data4trans,4096
memset data,0,4096,0:memset data4trans,0,4096,0:sdim result,64
cntx=-1
result=""
repeat length(prm_0):if prm_0(cnt,0)="TOPE"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="TOA"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="ALBUMARTIST"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="©ART"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if flac=1{result=utf8n2sjis@(data)}else{
if peek(data,0)<32{
memcpy data4trans,data,4095,0,1
result=data4trans
if peek(data,0)==0{result=eucjp2sjis@(data4trans)}
if peek(data,0)==1{memcpy data4trans,data,4093,0,3:result=utf16n2sjis(data4trans)}
if peek(data,0)==2{memcpy data4trans,data,4093,0,3:result=utf16ben2sjis(data4trans)}
if peek(data,0)==3{result=utf8n2sjis@(data4trans)}
}
}
}
return result
#defcfunc GetPublisherName array prm_0
flac=0
sdim data,4096
sdim data4trans,4096
memset data,0,4096,0:memset data4trans,0,4096,0:sdim result,64
result=""
cntx=-1
repeat length(prm_0):if prm_0(cnt,0)="TPUB"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="TPB"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="ORGANIZATION"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if flac=1{result=utf8n2sjis@(data)}else{
if peek(data,0)<32{
memcpy data4trans,data,4095,0,1
result=data4trans
if peek(data,0)==0{result=eucjp2sjis@(data4trans)}
if peek(data,0)==1{memcpy data4trans,data,4093,0,3:result=utf16n2sjis(data4trans)}
if peek(data,0)==2{memcpy data4trans,data,4093,0,3:result=utf16ben2sjis(data4trans)}
if peek(data,0)==3{result=utf8n2sjis@(data4trans)}
}
}
return result
#defcfunc GetReleasedDate array prm_0
flac=0
sdim data,4096
sdim data4trans,4096
memset data,0,4096,0:memset data4trans,0,4096,0:sdim result,64
result=""
cntx=-1
repeat length(prm_0):if prm_0(cnt,0)="TDRL"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="DATE"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="©day"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if flac=1{result=utf8n2sjis@(data)}else{
if peek(data,0)<32{
memcpy data4trans,data,4095,0,1
result=data4trans
if peek(data,0)==0{result=eucjp2sjis@(data4trans)}
if peek(data,0)==1{memcpy data4trans,data,4093,0,3:result=utf16n2sjis(data4trans)}
if peek(data,0)==2{memcpy data4trans,data,4093,0,3:result=utf16ben2sjis(data4trans)}
if peek(data,0)==3{result=utf8n2sjis@(data4trans)}
}
}
return result
#defcfunc GetReleasedYear array prm_0
flac=0
sdim data,4096
sdim data4trans,4096
memset data,0,4096,0:memset data4trans,0,4096,0:sdim result,64
result=""
cntx=-1
repeat length(prm_0):if prm_0(cnt,0)="TYER"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="TYE"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="YEAR"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if flac=1{result=utf8n2sjis@(data)}else{
if peek(data,0)<32{
memcpy data4trans,data,4095,0,1
result=data4trans
if peek(data,0)==0{result=eucjp2sjis@(data4trans)}
if peek(data,0)==1{memcpy data4trans,data,4093,0,3:result=utf16n2sjis(data4trans)}
if peek(data,0)==2{memcpy data4trans,data,4093,0,3:result=utf16ben2sjis(data4trans)}
if peek(data,0)==3{result=utf8n2sjis@(data4trans)}
}
}
if result=""{
sdim data,4096
sdim data4trans,4096
memset data,0,4096,0:memset data4trans,0,4096,0:sdim result,64
result=""
cntx=-1
repeat length(prm_0):if prm_0(cnt,0)="TDRL"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="DATE"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="©day"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if flac=1{result=utf8n2sjis@(data)}else{
if peek(data,0)<32{
memcpy data4trans,data,4095,0,1
result=data4trans
if peek(data,0)==0{result=eucjp2sjis@(data4trans)}
if peek(data,0)==1{memcpy data4trans,data,4093,0,3:result=utf16n2sjis(data4trans)}
if peek(data,0)==2{memcpy data4trans,data,4093,0,3:result=utf16ben2sjis(data4trans)}
if peek(data,0)==3{result=utf8n2sjis@(data4trans)}
}
}
if ((peek(result,0)&0xF0)=0x30) & ((peek(result,0)&0x0F)<=0x9){result=strmid(result,0,4)}else{result=strmid(result,1,4)}
}
return result
#defcfunc GetTrackNumber array prm_0
flac=0
sdim data,4096
sdim data4trans,4096
memset data,0,4096,0:memset data4trans,0,4096,0:sdim result,64
result=""
cntx=-1
repeat length(prm_0):if prm_0(cnt,0)="TRCK"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="TRK"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="TRACKNUMBER"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="trkn"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:trkid=lpeek(data,0):trkid=BE2LE32(trkid):data=str(trkid):break}:loop:flac=1}
if flac=1{result=utf8n2sjis@(data)}else{
if peek(data,0)<32{
memcpy data4trans,data,4095,0,1
result=data4trans
if peek(data,0)==0{result=eucjp2sjis@(data4trans)}
if peek(data,0)==1{memcpy data4trans,data,4093,0,3:result=utf16n2sjis(data4trans)}
if peek(data,0)==2{memcpy data4trans,data,4093,0,3:result=utf16ben2sjis(data4trans)}
if peek(data,0)==3{result=utf8n2sjis@(data4trans)}
}
}
return result
#defcfunc GetISRC array prm_0
flac=0
sdim data,4096
sdim data4trans,4096
memset data,0,4096,0:memset data4trans,0,4096,0:sdim result,64
result=""
cntx=-1
repeat length(prm_0):if prm_0(cnt,0)="TSRC"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="TRC"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="ISRC"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if flac=1{result=utf8n2sjis@(data)}else{
if peek(data,0)<32{
memcpy data4trans,data,4095,0,1
result=data4trans
if peek(data,0)==0{result=eucjp2sjis@(data4trans)}
if peek(data,0)==1{memcpy data4trans,data,4093,0,3:result=utf16n2sjis(data4trans)}
if peek(data,0)==2{memcpy data4trans,data,4093,0,3:result=utf16ben2sjis(data4trans)}
if peek(data,0)==3{result=utf8n2sjis@(data4trans)}
}
}
return result
#defcfunc GetAlbumName array prm_0
flac=0
sdim data,4096
sdim data4trans,4096
memset data,0,4096,0:memset data4trans,0,4096,0:sdim result,64
result=""
cntx=-1
repeat length(prm_0):if prm_0(cnt,0)="TALB"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="TAL"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="ALBUM"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="©alb"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if flac=1{result=utf8n2sjis@(data)}else{
if peek(data,0)<32{
memcpy data4trans,data,4095,0,1
result=data4trans
if peek(data,0)==0{result=eucjp2sjis@(data4trans)}
if peek(data,0)==1{memcpy data4trans,data,4093,0,3:result=utf16n2sjis(data4trans)}
if peek(data,0)==2{memcpy data4trans,data,4093,0,3:result=utf16ben2sjis(data4trans)}
if peek(data,0)==3{result=utf8n2sjis@(data4trans)}
}
}
return result
#defcfunc GetAlbumArtistName array prm_0
flac=0
sdim data,4096
sdim data4trans,4096
memset data,0,4096,0:memset data4trans,0,4096,0:sdim result,64
cntx=-1
result=""
repeat length(prm_0):if prm_0(cnt,0)="TPE2"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="TP2"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="ALBUMARTIST"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if flac=1{result=utf8n2sjis@(data)}else{
if peek(data,0)<32{
memcpy data4trans,data,4095,0,1
result=data4trans
if peek(data,0)==0{result=eucjp2sjis@(data4trans)}
if peek(data,0)==1{memcpy data4trans,data,4093,0,3:result=utf16n2sjis(data4trans)}
if peek(data,0)==2{memcpy data4trans,data,4093,0,3:result=utf16ben2sjis(data4trans)}
if peek(data,0)==3{result=utf8n2sjis@(data4trans)}
}
}
if result=""{
sdim data,4096
sdim data4trans,4096
memset data,0,4096,0:memset data4trans,0,4096,0:sdim result,64
cntx=-1
result=""
repeat length(prm_0):if prm_0(cnt,0)="TPE1"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="TP1"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="ARTIST"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="©ART"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if flac=1{result=utf8n2sjis@(data)}else{
if peek(data,0)<32{
memcpy data4trans,data,4095,0,1
result=data4trans
if peek(data,0)==0{result=eucjp2sjis@(data4trans)}
if peek(data,0)==1{memcpy data4trans,data,4093,0,3:result=utf16n2sjis(data4trans)}
if peek(data,0)==2{memcpy data4trans,data,4093,0,3:result=utf16ben2sjis(data4trans)}
if peek(data,0)==3{result=utf8n2sjis@(data4trans)}
}
}
}
if result=""{
sdim data,4096
sdim data4trans,4096
memset data,0,4096,0:memset data4trans,0,4096,0:sdim result,64
cntx=-1
result=""
repeat length(prm_0):if prm_0(cnt,0)="TOPE"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="TOA"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="ALBUMARTIST"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if flac=1{result=utf8n2sjis@(data)}else{
if peek(data,0)<32{
memcpy data4trans,data,4095,0,1
result=data4trans
if peek(data,0)==0{result=eucjp2sjis@(data4trans)}
if peek(data,0)==1{memcpy data4trans,data,4093,0,3:result=utf16n2sjis(data4trans)}
if peek(data,0)==2{memcpy data4trans,data,4093,0,3:result=utf16ben2sjis(data4trans)}
if peek(data,0)==3{result=utf8n2sjis@(data4trans)}
}
}
}
return result
#defcfunc GetDiscNumber array prm_0
flac=0
sdim data,4096
sdim data4trans,4096
memset data,0,4096,0:memset data4trans,0,4096,0:sdim result,64
result=""
cntx=-1
repeat length(prm_0):if prm_0(cnt,0)="TPOS"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="TPA"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="DISCNUMBER"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="dskn"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:trkid=lpeek(data,0):trkid=BE2LE32(trkid):data=str(trkid):break}:loop:flac=1}
if flac=1{result=utf8n2sjis@(data)}else{
if peek(data,0)<32{
memcpy data4trans,data,4095,0,1
result=data4trans
if peek(data,0)==0{result=eucjp2sjis@(data4trans)}
if peek(data,0)==1{memcpy data4trans,data,4093,0,3:result=utf16n2sjis(data4trans)}
if peek(data,0)==2{memcpy data4trans,data,4093,0,3:result=utf16ben2sjis(data4trans)}
if peek(data,0)==3{result=utf8n2sjis@(data4trans)}
}
}
return result
#defcfunc GetCopyRightsInfo array prm_0
flac=0
sdim data,4096
sdim data4trans,4096
memset data,0,4096,0:memset data4trans,0,4096,0:sdim result,64
result=""
cntx=-1
repeat length(prm_0):if prm_0(cnt,0)="TCOP"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="TCR"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="COPYRIGHT"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if flac=1{result=utf8n2sjis@(data)}else{
if peek(data,0)<32{
memcpy data4trans,data,4095,0,1
result=data4trans
if peek(data,0)==0{result=eucjp2sjis@(data4trans)}
if peek(data,0)==1{memcpy data4trans,data,4093,0,3:result=utf16n2sjis(data4trans)}
if peek(data,0)==2{memcpy data4trans,data,4093,0,3:result=utf16ben2sjis(data4trans)}
if peek(data,0)==3{result=utf8n2sjis@(data4trans)}
}
}
return result
#defcfunc GetLicenseInfo array prm_0
flac=0
sdim data,4096
sdim data4trans,4096
memset data,0,4096,0:memset data4trans,0,4096,0:sdim result,64
result=""
cntx=-1
repeat length(prm_0):if prm_0(cnt,0)="WCOP"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="WCP"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="LICENSE"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if flac=1{result=utf8n2sjis@(data)}else{
if peek(data,0)<32{
memcpy data4trans,data,4095,0,1
result=data4trans
if peek(data,0)==0{result=eucjp2sjis@(data4trans)}
if peek(data,0)==1{memcpy data4trans,data,4093,0,3:result=utf16n2sjis(data4trans)}
if peek(data,0)==2{memcpy data4trans,data,4093,0,3:result=utf16ben2sjis(data4trans)}
if peek(data,0)==3{result=utf8n2sjis@(data4trans)}
}
}
return result
#defcfunc GetOfficialWebsiteInfo array prm_0
flac=0
sdim data,4096
sdim data4trans,4096
memset data,0,4096,0:memset data4trans,0,4096,0:sdim result,64
result=""
cntx=-1
repeat length(prm_0):if prm_0(cnt,0)="WOAF"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="WAF"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="CONTACT"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if flac=1{result=utf8n2sjis@(data)}else{
if peek(data,0)<32{
memcpy data4trans,data,4095,0,1
result=data4trans
if peek(data,0)==0{result=eucjp2sjis@(data4trans)}
if peek(data,0)==1{memcpy data4trans,data,4093,0,3:result=utf16n2sjis(data4trans)}
if peek(data,0)==2{memcpy data4trans,data,4093,0,3:result=utf16ben2sjis(data4trans)}
if peek(data,0)==3{result=utf8n2sjis@(data4trans)}
}
}
return result
#defcfunc GetArtistWebsiteInfo array prm_0
flac=0
sdim data,4096
sdim data4trans,4096
memset data,0,4096,0:memset data4trans,0,4096,0:sdim result,64
result=""
cntx=-1
repeat length(prm_0):if prm_0(cnt,0)="WOAR"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="WAR"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="CONTACT"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if flac=1{result=utf8n2sjis@(data)}else{
if peek(data,0)<32{
memcpy data4trans,data,4095,0,1
result=data4trans
if peek(data,0)==0{result=eucjp2sjis@(data4trans)}
if peek(data,0)==1{memcpy data4trans,data,4093,0,3:result=utf16n2sjis(data4trans)}
if peek(data,0)==2{memcpy data4trans,data,4093,0,3:result=utf16ben2sjis(data4trans)}
if peek(data,0)==3{result=utf8n2sjis@(data4trans)}
}
}
return result
#defcfunc GetSourceWebsiteInfo array prm_0
flac=0
sdim data,4096
sdim data4trans,4096
memset data,0,4096,0:memset data4trans,0,4096,0:sdim result,64
result=""
cntx=-1
repeat length(prm_0):if prm_0(cnt,0)="WOAS"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="WAS"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="CONTACT"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if flac=1{result=utf8n2sjis@(data)}else{
if peek(data,0)<32{
memcpy data4trans,data,4095,0,1
result=data4trans
if peek(data,0)==0{result=eucjp2sjis@(data4trans)}
if peek(data,0)==1{memcpy data4trans,data,4093,0,3:result=utf16n2sjis(data4trans)}
if peek(data,0)==2{memcpy data4trans,data,4093,0,3:result=utf16ben2sjis(data4trans)}
if peek(data,0)==3{result=utf8n2sjis@(data4trans)}
}
}
return result
#defcfunc GetPublisherWebsiteInfo array prm_0
flac=0
sdim data,4096
sdim data4trans,4096
memset data,0,4096,0:memset data4trans,0,4096,0:sdim result,64
result=""
cntx=-1
repeat length(prm_0):if prm_0(cnt,0)="WPUB"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="WPB"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="CONTACT"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if flac=1{result=utf8n2sjis@(data)}else{
if peek(data,0)<32{
memcpy data4trans,data,4095,0,1
result=data4trans
if peek(data,0)==0{result=eucjp2sjis@(data4trans)}
if peek(data,0)==1{memcpy data4trans,data,4093,0,3:result=utf16n2sjis(data4trans)}
if peek(data,0)==2{memcpy data4trans,data,4093,0,3:result=utf16ben2sjis(data4trans)}
if peek(data,0)==3{result=utf8n2sjis@(data4trans)}
}
}
return result
#defcfunc GetAudioComment array prm_0
flac=0
sdim data,4096
sdim data4trans,4096
memset data,0,4096,0:memset data4trans,0,4096,0:sdim result,64
result=""
cntx=-1
repeat length(prm_0):if prm_0(cnt,0)="COMM"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="COM"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="DESCRIPTION"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if flac=1{result=utf8n2sjis@(data)}else{
if peek(data,0)<32{
memcpy data4trans,data,4095,0,1
result=data4trans
if peek(data,0)==0{result=eucjp2sjis@(data4trans)}
if peek(data,0)==1{memcpy data4trans,data,4093,0,3:result=utf16n2sjis(data4trans)}
if peek(data,0)==2{memcpy data4trans,data,4093,0,3:result=utf16ben2sjis(data4trans)}
if peek(data,0)==3{result=utf8n2sjis@(data4trans)}
}
}
return result
#defcfunc GetAudioLyrics array prm_0
flac=0
sdim data,4096
sdim data4trans,4096
memset data,0,4096,0:memset data4trans,0,4096,0:sdim result,64
result=""
cntx=-1
repeat length(prm_0):if prm_0(cnt,0)="USLT"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="ULT"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="SYLT"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="SLT"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="LYRICS"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if cntx=-1{repeat length(prm_0):if prm_0(cnt,0)="UNSYNCEDLYRICS"{cntx=cnt:memcpy data,prm_0(cnt,1),varsize(prm_0(cnt,1)),0,0:break}:loop:flac=1}
if flac=1{result=utf8n2sjis@(data)}else{
if peek(data,0)<32{
memcpy data4trans,data,4095-3,0,1+3
result=data4trans
if peek(data,0)==0{result=eucjp2sjis@(data4trans):if result=""{memcpy data4trans,data,4095-(3+1),0,1+3+1:result=eucjp2sjis@(data4trans)}}
if peek(data,0)==1{memcpy data4trans,data4trans,4093,0,2:result=utf16n2sjis(data4trans):if result=""{memcpy data4trans,data,4095-(3+4+2),0,1+3+4+2:result=utf16n2sjis(data4trans)}}
if peek(data,0)==2{memcpy data4trans,data4trans,4093,0,2:result=utf16ben2sjis(data4trans):if result=""{memcpy data4trans,data,4095-(3+4+2),0,1+3+4+2:result=utf16ben2sjis(data4trans)}}
if peek(data,0)==3{result=utf8n2sjis@(data4trans):if result=""{memcpy data4trans,data,4095-(3+1),0,1+3+1:result=utf8n2sjis@(data4trans)}}
}
}
if strmid(result,0,1)!="["{result="[00:00:00] "+result}
return result
#deffunc PicAudioLoad  str prm_0_str,int prm_1_int
statue=-1
PicID3Load prm_0_str,prm_1_int
statue=stat
if statue=-1{
PicFLACLoad prm_0_str,prm_1_int
statue=stat
}
return statue
#global
#endif
