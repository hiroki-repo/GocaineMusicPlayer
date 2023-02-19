#ifndef _GOCAINE_OGGTAG_READER_
#module _GOCAINE_OGGTAG_READER_
#define BE2LE32(%1) ((((%1>>(8*0))&0xFF)<<(8*3))|(((%1>>(8*1))&0xFF)<<(8*2))|(((%1>>(8*2))&0xFF)<<(8*1))|(((%1>>(8*3))&0xFF)<<(8*0)))
#define BE2LE24(%1) ((((%1>>(8*0))&0xFF)<<(8*2))|(((%1>>(8*1))&0xFF)<<(8*1))|(((%1>>(8*2))&0xFF)<<(8*0)))
#deffunc GetOGGArray str prm_0,array prm_1
vorbisheader="vorbis"
vorbisheader4chk=""
exist prm_0
strsize2=strsize
if strsize2=-1{return -1}
sdim oggtag,strsize2
bload prm_0,oggtag
if lpeek(oggtag,0)!0x5367674f{sdim oggtag,64:return -1}
repeat strsize2-11
metatype=peek(oggtag,cnt+4)
//artmp=lpeek(oggtag,cnt+4)&0xFFFFFF00
//artmp=BE2LE32(artmp)
wpoke vorbisheader4chk,6,0
memcpy vorbisheader4chk,oggtag,6,0,cnt+4+1
if vorbisheader4chk="vorbis"{
if (metatype)=3{
	cnt2=cnt
	cntx=0
	repeat strsize2-cnt2
	sizeoftaginfos=lpeek(oggtag,cnt2+4+1+6+cnt)
	if (peek(oggtag,cnt2+4+1+6+cnt)=0x1) & (peek(oggtag,cnt2+4+1+6+cnt)!sizeoftaginfos){cnt4add=cnt:break}
	sdim stringoftags,sizeoftaginfos
	if (cnt>=1){
		if (varsize(oggtag)-(cnt2+4+1+6+cnt+4))<=sizeoftaginfos{
			memcpy stringoftags,oggtag,(varsize(oggtag)-(cnt2+4+1+6+cnt+4)),0,cnt2+4+1+6+cnt+4
		}else{
			memcpy stringoftags,oggtag,sizeoftaginfos,0,cnt2+4+1+6+cnt+4
		}
		if stringoftags=""{break}
		sdim stringoftagss,4096,2
		split stringoftags,"=",stringoftagss
		strsizeofvar=varsize(prm_1(cntx,0))
		if strsizeofvar<=varsize(stringoftagss(0)){strsizeofvar=varsize(stringoftagss(0))}
		memcpy prm_1(cntx,0),stringoftagss(0),strsizeofvar,0,0
		repeat strlen(prm_1(cntx,0)):if peek(prm_1(cntx,0),cnt)>='a' and peek(prm_1(cntx,0),cnt)<='z'{poke prm_1(cntx,0),cnt,peek(prm_1(cntx,0),cnt)-32}:loop
		memcpy prm_1(cntx,1),stringoftagss(1),strsizeofvar,0,0
		cntx++
		if prm_1(cntx-1,0)="METADATA_BLOCK_PICTURE"{break}
	}
	continue cnt+sizeoftaginfos+4+((cnt=0)*4)
	loop
	break
}
}
//continue cnt+artmp+4
loop
sdim oggtag,64
return 0
#global
#endif
