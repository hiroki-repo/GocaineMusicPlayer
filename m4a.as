#ifndef _GOCAINE_M4ATAG_READER_
#module _GOCAINE_M4ATAG_READER_
#define BE2LE32(%1) ((((%1>>(8*0))&0xFF)<<(8*3))|(((%1>>(8*1))&0xFF)<<(8*2))|(((%1>>(8*2))&0xFF)<<(8*1))|(((%1>>(8*3))&0xFF)<<(8*0)))
#define BE2LE24(%1) ((((%1>>(8*0))&0xFF)<<(8*2))|(((%1>>(8*1))&0xFF)<<(8*1))|(((%1>>(8*2))&0xFF)<<(8*0)))
#deffunc GetM4AArray str prm_0,array prm_1
exist prm_0
strsize2=strsize
if strsize2=-1{return -1}
sdim m4atag,strsize2
bload prm_0,m4atag
if lpeek(m4atag,4)!0x70797466{sdim m4atag,64:return -1}
cntx=0:ilst=0
maxsize=-1
sdim tagname,64
repeat strsize2
artmp=lpeek(m4atag,cnt)
artmp=BE2LE32(artmp)
if ((artmp+cnt)<=strsize2) | (artmp+cnt)&0x80000000{break}
lpoke tagname,1,0
memcpy tagname,m4atag,4,0,cnt+4
//if maxsize=-1 and (tagname="moov" | tagname="trak" | tagname="mdia" | tagname="minf"){maxsize=cnt+artmp}
if tagname="ilst"{ilst=1}
if (tagname="moov" | tagname="trak" | tagname="mdia" | tagname="minf" | tagname="stbl" | tagname="udta" | tagname="ilst"){continue cnt+8}
if (tagname="meta"){continue cnt+12}
//if maxsize!-1 and maxsize<=(cnt+artmp){continue cnt+8}
if ilst=1{
lpoke prm_1(cntx,0),1,0
memcpy prm_1(cntx,0),tagname,4,0,0
if artmp>=16{
lpoke tagname,1,0
memcpy tagname,m4atag,4,0,cnt+4+8
}
if tagname="data"{
	if varsize(prm_1(cntx,1))>=(artmp-16-8){
		memcpy prm_1(cntx,1),m4atag,artmp-16-8,0,cnt+16+8
	}else{
		memcpy prm_1(cntx,1),m4atag,varsize(prm_1(cntx,1)),0,cnt+16+8
	}
}else{
	if varsize(prm_1(cntx,1))>=(artmp-8){
		memcpy prm_1(cntx,1),m4atag,artmp-8,0,cnt+8
	}else{
		memcpy prm_1(cntx,1),m4atag,varsize(prm_1(cntx,1)),0,cnt+8
	}
}
cntx++
}
continue cnt+artmp
loop
sdim m4atag,64
return 0
#global
#endif
