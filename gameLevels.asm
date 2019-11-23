gameLevelReferenceLo            byte <gameLevelEasy
                                byte <gameLevelNormal
                                byte <gameLevelHard

gameLevelReferenceHi            byte >gameLevelEasy
                                byte >gameLevelNormal
                                byte >gameLevelHard

gameMapReferenceLo              byte <gameMapEasy
                                byte <gameMapNormal
                                byte <gameMapHard

gameMapReferenceHi              byte >gameMapEasy
                                byte >gameMapNormal
                                byte >gameMapHard

gameLevelCurrent        byte 0 ; current level type from 0-2 (easy - hard)
gravity                 byte 0, 0 ;fraction, integer
thrust                  byte 0, 0 ;fraction, integer
horizontalInertia       byte 0, 0 ;fraction, integer
fuelRate                byte 0
base1XYBound            byte 0, 0, 0, 0 ; x lower, x upper, y lower, y upper
base2XYBound            byte 0, 0, 0, 0
base3XYBound            byte 0, 0, 0, 0

;Arrays for game types (structure to match gameLevelCurrent)
gameLevelEasy           byte 0
                        byte 2, 0 ;gravity
                        byte 4, 0 ;thrust
                        byte 2, 0 ;horizontal inertia
                        byte 10 ; fuel rate - higher = slower
                        byte 63, 66, 228, 230 ; base 1 bounds
                        byte 140, 145, 132, 134 ; base 2 bounds
                        byte 8, 18, 204, 206 ; base 3 bounds
gameMapEasy             text "{clear}{white}{down*8}##{down}]^{down}{arrow left}{down}${down}{left}&{down}${down}{left}&{down}{left}%{down}{left}'{down}{left*2}!{down}{left*3}[£{down}{left*3}!{down}{left*2}!{down}{left}{arrow left}{down}{arrow left}{down}{arrow left}{down}{arrow left}{(*3}'{up}{left}%"
                        text "{up}{left}&{up}{left}${up}{left}!{up}!{up}[£{up}!{up}'{up}{left}%{up}'{up}{left}%{up}{(*3}'{up}{left}%{up}{left}{arrow left}{up}{left*2}{arrow left}{up}{left}[£{up}!{up}'{up}{left}%{up}){down}{arrow left}##{down}${down}{left}&{down}${down}{left}&"
                        text "{down}{left}%{down}{left}'{down}{left}${down}{left}&{down}${down}{left}&{down}{left}!{down}{left*2}!{down}{left}${down}{left}&{down}{arrow left}{down}]^{(*4}!]^{down}]^{down}{arrow left}"
                        byte 00

gameLevelNormal         byte 1
                        byte 2, 0 ;gravity
                        byte 4, 0 ;thrust
                        byte 2, 0 ;horizontal inertia
                        byte 10 ; fuel rate
                        byte 63, 66, 228, 230 ; base 1 bounds
                        byte 140, 145, 132, 134 ; base 2 bounds
                        byte 8, 18, 204, 206 ; base 3 bounds
gameMapNormal           text "{clear}{white}{down*8}##{down}]^{down}{arrow left}{down}${down}{left}&{down}${down}{left}&{down}{left}%{down}{left}'{down}{left*2}!{down}{left*3}[£{down}{left*3}!{down}{left*2}!{down}{left}{arrow left}{down}{arrow left}{down}{arrow left}{down}{arrow left}{(*3}'{up}{left}%"
                        text "{up}{left}&{up}{left}${up}{left}!{up}!{up}[£{up}!{up}'{up}{left}%{up}'{up}{left}%{up}{(*3}'{up}{left}%{up}{left}{arrow left}{up}{left*2}{arrow left}{up}{left}[£{up}!{up}'{up}{left}%{up}){down}{arrow left}##{down}${down}{left}&{down}${down}{left}&"
                        text "{down}{left}%{down}{left}'{down}{left}${down}{left}&{down}${down}{left}&{down}{left}!{down}{left*2}!{down}{left}${down}{left}&{down}{arrow left}{down}]^{(*4}!]^{down}]^{down}{arrow left}"
                        byte 00

gameLevelHard           byte 2
                        byte 2, 0 ;gravity
                        byte 4, 0 ;thrust
                        byte 2, 0 ;horizontal inertia
                        byte 10 ; fuel rate
                        byte 63, 66, 228, 230 ; base 1 bounds
                        byte 140, 145, 132, 134 ; base 2 bounds
                        byte 8, 18, 204, 206 ; base 3 bounds
gameMapHard             text "{clear}{white}{down*8}##{down}]^{down}{arrow left}{down}${down}{left}&{down}${down}{left}&{down}{left}%{down}{left}'{down}{left*2}!{down}{left*3}[£{down}{left*3}!{down}{left*2}!{down}{left}{arrow left}{down}{arrow left}{down}{arrow left}{down}{arrow left}{(*3}'{up}{left}%"
                        text "{up}{left}&{up}{left}${up}{left}!{up}!{up}[£{up}!{up}'{up}{left}%{up}'{up}{left}%{up}{(*3}'{up}{left}%{up}{left}{arrow left}{up}{left*2}{arrow left}{up}{left}[£{up}!{up}'{up}{left}%{up}){down}{arrow left}##{down}${down}{left}&{down}${down}{left}&"
                        text "{down}{left}%{down}{left}'{down}{left}${down}{left}&{down}${down}{left}&{down}{left}!{down}{left*2}!{down}{left}${down}{left}&{down}{arrow left}{down}]^{(*4}!]^{down}]^{down}{arrow left}"
                        byte 00

