10 gosub 800
20 xx=peek(53279)
30 a=peek(197):ts=186
35 print"{home}";x
40 if a=22 then vv=vv-t:ts=183:goto 90
50 if a=18 then hv=hv-hi:ts=184
60 if a=10 then hv=hv+hi:ts=185
70 vv=vv+g:if vv>2 then vv=2
80 if vv<-2 then vv=-2
90 y=(y+vv):x=(x+hv)
100 if y<20 then print"{home}lost in space":goto 730
105 if x<0 then print"{home}lost in space":goto 730
110 xh=int(x/256):xl=x-(xh*256)
120 poke 2041,ts:poke 53250,xl:poke 53251,y
130 poke 53249,y:poke 53248,xl:poke 53246,xh
140 cd=peek(53279)
150 if (cd and 1)=1 then 200
160 goto 30

200 lz=0
220 if y=229 and (x>=64 and x<66) then lz=1:goto 260
230 if y=133 and (x>=144 and x<146) then lz=2:goto 260
240 if y=205 and (x>=265 and x<267) then lz=3:goto 260
250 if lz=0 then 700
260 print"{home}well done commander."
270 goto 270

700 poke 2040,176:poke 53287,7:poke 53276,1
710 for sp=172 to 181:for de=0 to 100:next de:poke 2040,sp:next sp
720 poke 53269,0:print"{home}you crashed"
730 print"game over"
740 goto 740

800 poke 53280,0:poke 53281,0
810 print"{clear}{white}loading..."
820 for i=0 to (16*64)-1:read a:poke 10880+i,a:next i:poke 2040,170:poke 2041,186
830 for i=0 to 335:read a:poke 12288+i,a:next i:poke 53272,28
840 poke 53249,y:poke 53251,y:poke 53248,x:poke 53250,x
850 poke 53287,1:poke 53285,15:poke 53286,11:poke 53288,2:poke 53269,3
860 print"{clear}{white}{down*8}##{down}]^{down}{arrow left}{down}${down}{left}&{down}${down}{left}&{down}{left}%{down}{left}'{down}{left*2}!{down}{left*3}[£{down}{left*3}!{down}{left*2}!{down}{left}{arrow left}{down}{arrow left}{down}{arrow left}{down}{arrow left}{(*3}'{up}{left}%";
870 print"{up}{left}&{up}{left}${up}{left}!{up}!{up}[£{up}!{up}'{up}{left}%{up}'{up}{left}%{up}{(*3}'{up}{left}%{up}{left}{arrow left}{up}{left*2}{arrow left}{up}{left}[£{up}!{up}'{up}{left}%{up}){down}{arrow left}##{down}${down}{left}&{down}${down}{left}&";
880 print"{down}{left}%{down}{left}'{down}{left}${down}{left}&{down}${down}{left}&{down}{left}!{down}{left*2}!{down}{left}${down}{left}&{down}{arrow left}{down}]^{(*4}!]^{down}]^{down}{arrow left}";
890 vv=0:g=3/112:t=3/112:hv=0:hi=1/28:x=60:y=60:return

1000 rem Ship
1010 data 16,0,18,8,126,28,5,255
1020 data 204,6,16,54,15,159,240,8
1030 data 146,16,8,243,240,8,242,16
1040 data 8,244,8,31,254,24,32,1
1050 data 244,32,0,164,39,128,188,39
1060 data 192,164,31,255,252,13,60,176
1070 data 25,195,152,49,0,140,48,0
1080 data 12,120,0,30,204,0,51,0
1090 rem Explosion1
1100 data 0,0,0,0,0,0,0,0
1110 data 0,0,2,128,1,2,0,1
1120 data 2,0,2,106,64,0,106,64
1130 data 0,169,64,0,42,64,0,42
1140 data 128,0,170,128,0,170,128,2
1150 data 154,160,2,106,80,2,128,160
1160 data 2,0,160,0,0,0,0,0
1170 data 0,0,0,0,0,0,0,0
1180 rem Explosion2
1190 data 0,0,0,8,0,160,8,0
1200 data 64,10,32,64,1,165,64,1
1210 data 170,128,2,170,128,42,170,128
1220 data 9,170,64,1,169,64,1,105
1230 data 64,1,106,96,1,106,96,1
1240 data 106,160,2,170,128,2,170,96
1250 data 10,85,96,8,153,96,40,0
1260 data 8,32,0,0,0,0,0,0
1270 rem Explosion3
1280 data 32,2,128,40,10,128,8,154
1290 data 10,9,149,104,1,169,80,9
1300 data 170,144,169,170,144,166,170,160
1310 data 5,106,160,41,106,160,9,170
1320 data 160,41,170,144,41,170,144,6
1330 data 170,152,6,170,152,6,150,144
1340 data 6,101,80,4,37,96,40,37
1350 data 40,160,40,8,128,32,10,0
1360 rem Explosion4
1370 data 40,2,128,42,154,128,9,90
1380 data 128,10,165,96,38,170,80,38
1390 data 170,144,170,170,160,90,170,160
1400 data 90,106,168,150,106,154,38,90
1410 data 150,6,170,166,6,170,168,6
1420 data 170,168,5,170,88,5,106,80
1430 data 5,90,80,42,154,168,24,24
1440 data 40,160,24,40,128,32,10,0
1450 rem Explosion5
1460 data 128,8,2,162,40,2,41,106
1470 data 138,9,150,170,10,166,170,170
1480 data 165,166,86,169,164,86,105,164
1490 data 105,101,86,169,106,166,41,106
1500 data 166,9,154,166,10,150,168,10
1510 data 150,168,10,170,160,41,86,80
1520 data 37,102,80,41,165,104,160,42
1530 data 10,160,42,2,128,40,2,0
1540 rem Explosion6
1550 data 2,168,2,6,150,10,5,109
1560 data 184,7,238,120,11,235,160,170
1570 data 107,160,150,167,224,166,149,248
1580 data 37,166,184,9,230,150,9,245
1590 data 170,9,185,154,9,190,154,10
1600 data 170,152,9,218,120,9,246,248
1610 data 42,154,184,40,20,148,40,40
1620 data 164,0,32,42,0,32,42,0
1630 rem Explosion7
1640 data 0,0,0,3,104,0,2,88
1650 data 148,0,166,88,10,246,96,15
1660 data 101,128,31,85,192,22,165,192
1670 data 37,94,224,9,127,80,9,183
1680 data 144,13,126,80,15,125,96,15
1690 data 94,96,15,105,64,7,150,128
1700 data 5,155,224,38,32,224,0,0
1710 data 0,0,0,0,0,0,0,0
1720 rem Explosion8
1730 data 0,0,0,0,80,0,0,117
1740 data 80,0,253,192,1,95,192,1
1750 data 87,64,3,117,80,7,125,80
1760 data 21,125,240,63,125,116,29,253
1770 data 84,13,95,80,7,245,240,5
1780 data 245,208,21,223,208,1,255,80
1790 data 1,80,64,1,0,80,0,0
1800 data 16,0,0,0,0,0,0,0
1810 rem Explosion9
1820 data 0,0,0,0,0,0,0,0
1830 data 0,0,0,0,0,1,64,0
1840 data 7,192,1,87,192,1,95,64
1850 data 3,215,80,5,247,208,5,255
1860 data 192,1,253,64,1,117,64,5
1870 data 95,64,7,255,64,5,127,192
1880 data 1,245,64,0,52,0,0,16
1890 data 0,0,0,0,0,0,0,0
1900 rem Explosion10
1910 data 0,0,0,0,0,0,0,0
1920 data 0,0,0,0,0,0,0,0
1930 data 0,0,0,28,0,0,20,0
1940 data 0,85,0,1,221,0,1,221
1950 data 0,3,221,0,1,95,0,1
1960 data 87,0,0,247,0,0,117,0
1970 data 0,81,0,0,0,0,0,0
1980 data 0,0,0,0,0,0,0,0
1990 rem Explosion11
2000 data 0,0,0,0,0,0,0,0
2010 data 0,0,0,0,0,0,0,0
2020 data 0,0,0,0,0,0,0,0
2030 data 0,17,0,0,21,0,0,85
2040 data 0,0,85,0,0,85,64,0
2050 data 85,64,0,85,64,0,21,0
2060 data 0,5,0,0,0,0,0,0
2070 data 0,0,0,0,0,0,0,0
2080 rem Explosion12
2090 data 0,0,0,0,0,0,0,0
2100 data 0,0,0,0,0,0,0,0
2110 data 0,0,0,0,0,0,0,0
2120 data 0,0,0,0,84,0,0,20
2130 data 0,0,85,0,0,84,0,0
2140 data 20,0,0,16,0,0,0,0
2150 data 0,0,0,0,0,0,0,0
2160 data 0,0,0,0,0,0,0,0
2170 rem Thrust Up
2180 data 0,0,0,0,0,0,0,0
2190 data 0,0,0,0,0,0,0,0
2200 data 0,0,0,0,0,0,0,0
2210 data 0,0,0,0,0,0,0,0
2220 data 0,0,0,0,0,0,0,0
2230 data 0,0,0,0,0,0,0,0
2240 data 0,60,0,0,231,0,0,231
2250 data 0,0,126,0,0,60,0,0
2260 rem Thrust Right
2270 data 0,0,0,0,0,0,0,0
2280 data 0,0,0,0,0,0,0,0
2290 data 0,0,0,0,0,0,0,14
2300 data 0,0,3,0,0,6,0,0
2310 data 0,0,0,0,0,0,0,0
2320 data 0,0,0,0,0,0,0,0
2330 data 0,0,0,0,0,0,0,0
2340 data 0,0,0,0,0,0,0,0
2350 rem Thrust Left
2360 data 0,0,0,0,0,0,0,0
2370 data 0,0,0,0,0,0,0,0
2380 data 0,0,0,0,0,112,0,0
2390 data 208,0,0,96,0,0,0,0
2400 data 0,0,0,0,0,0,0,0
2410 data 0,0,0,0,0,0,0,0
2420 data 0,0,0,0,0,0,0,0
2430 data 0,0,0,0,0,0,0,0

3000 data 60,102,110,110,96,98,60,0 : rem character 0
3010 data 24,60,102,126,102,102,102,0 : rem character 1
3020 data 124,102,102,124,102,102,124,0 : rem character 2
3030 data 60,102,96,96,96,102,60,0 : rem character 3
3040 data 120,108,102,102,102,108,120,0 : rem character 4
3050 data 126,96,96,120,96,96,126,0 : rem character 5
3060 data 126,96,96,120,96,96,96,0 : rem character 6
3070 data 60,102,96,110,102,102,60,0 : rem character 7
3080 data 102,102,102,126,102,102,102,0 : rem character 8
3090 data 60,24,24,24,24,24,60,0 : rem character 9
3100 data 30,12,12,12,12,108,56,0 : rem character 10
3110 data 102,108,120,112,120,108,102,0 : rem character 11
3120 data 96,96,96,96,96,96,126,0 : rem character 12
3130 data 99,119,127,107,99,99,99,0 : rem character 13
3140 data 102,118,126,126,110,102,102,0 : rem character 14
3150 data 60,102,102,102,102,102,60,0 : rem character 15
3160 data 124,102,102,124,96,96,96,0 : rem character 16
3170 data 60,102,102,102,102,60,14,0 : rem character 17
3180 data 124,102,102,124,120,108,102,0 : rem character 18
3190 data 60,102,96,60,6,102,60,0 : rem character 19
3200 data 126,24,24,24,24,24,24,0 : rem character 20
3210 data 102,102,102,102,102,102,60,0 : rem character 21
3220 data 102,102,102,102,102,60,24,0 : rem character 22
3230 data 99,99,99,107,127,119,99,0 : rem character 23
3240 data 102,102,60,24,60,102,102,0 : rem character 24
3250 data 102,102,102,60,24,24,24,0 : rem character 25
3260 data 126,6,12,24,48,96,126,0 : rem character 26
3270 data 0,0,0,5,10,16,96,128 : rem character 27
3280 data 1,5,8,144,96,0,0,0 : rem character 28
3290 data 128,64,64,80,105,6,0,0 : rem character 29
3300 data 0,0,0,0,132,74,49,1 : rem character 30
3310 data 128,64,48,8,4,4,6,1 : rem character 31
3320 data 0,0,0,0,0,0,0,0 : rem character 32
3330 data 1,1,2,10,20,16,32,192 : rem character 33
3340 data 102,102,102,0,0,0,0,0 : rem character 34
3350 data 0,0,0,0,4,42,209,129 : rem character 35
3360 data 128,64,64,32,16,16,8,8 : rem character 36
3370 data 1,1,2,4,2,2,4,8 : rem character 37
3380 data 4,2,2,4,2,2,1,1 : rem character 38
3390 data 8,16,32,32,32,64,64,128 : rem character 39
3400 data 0,0,0,0,0,0,0,255 : rem character 40
3410 data 0,0,8,20,36,66,65,129 : rem character 41
