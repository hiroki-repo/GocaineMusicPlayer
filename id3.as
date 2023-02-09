#ifndef _GOCAINE_ID3MOD_
#module _GOCAINE_ID3MOD_
#define BE2LE32(%1) ((((%1>>(8*0))&0xFF)<<(8*3))|(((%1>>(8*1))&0xFF)<<(8*2))|(((%1>>(8*2))&0xFF)<<(8*1))|(((%1>>(8*3))&0xFF)<<(8*0)))
#define BE2LE24(%1) ((((%1>>(8*0))&0xFF)<<(8*2))|(((%1>>(8*1))&0xFF)<<(8*1))|(((%1>>(8*2))&0xFF)<<(8*0)))
#deffunc GetID3Data str prm_0,str prm_1,var prm_2
exist prm_0:strsize2=strsize:if strsize2=-1{return -1}
sdim magic,64:bload prm_0,magic,3,0:if magic!="ID3"{return -1}
id3size=0:bload prm_0,id3size,4,6
sdim id3tag,id3size:bload prm_0,id3tag,id3size,0
sdim id3fid,4
repeat id3size-10
wpoke id3fid,3,0
if (wpeek(id3tag,3)=2){
memcpy id3fid,id3tag,3,0,10+cnt
artmp=(lpeek(id3tag,10+cnt+3)&0xFFFFFF)
artmp=BE2LE24(artmp)
if (id3fid=prm_1){memcpy prm_2,id3tag,artmp,0,10+cnt+6:break}
continue cnt+artmp+6
}else{
memcpy id3fid,id3tag,4,0,10+cnt
artmp=lpeek(id3tag,10+cnt+4)
artmp=BE2LE32(artmp)
if (id3fid=prm_1){memcpy prm_2,id3tag,artmp,0,10+cnt+10:break}
continue cnt+artmp+10
}
loop
return 0
#deffunc GetID3Array str prm_0,array prm_1
exist prm_0:strsize2=strsize:if strsize2=-1{return -1}
sdim magic,64:bload prm_0,magic,3,0:if magic!="ID3"{
if strsize2>=128{
sdim id3v1tag,128
sdim id3v1plustag,227
bload prm_0,id3v1tag,128,strsize2-128
sdim id3v1genre,128,256
id3v1genre(0)="Blues","Classic Rock","Country","Dance","Disco","Funk","Grunge","Hip-Hop","Jazz","Metal","New Age","Oldies","Other","Pop","R&B","Rap","Reggae","Rock","Techno","Industrial","Alternative","Ska","Death Metal","Pranks","Soundtrack","Euro-Techno","Ambient","Trip-Hop","Vocal","Jazz-funk","Fusion","Trans","Classical","Instrumental","Acid","House","Game","Sound Clip","Gospel","Noise","Alt. Rock","Bass","Soul","Punk","Space","Meditative","Instrumental pop","Instrumental rock","Ethnic","Gothic","Darkwave","Techno-Industrial","Electronic","Pop-folk","Eurodance","Dream","Southern Rock","Comedy","Cult","Gangsta","Top 40","Christian Rap","Pop/Funk","Jungle","Native American","Cabaret","New Wave","Psychedelic","Rave","Showtunes","Trailer","Lo-Fi","Tribal","Acid Punk","Acid Jazz","Polka","Retro","Musical","Rock & Roll","Hard Rock","Folk","Folk-Rock","National Folk","Swing","Fast Fusion","Bebob","Latin","Revival","Celtic","Bluegrass","Avantgarde","Gothic Rock","Progressive Rock","Psychedelic Rock","Symphonic Rock","Slow Rock","Big Band","Chorus","Easy Listening","Acoustic","Humour","Speech","Chanson","Opera","Chamber Music","Sonata","Symphony","Booty Bass","Primus","Porn Groove","Satire","Slow Jam","Club","Tango","Samba","Folklore","Ballad","Power Ballad","Rhythmic Soul","Freestyle","Duet","Punk Rock","Drum Solo","A capella","Euro-House","Dance Hall","Goa","Drum & Bass","Club-House","Hardcore","Terror","Indie","BritPop","Afro-punk","Polsk Punk","Beat","Christian gangsta rap","Heavy Metal","Black Metal","Crossover","Contemporary Christian","Christian Rock","Merengue","Salsa","Thrash Metal","Anime","JPop","Synthpop","Abstract","ArtRock","Baroque","Bhangra","Big beat","Breakbeat","Chillout","Downtempo","Dub","EBM","Eclectic","Electro","Electroclash","Emo","Experimental","Garage","Global","IDM","Illbient","Industro-Goth","Jam Band","Krautrock","Leftfield","Lounge","Math Rock","New Romantic","Nu-Breakz","Post-Punk","Post-Rock","Psytrance","Shoegaze","Space Rock","Trop Rock","World Music","Neoclassical","Audiobook","Audio theatre","Neue Deutsche Welle","Podcast","Indie-Rock","G-Funk","Dubstep","Garage Rock","Psybient"
if strmid(id3v1tag,0,3)="TAG"{
prm_1(0,0)="TT2"
memcpy prm_1(0,1),id3v1tag,30,0,3
prm_1(1,0)="TP1"
memcpy prm_1(1,1),id3v1tag,30,0,33
prm_1(2,0)="TAL"
memcpy prm_1(2,1),id3v1tag,30,0,63
prm_1(3,0)="TYE"
memcpy prm_1(3,1),id3v1tag,4,0,93
prm_1(4,0)="COM"
memcpy prm_1(4,1),id3v1tag,28,0,97
prm_1(5,0)="TRK"
prm_1(5,1)=str(peek(id3v1tag,126))
prm_1(6,0)="TCO"
prm_1(6,1)=id3v1genre(peek(id3v1tag,127))
if (strsize2>=(128+227)) & (strmid(id3v1plustag,0,4)="TAG+"){
bload prm_0,id3v1plustag,227,strsize2-128-227
prm_1(0,0)="TT2"
memcpy prm_1(0,1),id3v1plustag,60,0,4
prm_1(1,0)="TP1"
memcpy prm_1(1,1),id3v1plustag,60,0,64
prm_1(2,0)="TAL"
memcpy prm_1(2,1),id3v1plustag,60,0,124
prm_1(6,0)="TCO"
memcpy prm_1(6,1),id3v1plustag,30,0,185
}
return 0
}
}
return -1
}
cntx=0
id3size=0:bload prm_0,id3size,4,6:id3size=BE2LE32(id3size)
sdim id3tag,id3size:bload prm_0,id3tag,id3size,0
sdim id3fid,4
repeat id3size-10
wpoke id3fid,3,0
if ((cnt&0x7FFFFFFF)>(id3size-10)) | (cnt&0x80000000){break}
if (wpeek(id3tag,3)=2){
memcpy id3fid,id3tag,3,0,10+cnt
if id3fid=""{break}
artmp=(lpeek(id3tag,10+cnt+3)&0xFFFFFF)
artmp=BE2LE24(artmp)
prm_1(cntx,0)=id3fid
prm_1(cntx,1)=""
if artmp>=varsize(prm_1(cntx,1)){
if (varsize(id3tag)-(10+cnt+6))<=varsize(prm_1(cntx,1)){
memcpy prm_1(cntx,1),id3tag,(varsize(id3tag)-(10+cnt+6)),0,10+cnt+6
}else{
memcpy prm_1(cntx,1),id3tag,varsize(prm_1(cntx,1)),0,10+cnt+6
}
}else{
if (varsize(id3tag)-(10+cnt+6))<=artmp{
memcpy prm_1(cntx,1),id3tag,(varsize(id3tag)-(10+cnt+6)),0,10+cnt+6
}else{
memcpy prm_1(cntx,1),id3tag,artmp,0,10+cnt+6
}
}
cntx++
if length(prm_1)<=cntx{break}
continue cnt+artmp+6
}else{
if (varsize(id3tag)-(10+cnt))<4{break}
memcpy id3fid,id3tag,4,0,10+cnt
if id3fid=""{break}
if (varsize(id3tag)-(10+cnt+4))<4{break}
artmp=lpeek(id3tag,10+cnt+4)
artmp=BE2LE32(artmp)
prm_1(cntx,0)=id3fid
prm_1(cntx,1)=""
if artmp>=varsize(prm_1(cntx,1)){
if (varsize(id3tag)-(10+cnt+10))<=varsize(prm_1(cntx,1)){
memcpy prm_1(cntx,1),id3tag,(varsize(id3tag)-(10+cnt+10)),0,10+cnt+10
}else{
memcpy prm_1(cntx,1),id3tag,varsize(prm_1(cntx,1)),0,10+cnt+10
}
}else{
if (varsize(id3tag)-(10+cnt+10))<=artmp{
memcpy prm_1(cntx,1),id3tag,(varsize(id3tag)-(10+cnt+10)),0,10+cnt+10
}else{
memcpy prm_1(cntx,1),id3tag,artmp,0,10+cnt+10
}
}
cntx++
if length(prm_1)<=cntx{break}
continue cnt+artmp+10
}
loop
sdim id3tag,64
return 0
#global
#endif
