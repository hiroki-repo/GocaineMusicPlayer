#ifndef _GOCAINE_FLACTAG_READER_
#module _GOCAINE_FLACTAG_READER_
#define BE2LE32(%1) ((((%1>>(8*0))&0xFF)<<(8*3))|(((%1>>(8*1))&0xFF)<<(8*2))|(((%1>>(8*2))&0xFF)<<(8*1))|(((%1>>(8*3))&0xFF)<<(8*0)))
#define BE2LE24(%1) ((((%1>>(8*0))&0xFF)<<(8*2))|(((%1>>(8*1))&0xFF)<<(8*1))|(((%1>>(8*2))&0xFF)<<(8*0)))
#deffunc GetFLACArray str prm_0,array prm_1
exist prm_0
strsize2=strsize
if strsize2=-1{return -1}
sdim flactag,strsize2
bload prm_0,flactag
if lpeek(flactag,0)!0x43614c66{sdim flactag,64:return -1}
repeat strsize2
metatype=peek(flactag,cnt+4)
artmp=lpeek(flactag,cnt+4)&0xFFFFFF00
artmp=BE2LE32(artmp)
if (metatype&0x7F)=4{
	cnt2=cnt
	cntx=0
	repeat artmp
	sizeoftaginfos=lpeek(flactag,cnt2+4+4+cnt)
	sdim stringoftags,sizeoftaginfos
	if (cnt>=1){
		memcpy stringoftags,flactag,sizeoftaginfos,0,cnt2+4+4+cnt+4
		sdim stringoftagss,4096,2
		split stringoftags,"=",stringoftagss
		strsizeofvar=varsize(prm_1(cntx,0))
		if strsizeofvar<=varsize(stringoftagss(0)){strsizeofvar=varsize(stringoftagss(0))}
		memcpy prm_1(cntx,0),stringoftagss(0),strsizeofvar,0,0
		repeat strlen(prm_1(cntx,0)):if peek(prm_1(cntx,0),cnt)>='a' and peek(prm_1(cntx,0),cnt)<='z'{poke prm_1(cntx,0),cnt,peek(prm_1(cntx,0),cnt)-32}:loop
		memcpy prm_1(cntx,1),stringoftagss(1),strsizeofvar,0,0
		cntx++
	}
	continue cnt+sizeoftaginfos+4+((cnt=0)*4)
	loop
	break
}
if (metatype&0x80){break}
continue cnt+artmp+4
loop
sdim flactag,64
return 0
#global
#endif
