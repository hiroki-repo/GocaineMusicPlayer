#ifndef _GOCAINE_FLACTAG_READER_
#module _GOCAINE_FLACTAG_READER_
#define BE2LE32(%1) ((((%1>>(8*0))&0xFF)<<(8*3))|(((%1>>(8*1))&0xFF)<<(8*2))|(((%1>>(8*2))&0xFF)<<(8*1))|(((%1>>(8*3))&0xFF)<<(8*0)))
#define BE2LE24(%1) ((((%1>>(8*0))&0xFF)<<(8*2))|(((%1>>(8*1))&0xFF)<<(8*1))|(((%1>>(8*2))&0xFF)<<(8*0)))
#deffunc GetFLACArray str prm_0,array prm_1
loadedflacpicture=0
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
	sdim stringoftags,sizeoftaginfos+1
	memset stringoftags,0,sizeoftaginfos+1,0
	if (cnt>=1){
		memcpy stringoftags,flactag,sizeoftaginfos,0,cnt2+4+4+cnt+4
		sdim stringoftagss,4096,2:memset stringoftagss(0),0,4096,0:memset stringoftagss(1),0,4096,0
		split stringoftags,"=",stringoftagss
		strsizeofvar=varsize(prm_1(cntx,0))
		if strsizeofvar<=strlen(stringoftagss(0)){strsizeofvar=strlen(stringoftagss(0))}
		memcpy prm_1(cntx,0),stringoftagss(0),strsizeofvar,0,0
		if varsize(prm_1(cntx,0))>(strsizeofvar+3){lpoke prm_1(cntx,0),strsizeofvar,0}else{if varsize(prm_1(cntx,0))>(strsizeofvar){poke prm_1(cntx,0),strsizeofvar,0}}
		repeat strlen(prm_1(cntx,0)):if peek(prm_1(cntx,0),cnt)>='a' and peek(prm_1(cntx,0),cnt)<='z'{poke prm_1(cntx,0),cnt,peek(prm_1(cntx,0),cnt)-32}:loop
		memcpy prm_1(cntx,1),stringoftagss(1),strsizeofvar,0,0
		if varsize(prm_1(cntx,1))>(strsizeofvar+3){lpoke prm_1(cntx,1),strsizeofvar,0}else{if varsize(prm_1(cntx,1))>(strsizeofvar){poke prm_1(cntx,1),strsizeofvar,0}}
		cntx++
	}
	continue cnt+sizeoftaginfos+4+((cnt=0)*4)
	loop
	//break
}else{
if (metatype&0x7F)=6{
	imgfiletype=BE2LE32(lpeek(flactag,cnt+4+4))
	if imgfiletype=3{
		sdim pictureofmp3,artmp
		memcpy pictureofmp3,flactag,artmp,0,cnt+4+4
		loadedflacpicture=1
	}
}
}
if (metatype&0x80){break}
continue cnt+artmp+4
loop
sdim flactag,64
return 0
#deffunc PicFLACLoad str prm_0_picloader,int prm_1_picloader
sdim temp,4096,256,2
GetFLACArray prm_0_picloader,temp
sdim temp,64
if loadedflacpicture=0{return -1}
sdim minetype,64
minetypesize=BE2LE32(lpeek(pictureofmp3,4))
memcpy minetype,pictureofmp3,minetypesize,0,8
descriptionsize=BE2LE32(lpeek(pictureofmp3,8+minetypesize))
imagesize=BE2LE32(lpeek(pictureofmp3,8+minetypesize+4+descriptionsize+16))
posofimage=8+minetypesize+4+descriptionsize+16+4
magic=0
magicmask=0xFF
switch minetype
case "image/vnd.microsoft.icon"
magic=0x00010000
magicmask=0xffffffff
swbreak
case "image/bmp"
magic=0x00004d42
magicmask=0xffff
swbreak
case "image/jpeg"
magic=0x00ffd8ff
magicmask=0xffffff
swbreak
case "image/png"
magic=0x474e5089
magicmask=0xffffffff
swbreak
case "image/gif"
magic=0x38464947
magicmask=0xffffffff
swbreak
swend
sdim pictureofmp3x,imagesize
memcpy pictureofmp3x,pictureofmp3,imagesize,0,posofimage
memfile pictureofmp3x
switch minetype
case "image/vnd.microsoft.icon"
picload "MEM:a.ico",prm_1_picloader
swbreak
case "image/bmp"
picload "MEM:a.bmp",prm_1_picloader
swbreak
case "image/jpeg"
picload "MEM:a.jpg",prm_1_picloader
swbreak
case "image/png"
picload "MEM:a.png",prm_1_picloader
swbreak
case "image/gif"
picload "MEM:a.gif",prm_1_picloader
swbreak
swend
sdim pictureofmp3x,64
return 0
#global
#endif
