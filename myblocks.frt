         9 1 DO I J ! 5 SPACES ( eerst wat spaties)                             9 1 DO 9 J @ - I BORD @ EMIT SPACE LOOP CR                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ( Commands aplicable to 16 bit mode )                           : LC@ L@ ;                                                      : LC! L! ;                                                      : FRAME ;                                                       : BLACK ;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        <HEX ( DEBUG SCR#7 )                                           :  DUMP2   ( SEG ADDRESS AMOUNT - ..)                               OVER + SWAP FFF0 AND                                            DO                                                                  CR DUP H. I H. ." : "                                           I                                                               10 0 DO                                                             2DUP I + L@ B.                                                  I 2 MOD IF SPACE THEN                                       LOOP  &| EMIT                                                   10 0 DO 2DUP I + L@ FF AND TO-PRINT EMIT LOOP                   &| EMIT DROP                                                10 +LOOP CR DROP                                            ;    HEX>                                                                                                                                                                                       ( Commands aplicable to 16 bit mode )                             HEX                                                            : L@ SWAP 10 * + 7C00 - C@ ;                                    : L! SWAP 10 * + 7C00 - C! ;                                    : LC@ L@ ;                                                      : LC! L! ;                                                      : VV B800 0 ;   17 VARIABLE BLUE                               : VERTICAL-FRAME 20 0 DO BLUE @ VV I 50 * + 81 + LC! 2 +LOOP ;   : HORIZONTAL-FRAME 82 1 DO BLUE @ VV A00 + I + LC! 2 +LOOP ;    : FRAME 17 BLUE ! VERTICAL-FRAME HORIZONTAL-FRAME ;             : BLACK 7 BLUE ! VERTICAL-FRAME HORIZONTAL-FRAME ;              DECIMAL                                                                                                                                                                                                                                                                                                                         ( ERROR MESSAGES   )                                            MSG # 1 : EMPTY STACK                                           MSG # 2 : DICTIONARY FULL                                       MSG # 3 : HAS INCORRECT ADDRESS MODE                            MSG # 4 : ISN'T UNIQUE                                                                                                          MSG # 6 : DISK RANGE ?                                          MSG # 7 : FULL STACK                                            MSG # 8 : DISC ERROR !                                                                                                                                                                                                                                                                                                                                                                          MSG # 14 : SAVE/RESTORE MUST RUN FROM FLOPPY                    ( FIG FORTH FOR CP/M 2.0 ADAPTED BY A. VD HORST HCCH )          ( ERROR MESSAGES   )                                            MSG # 17 : COMPILATION ONLY, USE IN DEFINITION                  MSG # 18 : EXECUTION ONLY                                       MSG # 19 : CONDITIONALS NOT PAIRED                              MSG # 20 : DEFINITION NOT FINISHED                              MSG # 21 : IN PROTECTED DICTIONARY                              MSG # 22 : USE ONLY WHEN LOADING                                MSG # 23 : OFF CURRENT EDITING SCREEN                           MSG # 24 : DECLARE VOCABULARY                                   MSG # 25 : LIST EXPECTS DECIMAL                                                                                                                                                                                                                                                                                                                                                                                                                                  (  DEBUG   SCR#6)    0 VARIABLE BASE'                          : <HEX   BASE @ BASE' ! HEX ;       ( 0/1  SWITCH TO HEX)       : HEX>   BASE' @ BASE !     ;       ( 1/0  AND BACK)            (        1/0  PRINT IN HEX REGARDLESS OF BASE)                  : H.     <HEX 0 <# # # # # #> TYPE SPACE HEX> ;                 (        1/0  IDEM FOR A SINGLE BYTE)                           : B.     <HEX 0 <# # # #> TYPE HEX> ;                           : BASE?  BASE @ H. ;                ( 0/0 TRUE VALUE OF BASE)   : ^      ( 0/0 NON DESTRUCTIVE STACK PRINT)                              CR ." S: " SP@ S0 @ ( FIND LIMITS)                              BEGIN OVER OVER = 0=                                            WHILE 2 - DUP @ H.                                              REPEAT                                                          DROP DROP                                              ;                                                                                                                               <HEX ( DEBUG SCR#7 )                                            : TO-PRINT DUP DUP BL < SWAP 7F > OR IF DROP &. THEN ;          : CHARS  &| EMIT 0 DO DUP I + C@ TO-PRINT EMIT LOOP                   &| EMIT ;                                                 : BYTES 0 DO                                                               DUP I + C@ B.                                                   I 2 MOD IF SPACE THEN                                       LOOP ;                                                  :  DUMP   ( 2/0  DUMPS FROM ADDRESS-2 AMOUNT-1 BYTES)               OVER + SWAP                                                     DO                                                                  CR I H. ." : "                                                  I 0F AND DUP 5 2 */ SPACES 10 SWAP -                            I   OVER BYTES   OVER CHARS   DROP DROP                     10 I 0F AND - +LOOP         CR                              ;    HEX>                                                        ." SYSTEM ELECTIVE CP/M FIGFORTH EXTENSIONS 3.43    AH"          -1 CELL+ LOAD  ( 16/32 BIT DEPENDANCIES)                       ( MAINTENANCE )  100 LOAD 32 LOAD                              ( HEX CHAR DUMP)  6 LOAD 30 LOAD 7 LOAD 2 LOAD ( i.a. editor)    ( STRING         36 LOAD 37 LOAD )                              ( EDITOR )       101 105 THRU 107 LOAD 106 LOAD                 ( CP/M READ WRITE LOAD    15 LOAD 18 LOAD 21 LOAD 21: BUGS)     ( KRAKER )        10 LOAD                                       ( NEW SYSTEM      23 LOAD   )                                   ( CRC             71 LOAD   )                                   ( ASSEMBLER 8080  74 LOAD ) ( 8086  96 LOAD     )               ( STAR PRINTER    31 LOAD   )                                   ( CP/M CONVERT    80 LOAD   )                                   WARNING 1 TOGGLE                                                                                                                                                                                ." QUADRUPLE ARITHMETIC 08-02-84 "                              : ADC ( n1,n2-n,c  add, leave sum and carry)                       0 SWAP 0 D+ ;                                                : 2M+ ( d1,d2-d,c  add double )                                   >R SWAP >R    ADC R> ADC   R> SWAP >R                           ADC R> + ;                                                    : 3M+ ROT >R 2M+ R> ADC ;                                       : 4M+ ROT >R 3M+ R> ADC ;                                       : 2U*  ( d1,d2-q unsigned product)                              ROT ( l1,l2,h2,h1)    OVER OVER U* >R >R ^                      ROT ( l1,h2,h1,l2)    OVER OVER U* >R >R ^                      SWAP DROP ROT ROT ( l2,l1,h2) OVER OVER U* >R >R ^              DROP ( l1,l2)    U* ^ R> ADC ^ R> ADC ^                          IF ( carry) R> R> 2M+ 1+ ." C" ELSE                                         R> R> 2M+    ." NC" THEN  ^                         R> R> 2M+ DROP ^ ;                                             CR ." 84NOV22  FORTH KRAKER >1<  ALBERT VAN DER HORST "         0 VARIABLE SELTAB 120 ALLOT   SELTAB VARIABLE SELTOP            : T,  ( N--. Put N in select table)                                 SELTOP @ !  2 SELTOP +!  ;                                  : CFOF ( --N Get cfa of word following )                           [COMPILE] ' CFA ;                                            : C->P 2 + ; ( N--N Converteer cfa naar pfa )                   : ID.. C->P NFA ID. ; ( cfa--. Print a words name )             : SEL@    ( N--M,F F="value N present in table" )                  ( if F then M is vector address else M=N)                          0 SWAP ( initialise flag)                                       SELTOP @ SELTAB DO                                                  DUP I @ = IF ( FOUND!) DROP DROP 1 I 2+ @ THEN              4 +LOOP        SWAP   ( get flag up)  ;                   : <> - 0= 0= ;  : CR 13 EMIT 10 EMIT ;                          30 LOAD 33 LOAD -->                                              CR ." 84NOV24  FORTH KRAKER >2<  ALBERT VAN DER HORST "          HERE VARIABLE LIM                                             : (KRAAK) ( CFA--. Decompile a word from its CFA )                 DUP NEXTN LIM ! ( Get an absolute limit)                        DUP @ SEL@ IF ( Is content of CFA known?)                          EXECUTE ( Assuming CFA also on stack)                        ELSE                                                               CR DROP DUP DUP @ 2 - = IF                                          ." Code definition : " ELSE ." Can't handle : "             ENDIF ID.. CR                                                ENDIF ;                                                      : KRAAK  ( Use KRAAK SOMETHING to decompile the word SOMETHING)     CFOF (KRAAK) ;                                              : ?IM  ( CFA--f tests whether word IMMEDIATE )                       C->P NFA C@ $40 AND ;                                      : ?Q ?TERMINAL IF QUIT THEN ; ( NOODREM) -->                    CR ." 84NOV24  FORTH KRAKER >3<  ALBERT VAN DER HORST "         : BY ( CFA--. the CFA word is decompiled using : )                T, CFOF T, ; ( a word from the input stream )                 ( Example of a defining word decompilation)                     ( It is done by examples of the defined words )                 : -co DUP C->P @ CR H. ." CONSTANT " ID.. CR ;                         CFOF 0 @ BY -co                                          : -va DUP C->P @ CR H. ." VARIABLE " ID.. CR ;                         CFOF SELTAB @ BY -va                                     : -us DUP C->P C@ CR B. ."  USER " ID.. CR ;                           CFOF FENCE @ BY -us                                      : ITEM ( 1/1 Desinterpret next item, increments pointer)            DUP @ SEL@ ( Something special ?)                               IF EXECUTE ( The special) ELSE                                     DUP ?IM IF ." [COMPILE] " THEN ID.. 2+                       THEN ; -->                                                  CR ." 84NOV24  FORTH KRAKER >4<  ALBERT VAN DER HORST "         CFOF TASK @ CONSTANT DOCOL ( Get the  DOCOLON address )         ( Decompilation of special high level words)                     : -hi CR ." : " DUP DUP ID.. 2 +  CR                             BEGIN ?Q DUP @  LIT ;S <> >R DUP LIM @ < R> AND WHILE                ITEM REPEAT                                                CR DROP ." ;" ?IM IF ."  IMMEDIATE " THEN CR ;                      CFOF TASK @  BY -hi                                       ( for all -words: 1/1 pointer before afd after execution)       : -lit 2+ DUP @ H. 2+ ;                                             CFOF LIT BY -lit                                            : -0br CR ." 0BRANCH [ " -lit ." , ] " ;                            CFOF 0BRANCH BY -0br                                        : -br  CR ." BRANCH  [ " -lit ." , ] " ;                            CFOF BRANCH BY -br                                           -->                                                            CR ." A0MAR05  FORTH KRAKER >5<  ALBERT VAN DER HORST "          : -dq 2+ DUP COUNT CR &. EMIT &" EMIT BL EMIT                      TYPE &" EMIT BL EMIT  COUNT + ;                                                         CFOF (.") BY -dq                                                                                     : -do CR ." DO " 2 + ;     CFOF (DO) BY -do                     : -lo CR ." LOOP " 2 + ;   CFOF (LOOP) BY -lo                   : -pl CR ." +LOOP " 2 + ;  CFOF (+LOOP) BY -pl                  : -cm ." COMPILE " -lit ;  CFOF COMPILE BY -cm                  ( DIRTY TRICK FOLLOWING :)                                      : -pc CR ." ;CODE plus code (suppressed)"                         DROP ' TASK ; ( Destroy deecompile pointer !)                     CFOF (;CODE) BY -pc                                                                                                                                                                                                                                        ( DISK IO SCREEN 15 SCHRIJVEN >1< VERSIE #1)                    <HEX  0 VARIABLE FCB2   21 ALLOT  ( BUG: 2nd goes wrong)        : CLEAN-FCB DUP 21 0 FILL  1+ 0B 20 FILL ;                      : FILL-FCB 22 WORD                                                 1+ HERE  COUNT ROT SWAP CMOVE  ;                             : SET-DMA  1A BDOS DROP ;                                       : ?PRES   FCB2 0F BDOS 0FF - IF ." ALREADY PRESENT" QUIT THEN      FCB2 10 BDOS DROP ;                                            -->                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ( SCR # 16 SCHRIJVEN >2<   )                                    0 VARIABLE DISK-BUFFER-W 100 ALLOT                              DISK-BUFFER-W VARIABLE POINTER-W                                : .OPENW FCB2 CLEAN-FCB FCB2 FILL-FCB ?PRES                       FCB2 16 BDOS 0FF = IF ." DISK FULL " QUIT THEN                  DISK-BUFFER-W POINTER-W ! ;                                   : .CLOSEW                                                            DISK-BUFFER-W SET-DMA FCB2 15 BDOS . ." LAST RECORD" CR               FCB2 10 BDOS . ." CLOSE STATUS" CR ;                 0A0D VARIABLE CRLF    1A VARIABLE CTRLZ                         : MOVE-DOWN   -80 POINTER-W +!                                                DISK-BUFFER-W 80 OVER + SWAP 80 CMOVE ;           : TO-DISK DUP >R POINTER-W @ SWAP CMOVE                                   R> POINTER-W +!                                                 POINTER-W @ DISK-BUFFER-W -                                     80 >  IF   -->                                         ( SCREEN #17 SCHRIJVEN  >3<)                                                DISK-BUFFER-W SET-DMA FCB2 15 BDOS .                            MOVE-DOWN                                                   THEN ;                                                                                                                 : .WRITE  ( 2/0 WRITE SCREEN-1 .. SCREEN-2 TO DISK)                  1+ B/SCR * SWAP B/SCR * ( GET START BUFFER #'S)                   DO I BLOCK DUP                                                  40 -TRAILING TO-DISK  CRLF 2 TO-DISK                            40 + 40 -TRAILING TO-DISK CRLF 2 TO-DISK                      LOOP CTRLZ 1 TO-DISK                                       ;   HEX>                                                                                                                                                                                                                                                                                                                        ( DISK IO, LEZEN )                                              <HEX  ( BUG: 64 char lines go wrong)                            0 VARIABLE DISK-BUFFER-R  80 ALLOT 0 VARIABLE POINTER-R          0A CONSTANT "LF"  0D CONSTANT "CR"                              1A CONSTANT ^Z    DISK-BUFFER-R 80 + CONSTANT END-BUF           0 VARIABLE EOF                                                 : .OPENR   FCB2 DUP CLEAN-FCB FILL-FCB                                END-BUF POINTER-R !                                             FCB2 0F BDOS 0FF = IF ." NOT PRESENT" QUIT THEN                 0 EOF ! ;                                                 : .CLOSER   FCB2 10 BDOS . ." CLOSE STATUS" CR ;                                                                                                                                                              -->                                                                                                                                                                               ( SCR # 19,  TWEEDE SCREEN VAN CP/M READ)                       : ?EMPTY ( POINTER -- CORRECTED PNR, READ SECTOR IF AT END)         DUP END-BUF = IF DISK-BUFFER-R SET-DMA  FCB2 14 BDOS .                         DROP DISK-BUFFER-R THEN  ;                   : GET-CHAR                                                         POINTER-R @                                                       ?EMPTY                   ( GET NEW BUFFER IF NEEDED)            DUP C@ "LF" = IF 1+ ?EMPTY THEN ( SKIP OVER LF)                 DUP C@ SWAP              ( GET CHAR, POINTER ON TOP)            OVER ^Z =                                                        IF 1 EOF ! ELSE 1+ THEN ( INCREMENT POINTER UNLESS AT ^Z)    POINTER-R !  ;                                                                                                               -->                                                                                                                                                                                             CR ." READ CP/M files >3< AH   84/06/13"                        : GET-LINE ( ADR -- . reads a line to ADR )                          DUP 40 20 FILL ( preset spaces )                                41 OVER + SWAP ( max $41 char to a line, CR!)                   DO  GET-CHAR                                                        DUP "CR" = IF DROP 20 LEAVE THEN                                DUP ^Z   = IF DROP 20 LEAVE THEN                                I C! ( may leave spurious 81th space)                       LOOP  ;                                                    : .READ ( 2/0 READ SCREEN-2 TO SCREEN -1)                            1+ B/SCR * SWAP B/SCR * ( get start buffer #'s)                 DO  I BLOCK DUP GET-LINE                                            DUP 40 + GET-LINE  81 + 0 SWAP C! UPDATE                        I #BUFF MOD 0= IF ( full load of buffers) FLUSH THEN        LOOP                                                      ; HEX>                                                           ( 01-APR-83 LADEN VAN CP/M FILE  #1 )                           ( EXAMPLE: .OPENR TEMP" 25 26 .LOAD .CLOSER )                   <HEX  0 VARIABLE LBUF 3E ALLOT 0 C,                             : I-F-A ( ADRES -- . ,INTERPRET FROM ADDRESS )                      TIB @ >R  IN @ >R  ( SAVE CURRENT INTERPRET POSITION)           TIB !     0 IN !   ( NEW POSITION)                              0 INTERPRET                                                     >R IN !   >R TIB ! ( RESTORE)  ;                                                                                            : .LOAD ( LOAD THE CPM FILE SPECIFIED IN FCB2 )                         BEGIN   LBUF DUP GET-LINE I-F-A                                 EOF @ UNTIL ;                                                                                                                                                                              HEX>                                                                                                                         CR ." TAARTEN AUTOMATISERING DOOR DRS HENK" CR                  ." EEN VOORBEELD UIT BRODIE"     CR                             ." TYPE HELP VOOR DE GLOSSARY"  CR                              0 VARIABLE TAARTEN     0 VARIABLE DIEP-VRIES                    : HELP CR ." GLOSSARY:" CR ." BAK-TAART"                               CR ." EET-TAART" CR ." VRIES-IN" CR ." ONTDOOI"                 CR ." START" CR ." STATUS" CR ;                          : START 0 TAARTEN ! 0 DIEP-VRIES ! ;                            : BAK-TAART 1 TAARTEN +! ;                                      : EET-TAART TAARTEN @ DUP                                             IF -1 TAARTEN +! CR ." DANKJEWEL !" CR ELSE                       CR ." WELKE TAART ?" CR DROP THEN ;                     : VRIES-IN TAARTEN @ DIEP-VRIES +! 0 TAARTEN ! ;                : ONTDOOI DIEP-VRIES @ TAARTEN +! 0 DIEP-VRIES ! ;              : STATUS CR ." AANTAL AANWEZIGE TAARTEN: " TAARTEN ?              CR ." EN NOG " DIEP-VRIES ? ." IN DE DIEP VRIES " ;            ( EXTENDING THE FORTH SYSTEM #1 84/4/12 A.H.)                  <HEX                                                            : NEW-SYSTEM   ( Generates a new FORTH system, )                               ( using the CP/M SAVE command)                        LATEST PFA NFA 10C ! ( Define new topmost word)                 ( Initial value for VOC-LINK and FENCE:)                        HERE DUP 11C ! 11E !                                            HERE 100 / DECIMAL CR                                           CR ." TYPE: SAVE" . ." NEWFORTH.COM"                            BYE                                                        ;     HEX>                                                                                                                                                                                                                                                                                                                                                                                      ." GILBREATH's benchmark - BYTE jan 83 "  ( VERSIE #1)          8190 CONSTANT SIZE                                              0 VARIABLE FLAGS      SIZE ALLOT                                                                                                : DO-PRIME                                                          FLAGS SIZE 1 FILL                                               0 ( 0 COUNT ) SIZE 0                                            DO FLAGS I + C@                                                    IF I DUP + 3 +  ( DUP . )                                          DUP I +                                                         BEGIN DUP SIZE <                                                WHILE 0 OVER FLAGS +  C!  OVER + REPEAT                         DROP DROP 1+                                                 THEN                                                         LOOP                                                            . ." PRIMES" ;                                              ." ERATOSTHENES >1< Variables - A. van der Horst"  CR           ( User specified variables:)                                    52 VARIABLE CH/L  ( Characters per line)                        22 VARIABLE LN/P  ( Lines per page)                              1 VARIABLE PAUSE ( Boolean: pause between pages)                                                                               ( Other:)                                                       6250 CONSTANT SIZE ( 16 numbers pro byte)                       0 VARIABLE FLAGS      SIZE ALLOT                                FLAGS SIZE + CONSTANT END-FLAGS                                 0 VARIABLE LIM     ( part of FLAGS considered)                  0 VARIABLE C#      0 VARIABLE L#  ( char and line counter)      0 VARIABLE THOUSANDS ( #  thousand to be sieved)                0 VARIABLE MILS      ( Contains current thousand)               0 VARIABLE MANTISSA  ( The current thousands is to be printed)  -->                                                             ." ERATOSTHENES >2< Pretty printing - A. van der Horst"  CR     : FFEED  PAUSE @ IF CR ." KEY FOR NEXT SCREEN" KEY DROP THEN        12 EMIT CR ." ERATOSTHENES SIEVE -- PRIMES LESS THAN"           THOUSANDS @ 5 .R ."  000" CR 2 L# ! 1 MANTISSA ! ;          : ?P ( LENGTH -- . , give FF if LENGTH lines don't fat)              DUP L# +! L# @ LN/P @ > IF FFEED L# +! ELSE DROP THEN ;    : NEWLINE  ( Start at a new line, maybe with a mantissa)            1 ?P CR ( Checks first)                                         MANTISSA @ IF MILS @ 6 .R ELSE 6 SPACES THEN                    6 C# !   0 MANTISSA ! ;                                     : ?L ( LENGTH -- . , give LF if LENGTH char's don't fit)             DUP C# +! C# @ CH/L @ >                                         IF NEWLINE C# +! ELSE DROP THEN ;                          : .P   4 ?L SPACE 0 <# # # # #> TYPE ;                          : INIT-P  FFEED NEWLINE  ;   -->                                                                                                ." ERATOSTHENES >3< Bit manipulation - A. van der Horst " CR      HEX                                                           : NOT   0FF XOR ( N -- N  FLIP ALL BITS OF N) ;                 0 VARIABLE S-MASK -2 ALLOT 01 C, 02 C, 04 C, 08 C,                                         10 C, 20 C, 40 C, 80 C,              0 VARIABLE C-MASK -2 ALLOT                                                  01 NOT C, 02 NOT C, 04 NOT C, 08 NOT C,                         10 NOT C, 20 NOT C, 40 NOT C, 80 NOT C,             : INIT-T   FLAGS SIZE 0FF FILL ; ( Preset to 'prime')           DECIMAL                                                         : 8/MOD   0 8 U/ ; ( May be redefined in assembler )            : CLEAR-B ( BIT# --  clears the specified bit)                            8/MOD FLAGS + SWAP  ( Address in flags table)                   C-MASK + C@         ( Get mask)                                 OVER C@ AND SWAP C! ( Clear the bit)  ;               -->                                                             ." ERATOSTHENES >4< Bit manipulation - A. van der Horst " CR    : SET-B ( BIT# --  sets the specified bit)                                8/MOD FLAGS + SWAP  ( Address in flags table)                   S-MASK + C@         ( Get mask)                                 OVER C@ OR SWAP C!  ( Store with bit set)  ;          : TEST-B ( BIT# -- FLAG  Gets a FLAG testable by IF)                      8/MOD FLAGS + C@ SWAP  ( Get flag)                              S-MASK + C@ AND        ( Result: =0 or #0)     ;      : FLIP ( PRIME,START -- .  , marks multiples of PRIME as               (  non prime starting with START)                                  BEGIN  DUP LIM @ U<  WHILE                                             DUP CLEAR-B  OVER +                                      REPEAT   DROP DROP ;                                  : CHECK SIZE 16 U* 1000 U/  THOUSANDS @ U< IF                         ." INCREASE SIZE " ABORT THEN ;                           -->                                                             ." ERATOSTHENES >5< Main program - A. van der Horst " CR        : BATCH1 ( First batch of 500 numbers)                               500 1 ( Only odd numbers)                                      DO I TEST-B                                                        IF I DUP + 1 + DUP .P ( get prime number)                          I FLIP THEN ( Mark multiple as non-prime)                 LOOP ;                                                      : BATCH ( OFFSET --  every  following batch )                        500 0                                                           DO DUP I + TEST-B IF I DUP + 1 + .P THEN                        LOOP DROP ;                                                : SIEVE  ( N --  Makes list of primes <N*1000 )                     DUP THOUSANDS !   DUP CHECK   500 * LIM !  0 MILS !             INIT-T INIT-P 2 .P BATCH1                                       THOUSANDS @ 1                                                   DO I MILS !  1 MANTISSA !  NEWLINE I 500 * BATCH LOOP ;     ." DEFINIEER ^. EN  ''.  85JAN06 ALBERT VAN DER HORST"          <HEX                                                             : TOH 30 - DUP 9 > IF 7 - THEN ;                                   1 WIDTH !                                                    : &. ( 0/1 Leaves ASCII character at .  f.i. &A leaves 41H)       HERE 2 + C@ [COMPILE] LITERAL ; IMMEDIATE                     : ^. ( 0/1 leaves control character at . f.i. ^A leaves 01H)      HERE 2 + C@ 1F AND [COMPILE] LITERAL ; IMMEDIATE              : $.. ( 0/1 leaves hex number f.i. $0A leaves 0AH)                HERE 2 + C@ TOH 10 * HERE 3 + C@ TOH + [COMPILE] LITERAL ;    IMMEDIATE                                                       : $.... ( 0/1 leaves hex number 16 bits)                           0 HERE 6 + HERE 2 + DO 10 * I C@ TOH + LOOP                     [COMPILE] LITERAL ; IMMEDIATE                                   1F WIDTH ! HEX>                                              $1B CONSTANT ESC    $0F CONSTANT SI   $0E CONSTANT SO          ." 84NOV25 Initialize STAR-printer AH "  <HEX                   : PEMIT 7F AND 5 BDOS DROP ;                                    : PCR   0D PEMIT   0A PEMIT ;                                   : INIT-STAR ( N--. N is lines per pages)                           ESC PEMIT "@ PEMIT ESC PEMIT "C PEMIT ( TOS) PEMIT ;         : CONDENSED  ESC PEMIT "P PEMIT "3 PEMIT ;                      : EMPHASIZED ESC PEMIT  "E PEMIT ;                              : DOUBLE ESC PEMIT "G PEMIT ;                                   : BOLD EMPHASIZED DOUBLE ;                                      ( 137 CH/L !    60 LN/P !     0 PAUSE ! )                        : PSPACES  ( 1/0 print N-1 spaces)                                0 DO 20 PEMIT LOOP ;                                          : PTYPE  ( ADDRESS,LENGTH -- . PRINT LENGTH CHAR AT ADDRESS)            -DUP IF                                                         OVER + SWAP DO I C@ PEMIT LOOP THEN ;                   : P."  "" WORD HERE COUNT PTYPE ;       -->                    ( SUPER-QUAD)                                                     0 VARIABLE L                                                  : CONDENSED 34 MODE ;                                           :  HEADER  CR DUP 2 + SWAP                                         DO 3  SPACES ." SCR #" I 4 .R 54  SPACES LOOP ;              : 1LINE  L @ OVER (LINE)  TYPE                                    L @ 2 .R SPACE  L @ 16 + SWAP (LINE)  TYPE CR ;                : SUPER-DUPE                                                      2 /MOD SWAP DROP 2 *                                            DUP HEADER CR                                                   16 0 DO  I L ! DUP 1LINE                                        LOOP  ;                                                      : SQ CONDENSED SUPER-DUPE 2+ SUPER-DUPE DROP ;                                                                                                                                                                                                                  CR ." KRAAKER"                                                  : NEXTN ( CFA--NFA Get the NFA of the word defined)               C->P NFA LATEST             ( after the CFA one)                2DUP = IF                                                         DROP DROP HERE  ( No following word)                          ELSE                                                              BEGIN                                                              2DUP PFA LFA @ <> WHILE                                         PFA LFA @                                                    REPEAT                                                          SWAP DROP ( The CFA)                                          ENDIF                                                         ;                                                               : NEXTC ( CFA--CFA Like previous definition, giving CFA)          NEXTN PFA CFA ;                                                                                                               CR ." KRAAKER"                                                  : KRAAK-FROM ( .--. Kraak, starting with following word)          CFOF                                                            BEGIN                                                              DUP NEXTN HERE < WHILE                                          NEXTC DUP (KRAAK)                                            REPEAT                                                          DROP                                                          ;                                                               0 VARIABLE aux                                                  : PEMIT $7F AND 5 BDOS DROP ;                                   : TO-LP-KRAAK-FROM                                                ' EMIT @ aux !                                                  ' PEMIT CFA ' EMIT !                                            KRAAK-FROM                                                      aux @ ' EMIT ! ;                                              : A0 ;                                                          : A1 A0 A0 ;   : A2 A1 A1 ;    : A3 A2 A2 ;                     : A4 A3 A3 ;   : A5 A4 A4 ;    : A6 A5 A5 ;                     : A7 A6 A6 ;   : A8 A7 A7 ;    : A9 A8 A8 ;                     : AA A9 A9 ;                                                                                                                   : TEST 0 DO AA LOOP ;                                           : Q 0 DO 10000 TEST LOOP ;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ( Elementary string: $@ $! $=          89jul16-AH)               : $@ COUNT ;     : $. TYPE ;  : C+! >R R @ + R> ! ;             : $! ( address, count,string -.)                                  OVER OVER C! 1+ SWAP CMOVE     ;                              : $C+ ( C,$-. append the character to the string $ )               SWAP OVER $@ + C!  1 SWAP C+! ;                              : $+!  ( $T,$C,$-. Append $C char's from $T to $)                  DUP C@ >R ( Keep old length )  2DUP C+! ( Adjust length)        1 + R> + SWAP CMOVE  ;                                      ( HANDY & Preparation for ANSI-fication)                        : PARSE WORD HERE $@ ;                                          : S" &" PARSE 2DUP ( fig: already HERE) 1+ ALLOT DROP ;         : STRING <BUILDS S" DROP DROP DOES> $@ ;                                                                                                                                                                                                                         ( STRING MANIPULATIONS : $I $S A0MAR06-AH)                      : $I ( String,c - Index   Index is the first place                      ( is to be found in the string else 0 )                   OVER C@ 0= IF DROP DROP 0 ELSE                                  0 ROT ROT SWAP $@ OVER + SWAP DO                                  DUP I C@ = IF SWAP  DROP I SWAP LEAVE THEN                    LOOP DROP THEN ;                                              : $S ( STRING, DEL- TEXT1, L1, TEXT2, L2 )                        ( Splits the text at the delimiter in two)                      (  if not present, L2 is made zero )                           OVER SWAP $I  DUP IF                                               >R $@ OVER R SWAP - ( Length before delimiter )                 SWAP OVER - 1 - ( Length after delimiter)                       R> 1+ SWAP                                                   ELSE DROP $@ 0 0                                                THEN ;                                                        (  -HEADING                   89jul16-AH )                       : -HEADING ( $T,$C -$T,$C   Like -TRAILING, removes)               BEGIN                        ( heading blanks )                   OVER C@ BL = OVER 0= 0=  AND                                  WHILE                                                             1 - SWAP 1 + SWAP                                             REPEAT  ;                                                    : $=  ( S1 S2 --F string at address S1 equal to other one)        1 ROT ROT  ( Start with a zero flag)                            DUP C@ 1+ ( Compare also count ) 0 DO                              OVER I + C@ OVER I + C@ <> IF                                      ROT DROP 0 ROT ROT ( Replace flag with 0 )                      LEAVE                                                        THEN                                                         LOOP DROP DROP  ;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            ( WRITE THE CURRENT SYSTEM TO HARD DISK ) HEX                   B/BUF SEC/BLK / CONSTANT SEC-LEN                                0 VARIABLE RW-BUFFER B/BUF ALLOT                                0 VARIABLE PARAM-BLOCK -2 ALLOT 10 C, 0 C,                      HERE 1 - SEC-LEN / , SEC-LEN , 7C0 ,                            ( We use the two l.s. bytes of 64 bit number)                                 1 , 0 , 0 , 0 ,                                    CODE WRITE-SYSTEM                                                PUSHX, SI|                                                      MOVXI, AX| 4300 W,                                              MOVXI, DX| 0080 W,                                              MOVXI, SI| PARAM-BLOCK W,                                       INT, 13  B,                                                     POPX, SI|                                                       PUSHF,                                                          NEXT C;            DECIMAL                                    ( Experiment with GDT etc.) HEX                                 ( 32 K GDT AT 0001.8000 ) 2800 CONSTANT GDT-SEGMENT             7FFF VARIABLE GDT 2.8000 SWAP , ,                               7C0 CONSTANT CODE-SEGMENT ( The same for real and prot)         CODE-SEGMENT  10 * CONSTANT CODE-START                          : GDT! GDT-SEGMENT SWAP L! ;   1800 CONSTANT DATA-SEGMENT       : CODE! CODE-SEGMENT + GDT! ;   : DATA! DATA-SEGMENT + GDT! ;   : PREPARE-CS                                                      FFFF 0 CODE!   CODE-START 2 CODE!                               9A00 4 CODE!   008F 6 CODE! ;                                 : PREPARE-DS                                                      FFFF 0 DATA! CODE-START 2 DATA!                                 9200 4 DATA! 008F 6 DATA! ;                                    CODE LOAD-GDT CLI, 0F C, 01 C, 10 C, MEM| GDT MEM,             NEXT C; DECIMAL                                                                                                                 ( Experiment with GDT etc.) HEX                                 7C8 CONSTANT CS-32 ( 32 BITS CODE SEGMENT)                      10  CONSTANT DS-32 ( 32 BITS DATA SEGMENT)                      : CS32! CS-32 + GDT! ;   : DS32! DS-32 + GDT! ;                 : PREPARE-CS32                                                    FFFF 0 CS32!   CODE-START 2 CS32!                               9A00 4 CS32!   00CF 6 CS32! ;                                 : PREPARE-DS32                                                    FFFF 0 DS32!   CODE-START 2 DS32!                               9200 4 DS32!   00CF 6 DS32! ;                                 PREPARE-DS PREPARE-CS PREPARE-CS32 PREPARE-DS32                                                                                 DECIMAL                                                                                                                                                                                                                                                         ( Experimenting with drive parameters ) HEX                     B/BUF SEC/BLK / CONSTANT SEC-LEN                                0 VARIABLE RW-BUFFER B/BUF ALLOT                                0 VARIABLE PARAM-BLOCK -2 ALLOT 10 C, 0 C,                      HERE 1 - SEC-LEN / , SEC-LEN , 7C0 ,                            ( We use the two l.s. bytes of 64 bit number)                                 1 , 0 , 0 , 0 ,                                    CODE WRITE-SYSTEM                                                PUSHX, SI|                                                      MOVXI, AX| 4300 W,                                              MOVXI, DX| 0080 W,                                              MOVXI, SI| PARAM-BLOCK W,                                       INT, 13  B,                                                     POPX, SI|                                                       PUSHF,                                                          NEXT C;            DECIMAL                                    ( EXPERIMENT: SWITCH TO PROTECTED MODE AND BACK )                 90 LOAD 41 42 THRU HEX     LOAD-GDT                           CODE TO-PROT1                                                     CLI, PUSHS, DS|  TO-PROT,                                         JMPFAR, HERE 4 + MEM, CS-32 SEG,                                MOVI, W| R| AX| DS-32 , 0 ,                                     MOVSW, T| DS| R| AX|                                            MOVI, W| R| AX| &a , 0 ,                                        XCHGX, AX| XCHGX, AX| XCHGX, AX| XCHGX, AX|                     MOVFA, B| B.0400 SWAP , ,                                       JMPFAR, HERE 6 + MEM, 0 , CODE-SEGMENT SEG,                  TO-REAL, STI, POPS, DS|  OS, PUSHX, AX|                         NEXT C; DECIMAL                                                                                                                                                                                                                                                ( SWITCH TO PROTECTED MODE AND BACK TIMING TEST )               CODE TO-PROT2                                                     CLI, TO-PROT,                                                     JMPFAR, HERE 4 + MEM, CS-32 SEG,                                JMPFAR, HERE 6 + MEM, 0 , CODE-SEGMENT SEG,                  TO-REAL, STI,                                                   NEXT C; DECIMAL                                                CODE TO-PROT3                                                     CLI, TO-PROT,   TO-REAL, STI,                                  NEXT C; DECIMAL                                                                                                                : TEST2 0 DO TO-PROT2 LOOP ;                                    : TEST3 0 DO TO-PROT3 LOOP ;                                    : Q2 0 DO 10000 TEST2 LOOP ;                                    : Q3 0 DO 10000 TEST3 LOOP ;                                                                                                    ( SWITCH TO PROTECTED MODE AND BACK REPLACEMENT FOR DOCOL )       90 LOAD 41 42 THRU HEX     LOAD-GDT                           CODE NEW-DOCOL                                                   (  JMPFAR, HERE 6 + MEM, 0 , CODE-SEGMENT SEG, )                (  TO-REAL,) STI,   CLI,   ( TO-PROT,)                         (  JMPFAR, HERE 4 + MEM, CS-32 SEG, )                             LEA, BP1| DB| [BP] -2 B,                                        MOV, W| F| SI1| DB| [BP] 0 B,                                   LEA, SI1| DB| [DI] 2 B,                                        NEXT C; DECIMAL                                                 : A0 ; ' A0 2 - @ CONSTANT 'DOCOL                              CODE X JMP,  ' NEW-DOCOL 'DOCOL 3 + - , C;                       CODE SWITCH  ' X 'DOCOL  CP, CP, CP, DROP DROP                 CLI,  ( TO-PROT, MOVXI, AX| DATA-SEGMENT MEM,                    MOVSW, T| DS| R| AX|  MOVSW, T| ES| R| AX|  MOVSW, T|          SS| R| AX| ) NEXT C;  DECIMAL                                   ( SWITCH TO PROTECTED MODE AND BACK REPLACEMENT FOR DOCOL )     CODE NEW-BIOS                                                     POPX, AX|   MOVFA, B| HERE 0 ,    ( PATCH THE INTERRUPT #)      POPX, DX|  POPX, CX|  POPX, BX|  POPX, DI|                    PUSHX, SI|   PUSHX, BP| ( TO-REAL,) STI, XCHGX, DI|               INT, HERE SWAP ! 0 C, ( PATCH THE ADDRESS WHERE TO PATCH )      PUSHF, POPX, DI|   ( SAVE FLAGS BEFORE THEY ARE DESTROYED)      XCHGX, SI| ( FREE AX)  CLI,  ( TO-PROT,)                        ( NOW ALL REGISTERS ARE TIED UP EXCEPT ax| [!])               POPX, BP|  POPX, AX|  XCHGX, SI|  ( RESTORE FORTH REGISTERS)    PUSHX, AX|    PUSHX, BX|    PUSHX, CX|    PUSHX, DX|  PUSHX, DI| NEXT C;                                                        CODE HLT HLT, C;                                                : PATCH-BIOS ' NEW-BIOS ' BIOS CFA ! ;                          : PATCH PATCH-BIOS SWITCH ;                                     KRAAKER                                                                                                                         ' NEW-BIOS 30 DUMP ' NEW-DOCOL 30 DUMP 48 EDIT                  40BB :                            58A2 CF40 5A|X..@Z|           40C0 : 595B 5F56 550F 20C0 480F 22C0 FB97 CD00 |Y[_VU. .H.".....40D0 : 9C5F 96FA 0F20 C040 0F22 C05D 5896 5053 |._... .@.".]X.PS                                                                4043 :        0F20 C048 0F22 C0FB FA0F 20C0 40|. .H.".... .@|   4050 : 0F22 C08D 6EFE 8976 008D 7502 AD89 C789 |."..n..v..u.....4060 : FBFF 2582 41B0 3540 5A06 A804 8627 444F |..%.A.5@Z....'DO                                                                ' NEW-BIOS 30 DUMP                                              44E1 :   58A2 EE44 5A59 5B5F 5655 FB97 CD10 9C|X..DZY[_VU.....| 44F0 : 5F96 FA5D 5896 5053 5152 57AD 89C7 89FB |_..]X.PSQRW.....4500 : FF25 8348 4CD4 D444 0A45 F481 D802 4511 |.%.HL..D.E....E.4510 : 45E9 A730 8A50 4154 4348 2D42 494F D30B |E..0.PATCH-BIO..                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                ( SCREEN FOR TESTING THE EDITOR WAS SYSTEM TO HARD DISK ) HEX   B/BUF SEC/BLK / CONSTANT SEC-LEN                                0 VARIABLE RW-BUFFER B/BUF ALLOT                                0 VARIABLE PARAM-BLOCK -2 ALLOT 10 C, 0 C,                      HERE 1 - SEC-LEN / , SEC-LEN , 7C0 ,                            ( We use THE T O l.s. bytes of 64 bit number)                                 1 , 0 , 0 , 0 ,                                    CODE WRITE-SYSTEM                                                PUSHX, SI|    MOVXI, SI| PARAM-BLOCK W,                         MOVXI, AX| 4300 W,      MOVXI, DX| 0080 W,                      INT, 13  B,     POPX, SI|       PUSHF,                          NEXT C;                                                       ( +!   2DUP   DUP   SWAP   DROP   OVER   DMINUS   MINUS         D+   +  )                                                                                                                       DECIMAL                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         : TEST 1 OVER = IF ." ONE" ELSE TEST                                  2 OVER = IF ." TWO " ELSE                                       ." THREE " THEN ;                                                                                                         1234 1234 1234                                                  ^ 1 TEST ^                                                      ^ 2 TEST ^                                                      ^ 3 TEST ^                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ( WRITE THE CURRENT SYSTEM TO HARD DISK ) HEX                   B/BUF SEC/BLK / CONSTANT SEC-LEN                                0 VARIABLE RW-BUFFER B/BUF ALLOT                                0 VARIABLE PARAM-BLOCK -2 ALLOT 10 C, 0 C,                      HERE 1 - SEC-LEN / , SEC-LEN , 7C0 ,                            ( We use the two l.s. bytes of 64 bit number)                                 1 , 0 , 0 , 0 ,                                    CODE WRITE-SYSTEM                                                PUSHX, SI|                                                      MOVXI, AX| 4300 W,                                              MOVXI, DX| 0080 W,                                              MOVXI, SI| PARAM-BLOCK W,                                       INT, 13  B,                                                     POPX, SI|                                                       PUSHF,                                                          NEXT C;            DECIMAL                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ." CRC CHECK FOR FIG  85JAN06 ALBERT VAN DER HORST"             ( Adapted from FORTH DIMENSIONS IV-3 )                           : ACCUMULATE ( oldcrc/char -- newcrc )                            $0100 * XOR                                                     8 0 DO                                                             DUP 0< IF $4002 XOR DUP + 1+ ELSE DUP + THEN                 LOOP ;                                                        : DISPOSE ( crcvalue/adres/len -- newcrcvalue)                     OVER DUP C@ "( = SWAP 1+ C@ BL = AND OVER 1 = AND IF               ( comment; skip it) DROP DROP ") WORD                        ELSE                                                               1+ OVER + SWAP DO I C@ ACCUMULATE LOOP                       THEN ;                                                       : MORE ( -- adr f  Leaves flag if there is more in the block)      BL WORD HERE DUP C@ 2 < OVER 1+ C@ "! < AND 0=               ;                                                               ." CRC 2 "                                                      : VERIFY-BLOCK ( oldcrc/blnr -- newcrc)                           BLK @ >R IN @ >R   BLK !  0 IN !                                BEGIN MORE WHILE                                                    BL OVER COUNT + C! COUNT DISPOSE                            REPEAT DROP ( drop the address left by MORE)                    R> IN ! R> BLK ! ;                                            : VERIFY ( scrnr/crc)                                             0 SWAP B/SCR * DUP B/SCR + SWAP DO                                 I VERIFY-BLOCK                                               LOOP                                                          ;                                                               : VER   SCR @ VERIFY U. ;                                                                                                                                                                                                                                      ( Test screen)                                                       For program exchange, the medium of hard copy is cheap,    convenient, and machine-independent. Its primary disadvantages  are the time required for hand-typing the source code and the   possibility of human error in the process. Even if the screens  LOAD without error messages, some errors may pass undetected    until run-time, when the system crashes mysteriously.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           CR ." CASSADY'S 8080 ASSEMBLER 81AUG17  >1<"                    HEX VOCABULARY ASSEMBLER IMMEDIATE : 8* DUP + DUP + DUP + ;     ' ASSEMBLER CFA ' ;CODE 8 + !        ( PATCH ;CODE IN NUCLEUS ) : CODE ?EXEC CREATE [COMPILE] ASSEMBLER !CSP ; IMMEDIATE        : C; CURRENT @ CONTEXT ! ?EXEC ?CSP SMUDGE ; IMMEDIATE          : LABEL ?EXEC 0 VARIABLE SMUDGE -2 ALLOT [COMPILE] ASSEMBLER        !CSP ; IMMEDIATE     ASSEMBLER DEFINITIONS                  4 CONSTANT H    5 CONSTANT L     7 CONSTANT A    6 CONSTANT PSW 2 CONSTANT D    3 CONSTANT E     0 CONSTANT B    1 CONSTANT C   6 CONSTANT M    6 CONSTANT SP     ' ;S 0B + @ CONSTANT (NEXT)   : 1MI <BUILDS C, DOES> C@ C, ;  : 2MI <BUILDS C, DOES> C@ + C, ; : 3MI <BUILDS C, DOES> C@ SWAP 8* +  C, ;                      : 4MI <BUILDS C, DOES> C@ C, C, ;                               : 5MI <BUILDS C, DOES> C@ C, , ;  : PSH1 C3 C, (NEXT) 1 - , ;   : PSH2 C3 C, (NEXT) 2 - , ;       : NEXT C3 C, (NEXT) , ;        -->                                                            CR ." CASSADY'S 8080 ASSEMBLER 81AUG17  >2<"                    00 1MI NOP     76 1MI HLT     F3 1MI DI     FB 1MI EI           07 1MI RLC     0F 1MI RRC     17 1MI RAL    1F 1MI RAR          E9 1MI PCHL    F9 1MI SPHL    E3 1MI XTHL   EB 1MI XCHG         27 1MI DAA     2F 1MI CMA     37 1MI STC    3F 1MI CMC          80 2MI ADD     88 2MI ADC     90 2MI SUB    98 2MI SBB          A0 2MI ANA     A8 2MI XRA     B0 2MI ORA    B8 2MI CMP          09 3MI DAD     C1 3MI POP     C5 3MI PUSH   02 3MI STAX         0A 3MI LDAX    04 3MI INR     05 3MI DCR    03 3MI INX          0B 3MI DCX     C7 3MI RST     D3 4MI OUT    DB 4MI IN           C6 4MI ADI     CE 4MI ACI     D6 4MI SUI    DE 4MI SBI          E6 4MI ANI     EE 4MI XRI     F6 4MI ORI    FE 4MI CPI          22 5MI SHLD    2A 5MI LHLD    32 5MI STA    3A 5MI LDA          CD 5MI CALL    C3 5MI JMP                                                      ( CZ,CNZ,CCY,CNC)  -->                                                                                           CR ." CASSADY'S 8080 ASSEMBLER 81AUG17  >3<"                    C9 1MI RET                   C2 CONSTANT 0=  D2 CONSTANT CS     E2 CONSTANT PE  F2 CONSTANT 0<   : NOT 8 + ;                    : MOV 8* 40 + + C, ;   : MVI 8* 6 + C, C, ;   : LXI 8* 1+ C, , ;: THEN HERE SWAP ! ;               : IF C, HERE 0 , ;           : ELSE C3 IF SWAP THEN ;           : BEGIN HERE ;               : UNTIL C, , ;                     : WHILE IF ;                 : REPEAT SWAP C3 C, , THEN ;                                    ;S                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              CR ." SIMPLE PROFILER AH   85FEB15"                             LABEL NEXT2      ( REPLACES NEXT!)                                 B LDAX   B INX   A L MOV                                        B LDAX   B INX   A H MOV   (NEXT) 6 + JMP C;                    (NEXT) 3 + JMP C;                                             ODE PROFILE  ( PATCHES THE CODE AT NEXT FOR PROFILING)            $C3 A MVI  (NEXT) STA                                           NEXT2 H LXI    (NEXT) 1+ SHLD     NEXT C;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                                ( STREAM READ ROUTINES CP/M 85/012/08  AH )                     : F_READ ( B,N-N2 Tries to read N char's to buffer B)                    ( N2 is number actually read, 0 for EOF)                    ( NOT  YET: NOW IT IS FILLED WITH ^Z, NOTHING RETURNED )    BEGIN                                                              SWAP GET-CHAR                                                   OVER C! 1+ SWAP 1 -                                             DUP 0=                                                       UNTIL                                                          ;                                                               : F_WRITE ( B,N-N2 Tries to write N char's from buffer B)            ( N2 is the number actually written to disk )                   ( NOT  YET: NOW IT IS UNCLEAR, NOTHING RETURNED )            TO-DISK                                                       ;                                                                                                                               ( DISC IO SCREEN 15 GENERAL  >1<   85/12/08 AH )                <HEX                                                            0A0D VARIABLE CRLF    1A VARIABLE CTRLZ                         : CLEAN-FCB DUP 21 0 FILL  1+ 0B 20 FILL ;                                                                                      : FILL-FCB 22 WORD                                                 1+ HERE  COUNT ROT SWAP CMOVE  ;                                                                                             : SET-DMA  1A BDOS DROP ;                                                                                                         -->                                                                                                                                                                                                                                                                                                                                                                                           ( DISC IO SCREEN 16 WRITE    >1<   85/12/08 AH )                0 VARIABLE DISK-BUFFER-W 100 ALLOT                              DISK-BUFFER-W VARIABLE POINTER-W                               0 VARIABLE FCB2   21 ALLOT  ( BUG: 2nd goes wrong)               : ?PRES ( .-. Aborts whether the entry is already present )        FCB2 0F BDOS 0FF - IF ." ALREADY PRESENT" QUIT THEN             FCB2 10 BDOS DROP ;                                          : .OPENW FCB2 CLEAN-FCB FCB2 FILL-FCB ?PRES                       FCB2 16 BDOS 0FF = IF ." DISK FULL " QUIT THEN                  DISK-BUFFER-W POINTER-W ! ;                                   : .CLOSEW                                                            DISK-BUFFER-W SET-DMA FCB2 15 BDOS . ." LAST RECORD" CR               FCB2 10 BDOS . ." CLOSE STATUS" CR ;                 : MOVE-DOWN   -80 POINTER-W +!                                                DISK-BUFFER-W 80 OVER + SWAP 80 CMOVE ;               -->                                                         ( DISC IO SCREEN 17 WRITE    >2<   85/12/08 AH )3<)             : TO-DISK DUP >R POINTER-W @ SWAP CMOVE                                   R> POINTER-W +!                                                 POINTER-W @ DISK-BUFFER-W -                                     80 >  IF   -->                                                     DISK-BUFFER-W SET-DMA FCB2 15 BDOS .                            MOVE-DOWN                                                   THEN ;                                                                                                                 : .WRITE  ( 2/0 WRITE SCREEN-1 .. SCREEN-2 TO DISK)                  1+ B/SCR * SWAP B/SCR * ( GET START BUFFER #'S)                   DO I BLOCK DUP                                                  40 -TRAILING TO-DISK  CRLF 2 TO-DISK                            40 + 40 -TRAILING TO-DISK CRLF 2 TO-DISK                      LOOP CTRLZ 1 TO-DISK                                       ;   HEX>                                                        ( DISC IO SCREEN 18 READ     >1<   85/12/08 AH )                <HEX  ( BUG: 64 char lines go wrong)                            0 VARIABLE DISK-BUFFER-R  80 ALLOT 0 VARIABLE POINTER-R          0A CONSTANT "LF"  0D CONSTANT "CR"                              1A CONSTANT ^Z    DISK-BUFFER-R 80 + CONSTANT END-BUF           0 VARIABLE EOF                                                 : .OPENR   FCB2 DUP CLEAN-FCB FILL-FCB                                END-BUF POINTER-R !                                             FCB2 0F BDOS 0FF = IF ." NOT PRESENT" QUIT THEN                 0 EOF ! ;                                                 : .CLOSER   FCB2 10 BDOS . ." CLOSE STATUS" CR ;                                                                                                                                                              -->                                                                                                                                                                               ( DISC IO SCREEN 19 READ     >2<   85/12/08 AH )                : ?EMPTY ( POINTER -- CORRECTED PNR, READ SECTOR IF AT END)         DUP END-BUF = IF DISK-BUFFER-R SET-DMA  FCB2 14 BDOS .                         DROP DISK-BUFFER-R THEN  ;                   : GET-CHAR                                                         POINTER-R @                                                       ?EMPTY                   ( GET NEW BUFFER IF NEEDED)            DUP C@ "LF" = IF 1+ ?EMPTY THEN ( SKIP OVER LF)                 DUP C@ SWAP              ( GET CHAR, POINTER ON TOP)            OVER ^Z =                                                        IF 1 EOF ! ELSE 1+ THEN ( INCREMENT POINTER UNLESS AT ^Z)    POINTER-R !  ;                                                                                                               -->                                                                                                                                                                                             ( DISC IO SCREEN 20 READ     >3<   85/12/08 AH )                : GET-LINE ( ADR -- . reads a line to ADR )                          DUP 40 20 FILL ( preset spaces )                                41 OVER + SWAP ( max $41 char to a line, CR!)                   DO  GET-CHAR                                                        DUP "CR" = IF DROP 20 LEAVE THEN                                DUP ^Z   = IF DROP 20 LEAVE THEN                                I C! ( may leave spurious 81th space)                       LOOP  ;                                                    : .READ ( 2/0 READ SCREEN-2 TO SCREEN -1)                            1+ B/SCR * SWAP B/SCR * ( get start buffer #'s)                 DO  I BLOCK DUP GET-LINE                                            DUP 40 + GET-LINE  81 + 0 SWAP C! UPDATE                        I #BUFF MOD 0= IF ( full load of buffers) FLUSH THEN        LOOP                                                      ; HEX>                                                           ( DISC IO SCREEN 21  LOAD    >1<   85/12/08 AH )                ( EXAMPLE: .OPENR TEMP" 25 26 .LOAD .CLOSER )                   <HEX  0 VARIABLE LBUF 3E ALLOT 0 C,                             : I-F-A ( ADRES -- . ,INTERPRET FROM ADDRESS )                      TIB @ >R  IN @ >R  ( SAVE CURRENT INTERPRET POSITION)           TIB !     0 IN !   ( NEW POSITION)                              0 INTERPRET                                                     >R IN !   >R TIB ! ( RESTORE)  ;                                                                                            : .LOAD ( LOAD THE CPM FILE SPECIFIED IN FCB2 )                         BEGIN   LBUF DUP GET-LINE I-F-A                                 EOF @ UNTIL ;                                                                                                                                                                              HEX>                                                                                                                        †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               ( POSTIT/FIXUP 8086 ASSEMBLER LOAD SCREEN AvdH HCC HOLLAND)     ASSEMBLER DEFINITIONS HEX                                       : 3PI <BUILDS C, C, C, DOES> POST, POST, POST, DROP ;           : 3FI <BUILDS C, C, C, DOES> <FIX 3 + FIX| FIX| FIX| DROP ;     8 0 8 1FAMILY| DR0| DR1| DR2| DR3| ILL| ILL| DR6| DR7|          8 0 4 1FAMILY| CR0| ILL| CR1| CR2|  00 20 0F 3PI MOVCD,         : GET-CR0   MOVCD, F| CR0| R| AX| ;                             : PUT-CR0   MOVCD, T| CR0| R| AX| ;                             : TO-PROT,  GET-CR0  INCX, AX|  PUT-CR0                           JMPFAR, HERE 4 + , 10 W, ;                                    : TO-REAL,  GET-CR0  DECX, AX|  PUT-CR0                         JMPFAR, HERE 4 + , 7C0 W, ;                                     66 1PI OS,   67 1PI AS, ( OPERAND AND ADDRESS SIZE OVERWRITE)   : NOP, XCHGX, AX| ;                                             : CP, MOVTA, B| SWAP DUP , 1 + MOVFA, SWAP DUP , 1 + ;          -->                                                             ( POSTIT/FIXUP 8086 ASSEMBLER SYSDEPENDANT AvdH HCC HOLLAND)    FORTH DEFINITIONS DECIMAL                                       : 2DROP DROP DROP ;                                             : ALIGN HERE 1 AND IF 0 C, THEN ;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ( AUXILIARY DEFINITIONS ) DECIMAL                               0 VARIABLE IDP   : <FIX HERE IDP ! ; : IHERE IDP @ ;            : C|, -1 IDP +! IHERE C@ OR IHERE C! ;  ( c.f. C, )             : C@+ COUNT ;  : C@- 1 - DUP C@ ; ( : C!+ >R R ! R> 1+ ;)       : MEM, , ; : R, HERE - 2 + , ; : B, C, ;  : W, , ; : SEG, , ;   : POST, C@+ C, ;       : FIX| C@- C|, ;                         : 1PI <BUILDS C, DOES> POST, DROP ;                             : 2PI <BUILDS C, C, DOES> POST, POST, DROP ;                    : 1FI <BUILDS C, DOES> <FIX 1+ FIX| DROP ;                      : 2FI <BUILDS C, C, DOES> <FIX 2+ FIX| FIX| DROP ;              : 1FAMILY,  ( INCREMENT, OPCODE , COUNT -- )                       0 DO DUP 1PI OVER + LOOP DROP DROP ;                         : 1FAMILY| 0 DO DUP 1FI OVER + LOOP DROP DROP ;                 : SPLIT 256 /MOD SWAP ; ( To handle two bytes at once )         : 2FAMILY, 0 DO DUP SPLIT 2PI OVER + LOOP DROP DROP ;           : 2FAMILY| 0 DO DUP SPLIT 2FI OVER + LOOP DROP DROP ;           ( POST-IT/FIX-UP 8086 ASSEMBLER , OPCODES AvdH HCCFIG HOLLAND)   8 0 4 1FAMILY| ES| CS| SS| DS|    1 6 2 1FAMILY, PUSHS, POPS,   HEX 8 26 4 1FAMILY, ES:, CS:, SS:, DS:,                         8 27 4 1FAMILY, DAA, DAS, AAA, AAS,                             1 0 2 1FAMILY| B1| W1|   08 04 8 1FAMILY, ADDAI, ORAI, ADCAI,  SBBAI, ANDAI, SUBAI, XORAI, CMPAI, 2 A0 2 1FAMILY, MOVTA, MOVFA, 1 0 2 1FAMILY| Y| N|   2 0 8 1FAMILY| O| C| Z| CZ| S| P| L| LE| 70 1PI J,  ( As in J, L| Y| <CALC> S, )                         1 0 8 1FAMILY| AX| CX| DX| BX| SP| BP| SI| DI|                  08 40 4 1FAMILY, INCX, DECX, PUSHX, POPX,    90 1PI XCHGX,      ( C7) 6 1FI MEM|   ( C0) 40 00 4 1FAMILY| D0| DB| DW| R|        ( 38) 08 00 8 1FAMILY| AX1| CX1| DX1| BX1| SP1| BP1| SI1| DI1|  ( 07) 1 0 8 1FAMILY| [BX+SI] [BX+DI] [BP+SI] [BP+DI]           [SI] [DI] [BP] [BX]                                              1 0 8 1FAMILY| AL| CL| DL| BL| AH| CH| DH| BH|                                                                                 ( POST-IT/FIX-UP 8086 ASSEMBLER , OPCODES AvdH HCCFIG HOLLAND)  1 0 2 2FAMILY| B| W|   2 0 2 2FAMILY| F| T|                     8 0 8 2FAMILY, ADD, OR, ADC, SBB, AND, SUB, XOR, CMP,           2 84 2 2FAMILY, TEST, XCHG,   0 88 2PI MOV,                     ( 00FD) 0 8C 2PI MOVSW,   ( 00FE) 0 8D 2PI LEA,                 ( IRR,egular)  ( FF) 9A 1PI CALLFAR,  ( FE) A8 1PI TESTAI, ( FF)1 98 8 1FAMILY, CBW, CWD, IR2, WAIT, PUSHF, POPF, SAHF, LAHF,   ( FE) 2 A4 6 1FAMILY, MOVS, CMPS, IR3, STOS, LODS, SCAS,        08 B0 2 1FAMILY, MOVRI, MOVXI,                                  8 C2 2 1FAMILY, RET+, RETFAR+,  8 C3 2 1FAMILY, RET,  RETFAR,   1 C4 2 1FAMILY, LES, LDS,  0 C6 2PI MOVI,  0 CD 1PI INT,        1 CC 4 1FAMILY, INT3, IRR, INTO, IRET,                          1 D4 4 1FAMILY, AAM, AAD, IL1, XLAT,                            1 E0 4 1FAMILY, LOOPNZ, LOOPZ, LOOP, JCXZ,                      2 E4 2 1FAMILY, INAP, OUTAP,  2 EC 2 1FAMILY, INAD, OUTAD,      1 E8 2 1FAMILY, CALL, JMP,  EA 1PI JMPFAR,  EB 1PI JMPS,        ( POST-IT/FIX-UP 8086 ASSEMBLER , OPCODES AvdH HCCFIG HOLLAND)  1 F0 6 1FAMILY, LOCK, ILL, REP, REPZ, HLT, CMC,                 1 F8 6 1FAMILY, CLC, STC, CLI, STI, CLD, STD, ( 38FE)           800 80 8 2FAMILY, ADDI, ORI, ADCI, SBBI, ANDI, SUBI, XORI, CMPI,800 83 8 2FAMILY, ADDSI, IL3, ADCSI, SBBSI, IL4, SUBSI, IL5,    CMPSI,   2 0 2 2FAMILY| 1| V|                                   800 D0 8 2FAMILY, ROL, ROR, RCL, RCR, SHL, SHR, IL6, RAR,       800 10F6 6 2FAMILY, NOT, NEG, MUL, IMUL, DIV, IDIV,             00 F6 2PI TESTI, 800 FE 2 2FAMILY, INC, DEC,                    ( 38FF) 00 8F 2PI POP,  30 FE 2PI PUSH,                         800 10FF 4 2FAMILY, CALLO, CALLFARO, JMPO, JMPFARO,                                                                                                                                                                                                                                                                                                                                             ( POST-IT/FIX-UP 8086 ASSEMBLER , POSTLUDE AvdH HCCFIG HOLLAND) VOCABULARY ASSEMBLER IMMEDIATE                                  ' ASSEMBLER CFA ' ;CODE 4 CELLS + !    ( PATCH ;CODE IN NUCLEUS)ASSEMBLER DEFINITIONS 92 95 HEX THRU DECIMAL                    : C; CURRENT @ CONTEXT ! ?EXEC ?CSP SMUDGE ; IMMEDIATE          : NEXT                                                               LODS, W1|                                                       MOV, W| F| R| DI| AX1|                                          MOV, W| F| R| BX| DI1|                                          JMPO, D0| [DI]                                              ;                                                              FORTH DEFINITIONS                                               : CODE ?EXEC CREATE [COMPILE] ASSEMBLER !CSP ; IMMEDIATE         CODE TEST NEXT  C;                                                                                                                                                                             ( Basic block manipulapions ) HEX ( ASSUMES BLOCK 90)           ALIGN 0 VARIABLE RW-BUFFER B/BUF ALLOT                          0 VARIABLE PARAM-BLOCK -2 ALLOT 10 C, 0 C,                      2 , ( 2 sectors/block) RW-BUFFER , 7C0 ,                        HERE 2 ALLOT  0 , 0 , 0 , CONSTANT BL#                           : R/W-BLOCK  ASSEMBLER                                           POPX, AX|            ADD, W| R| AX1| AX|                        MOVFA, W1| BL# W,    PUSHX, SI|                                 MOVXI, BX| W,   MOVXI, DX| 0080 W,                              MOVXI, SI| PARAM-BLOCK W,  TO-REAL, MOVI, W| AX| 7C0 MEM,      MOVSW, T| DS| AX| XCHGX, BX|                                    INT, 13 B, PUSHF, POPX, BX| TO-PROT,                             POPX, SI|   PUSHX, BX|  NEXT ;                                CODE READ-BLOCK 4200 R/W-BLOCK  C;                              CODE WRITE-BLOCK 4300 R/W-BLOCK  C;                             DECIMAL                                                         HEX ( copy a hd system, wa written to a floppy to the           hard disk. Done by a Forth booted from another floppy.)         40 CONSTANT HD-OFFSET                                           : COPY-FLOPPY                                                     HERE B/BUF / 1+ 0 DO                                              RW-BUFFER I 1 R/W                                               I WRITE-BLOCK 1 AND .                                         LOOP ;                                                        : RESTORE-BLOCKS 100 0 DO                                          RW-BUFFER I OFFSET @ + 1 R/W                                    I HD-OFFSET + WRITE-BLOCK 1 AND .                            LOOP ;                                                          : SAVE-BLOCKS 100 0 DO                                             I HD-OFFSET + READ-BLOCK 1 AND .                                RW-BUFFER I OFFSET @ + 0 R/W LOOP ;  DECIMAL                 : SAFE HD-OFFSET OFFSET @ = 17 ?ERROR ;                         ( Experimenting with drive parameters ) HEX                     B/BUF SEC/BLK / CONSTANT SEC-LEN                                0 VARIABLE RW-BUFFER B/BUF ALLOT                                0 VARIABLE PARAM-BLOCK -2 ALLOT 10 C, 0 C,                      HERE 1 - SEC-LEN / , SEC-LEN , 7C0 ,                            ( We use the two l.s. bytes of 64 bit number)                                 1 , 0 , 0 , 0 ,                                    CODE WRITE-SYSTEM                                                PUSHX, SI|                                                      MOVXI, AX| 4300 W,                                              MOVXI, DX| 0080 W,                                              MOVXI, SI| PARAM-BLOCK W,                                       INT, 13  B,                                                     POPX, SI|                                                       PUSHF,                                                          NEXT C;            DECIMAL                                    ( BASIC STYLE MINI EDITOR - FORTH DIM iii/2 @ SHAPIN)           HEX : TEXT HERE C/L 1+ BLANKS WORD HERE PAD C/L 1+ CMOVE ;      : LINE DUP FFF0 AND 17 ?ERROR SCR @ (LINE) DROP ;               : -MOVE LINE C/L CMOVE UPDATE ;                                 : P 1 TEXT PAD 1+ SWAP -MOVE ; DECIMAL                          ( Usage : to change line 1 of screen 3 )                        ( 3 SCR ! 1 P <CONTENT> )                                       : CLEAN BLOCK B/BUF OVER + SWAP DO                                I C@ 0= IF BL I C! THEN  LOOP ;                               : THRU 1+ SWAP DO ." LOADING " I . I LOAD LOOP ;                : L-S SCR @ LIST ; : LO-S SCR @ LOAD ;                          : C-S SWAP BLOCK SWAP BLOCK B/BUF CMOVE UPDATE FLUSH ;          : BIOSI BIOS DROP DROP DROP DROP DROP ;  ( Ignore result)       : MODE 0 0 0 16 BIOSI ;  : CELLS 0 CELL+ * ;                    : DISK-INIT 0 0 0 0 19 BIOSI ;                                  : LIST BASE @ 10 - 25 ?ERROR LIST ;                             ( MINI EDITOR FOR MSDOS ) HEX                                   B800 CONSTANT VID   050 CONSTANT VW   19 CONSTANT VH            VH VW * CONSTANT VL                                             : A-L SCR @ (LINE) ;                                            : VA ( I - VS,VO ) DUP + VID SWAP ;                             : >V ( $, OFFSET - )                                            SWAP 0 DO                                                        OVER I + C@ 700 OR   OVER I + VA LC!                           LOOP DROP DROP ;                                                : V> ( BUF -LEN OFFSET- )                                       SWAP 0 DO OVER I +   OVER I + VA                                 LC@ SWAP C!                                                    LOOP DROP DROP ;                                                : PAGE PAD VL 2DUP BLANKS 0 >V ;                                : PG PAD 10 VW * 2DUP BLANKS 0 >V ;                              DECIMAL                                                        HEX                                                             : GET-S 10 0 DO I A-L I VW * >V LOOP ;                          : PUT-S 10 0 DO I A-L I VW * V> LOOP UPDATE ;                   : GET-L PAD VW ROT VW * >V ;                                    : PUT-L PAD VW ROT VW * V> ;                                    ( 19 CONSTANT PB )   13 CONSTANT HW                             : PUSH-D 10 SWAP DO I 1+ PUT-L I GET-L LOOP ;                   : PUSH-DOWN VH SWAP DO I 1+ PUT-L I GET-L LOOP ;                : DEL-L DUP PUT-L VH  GET-L PUSH-DOWN ;                         : PUSH-UP VH DO I PUT-L I 1+ GET-L -1 +LOOP ;                   : UDL-L DUP PUSH-UP VH PUT-L GET-L ;                            : PUSH-U HW DO I PUT-L I 1+ GET-L -1 +LOOP ;                    : UFL-L DUP PUSH-U VH 1 - PUT-L GET-L ;                         : DUP-L DUP DEL-L DUP UFL-L UDL-L ;                                                                                              DECIMAL                                                        HEX ( CURSOR E.D.)                                              0 VARIABLE CURSOR                                                : CURL CURSOR @ VW / ; : CP CURSOR @ VW MOD  ;                  : BIOS-CURSOR CURSOR @ VW /MOD 100 * + ;                       : SET 200 0 0 BIOS-CURSOR 10 BIOS DROP DROP DROP DROP DROP ;    : MOVE-CURSOR   ( WORD STAR)                                    DUP ^D = IF  1 ELSE   DUP ^E = IF 0 VW - ELSE                   DUP ^I = IF  8 ELSE   DUP ^M = IF VW CP - ELSE                  DUP ^S = IF -1 ELSE   DUP ^X = IF VW ELSE                       0    THEN THEN THEN THEN THEN THEN CURSOR +! ;                  : DELSTORING DUP ^Y  = IF CURL DEL-L ELSE                             DUP ^P = IF CURL UDL-L ELSE                                     DUP ^U = IF CURL UFL-L                                          THEN THEN THEN ;                                          : DUP-L CURL DUP-L ;                                              DECIMAL                                                       HEX                                                             : PAD-B PAD VW BLANKS  ;                                        : GET-R PAD VW CP - CURL VW * CP + >V ;                         : GET-P PAD    CP   CURL VW *      >V ;                         : PUT-R PAD VW CP - CURL VW * CP + V> ;                         : RUBOUT-M PUT-R MINUS CURSOR +! GET-R ;                        : INSERT-M PUT-R DUP CURSOR +! GET-R MINUS CURSOR +! ;          : RUBOUT 1 RUBOUT-M ; : INSERT 1 INSERT-M ;                     : RUB-C PAD-B RUBOUT SET ;                                      : DEL-C 1 CURSOR +! RUB-C ;                                     : INS-C INSERT ;                                                : EOL PAD-B GET-R ;  : FOL PAD-B GET-P ;                        : SPL DUP-L PAD-B PUT-R CURL 1+ GET-L EOL ;                     : JOL PAD-B CURL 1+ PUT-L GET-R CURL 1+ PUSH-D ;                DECIMAL                                                                                                                         HEX                                                              0 VARIABLE I-MODE                                              : INSELETING                                                          DUP ^H = IF RUB-C ELSE                                          DUP ^G = IF DEL-C ELSE                                          DUP ^V = IF I-MODE 1 TOGGLE ELSE                                THEN THEN THEN ;                                          : JOINITTING                                                          DUP ^J = IF JOL   ELSE                                          DUP ^O = IF SPL   ELSE THEN THEN ;                        : EM-C EMIT 1 CURSOR +! ;                                       : PRINT ( C --C . Print it if printable)                          DUP 1F > IF DUP 7F < IF                                         I-MODE @   IF INS-C THEN  DUP EM-C                              THEN THEN ;                                                   DECIMAL                                                         ( DISPATCHER )    HEX                                           : AT-END VH 1 - VW * CURSOR ! SET ;                             : DEBUG CURSOR @ AT-END ^ CURSOR ! ;                            : EXITING KEY &Q - IF PUT-S THEN ;                              : ROUTE BEGIN KEY                                               PRINT DELSTORING                                                INSELETING JOINITTING                                           WORDING MOVE-CURSOR SET                                         ( DEBUG)                                                        ESC = UNTIL ;                                                   : E-S  ( EDIT CURRENT SCREEN )                                  FRAME 0 CURSOR ! SET   PG                                       GET-S ROUTE EXITING  AT-END BLACK ;                             :  EDIT SCR ! E-S ;                                             : E-R 3 MODE EDIT ;                                             DECIMAL                                                          ( Finding the next word)                                        : BL? VA L@ $FF AND BL = ;                                     : BOUNDARY? BL? 0= OVER 1 - BL? AND ;                           : >SEARCH BEGIN 1 + DUP BOUNDARY? UNTIL  ;                      : <SEARCH BEGIN 1 - DUP BOUNDARY? UNTIL  ;                      : NEXT-W CURSOR @ >SEARCH CURSOR ! ;                            : BACK-W CURSOR @ <SEARCH CURSOR ! ;                            : DEL-W  CURSOR @ NEXT-W SPL                                       CURSOR ! SET SPL CURL 1+ DEL-L JOL ;                         : VTYPE CURSOR @ >V ;                                           : GET-W VH 1 - PUT-L PAD VW -TRAILING 1+ ;                      : UFW GET-W INSERT-M DROP GET-W VTYPE ;                         : WORDING                                                         DUP ^F = IF NEXT-W ELSE   DUP ^A = IF BACK-W ELSE               DUP ^T = IF DEL-W ELSE    DUP ^Z = IF UFW ELSE                THEN THEN THEN THEN ;                                           : FROM-BIOS 100 /MOD VW * + CURSOR ! ;                          : GET 300 0 0 0 10 BIOS DROP FROM-BIOS  DROP DROP DROP ;        : P ( AT-END) GET ROUTE CURL PUT-L                                ( PAD SCRATCH BLOCK LL CMOVE )                                   AT-END CR PAD 50 1 - -TRAILING TYPE SPACE                       PAD TIB @ 50 CMOVE 0 IN !                                    ; ( IMMEDIATE  DOESN'T WORK VIA S)                              DECIMAL                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ( TROEP SCEHRM EDITOR)                                          : EKEY 1000 0 0 0 16 BIOS DROP DROP DROP DROP ;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          9 1 DO I J ! 5 SPACES ( eerst wat spaties)                             9 1 DO 9 J @ - I BORD @ EMIT SPACE LOOP CR                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       HEX   : HOME 1A EMIT ;   0 VARIABLE I-STATE                     : A-L    SCR @ (LINE) ; ( 1/2 ADDRESS OF LINE)                  : GET-L  A-L F000 SWAP CMOVE ; ( /0 MOVE LINE TO SCREEN)        : PUT-L  A-L F000 ROT ROT CMOVE ; ( /0 MOVE LINE FR SCREEN)     : DISPATCH ( 1/0 EXECUTE CONTROL CHARACTER)                     ( ^D) DUP  4 = IF  1B EMIT  57 EMIT  DROP ELSE                  ( ^I) DUP  9 = IF  I-STATE 1 TOGGLE  DROP ELSE                  ( ^X) DUP 18 = IF  1B EMIT  45 EMIT  DROP ELSE                  ( ^Y) DUP 19 = IF  1B EMIT  52 EMIT  DROP ELSE                  ( ^Q) DUP 11 = IF  ." ABORTED"       QUIT ELSE                    EMIT THEN THEN THEN THEN THEN ;                               : EMIT1  I-STATE @ IF  1B EMIT  51 EMIT  THEN EMIT ; ( 1/0)     : XX     BEGIN  KEY DUP DUP 20 <                                             IF DISPATCH ELSE EMIT1 THEN ( ^E) 5 = UNTIL  ;     : E-L    HOME DUP GET-L XX A EMIT PUT-L UPDATE ;                : C-L    SWAP A-L DROP SWAP A-L CMOVE  ;  -->                   ( GET-S   10 0 DO I A-L F000 I 80 * + SWAP CMOVE LOOP ;     )   ( PUT-S   10 0 DO F000 I 80 * + I A-L UPDATE CMOVE LOOP ;   )   ( CLEAN   F800 F000 DO I C@ 7F AND I C! LOOP ;              )   ( E-S     0 I-STATE !  HOME GET-S XX CLEAN PUT-S HOME )         ( EDIT SCR ! E-S )  : L-S SCR @ LIST ; : LO-S SCR @ LOAD ;      : INIT-STAR 1B 5 BDOS . 43 5 BDOS . 42 5 BDOS .                             1B 5 BDOS . 4E 5 BDOS . 4 5 BDOS . ;                : LAST-SEC ( 0/1 LEAVES ONE MORE THAN THE LAST BLOCK NR)            0 BEGIN 1+ F000 OVER 1 R/W DISK-ERROR @ UNTIL               ;                                                               : EXTEND   ( 1/0 EXTENDS # BLOCKS WITH NUMBER-1 )                 8 * LAST-SEC HOME ( GET AMOUNT OF BLOCKS)                       SWAP OVER + SWAP DO F000 I 0 R/W LOOP                           FCB 10 BDOS DROP    ( CLOSE THE FILE,I.E. UPDATE DIRECTORY)     FCB 0F BDOS DROP    ( OPEN AGAIN  )                           ;   DECIMAL                                                             ( SCR # 3 NIET DEBUGGED 84 AUG 24)                      : M-L-N 15 A-L DROP                                                  1 SCR +!  0 A-L CMOVE   -1 SCR +! ;                        : FETCH  ( 1/0 GET SCREEN-1 INTO MEMORY )                            FLUSH SWAP DUP FETCH                                            B/SCR * SWAP B/SCR * ( GET START BUFFER #'S)                    B/SCR 0 DO                                                         OVER I + BLOCK                                                  OVER I + 0 R/W ( zou gevaarlijk zonder FLUSH)                LOOP                                                            DROP DROP                                                                                                                  ;                                                                                                                                                                                                                                                               ( ERROR MESSAGES   )                                            MSG # 1 : EMPTY STACK                                           MSG # 2 : DICTIONARY FULL                                       MSG # 3 : HAS INCORRECT ADDRESS MODE                            MSG # 4 : ISN'T UNIQUE                                                                                                          MSG # 6 : DISK RANGE ?                                          MSG # 7 : FULL STACK                                            MSG # 8 : DISC ERROR !                                                                                                                                                                                                                                                                                                                                                                                                                                          ( FIG FORTH FOR CP/M 2.0 ADAPTED BY A. VD HORST HCCH )          ( ERROR MESSAGES   )                                            MSG # 17 : COMPILATION ONLY, USE IN DEFINITION                  MSG # 18 : EXECUTION ONLY                                       MSG # 19 : CONDITIONALS NOT PAIRED                              MSG # 20 : DEFINITION NOT FINISHED                              MSG # 21 : IN PROTECTED DICTIONARY                              MSG # 22 : USE ONLY WHEN LOADING                                MSG # 23 : OFF CURRENT EDITING SCREEN                           MSG # 24 : DECLARE VOCABULARY                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    (  DEBUG   SCR#6)    0 VARIABLE BASE'                          : <HEX   BASE @ BASE' ! HEX ;       ( 0/1  SWITCH TO HEX)       : HEX>   BASE' @ BASE !     ;       ( 1/0  AND BACK)            (        1/0  PRINT IN HEX REGARDLESS OF BASE)                  : H.     <HEX 0 <# # # # # #> TYPE SPACE HEX> ;                 (        1/0  IDEM FOR A SINGLE BYTE)                           : B.     <HEX 0 <# # # #> TYPE HEX> ;                           : BASE?  BASE @ H. ;                ( 0/0 TRUE VALUE OF BASE)   : ^      ( 0/0 NON DESTRUCTIVE STACK PRINT)                              CR ." S: " SP@ S0 @ ( FIND LIMITS)                              BEGIN OVER OVER = 0=                                            WHILE 2 - DUP @ H.                                              REPEAT                                                          DROP DROP                                              ;                                                                                                              -->              <HEX ( DEBUG SCR#7 )                                            :  DUMP   ( 2/0  DUMPS FROM ADDRESS-2 AMOUNT-1 BYTES)                     OVER + SWAP FFF0 AND                                            DO                                                                 CR I H. ." : "                                                  I                                                               10 0 DO                                                            DUP I + C@ B.                                                   I 2 MOD IF SPACE THEN                                        LOOP                                                            1B EMIT 67 EMIT                                                 10 0 DO DUP I + C@ EMIT LOOP                                    1B EMIT 47 EMIT                                                 DROP                                                         10 +LOOP         CR                                   ;    HEX>                                                       ." SYSTEM ELECTIVE CP/M FIGFORTH EXTENSIONS 84AUG12 AH"                                                                         ( EDITOR )         1 LOAD                                                                                                       ( HEX UT. )        6 LOAD                                       ( QUADR. ARITHM.)  9 LOAD                                       ( CP/M READ )     15 LOAD                                       ( CP/M WRITE)     18 LOAD                                       ( CP/M LOAD )     21 LOAD   ( BUGS)                             ( KRAKER )        10 LOAD                                       ( NEW SYSTEM)     23 LOAD                                       ( CRC )           71 LOAD                                       ( SPECIAL CHAR )  30 LOAD                                       ( ASSEMBLER)      74 LOAD                                       ( STAR PRINTER )  31 LOAD                                       ( CP/M CONVERT )  80 LOAD                                       ." QUADRUPLE ARITHMETIC 08-02-84 "                              : ADC ( n1,n2-n,c  add, leave sum and carry)                       0 SWAP 0 D+ ;                                                : 2M+ ( d1,d2-d,c  add double )                                   >R SWAP >R    ADC R> ADC   R> SWAP >R                           ADC R> + ;                                                    : 3M+ ROT >R 2M+ R> ADC ;                                       : 4M+ ROT >R 3M+ R> ADC ;                                       : 2U*  ( d1,d2-q unsigned product)                              ROT ( l1,l2,h2,h1)    OVER OVER U* >R >R ^                      ROT ( l1,h2,h1,l2)    OVER OVER U* >R >R ^                      SWAP DROP ROT ROT ( l2,l1,h2) OVER OVER U* >R >R ^              DROP ( l1,l2)    U* ^ R> ADC ^ R> ADC ^                          IF ( carry) R> R> 2M+ 1+ ." C" ELSE                                         R> R> 2M+    ." NC" THEN  ^                         R> R> 2M+ DROP ^ ;                                             CR ." 84NOV22  FORTH KRAKER >1<  ALBERT VAN DER HORST "         0 VARIABLE SELTAB 120 ALLOT   SELTAB VARIABLE SELTOP            : T,  ( N--. Put N in select table)                                 SELTOP @ !  2 SELTOP +!  ;                                  : CFOF ( --N Get cfa of word following )                           [COMPILE] ' CFA ;                                            : C->P 2 + ; ( N--N Converteer cfa naar pfa )                   : ID.. C->P NFA ID. ; ( cfa--. Print a words name )             : SEL@    ( N--M,F F="value N present in table" )                  ( if F then M is vector address else M=N)                          0 SWAP ( initialise flag)                                       SELTOP @ SELTAB DO                                                  DUP I @ = IF ( FOUND!) DROP DROP 1 I 2+ @ THEN              4 +LOOP        SWAP   ( get flag up)  ;                   : <> - 0= 0= ;  : CR 13 EMIT 10 EMIT ;                          30 LOAD 33 LOAD -->                                              CR ." 84NOV24  FORTH KRAKER >2<  ALBERT VAN DER HORST "          HERE VARIABLE LIM                                             : (KRAAK) ( CFA--. Decompile a word from its CFA )                 DUP NEXTN LIM ! ( Get an absolute limit)                        DUP @ SEL@ IF ( Is content of CFA known?)                          EXECUTE ( Assuming CFA also on stack)                        ELSE                                                               CR DROP DUP DUP @ 2 - = IF                                          ." Code definition : " ELSE ." Can't handle : "             ENDIF ID.. CR                                                ENDIF ;                                                      : KRAAK  ( Use KRAAK SOMETHING to decompile the word SOMETHING)     CFOF (KRAAK) ;                                              : ?IM  ( CFA--f tests whether word IMMEDIATE )                       C->P NFA C@ $40 AND ;                                      : ?Q ?TERMINAL IF QUIT THEN ; ( NOODREM) -->                    CR ." 84NOV24  FORTH KRAKER >3<  ALBERT VAN DER HORST "         : BY ( CFA--. the CFA word is decompiled using : )                T, CFOF T, ; ( a word from the input stream )                 ( Example of a defining word decompilation)                     ( It is done by examples of the defined words )                 : -co DUP C->P @ CR H. ." CONSTANT " ID.. CR ;                         CFOF 0 @ BY -co                                          : -va DUP C->P @ CR H. ." VARIABLE " ID.. CR ;                         CFOF SELTAB @ BY -va                                     : -us DUP C->P C@ CR B. ."  USER " ID.. CR ;                           CFOF FENCE @ BY -us                                      : ITEM ( 1/1 Desinterpret next item, increments pointer)            DUP @ SEL@ ( Something special ?)                               IF EXECUTE ( The special) ELSE                                     DUP ?IM IF ." [COMPILE] " THEN ID.. 2+                       THEN ; -->                                                  CR ." 84NOV24  FORTH KRAKER >4<  ALBERT VAN DER HORST "         CFOF TASK @ CONSTANT DOCOL ( Get the  DOCOLON address )         ( Decompilation of special high level words)                     : -hi CR ." : " DUP DUP ID.. 2 +  CR                             BEGIN ?Q DUP @  LIT ;S <> >R DUP LIM @ < R> AND WHILE                ITEM REPEAT                                                CR DROP ." ;" ?IM IF ."  IMMEDIATE " THEN CR ;                      CFOF TASK @  BY -hi                                       ( for all -words: 1/1 pointer before afd after execution)       : -lit 2+ DUP @ H. 2+ ;                                             CFOF LIT BY -lit                                            : -0br CR ." 0BRANCH [ " -lit ." , ] " ;                            CFOF 0BRANCH BY -0br                                        : -br  CR ." BRANCH  [ " -lit ." , ] " ;                            CFOF BRANCH BY -br                                           -->                                                            CR ." 84JAN06  FORTH KRAKER >5<  ALBERT VAN DER HORST "          : -dq 2+ DUP COUNT CR ". EMIT "" EMIT BL EMIT                      TYPE "" EMIT BL EMIT  COUNT + ;                                                         CFOF (.") BY -dq                                                                                     : -do CR ." DO " 2 + ;     CFOF (DO) BY -do                     : -lo CR ." LOOP " 2 + ;   CFOF (LOOP) BY -lo                   : -pl CR ." +LOOP " 2 + ;  CFOF (+LOOP) BY -pl                  : -cm ." COMPILE " -lit ;  CFOF COMPILE BY -cm                  ( DIRTY TRICK FOLLOWING :)                                      : -pc CR ." ;CODE plus code (suppressed)"                         DROP ' TASK ; ( Destroy deecompile pointer !)                     CFOF (;CODE) BY -pc                                                                                                                                                                                                                                        ( DISK IO SCREEN 15 SCHRIJVEN >1< VERSIE #1)                    <HEX  0 VARIABLE FCB2   21 ALLOT  ( BUG: 2nd goes wrong)        : CLEAN-FCB DUP 21 0 FILL  1+ 0B 20 FILL ;                      : FILL-FCB 22 WORD                                                 1+ HERE  COUNT ROT SWAP CMOVE  ;                             : SET-DMA  1A BDOS DROP ;                                       : ?PRES   FCB2 0F BDOS 0FF - IF ." ALREADY PRESENT" QUIT THEN      FCB2 10 BDOS DROP ;                                            -->                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ( SCR # 16 SCHRIJVEN >2<   )                                    0 VARIABLE DISK-BUFFER-W 100 ALLOT                              DISK-BUFFER-W VARIABLE POINTER-W                                : .OPENW FCB2 CLEAN-FCB FCB2 FILL-FCB ?PRES                       FCB2 16 BDOS 0FF = IF ." DISK FULL " QUIT THEN                  DISK-BUFFER-W POINTER-W ! ;                                   : .CLOSEW                                                            DISK-BUFFER-W SET-DMA FCB2 15 BDOS . ." LAST RECORD" CR               FCB2 10 BDOS . ." CLOSE STATUS" CR ;                 0A0D VARIABLE CRLF    1A VARIABLE CTRLZ                         : MOVE-DOWN   -80 POINTER-W +!                                                DISK-BUFFER-W 80 OVER + SWAP 80 CMOVE ;           : TO-DISK DUP >R POINTER-W @ SWAP CMOVE                                   R> POINTER-W +!                                                 POINTER-W @ DISK-BUFFER-W -                                     80 >  IF   -->                                       ( Experimenting with drive parameters ) HEX                     ALIGN 0 VARIABLE RW-BUFFER B/BUF ALLOT                          0 VARIABLE PARAM-BLOCK -2 ALLOT 10 C, 0 C,                      2 , ( 2 sectors/block) RW-BUFFER , 7C0 ,                        HERE 2 ALLOT  0 , 0 , 0 , CONSTANT BL#                           : R/W-BLOCK  ASSEMBLER  ( MACRO: OPCODE -- . )                   POPX, BX|    POPX, AX|                                          ADD, W| AX1| R| AX|  MOVFA, W1| BL# W, XCHGX, BX|               ADC, W| AX1| R| AX|  MOVFA, W1| BL# 2+ W,                       PUSHX, SI|  MOVXI, BX| W,  MOVXI, DX| 0080 W,                   MOVXI, SI| PARAM-BLOCK W,  TO-REAL,                             MOVI, W| AX| 7C0 MEM,  MOVSW, T| DS| AX|                        XCHGX, BX|                                                      INT, 13 B, PUSHF, POPX, BX| TO-PROT,                            POPX, SI|   PUSHX, BX|  NEXT ;                                DECIMAL                                                         ( TEST OF HARD DISK )                                           HEX  CODE READ-BLOCK2 4200 R/W-BLOCK  C;  ( D - . )              CODE WRITE-BLOCK2 4300 R/W-BLOCK  C; ( D - . )                 DECIMAL : TEST  0.                                                BEGIN  CR 2DUP D.                                                      2000. D+ ( SKIP 1 MEG)                                          2DUP READ-BLOCK2 1 AND UNTIL                           DROP DROP ;                                                     0 VARIABLE SYSTEM-OFFSET                                        HEX : SAVE 140 * SYSTEM-OFFSET !                                  140 0 DO I 0 READ-BLOCK2 .                                             SYSTEM-OFFSET @ I + 0 WRITE-BLOCK2 .                     LOOP ;                                                        : .ELECTIVE 140 U* 48. D+ READ-BLOCK2 . RW-BUFFER C/L TYPE ;    DECIMAL                                                         DECIMAL                                                         ( TEST OF HARD DISK )                                           HEX  CODE READ-BLOCK2 4200 R/W-BLOCK  C;  ( D - . )              CODE WRITE-BLOCK2 4300 R/W-BLOCK  C; ( D - . )                 DECIMAL : TEST  0.                                                BEGIN  CR 2DUP D.                                                      2000. D+ ( SKIP 1 MEG)                                          2DUP READ-BLOCK2 1 AND UNTIL                           DROP DROP ;                                                     0 VARIABLE SYSTEM-OFFSET                                        HEX : SAVE 140 * SYSTEM-OFFSET !                                  140 0 DO I 0 READ-BLOCK2 .                                             SYSTEM-OFFSET @ I + 0 WRITE-BLOCK2 .                     LOOP ;                                                        : .ELECTIVE 140 U* 48. D+ READ-BLOCK2 . RW-BUFFER C/L TYPE ;    DECIMAL                                                         DECIMAL                                                          CR ." READ CP/M files >3< AH   84/06/13"                        : GET-LINE ( ADR -- . reads a line to ADR )                          DUP 40 20 FILL ( preset spaces )                                41 OVER + SWAP ( max $41 char to a line, CR!)                   DO  GET-CHAR                                                        DUP "CR" = IF DROP 20 LEAVE THEN                                DUP ^Z   = IF DROP 20 LEAVE THEN                                I C! ( may leave spurious 81th space)                       LOOP  ;                                                    : .READ ( 2/0 READ SCREEN-2 TO SCREEN -1)                            1+ B/SCR * SWAP B/SCR * ( get start buffer #'s)                 DO  I BLOCK DUP GET-LINE                                            DUP 40 + GET-LINE  81 + 0 SWAP C! UPDATE                        I #BUFF MOD 0= IF ( full load of buffers) FLUSH THEN        LOOP                                                      ; HEX>                                                           ( 01-APR-83 LADEN VAN CP/M FILE  #1 )                           ( EXAMPLE: .OPENR TEMP" 25 26 .LOAD .CLOSER )                   <HEX  0 VARIABLE LBUF 3E ALLOT 0 C,                             : I-F-A ( ADRES -- . ,INTERPRET FROM ADDRESS )                      TIB @ >R  IN @ >R  ( SAVE CURRENT INTERPRET POSITION)           TIB !     0 IN !   ( NEW POSITION)                              0 INTERPRET                                                     >R IN !   >R TIB ! ( RESTORE)  ;                                                                                            : .LOAD ( LOAD THE CPM FILE SPECIFIED IN FCB2 )                         BEGIN   LBUF DUP GET-LINE I-F-A                                 EOF @ UNTIL ;                                                                                                                                                                              HEX>                                                                                                                         CR ." TAARTEN AUTOMATISERING DOOR DRS HENK" CR                  ." EEN VOORBEELD UIT BRODIE"     CR                             ." TYPE HELP VOOR DE GLOSSARY"  CR                              0 VARIABLE TAARTEN     0 VARIABLE DIEP-VRIES                    : HELP CR ." GLOSSARY:" CR ." BAK-TAART"                               CR ." EET-TAART" CR ." VRIES-IN" CR ." ONTDOOI"                 CR ." START" CR ." STATUS" CR ;                          : START 0 TAARTEN ! 0 DIEP-VRIES ! ;                            : BAK-TAART 1 TAARTEN +! ;                                      : EET-TAART TAARTEN @ DUP                                             IF -1 TAARTEN +! CR ." DANKJEWEL !" CR ELSE                       CR ." WELKE TAART ?" CR DROP THEN ;                     : VRIES-IN TAARTEN @ DIEP-VRIES +! 0 TAARTEN ! ;                : ONTDOOI DIEP-VRIES @ TAARTEN +! 0 DIEP-VRIES ! ;              : STATUS CR ." AANTAL AANWEZIGE TAARTEN: " TAARTEN ?              CR ." EN NOG " DIEP-VRIES ? ." IN DE DIEP VRIES " ;            ( EXTENDING THE FORTH SYSTEM #1 84/4/12 A.H.)                  <HEX                                                            : NEW-SYSTEM   ( Generates a new FORTH system, )                               ( using the CP/M SAVE command)                        LATEST PFA NFA 10C ! ( Define new topmost word)                 ( Initial value for VOC-LINK and FENCE:)                        HERE DUP 11C ! 11E !                                            HERE 100 / DECIMAL CR                                           CR ." TYPE: SAVE" . ." NEWFORTH.COM"                            BYE                                                        ;     HEX>                                                                                                                                                                                                                                                                                                                                                                                      ." GILBREATH's benchmark - BYTE jan 83 "  ( VERSIE #1)          8190 CONSTANT SIZE                                              0 VARIABLE FLAGS      SIZE ALLOT                                                                                                : DO-PRIME                                                          FLAGS SIZE 1 FILL                                               0 ( 0 COUNT ) SIZE 0                                            DO FLAGS I + C@                                                    IF I DUP + 3 +  ( DUP . )                                          DUP I +                                                         BEGIN DUP SIZE <                                                WHILE 0 OVER FLAGS +  C!  OVER + REPEAT                         DROP DROP 1+                                                 THEN                                                         LOOP                                                            . ." PRIMES" ;                                              ." ERATOSTHENES >1< Variables - A. van der Horst"  CR           ( User specified variables:)                                    52 VARIABLE CH/L  ( Characters per line)                        22 VARIABLE LN/P  ( Lines per page)                              1 VARIABLE PAUSE ( Boolean: pause between pages)                                                                               ( Other:)                                                       6250 CONSTANT SIZE ( 16 numbers pro byte)                       0 VARIABLE FLAGS      SIZE ALLOT                                FLAGS SIZE + CONSTANT END-FLAGS                                 0 VARIABLE LIM     ( part of FLAGS considered)                  0 VARIABLE C#      0 VARIABLE L#  ( char and line counter)      0 VARIABLE THOUSANDS ( #  thousand to be sieved)                0 VARIABLE MILS      ( Contains current thousand)               0 VARIABLE MANTISSA  ( The current thousands is to be printed)  -->                                                             ." ERATOSTHENES >2< Pretty printing - A. van der Horst"  CR     : FFEED  PAUSE @ IF CR ." KEY FOR NEXT SCREEN" KEY DROP THEN        12 EMIT CR ." ERATOSTHENES SIEVE -- PRIMES LESS THAN"           THOUSANDS @ 5 .R ."  000" CR 2 L# ! 1 MANTISSA ! ;          : ?P ( LENGTH -- . , give FF if LENGTH lines don't fat)              DUP L# +! L# @ LN/P @ > IF FFEED L# +! ELSE DROP THEN ;    : NEWLINE  ( Start at a new line, maybe with a mantissa)            1 ?P CR ( Checks first)                                         MANTISSA @ IF MILS @ 6 .R ELSE 6 SPACES THEN                    6 C# !   0 MANTISSA ! ;                                     : ?L ( LENGTH -- . , give LF if LENGTH char's don't fit)             DUP C# +! C# @ CH/L @ >                                         IF NEWLINE C# +! ELSE DROP THEN ;                          : .P   4 ?L SPACE 0 <# # # # #> TYPE ;                          : INIT-P  FFEED NEWLINE  ;   -->                                                                                                ." ERATOSTHENES >3< Bit manipulation - A. van der Horst " CR      HEX                                                           : NOT   0FF XOR ( N -- N  FLIP ALL BITS OF N) ;                 0 VARIABLE S-MASK -2 ALLOT 01 C, 02 C, 04 C, 08 C,                                         10 C, 20 C, 40 C, 80 C,              0 VARIABLE C-MASK -2 ALLOT                                                  01 NOT C, 02 NOT C, 04 NOT C, 08 NOT C,                         10 NOT C, 20 NOT C, 40 NOT C, 80 NOT C,             : INIT-T   FLAGS SIZE 0FF FILL ; ( Preset to 'prime')           DECIMAL                                                         : 8/MOD   0 8 U/ ; ( May be redefined in assembler )            : CLEAR-B ( BIT# --  clears the specified bit)                            8/MOD FLAGS + SWAP  ( Address in flags table)                   C-MASK + C@         ( Get mask)                                 OVER C@ AND SWAP C! ( Clear the bit)  ;               -->                                                             ." ERATOSTHENES >4< Bit manipulation - A. van der Horst " CR    : SET-B ( BIT# --  sets the specified bit)                                8/MOD FLAGS + SWAP  ( Address in flags table)                   S-MASK + C@         ( Get mask)                                 OVER C@ OR SWAP C!  ( Store with bit set)  ;          : TEST-B ( BIT# -- FLAG  Gets a FLAG testable by IF)                      8/MOD FLAGS + C@ SWAP  ( Get flag)                              S-MASK + C@ AND        ( Result: =0 or #0)     ;      : FLIP ( PRIME,START -- .  , marks multiples of PRIME as               (  non prime starting with START)                                  BEGIN  DUP LIM @ U<  WHILE                                             DUP CLEAR-B  OVER +                                      REPEAT   DROP DROP ;                                  -->                                                                                                                                                                                             ." ERATOSTHENES >5< Main program - A. van der Horst " CR        : BATCH1 ( First batch of 500 numbers)                               500 1 ( Only odd numbers)                                      DO I TEST-B                                                        IF I DUP + 1 + DUP .P ( get prime number)                          I FLIP THEN ( Mark multiple as non-prime)                 LOOP ;                                                      : BATCH ( OFFSET --  every  following batch )                        500 0                                                           DO DUP I + TEST-B IF I DUP + 1 + .P THEN                        LOOP DROP ;                                                : SIEVE  ( N --  Makes list of primes <N*1000 )                     DUP THOUSANDS !   500 * LIM !  0 MILS !                         INIT-T INIT-P 2 .P BATCH1                                       THOUSANDS @ 1                                                   DO I MILS !  1 MANTISSA !  NEWLINE I 500 * BATCH LOOP ;     ." DEFINIEER ^. EN  ''.  85JAN06 ALBERT VAN DER HORST"          <HEX                                                             : TOH 30 - DUP 9 > IF 7 - THEN ;                                   1 WIDTH !                                                    : ". ( 0/1 Leaves ASCII character at .  f.i. 'A leaves 41H)       HERE 2 + C@ [COMPILE] LITERAL ; IMMEDIATE                     : ^. ( 0/1 leaves control character at . f.i. ^A leaves 01H)      HERE 2 + C@ 1F AND [COMPILE] LITERAL ; IMMEDIATE              : $.. ( 0/1 leaves hex number f.i. $0A leaves 0AH)                HERE 2 + C@ TOH 10 * HERE 3 + C@ TOH + [COMPILE] LITERAL ;    IMMEDIATE                                                       : $.... ( 0/1 leaves hex number 16 bits)                           0 HERE 6 + HERE 2 + DO 10 * I C@ TOH + LOOP                     [COMPILE] LITERAL ; IMMEDIATE                                   1F WIDTH ! HEX>                                              $1B CONSTANT ESC    $0F CONSTANT SI   $0E CONSTANT SO          ." 84NOV25 Initialize STAR-printer AH "  <HEX                   : PEMIT 7F AND 5 BDOS DROP ;                                    : PCR   0D PEMIT   0A PEMIT ;                                   : INIT-STAR ( N--. N is lines per pages)                           ESC PEMIT "@ PEMIT ESC PEMIT "C PEMIT ( TOS) PEMIT ;         : CONDENSED  ESC PEMIT "P PEMIT "3 PEMIT ;                      : EMPHASIZED ESC PEMIT  "E PEMIT ;                              : DOUBLE ESC PEMIT "G PEMIT ;                                   : BOLD EMPHASIZED DOUBLE ;                                      ( 137 CH/L !    60 LN/P !     0 PAUSE ! )                        : PSPACES  ( 1/0 print N-1 spaces)                                0 DO 20 PEMIT LOOP ;                                          : PTYPE  ( ADDRESS,LENGTH -- . PRINT LENGTH CHAR AT ADDRESS)            -DUP IF                                                         OVER + SWAP DO I C@ PEMIT LOOP THEN ;                   : P."  "" WORD HERE COUNT PTYPE ;       -->                    ( SUPER-TRIO)                                                     0 VARIABLE L                                                  :  HEADER  CR DUP 3 + SWAP                                         DO 8 PSPACES ." SCR #" I 4 .R 36 PSPACES LOOP ;              : 1LINE  DUP 3 + SWAP                                                DO L @  DUP 8 .R I (LINE) PTYPE                                 LOOP PCR ;                                                  : SUPER-TRIO                                                      CONDENSED 3 /MOD SWAP DROP 3 *                                  DUP HEADER CR CR                                                10 0 DO  I L ! DUP 1LINE                                        LOOP  DROP ; HEX>                                                                                                                                                                                                                                                                                                            CR ." KRAAKER"                                                  : NEXTN ( CFA--NFA Get the NFA of the word defined)               C->P NFA LATEST             ( after the CFA one)                2DUP = IF                                                         DROP DROP HERE  ( No following word)                          ELSE                                                              BEGIN                                                              2DUP PFA LFA @ <> WHILE                                         PFA LFA @                                                    REPEAT                                                          SWAP DROP ( The CFA)                                          ENDIF                                                         ;                                                               : NEXTC ( CFA--CFA Like previous definition, giving CFA)          NEXTN PFA CFA ;                                                                                                               CR ." KRAAKER"                                                  : KRAAK-FROM ( .--. Kraak, starting with following word)          CFOF                                                            BEGIN                                                              DUP NEXTN HERE < WHILE                                          NEXTC DUP (KRAAK)                                            REPEAT                                                          DROP                                                          ;                                                               0 VARIABLE aux                                                  : PEMIT $7F AND 5 BDOS DROP ;                                   : TO-LP-KRAAK-FROM                                                ' EMIT @ aux !                                                  ' PEMIT CFA ' EMIT !                                            KRAAK-FROM                                                      aux @ ' EMIT ! ;                                              : A0 ;                                                          : A1 A0 A0 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    : A1 A1 A1 ;                                                    CR ." #36 FROBOZZ AMATEUR ADVENTURER >1< 84/4/5 "               ( DIRECTIONS )                                                  0 CONSTANT N  1 CONSTANT NE                                     2 CONSTANT E  3 CONSTANT SE   8 CONSTANT U                      4 CONSTANT S  5 CONSTANT SW   9 CONSTANT D                      6 CONSTANT W  7 CONSTANT NW                                     14 CONSTANT LEN ( gth of 1 entry in map)                        0 VARIABLE MAP LEN 256 * ALLOT                                  ( Offsets from entry in map :)                                  : [inuse] 0 + ; ( boolean : valid entry )                       : [dist] 1+ ; ( 0=unknown,1..FD=distance+1)                       0 CONSTANT UNK ( nown)   255 CONSTANT TRUE                    254 CONSTANT AMB ( iguous)   255 CONSTANT BLO ( cked)           : [dir] + 2+ ;  ( M D -- A address A from MAP entry M dir D)    : [char] 12 + ; ( characterisation : 2 bytes)                   : ZAP MAP LEN 256 * ERASE ;     -->                             CR  ." #37 FROBOZZ AMATEUR ADVENTURER >2< 84/5/27"              0 VARIABLE STATUS 10 ALLOT   ( last 10 moves)                   0 VARIABLE CURPOS ( This position in map)                       0 VARIABLE OLDPOS ( Previous position  in map)                  : SHIFT STATUS 1+ DUP 1 - 10 CMOVE ;                            STATUS 10 + CONSTANT LASTMOVE                                   : MAP[]   ( N -- M Converts position N to address M)                 LEN * MAP + ;                                              : CN   ( defines a characterization )                                   0 VARIABLE ; ( later misschien net vocabje)              CN AMBIGUOUS  CN BLOCKED  CN UNKNOWN                           : ID..   NFA ID. ;                                              : .CHAR  DUP MAP[] [char] @ ( N-- Print char'n)                   DUP IF                                                            DUP ID.. @ AMB = IF ." #" . ELSE DROP THEN                    ELSE    DROP ." PLACE:#" . THEN ;   -->                       CR ." #38 FROBOZZ AMATEUR ADVENTURER >3< 84/5/27"               : WHERE? CURPOS @ .CHAR ;                                       : C-CONNECT ( C P -- Cross connect links between an )              ( unambigous characterization and a position )                   2DUP SWAP !  ( Point from characterization to map address)      MAP[] [char] ! ( Store char'n in map)                       ;                                                               : P-CONNECT ( P1 P2 D -- Connect from P1 to P2 in direction D)      ROT MAP[] [dir] C!                                          ;                                                               : NEW-ENTRY ( -- n Find first free position n in MAP)               MAP 0  BEGIN 1+ SWAP LEN + SWAP OVER [inuse]  C@ 0= UNTIL       SWAP TRUE SWAP [inuse] !                                    ;              -->                                                                                                                                                                              CR  ." #39 FROBOZZ AMATEUR ADVENTURER >4< 84/4/8 "              : FILL-IN  ( Fills in the information from last move)              OLDPOS @ CURPOS @ LASTMOVE C@ P-CONNECT                      ;                                                               : DIRECTION ( N --  moves the status in direction N)                SHIFT DUP LASTMOVE C!                                           CURPOS C@ MAP[] [dir] C@ ( get # of next place in map)          DUP CR ." OSB: exit is : " .CHAR CR                             ( Is it an unknown exit?)                                       DUP 0= IF DROP NEW-ENTRY THEN                                   DUP BLO - IF ( Only change position if not blocked!)              CURPOS @ OLDPOS !  CURPOS !                                     FILL-IN ( Only effective by a new entry )                     ELSE                                                              DROP                                                          THEN  ;              -->                                   CR  ." #40 FROBOZZ AMATEUR ADVENTURER >5< 84/6/27"               : HERE: ( Defining word:makes a name for the current place)       CURPOS @ MAP[] [char] @ 0= IF                                      0 VARIABLE LATEST PFA CURPOS @ C-CONNECT                        FILL-IN ( The last position connection)                      ELSE                                                               CR ." This place already been characterized" QUIT            THEN ;                                                        : TEXT ." N  NE E  SE S  SW W  NW U  D  " ;                     : .DIR 1+ 3 * ' TEXT + 3 TYPE ;                                 : SEND-DIR 1+ 3 * ' TEXT + 3 PTYPE ;                            : EXIT?  ( Print current exits)                                   CURPOS @ MAP[] 10 0 DO                                            DUP I [dir] C@                                                  DUP BLO - IF CR I .DIR ." : " .CHAR ELSE DROP THEN            LOOP DROP ; -->                                              CR  ." #41 FROBOZZ AMATEUR ADVENTURER >6< 84/4/9 "               : CLEAR! ( N -- Clears a place)                                   MAP[] LEN ERASE ;                                             : AUX! ( P -- Characterizes with P the current place)              CURPOS @ MAP[] [char] @ IF                                        ." This place already characterized"                          ELSE                                                              CURPOS @ CLEAR! ( Throw away)                                   OLDPOS @ SWAP LASTMOVE C@ P-CONNECT                           THEN ;                                                        : HERE! @ DUP AUX! DUP CURPOS ! ; ( Use: TROLL HERE! )          : ALSO! AMB OVER ! CURPOS @ MAP[] [char] ! ; ( Use:MAZE ALSO!)  : BACKK    OLDPOS @ CURPOS !  ;                                 : BLOCKED! BLO AUX! BACKK ;                                     : AMB!     AMB AUX! ;                                           : KILL! DUP @ MAP[] [char] 0 SWAP !  0 SWAP ! ;   -->          CR  ." #42 FROBOZZ AMATEUR ADVENTURER >7< 84/6/28"              : P?    ( P -- Dumps a place)                                     CR ." PLACE# FL AU " TEXT ." CHAR"  CR                          DUP 3 .R 4 SPACES                                               DUP MAP[] LEN 2 - 0 DO DUP I + C@ B. SPACE LOOP DROP            .CHAR                                                         ;                                                               : PATCH ( Use: WHOUSE SHOUSE S PATCH )                                ROT @ ROT @ ROT P-CONNECT ;                               : ?FIX  MAP[] [char] @ DUP 0= 0= SWAP @ AMB = 0= AND ;          : ?SWAP ( P1 P2 -- {P1,P2} Change order such that )                     ( P2 has no fixed characterization)                       DUP ?FIX IF SWAP THEN                                           DUP ?FIX IF                                                          CR ." Places differently characterized"  QUIT              THEN  ;   -->                                                 CR  ." #43 FROBOZZ AMATEUR ADVENTURER >8< 84/4/19"              : REPLACE ( P1 P2--. Replace all references to P2 by P1)          ?SWAP   ( or the other way around if P2 characterized)          CURPOS @ OVER = IF                                                  OVER ( P1) CURPOS !                                         THEN                                                            256  0 DO ( For all place do)                                      I MAP[] 0 [dir] 10 OVER + SWAP DO ( For 10 dir's do)               I C@ OVER ( P2) = IF                                               OVER ( P1) I C!                                              THEN                                                         LOOP                                                         LOOP  DROP DROP                                               ;                                                                   -->                                                                                                                         CR  ." #44 FROBOZZ AMATEUR ADVENTURER >9< 84/5/27"              : MYSELF LATEST PFA CFA , ; IMMEDIATE                           : (IDENT)  ( n1 n1 -- Identify locations n1 and n2)               ?SWAP 2DUP REPLACE SWAP ( Destination location on top)          10 0 DO ( For all directions do)                                   OVER MAP[] I [dir] C@                                           OVER MAP[] I [dir] C@                                           2DUP = >R 2DUP UNK = SWAP UNK =  OR R> OR IF                       MAX OVER MAP[] I [dir] C!                                    ELSE                                                               CR MYSELF                                                    THEN                                                         LOOP                                                            DROP ( Destination location) CLEAR! ( Other)                  ;                                                               : FOUND! @ CURPOS @ (IDENT) ;                                   CR ." #45 FROBOZZ MAGIC COMMUNICATION >9A< 84/6/28 "             <HEX 54 3 C! HEX>                                              ( 30 LOAD 31 LOAD ( Get standard communication)                 0 VARIABLE REMEMBER 254 ALLOT ( keeps last message from host)   0 VARIABLE L-W-L ( Boolean: last character was line-feed)       : STORE ( C--. Store char in REMEMBER)                               127 AND ( strip parity)                                         DUP "> - IF ( unless prompt)                                       L-W-L @ IF 0 REMEMBER C! THEN                                   DUP REMEMBER COUNT + C!      ( Store char an place)             REMEMBER C@ 1 + REMEMBER C!  ( Bump count)                      ^J = L-W-L ! ( Keep flag)                                    ELSE DROP THEN  ;                                          : L-STORE ( A L -. Store A in list L )                           2 OVER +! DUP @ + ! ;    -->                                                                                                  CR  ." #46 FROBOZZ MAGIC COMMUNICATION >10< 84/6/27"                                                                            : ECR 13 4 BDOS DROP ;                                          : WAIT BEGIN 0 3 BDOS DUP EMIT DUP STORE                             127 AND   "> = ?TERMINAL OR UNTIL  ;                        : \ ( Sends a line and wait for a prompt)                           P." ECR ( Send the remainder of the line)                       WAIT ;                                                      : COM-DIR DUP SEND-DIR ECR WAIT DIRECTION ;                     : n N COM-DIR ;  : ne NE COM-DIR ;                              : e E COM-DIR ;  : se SE COM-DIR ;                              : s S COM-DIR ;  : sw SW COM-DIR ;                              : w W COM-DIR ;  : nw NW COM-DIR ;                              : u U COM-DIR ;  : d  D  COM-DIR ;                              : bl BLOCKED! ; : ex EXIT? ; : wh WHERE? ; -->                                                                                  CR  ." #47 FROBOZZ AMATEUR ADVENTURER >11< 84/6/12 "            : SEND-NAME  NFA COUNT 127 AND PTYPE ;                          : DROP! DUP @ IF DUP KILL! THEN                                     DUP CURPOS @ C-CONNECT   ' DROP SEND-NAME 32 PEMIT              SEND-NAME ECR WAIT ;                                        : MARK-AUX ( N-- Marks the exits from N)                          MAP[] DUP [dist] C@ 1+ ( Get the marking on top)                SWAP 0 [dir] 10 OVER + SWAP DO                                     I C@ MAP[] [dist] 2DUP C@ < IF                                    OVER SWAP C! ( I C@ MYSELF) ELSE                                DROP THEN                                                  LOOP  DROP  ;                                                 : M-D  MAP[] [dist] C! ; ( Mark distance)                       : INIT-AUX  ( Zeros all normal places)                            255 UNK M-D 255 AMB M-D 255 BLO M-D                             254 MAP[] [dist] 1 MAP[] [dist] DO 0 I C! LEN +LOOP ; -->     CR  ." #48 FROBOZZ AMATEUR ADVENTURER >12< 84/5/22 "            ( The [dist]'s are in a circular list for each distance)        ( The DIST-LIST contains the start entries in these lists)      0 VARIABLE DIST-LIST 50 ALLOT                                                                                                   : APPEND ( I,J --. Append place #J to Ith circular last)          OVER DIST-LIST + C@ 0= IF  ( so list was empty)                   DUP DUP MAP[] [dist] C! ( Make J refer to itself)               SWAP DIST-LIST + C! ( Make list I refer to place #J)          ELSE                                                               SWAP DIST-LIST + C@   ( Get start of circular last)             2DUP MAP[] [dist] C@ SWAP MAP[] [dist] C! ( Redarect 2nd)       MAP[] [dist] C! ( Make 1th of list point to new entry)       THEN ;   -->                                                                                                                                                                                  CR  ." #49 FROBOZZ AMATEUR ADVENTURER >13< 84/5/22 "                                                                            : MARK-EX ( I,N-- Appends all exits from N to the Ith list)       MAP[] 0 [dir] 10 OVER + SWAP DO                                    I C@ MAP[] [dist] C@ 0= IF ( This exit not yet marked)               DUP I C@ APPEND                                            THEN                                                         LOOP  DROP ;                                                  0 VARIABLE START                                                : MARK-NEW-LIST ( N -- Generate Nth circular list)                  0 OVER DIST-LIST + C! ( initialize to empty)                    DUP 1 - DIST-LIST + C@ DUP START C! ( Keep end of list)         BEGIN 2DUP MARK-EX MAP[] [dist] C@ DUP START C@ = UNTIL         DROP DROP ;                          -->                                                                                                                                                    CR  ." #50 FROBOZZ AMATEUR ADVENTURER >14< 84/5/27 "            : (M-U-F) ( N --M Generates circular lists )                           ( until place #N in last one or last list empty)                ( returns M: moves needed)                                 0 DIST-LIST !                                                   0 CURPOS @ APPEND ( Create 0th circular list )                  0 BEGIN                                                            1+ DUP MARK-NEW-LIST                                         OVER MAP[] [dist] C@ ( place N marked?)                         OVER DIST-LIST + C@ 0= ( dead end?) OR UNTIL                    SWAP DROP ;                                                                                                                    : M-U-F  INIT-AUX (M-U-F) ; ( N--M As M-U-F but initialized)    : L-U-U  ( --M Lists incorrect,find length to first UNKNOWN)       INIT-AUX   0 UNK M-D  UNK (M-U-F) ;                                -->                                                        C->P NFA LATEST             ( after the CFA one)                2DUP = IF                                                                  ( from place #K to #J in direction D)                           ( Leaves -1 if nothing found)                        -1 ROT ROT SWAP ( Initiate not found flag)                      MAP[] 0 [dir] ( get first exit from #K)                         10 0 DO                                                            2DUP I + C@ = IF                                                  DROP I ROT ROT LEAVE ( the direction as a flag)               THEN                                                         LOOP  DROP DROP ;                                                                             -->                                                                                                                                                                                                                                                                                             CR ." #52 FROBOZZ AMATEUR ADVENTURER >16< 84/6/12 "             : FIND-FROM ( M,J--D,N Find out place #N in sublist #J)                     ( from where to go in direction D to arrive at M)    DIST-LIST + C@                                                  BEGIN                                                              MAP[] [dist] C@ 2DUP ( get next place from list)                SWAP CONNECTED? -1 -                                         UNTIL                                                           DUP ROT CONNECTED? ( Repeat last,sucessful query)              ; -->                                                                                                                                                                                                                                                                                                                                                                                                                                                           CR ." #53 FROBOZZ AMATEUR ADVENTURER >17< 84/6/28 "                                                                             : F-P-B-N ( N--{0,DN..D2,D1} Find place by its number N)          ( N is reachable by going direction D1,D2..Dn)                  -1 SWAP ( leave stack bottom) DUP M-U-F                         DUP DIST-LIST + C@ IF                                              1 - -1 SWAP DO                                                     I FIND-FROM SWAP                                             -1 +LOOP DROP                                                ELSE                                                               CR ." CAN'T REACH THAT ROOM " CR                             THEN ;                                                                                                                        : GOTO!# ( Use: KITCHEN @ GOTO!# )                                 F-P-B-N CR BEGIN DUP 1+ WHILE COM-DIR CR REPEAT DROP ;       : GOTO!  @ GOTO!# ; ( Use: KITCHEN @ GOTO!# ) -->               CR  ." #54 FROBOZZ INTELLIGENT ENQUIRER >18< 84/6/12 "                                                                          : KEEP: ( Get the info from REMEMBER into a named buffer)         0 VARIABLE HERE 2 -   REMEMBER C@ ALLOT                         REMEMBER SWAP OVER C@ 1+ CMOVE ;                                                                                              : =$ ( S1,S2--F Leaves flag indication equality of strings)          1 ROT ROT ( Start with equal flag)                              DUP C@ 1+ 0 DO                                                     OVER I + C@ OVER I + C@ - IF                                       ROT DROP 0 ROT ROT ( Replace flag with 0) LEAVE              THEN                                                         LOOP DROP DROP  ;                                            -->                                                                                                                                                                                           CR  ." #55 FROBOZZ INTELLIGENT ENQUIRER >19< 84/5/27 "                                                                          : COMPARE-TEXTS ( T--F Leaves flag indicating whether one of th       ( from the array of pointers T has arrived)                 0 SWAP ( Start with no flag)                                    DUP @ -DUP IF                                                     0 DO                                                               DUP I 1+ 2 * + @ REMEMBER =$ IF                                    SWAP DROP 1 SWAP LEAVE                                       THEN                                                         LOOP                                                          THEN  DROP ;                                                                                                                    -->                                                                                                                                                                                           CR  ." #56 FROBOZZ INTELLIGENT ENQUIRER >20< 84/6/27"           0 VARIABLE BLK-TEXTS 10 ALLOT                                   : BLOCKED? BLK-TEXTS COMPARE-TEXTS IF                                     BLOCKED!                                                     ELSE                                                               CR ." Please do by hand! " CR QUIT                           THEN ;                                                   : TRY-HERE ( investigates all exits of the current position)       ( If it discovers blocked exits, it will take care of that,)    ( Special cases are left to the adventurer himself)            CURPOS @ MAP[] 0 [dir] 10 0 DO                                    DUP I + C@ UNK = IF                                                I SEND-DIR ECR WAIT ( try this direction)                       I DIRECTION    BLOCKED?                                      THEN                                                          LOOP ;   -->                                                  CR  ." #57 FROBOZZ INTELLIGENT ENQUIRER >21< 84/6/27 "                                                                          : TRY-EVERY-WHERE ( As TRY-HERE but in the whole map)           TRY-HERE                                                        BEGIN  ?TERMINAL 0= WHILE                                         L-U-U 1 - DIST-LIST + C@ ( Get some place from prev. list)      M-U-F UNK SWAP FIND-FROM                                        DROP ( direction found)                                         GOTO!# ( the place with an UNknown exit)                        TRY-HERE                                                        BLOCKED?                                                      REPEAT                                                          ;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              0                                                                1                                                                2                                                                3                                                                4                                                                5                                                                6                                                                7                                                                8                                                                9                                                                a                                                                B                                                                C                                                                D                                                                E                                                                F                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 CR ." #70 FROBOZZ AMATEUR ADVENTURER >12< 84/4/8"                ( ****** START SITUATIE *****************)                      ZAP                                                             UNKNOWN UNK C-CONNECT    BLOCKED BLO C-CONNECT                  AMBIGUOUS AMB C-CONNECT                                         CHARACTERIZATION WHOUSE                                         WHOUSE NEW-ENTRY C-CONNECT                                      1 CURPOS !                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ." CRC CHECK FOR FIG  85JAN06 ALBERT VAN DER HORST"             ( Adapted from FORTH DIMENSIONS IV-3 )                           : ACCUMULATE ( oldcrc/char -- newcrc )                            $0100 * XOR                                                     8 0 DO                                                             DUP 0< IF $4002 XOR DUP + 1+ ELSE DUP + THEN                 LOOP ;                                                        : DISPOSE ( crcvalue/adres/len -- newcrcvalue)                     OVER DUP C@ "( = SWAP 1+ C@ BL = AND OVER 1 = AND IF               ( comment; skip it) DROP DROP ") WORD                        ELSE                                                               1+ OVER + SWAP DO I C@ ACCUMULATE LOOP                       THEN ;                                                       : MORE ( -- adr f  Leaves flag if there is more in the block)      BL WORD HERE DUP C@ 2 < OVER 1+ C@ "! < AND 0=               ;                                                               ." CRC 2 "                                                      : VERIFY-BLOCK ( oldcrc/blnr -- newcrc)                           BLK @ >R IN @ >R   BLK !  0 IN !                                BEGIN MORE WHILE                                                    BL OVER COUNT + C! COUNT DISPOSE                            REPEAT DROP ( drop the address left by MORE)                    R> IN ! R> BLK ! ;                                            : VERIFY ( scrnr/crc)                                             0 SWAP B/SCR * DUP B/SCR + SWAP DO                                 I VERIFY-BLOCK                                               LOOP                                                          ;                                                               : VER   SCR @ VERIFY U. ;                                                                                                                                                                                                                                      ( Test screen)                                                       For program exchange, the medium of hard copy is cheap,    convenient, and machine-independent. Its primary disadvantages  are the time required for hand-typing the source code and the   possibility of human error in the process. Even if the screens  LOAD without error messages, some errors may pass undetected    until run-time, when the system crashes mysteriously.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           CR ." CASSADY'S 8080 ASSEMBLER 81AUG17  >1<"                    HEX VOCABULARY ASSEMBLER IMMEDIATE : 8* DUP + DUP + DUP + ;     ' ASSEMBLER CFA ' ;CODE 8 + !        ( PATCH ;CODE IN NUCLEUS ) : CODE ?EXEC CREATE [COMPILE] ASSEMBLER !CSP ; IMMEDIATE        : C; CURRENT @ CONTEXT ! ?EXEC ?CSP SMUDGE ; IMMEDIATE          : LABEL ?EXEC 0 VARIABLE SMUDGE -2 ALLOT [COMPILE] ASSEMBLER        !CSP ; IMMEDIATE     ASSEMBLER DEFINITIONS                  4 CONSTANT H    5 CONSTANT L     7 CONSTANT A    6 CONSTANT PSW 2 CONSTANT D    3 CONSTANT E     0 CONSTANT B    1 CONSTANT C   6 CONSTANT M    6 CONSTANT SP     ' ;S 0B + @ CONSTANT (NEXT)   : 1MI <BUILDS C, DOES> C@ C, ;  : 2MI <BUILDS C, DOES> C@ + C, ; : 3MI <BUILDS C, DOES> C@ SWAP 8* +  C, ;                      : 4MI <BUILDS C, DOES> C@ C, C, ;                               : 5MI <BUILDS C, DOES> C@ C, , ;  : PSH1 C3 C, (NEXT) 1 - , ;   : PSH2 C3 C, (NEXT) 2 - , ;       : NEXT C3 C, (NEXT) , ;        -->                                                            CR ." CASSADY'S 8080 ASSEMBLER 81AUG17  >2<"                    00 1MI NOP     76 1MI HLT     F3 1MI DI     FB 1MI EI           07 1MI RLC     0F 1MI RRC     17 1MI RAL    1F 1MI RAR          E9 1MI PCHL    F9 1MI SPHL    E3 1MI XTHL   EB 1MI XCHG         27 1MI DAA     2F 1MI CMA     37 1MI STC    3F 1MI CMC          80 2MI ADD     88 2MI ADC     90 2MI SUB    98 2MI SBB          A0 2MI ANA     A8 2MI XRA     B0 2MI ORA    B8 2MI CMP          09 3MI DAD     C1 3MI POP     C5 3MI PUSH   02 3MI STAX         0A 3MI LDAX    04 3MI INR     05 3MI DCR    03 3MI INX          0B 3MI DCX     C7 3MI RST     D3 4MI OUT    DB 4MI IN           C6 4MI ADI     CE 4MI ACI     D6 4MI SUI    DE 4MI SBI          E6 4MI ANI     EE 4MI XRI     F6 4MI ORI    FE 4MI CPI          22 5MI SHLD    2A 5MI LHLD    32 5MI STA    3A 5MI LDA          CD 5MI CALL    C3 5MI JMP                                                      ( CZ,CNZ,CCY,CNC)  -->                                                                                           CR ." CASSADY'S 8080 ASSEMBLER 81AUG17  >3<"                    C9 1MI RET                   C2 CONSTANT 0=  D2 CONSTANT CS     E2 CONSTANT PE  F2 CONSTANT 0<   : NOT 8 + ;                    : MOV 8* 40 + + C, ;   : MVI 8* 6 + C, C, ;   : LXI 8* 1+ C, , ;: THEN HERE SWAP ! ;               : IF C, HERE 0 , ;           : ELSE C3 IF SWAP THEN ;           : BEGIN HERE ;               : UNTIL C, , ;                     : WHILE IF ;                 : REPEAT SWAP C3 C, , THEN ;                                    ;S                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              CR ." SIMPLE PROFILER AH   85FEB15"                             LABEL NEXT2      ( REPLACES NEXT!)                                 B LDAX   B INX   A L MOV                                        B LDAX   B INX   A H MOV   (NEXT) 6 + JMP C;                    (NEXT) 3 + JMP C;                                             ODE PROFILE  ( PATCHES THE CODE AT NEXT FOR PROFILING)            $C3 A MVI  (NEXT) STA                                           NEXT2 H LXI    (NEXT) 1+ SHLD     NEXT C;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               †                                                                                                                               лuРDFW---HD  а @р	             )@           FAT12      ј       Є BЇА Њ> Ќ√и` ∞ і ≤PЌиU ∞ иk Й»иK ∞ иa ∞Dи\ М»!јuкЗ ј∞FиL ъМ»ОЎО–ОјЉ  ыі ≤PЌrєи™€rі∞Wи- и йO∞и" ∞
й XPPИаи XP±“ши X$'Иƒ±“м00€іЌ√                                                                                                                                                                                                                                                                                               U™Рй!Рй Љ Єч@     чЄчч    ««Е (≥ЄчЄч    ЬP°0	јt=€€t9рtw°2	јt9рrЭлXЭ≠Й√лRP≠Й√ЙЏB€'ГLI‘  o≠лмЗEXECUT≈g~[лбЖBRANC»rМ4лѕЗ0BRANC»БЬX	јtлFFлЇЖ(LOOP©Р∞ї ^ ЛF +F1ЎxћГ≈FFлШДNOO–•““лЛ÷лЗЏлГЗ(+LOOP©«и[л»Д(DO©№фZXЗмPRЗмй`€Б…лЛF йS€ЕDIGI‘€ZX,0r<	v,<
r8–s	)“И¬∞й+€)јй'€Ж(FIND©BМЎОј[YЙѕКИ¬2$?uCGК2 јusфГ√SЄ (цйсюCrК јлчЛ	џuЌЄ  йЁюЗENCLOS≈7НX[Sі Ї€€KCB:tъR:'uЙ–BйґюCB:t	:'uцЙ–йІюЙ–@й°юВC“Б.m
 EЕCMOV≈Љ’ьЙуY_^МЎОју§ЙёйyюВU™ЋнX[чгТйhюВUѓжь[ZX9ЏsчуйUюЄ€€Й¬йMюГANƒхX[!Ўй?юВO“&X[	Ўй1юГXO“5X[1Ўй"юГSPј-DЙайюГSP°<QЛ,ЛgйюГRPјIcЙийцэГRP°[pЛ,ЛoйеэВ;”hБЛv EEй÷эЕLEAV≈zУЛF ЙFй√эВ>“Й£[MMЙ^ й≥эВRЊЬ≥ЛF EEй£эБ“ђВ0љї»X	јЄ tHйКэВ0ЉЅџX	јЄ xHйwэБЂ‘нX[ЎйjэВDЂзыXZ[Y ЎйWэЕMINU”фXчЎйHэЖDMINU”![Y)јЙ¬) Ўй/эДOVE“7ZXPй эДDRO–.FXйэДSWA–=SZXйэГDU–J`XPйщьД2DU–XnXZRPйиьВ+°e|[Xй№ьЖTOGGL≈uОX[0й ьБјГЫ[ЛйљьВCјХ®[К(дйЃьВ2ј°Ј[ЛЛWйЭьБ°∞∆[XЙйТьВC°ј‘[XИйДьВ2°Ќв[XЙXЙGйrьВLјџф[YМЏОўЛОЏй]ьВL°н[YМЏОўXЙОЏйIьЅЇ.„	Т	–Щ¬ƒ\
ѓ
BMMЙv Й÷й&ьЅї.
8
q
N
ИCONSTAN‘9.q
Yѓ
BЙ”ЛйцыИVARIABL≈K.Vѓ
BRйбыДUSE“h.Vѓ
BЙ”К(€Л>,Нй√ыБ∞~°1јйЄыБ±ЫђЄ йђыБ≤¶ЄЄ й†ыБ≥≤ƒЄ йФыВBћЊ`  ГC/ћ `@ ЕFIRS‘”`шчЕLIMI‘Ё`  ВEЌй`  ЕB/BU∆х` ЕB/SC“ю` З+ORIGIќ
.m лВS∞Л ВR∞*Л ГTI¬3Л
 ЕWIDT»<Л ЗWARNIN«FЛ ЕFENC≈RЛ ВD–`Л ИVOC-LINЋlЛ ГBLЋuЛ ВIќДЛ ГOU‘ОЛ ГSC“ЧЛ ЖOFFSE‘°Л  ЗCONTEX‘ЂЛ  ЗCURREN‘ЄЛ" ЕSTAT≈∆Л$ ДBAS≈‘Л& ГDPћаЛ( ГFLƒлЛ* ГCS–хЛ, ВR£€Л. ГHLƒ	Л0 В1Ђ#X@й6ъВ2Ђ/X й(ъДHER≈(.qЩЕALLO‘6.qzБђE.=ƒґMВCђU.=“™MБ≠e|ZX)–йџщБљv.z∆БЉГХZXЙ”1√x)–	јЄ  y@йіщВUЉП.l3ўЪ Dў∆К zўБЊ™.QУГRO‘ЋяZ[XSйwщЕSPAC≈„.ѕEД-DU–ж.^Ъ ^ИTRAVERS≈ц.Q5лm 5¶УЪр€QDЖLATES‘		.–ЩЩГLFЅ0	.m zГCFЅC	.ґzГNFЅS	.m zm€€	ГPFЅa	.™	m лД!CS–w	.BƒЖ?ERRO“Л	.QЪ ОК DЕ?COM–Ь	.№Щ∆m •	Е?EXE√Ј	.№Щm •	Ж?PAIR”ѕ	.zm •	Д?CS–е	.BЩzm •	И?LOADIN«ъ	.КЩ∆m •	ЗCOMPIL≈
.њ	±^-°ЩYЅџ.
.Я№ƒБЁJ
.mј №ƒЖSMUDG≈X
.9	m  МГHEЎh
.m зƒЗDECIMAћ}
.m
 зƒЗ(;CODE©П
.±9	}	Y	ƒ≈;COD≈•
.
8
ѓ
N
ќЗ<BUILD”љ
.ЯVЕDOESЊ”
.±9	}	ƒѓ
ЗмVЗмBЙ”Л7BBRйVчЕCOUN‘е
.^!Q¶Й-TRAILIN«	.^Ят55л™z¶ѕzЪ СК ™zЃа€Д(."©.њ^!±л°¬.ҐU.m" №ЩЪ 8
\`=¶!MК
 `=ЕQUERўp.BЩmP yЯУƒЅАЯ.КЩЪ* ™КzЯУƒКЩ™z∆Ъ „	±DК ±DДFILћї XY_МџО√ьу™йRцЕERAS≈ч.ЯюЖBLANK”.ѕюДHOLƒ.m€€zЩ“ГPAƒ..=mT лДWORƒG.КЩЪ КЩAК BЩУЩлQЛ=m" &Уz5z°њ=“л=!±”И(NUMBER©Y.!^°¶зЩЪ, QзЩлDЁзЩлщсЩ!Ъ ™сz±К∆€±ЖNUMBE“¶.ЯЯЁ^!¶m- З^°лm€€сƒ±^¶ѕzЪ ^¶m. zЯ•	ЯК№€D±Ъ Е-FINƒу.ѕ`=¬ЩЩ@^∆Ъ
 D=9	@З(ABORT©L.еЕERRO“v.\ЩўЪ А=\? OКЩэЪ УЩQЄГIDЃЖ.Mm  m_ ю^}	I	5zMQ”Mm ™zlл¶m EоЖCREAT≈љ.TЪ Dg	√m о=^¶NЩя!M^m† М=™zmА М9	Y–Щƒ=-Y…[COMPILEЁ.T∆Я•	DY	Y«LITERAћX.№ЩЪ 8
mY»DLITERAћv.№ЩЪ QААЖ?STACЋТ.B/ЩQѓ™•	B=mА лѓm •	ЙINTERPRE‘ѓ.TЪ №ЩУЪ
 Y	YК Y	|ЄК =ьсЩ!Ъ ЭК DАЄК¬€ЙIMMEDIAT≈№.9	m@ МКVOCABULARў*.Ё
mБ†Y–ЩY	Y=АЩYАƒн
-¬ƒ≈FORT»Bщ
oБ†Љ  ЛDEFINITION”w.¬Щ–ƒЅ®Й.m) `ДQUI‘£.ЯКƒN
nЅІи№Щ∆Ъ \OKКз€ЕABOR‘±.OЩ
ЄЅc\IBM-PC Fig-Forth 2.0.CЧЄЊйIтДWARЌЁ.№еЊNЄ  ОЎїМ НЙCCММ»ОЎЛ&О–ОјьЛ..йтWДCOLƒ.№еkƒеvƒmm,Щm ”mЩmЕƒеДS->ƒPОZ)ј	“yHйƒсВ+≠Е.ўЪ ГD+≠Щ.ўЪ ГAB”™.^ЮДDAB”Љ.^∞ГMIќ .lѕЪ QDГMAЎў.lУЪ QDВM™п.l3°¬Q¬л±∞ВMѓ.5°°—њ¬ъ±њ3ЮQ±ЮQБ™ .
DД/MOƒG.°М±%БѓS.ZQDГMOƒf.ZDЕ*/MOƒt.°
±%В*ѓВ.КQDЕM/MOƒЦ.°Яњъ±Q°ъ±Ж(LINE©•.°m@ К±KлAлm@ Е.LIN≈√.ћ)ЗMESSAG≈к.\ЩЪ эЪ
 m тоК \MSG # 'ГPCјь7Zм(дй рГPC°/FZXойрВPј>SZнйрВP°L_ZXпйъпГUS≈XyшчДPRE÷eyшчЕ#BUF∆o` Д+BU∆z.mл^сЗЪ Dе^vЩzЖUPDAT≈Ж.vЩЩm А$vЩƒНEMPTY-BUFFER”≠.ес5zЖBUFFE“ћ.m€ kЩ^°НЪь€kƒњЩўЪ њ-њЩm€Я~њƒњvƒ±-ЕBLOCЋк.m€ іЩл°vЩ^Щњz^лЪ4 Н∆Ъ Dњу^њ™~ґz^Щњz^л∆Ъ÷€^vƒ±D-ЕFLUS»9.В!ЯтЯуDЃш€ДLOAƒЯ.КЩ°УЩ°ЯУƒKКƒи±Уƒ±Кƒ√--Њљ.
ЯУƒКЩ5zzКzДBIO”рXҐ&ZY[XVUЌ ]^PSQRЬй.оДBDO”:ZY[XЌ!PSQRЬйоЕSMALћ1.mOm
ЯЯm DDDDDЖEXPEC‘H.5л5ту^m  ЩЗЪ* D^З^±ґzл°Ъ
 m К m К( ^m ЗЪ СDѕЯК ^“Я!ƒEЃЬ€DГKEўp.m ЯЯЯm DDDDm€ ДTYP≈н.эЪ 5лQт¶EЃш€К DДEMI‘.™Эzm ^m
 ЗЪ m xЯЭƒxЖ(EMIT©>.m лЯЯЯm DDDDDЙ?TERMINAћo.m ЯЯЯm m@ ∆°DDDD±ДPOU‘Ш.ЯЯЯm DDDDDЕDRIV≈ћy  ЖRECORƒнy  ЗSEC/BLЋщ` КDISK-ERRO“y  ЖLBAPA“y    ј        ДRBLЋ%IXVЙ∆UЄ BЇА Ќ]^ЬймДWBLЋ@eXVЙ∆UЄ CЇА Ќ]^ЬйзлГR/„\.°m K.m лƒ.m лƒ.њЪ GК c^!ƒ™^Ъ m	 ±z•	ЅІx.T∆Я•	DАЖFORGE‘».–Щ¬Щzm •	ћ^hЩУm •	^g	qƒI	Щ¬ЩƒДBACЋ№.=zY≈BEGIќ.њ	=™≈ENDI∆,.њ	ґо	=5zQƒƒTHEќ>.F¬DѕZ.8
т=¬ƒLOO–g.¬о	8
Ѓ"≈+LOO–x.¬о	8
ж"≈UNTIћН.™о	8
Ъ"√ENƒ£.Ђ≈AGAIќє.™о	8
К"∆REPEA‘≈.°°Ќ±±ґzF¬I∆џ.8
Ъ=ЯYґƒELS≈ш.ґо	8
К=ЯYQґFґ≈WHIL≈.э-ЖSPACE”..ЯхэЪ ЯтоЃь€В<£>.MƒВ#Њ_.DDЩM5zДSIGќn.ЁўЪ m- 5Б£Е.зЩ≠Ёm	 5УЪ m лm0 л5В#”Ю.Ґ55$∆Ъф€ГD.“».°Q5—dЌМs±5zGВ.“я.°М±еВDЃ.ЯеоБЃ.МБњ#.Щ'ВUЃ/.ЯЕVLIS‘;.mА Эƒ¬ЩЩЭЩўѕЪ
 ЅЯЭƒ^√оо}	I	Щ^∆§$Ъ‘€DГBY≈HЪЌ'ДLIS‘Т.Щ
Ѕ^Іƒ\SCR # 'm ЯтЅm оІЩт§Ъ СЃв€ЅЕINDEЎЬ.m EЅ!QтЅm оЯт§Ъ СЃд€ЕTRIAƒж.m Em jm Km 5лQтЅ£§Ъ СЃр€ЅД.CP’.зЩm$ зƒm(  µзƒЕMATC»\ЛЙчY[Z^Vђ:uSQVItJtCђ:tф^Y[Juжй YYYЙр^)рЙюй°зДTASЋБ.ЕTRIAƒР.m 9m jm Km 5лQтЅMШЪ СЃр€ЅД.CP’».зЩm$ зƒm(  µ√зƒЕMATC»5ЙчY[Z^Vђ:uSQVItJtCђ:tф^Y[Juжй YYYЙр^)рЙюйчжДTASЋ+.1.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        лYРDFW--EXP  а @р	             )Юё}NO NAME    FAT12   иќ ∞ і ≤ Ќи√ ∞ иў Й»иє ∞ иѕ ∞Dи  М»!јuкk ј∞FиЇ ъМ»ОЎО–ОјЉ  ыі ≤ Ќrєє" ї и rЃ;° |х∞WиП иe й_ЌQSЙ»1“ч6 И—юЅ1“ч6 И÷И≈≤ ЄЌ[ЬБ√ ЭYA√и> и1 М»и8 и) МЎи0 и! Мји( и М–и  и Йри и	 Йши и √∞и" ∞
й XPPИаи XP±“ши X$'Иƒ±“м00€іЌ√                                                                                                                                                                                                             U™р€€@ ` А 	† ј а р€€/@`А†ја ! #@%`'А)†+ј-а/ 1 3@5`7А9†;ј=а? A C@E`GАI†KјMаO Q S@U`WАY†[ј]а_ a c@e`gАi†kјmаo q s@u`wАy†{ј}а Б Г@Е`ЗАЙ†ЛјНаП 	С 	У@	Х`	ЧА	Щ†	Ыј	Эа	Я 
° 
£@
•`
ІА
©†
Ђј
≠а
ѓ ± ≥@µ`ЈАє†їјљањ Ѕ √@≈`«А…†ЋјЌаѕ — ”@’`„Аў†џјЁая б г@е`зАй†лјнап с у@х`чАщ†ыјэа€ !AaБ	°Ѕб!AaБ°Ѕб!!#A%a'Б)°+Ѕ-б/1!3A5a7Б9°;Ѕ=б?A!CAEaGБI°KЅMбOQ!SAUьВL°н[YМЏОўXЙОЏйIьЅЇ.„	Т	–Щ¬ƒ\
ѓ
BMMЙv Й÷й&ьЅї.
8
q
N
ИCONSTAN‘9.q
Yѓ
BЙ”ЛйцыИVARIABL≈K.Vѓ
BRйбыДUSE“h.Vѓ
BЙ”К(€Л>,Нй√ыБ∞~°1јйЄыБ±ЫђЄ йђыБ≤¶ЄЄ й†ыБ≥≤ƒЄ йФыВBћЊ`  ГC/ћ `@ ЕFIRS‘”`шчЕLIMI‘Ё`  ВEЌй`  ЕB/BU∆х` ЕB/SC“ю` З+ORIGIќ
.m лВS∞Л ВR∞*Л ГTI¬3Л
 ЕWIDT»<Л ЗWARNIN«FЛ ЕFENC≈RЛ ВD–`Л ИVOC-LINЋlЛ ГBLЋuЛ ВIќДЛ ГOU‘ОЛ ГSC“ЧЛ ЖOFFSE‘°Л  ЗCONTEX‘ЂЛ  ЗCURREN‘ЄЛ" ЕSTAT≈∆Л$ ДBAS≈‘Л& ГDPћаЛ( ГFLƒлЛ* ГCS–хЛ, ВR£€Л. ГHLƒ	Л0 В1Ђ#X@й6ъВ2Ђ/X й(ъДHER≈(.qЩЕALLO‘6.qzБђE.=ƒґMВCђU.=“™MБ≠e|ZX)–йџщБљv.z∆БЉГХZXЙ”1√x)–	јЄ  y@йіщВUЉП.l3ўЪ Dў∆К zўБЊ™.QУГRO‘ЋяZ[XSйwщЕSPAC≈„.ѕ9Д-DU–ж.^Ъ ^ИTRAVERS≈ц.Q5лm 5¶УЪр€QDЖLATES‘		.–ЩЩГLFЅ0	.m zГCFЅC	.ґzГNFЅS	.m zm€€	ГPFЅa	.™	m лД!CS–w	.BƒЖ?ERRO“Л	.QЪ ОК DЕ?COM–Ь	.№Щ∆m •	Е?EXE√Ј	.№Щm •	Ж?PAIR”ѕ	.zm •	Д?CS–е	.BЩzm •	И?LOADIN«ъ	.КЩ∆m •	ЗCOMPIL≈
.њ	±^-°ЩYЅџ.
.Я№ƒБЁJ
.mј №ƒЖSMUDG≈X
.9	m  МГHEЎh
.m зƒЗDECIMAћ}
.m
 зƒЗ(;CODE©П
.±9	}	Y	ƒ≈;COD≈•
.
8
ѓ
N
ќЗ<BUILD”љ
.ЯVЕDOESЊ”
.±9	}	ƒѓ
ЗмVЗмBЙ”Л7BBRйVчЕCOUN‘е
.^!Q¶Й-TRAILIN«	.^Ят55л™z¶ѕzЪ СК ™zЃа€Д(."©.њ^!±л°¬.ҐU.m" №ЩЪ 8
\`=¶!MК
 `=ЕQUERўp.BЩmP mЯУƒЅАЯ.КЩЪ* ™КzЯУƒКЩ™z∆Ъ „	±DК ±DДFILћї XY_МџО√ьу™йRцЕERAS≈ч.ЯюЖBLANK”.ѕюДHOLƒ.m€€zЩ“ГPAƒ..=mT лДWORƒG.КЩЪ КЩ;К BЩУЩлQЛ=m" &Уz5z°њ=“л=!±”И(NUMBER©Y.!^°¶зЩЪ, QзЩлDЁзЩлщсЩ!Ъ ™сz±К∆€±ЖNUMBE“¶.ЯЯЁ^!¶m- З^°лm€€сƒ±^¶ѕzЪ ^¶m. zЯ•	ЯК№€D±Ъ Е-FINƒу.ѕ`=¬ЩЩ@^∆Ъ
 D=9	@З(ABORT©L.еЕERRO“v.\ЩўЪ А=\? OКЩэЪ УЩQЄГIDЃЖ.Mm  m_ ю^}	I	5zMQ”Mm ™zlл¶m 9оЖCREAT≈љ.TЪ Dg	√m о=^¶NЩя!M^m† М=™zmА М9	Y–Щƒ=-Y…[COMPILEЁ.T∆Я•	DY	Y«LITERAћX.№ЩЪ 8
mY»DLITERAћv.№ЩЪ QААЖ?STACЋТ.B/ЩQѓ™•	B=mА лѓm •	ЙINTERPRE‘ѓ.TЪ №ЩУЪ
 Y	YК Y	|ЄК =ьсЩ!Ъ ЭК DАЄК¬€ЙIMMEDIAT≈№.9	m@ МКVOCABULARў*.Ё
mБ†Y–ЩY	Y=АЩYАƒн
-¬ƒ≈FORT»Bщ
oБ†¬  ЛDEFINITION”w.¬Щ–ƒЅ®Й.m) `ДQUI‘£.ЯКƒN
nЅІи№Щ∆Ъ \OKКз€ЕABOR‘±.OЩ
ЄЅi\IBM-PC Fig-Forth 2.0.AЧЄЊйIтДWARЌЁ.№еЊNЄ  ОЎїМ НЙCCММ»ОЎЛ&О–ОјьЛ..йтWДCOLƒ.№еkƒеvƒmm,Щm ”mЩmЕƒеДS->ƒPОZ)ј	“yHйƒсВ+≠Е.ўЪ ГD+≠Щ.ўЪ ГAB”™.^ЮДDAB”Љ.^∞ГMIќ .lѕЪ QDГMAЎў.lУЪ QDВM™п.l3°¬Q¬л±∞ВMѓ.5°°—њ¬ъ±њ3ЮQ±ЮQБ™ .
DД/MOƒG.°М±%БѓS.ZQDГMOƒf.ZDЕ*/MOƒt.°
±%В*ѓВ.КQDЕM/MOƒЦ.°Яњъ±Q°ъ±Ж(LINE©•.°m@ К±Kл;лm@ Е.LIN≈√.ћ)ЗMES€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€цццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццц€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€цццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццццц€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€
	DW	OFFSET INTE3-$
	DW	CFA
	DW	COMMA
	DW	BRAN	;ELSE
	DW	OFFSET INTE4-$
INTE3	DW	CFA
	DW	EXEC	;ENDIF
INTE4	DW	QSTAC
	DW	BRAN	;ELSE
	DW	OFFSET INTE5-$
INTE2	DW	HERE
	DW	NUMB
	DW	DPL
	DW	FETCH
	DW	ONEP
	DW	ZBRAN	;IF
	DW	OFFSET INTE6-$
	DW	DLITE
	DW	BRAN	;ELSE
	DW	OFFSET INTE7-$
INTE6	DW	DROP
	DW	LITER	;ENDIF
INTE7	DW	QSTAC	;ENDIF
INTE5	DW	BRAN	;AGAIN
	DW	OFFSET INTE1-$
	PAGE
;	IMMEDIATE
;
	DB	89H
	DB	'IMMEDIAT'
	DB	'E'+80H
	DW	INTER-0CH
IMMED	DW	DOCOL
	DW	LATES
	DW	LIT,40H
	DW	TOGGL
	DW	SEMIS
;
;	VOCABULARY
;
	DB	8AH
	DB	'VOCABULAR'
	DB	'Y'+80H
	DW	IMMED-0CH
VOCAB	DW	DOCOL
	DW	BUILD
	DW	LIT
	DW	0A081H
	DW	COMMA
	DW	CURR
	DW	FETCH
	DW	CFA
	DW	COMMA
	DW	HERE
	DW	VOCL
	DW	FETCH
	DW	COMMA
	DW	VOCL
	DW	STORE
	DW	DOES
DOVOC	DW	TWOP
	DW	CONT
	DW	STORE
	DW	SEMIS
	PAGE
;	FORTH
;
;   THE 'TASK-7' IS A COLD START VALUE ONLY.
;   IT IS CHANGED EACH TIME A DEFINITION IS
;   APPENDED TO THE 'FORTH' VOCABULARY.
;
	DB	0C5H
	DB	'FORT'
	DB	'H'+80H
	DW	VOCAB-0DH
FORTH	DW	DODOE
	DW	DOVOC
	DW	0A081H
	DW	TASK-7	;COLD START VALUE ONLY
	DW	0	; END OF VOCABULARY LIST
;
;	DEFINITIONS
;
	DB	8BH
	DB	'DEFINITION'
	DB	'S'+80H
	DW	FORTH-8
DEFIN	DW	DOCOL
	DW	CONT
	DW	FETCH
	DW	CURR
	DW	STORE
	DW	SEMIS
;
;	(
;
	DB	0C1H
	DB	'('+80H
	DW	DEFIN-0EH
PAREN	DW	DOCOL
	DW	LIT,')'
	DW	WORDS
	DW	SEMIS
	PAGE
;	QUIT
;
	DB	84H
	DB	'QUI'
	DB	'T'+80H
	DW	PAREN-4
QUIT	DW	DOCOL
	DW	ZERO
	DW	BLK
	DW	STORE
	DW	LBRAC
QUIT1	DW	RPSTO	;BEGIN
	DW	CR
	DW	QUERY
	DW	INTER
	DW	STATE
	DW	FETCH
	DW	ZEQU
	DW	ZBRAN	;IF
	DW	OFFSET QUIT2-$
	DW	PDOTQ
	DB	2
	DB	'OK'	;ENDIF
QUIT2	DW	BRAN	;AGAIN
	DW	OFFSET QUIT1-$
;
;	ABORT
;
	DB	85H
	DB	'ABOR'
	DB	'T'+80H
	DW	QUIT-7
ABORT	DW	DOCOL
	DW	SPSTO
	DW	DECA
	DW	QSTAC	; IT DID TO & INCL THIS
	DW	CR
	DW	DOTCPU
	DW	PDOTQ
	DB	20
	DB	'IBM-PC Fig-Forth '
	DB	FIGREL+30H,ADOT,FIGREV+30H
	DW	FORTH
	DW	DEFIN
	DW	QUIT
	PAGE
;	WARM START VECTOR COMES HERE
;
WRM:	MOV	SI,OFFSET WRM1
	JMP	NEXT
;
WRM1	DW	WARM
;
;	WARM
;
	DB	84H
	DB	'WAR'
	DB	'M'+80H
	DW	ABORT-8
WARM	DW	DOCOL
	DW	MTBUF
	DW	ABORT
;
;	COLD START VECTOR COMES HERE
;
LCLD:    MOV     SI,OFFSET CLD1  ; (IP) <-
	MOV	AX,0
	MOV	DS,AX		;TO VECTOR AREA
	MOV	BX,08CH
	LEA	AX,[WRM]
	MOV	[BX],AX		;JUMP TO WRM ON <CTRL-BREAK>
	INC	BX
	INC	BX
	MOV	[BX],CS
	MOV	AX,CS
	MOV	DS,AX		; SET DATA SEG
	MOV	SP,[ORIG+12H]    ;PARAM. STACK
	MOV	SS,AX		; SET STACK SEGMENT
	MOV	ES,AX		; SET EXTRA SEG
	CLD			; DIR = INC
	MOV	BP,[RPP]          ; RETURN STACK
	JMP	NEXT
;
CLD1	DW	COLD
;
;	COLD
;
	DB	84H
	DB	'COL'
	DB	'D'+80H
	DW	WARM-7
COLD	DW	DOCOL
	DW	MTBUF
	DW	FIRST
	DW	USE,STORE
	DW	FIRST
	DW	PREV,STORE
	DW	DRZER
	DW	LIT,0
	DW	LIT,EPRINT
	DW	STORE
	DW	LIT
	DW	ORIG+12H
	DW	LIT,UP
	DW	FETCH
	DW	LIT,6
	DW	PLUS
	DW	LIT,10H
	DW	LCMOVE
	DW	LIT,ORIG+0CH
	DW	FETCH
	DW	LIT,FORTH+6
	DW	STORE
	DW	ABORT
	PAGE
;	S->D
;
	DB	84H
	DB	'S->'
	DB	'D'+80H	; 1 WORD TO 2 WORDS
	DW	COLD-7
STOD	DW	$+2
	POP	DX	;S1
	SUB	AX,AX
	OR	DX,DX
	JNS	STOD1	;POS
	DEC	AX	;NEG
STOD1:	JMP	DPUSH
;
;	+-
;
	DB	82H
	DB	'+'
	DB	'-'+80H
	DW	STOD-7
PM	DW	DOCOL
	DW	ZLESS
	DW	ZBRAN	;IF
	DW	OFFSET PM1-$
	DW	MINUS	;ENDIF
PM1	DW	SEMIS
;
;	D+-
;
	DB	83H
	DB	'D+'
	DB	'-'+80H
	DW	PM-5
DPM	DW	DOCOL
	DW	ZLESS
	DW	ZBRAN	;IF
	DW	OFFSET DPM1-$
	DW	DMINU	;ENDIF
DPM1	DW	SEMIS
;
;	ABS
;
	DB	83H
	DB	'AB'
	DB	'S'+80H
	DW	DPM-6
ABS1	DW	DOCOL
	DW	DUPE
	DW	PM
	DW	SEMIS
;
;	DABS
;
	DB	84H
	DB	'DAB'
	DB	'S'+80H
	DW	ABS1-6
DABS	DW	DOCOL
	DW	DUPE
	DW	DPM
	DW	SEMIS
;
;	MIN
;
	DB	83H
	DB	'MI'
	DB	'N'+80H
	DW	DABS-7
MIN	DW	DOCOL,TDUP
	DW	GREAT
	DW	ZBRAN	;IF
	DW	OFFSET MIN1-$
	DW	SWAP	;ENDIF
MIN1	DW	DROP
	DW	SEMIS
;
;	MAX
;
	DB	83H
	DB	'MA'
	DB	'X'+80H
	DW	MIN-6
MAX	DW	DOCOL,TDUP
	DW	LESS
	DW	ZBRAN	;IF
	DW	OFFSET MAX1-$
	DW	SWAP	;ENDIF
MAX1	DW	DROP
	DW	SEMIS
	PAGE
;	M*
;
	DB	82H
	DB	'M'
	DB	'*'+80H
	DW	MAX-6
MSTAR	DW	DOCOL,TDUP
	DW	XORR
	DW	TOR
	DW	ABS1
	DW	SWAP
	DW	ABS1
	DW	USTAR
	DW	FROMR
	DW	DPM
	DW	SEMIS
;
;	M/
;
	DB	82H
	DB	'M'
	DB	'/'+80H
	DW	MSTAR-5
MSLAS	DW	DOCOL
	DW	OVER
	DW	TOR
	DW	TOR
	DW	DABS
	DW	RR
	DW	ABS1
	DW	USLAS
	DW	FROMR
	DW	RR
	DW	XORR
	DW	PM
	DW	SWAP
	DW	FROMR
	DW	PM
	DW	SWAP
	DW	SEMIS
;
;	*
;
	DB	81H
	DB	'*'+80H
	DW	MSLAS-5
STAR	DW	DOCOL
	DW	MSTAR
	DW	DROP
	DW	SEMIS
;
;	/MOD
;
	DB	84H
	DB	'/MO'
	DB	'D'+80H
	DW	STAR-4
SLMOD	DW	DOCOL
	DW	TOR
	DW	STOD
	DW	FROMR
	DW	MSLAS
	DW	SEMIS
;
;	/
;
	DB	81H
	DB	'/'+80H
	DW	SLMOD-7
SLASH	DW	DOCOL
	DW	SLMOD
	DW	SWAP
	DW	DROP
	DW	SEMIS
;
;	MOD
;
	DB	83H
	DB	'MO'
	DB	'D'+80H
	DW	SLASH-4
MODD	DW	DOCOL
	DW	SLMOD
	DW	DROP
	DW	SEMIS
;
;	*/MOD
;
	DB	85H
	DB	'*/MO'
	DB	'D'+80H
	DW	MODD-6
SSMOD	DW	DOCOL
	DW	TOR
	DW	MSTAR
	DW	FROMR
	DW	MSLAS
	DW	SEMIS
;
;	*/
;
	DB	82H
	DB	'*'
	DB	'/'+80H
	DW	SSMOD-8
SSLA	DW	DOCOL
	DW	SSMOD
	DW	SWAP
	DW	DROP
	DW	SEMIS
;
;	M/MOD
;
	DB	85H
	DB	'M/MO'
	DB	'D'+80H
	DW	SSLA-5
MSMOD	DW	DOCOL
	DW	TOR
	DW	ZERO
	DW	RR
	DW	USLAS
	DW	FROMR
	DW	SWAP
	DW	TOR
	DW	USLAS
	DW	FROMR
	DW	SEMIS
	PAGE
;	(LINE)
;
	DB	86H
	DB	'(LINE'
	DB	')'+80H
	DW	MSMOD-8
PLINE	DW	DOCOL
	DW	TOR
	DW	LIT,64
	DW	BBUF
	DW	SSMOD
	DW	FROMR
	DW	BSCR
	DW	STAR
	DW	PLUS
	DW	BLOCK
	DW	PLUS
	DW	LIT,64
	DW	SEMIS
;
;	.LINE
;
	DB	85H
	DB	'.LIN'
	DB	'E'+80H
	DW	PLINE-9
DLINE	DW	DOCOL
	DW	PLINE
	DW	DTRAI
	DW	TYPES
	DW	SEMIS
;
;	MESSAGE
;
	DB	87H
	DB	'MESSAG'
	DB	'E'+80H
	DW	DLINE-8
MESS	DW	DOCOL
	DW	WARN
	DW	FETCH
	DW	ZBRAN	;IF
	DW	OFFSET MESS1-$
	DW	DDUP
	DW	ZBRAN	;IF
	DW	OFFSET MESS2-$
	DW	LIT,4
	DW	OFSET
	DW	FETCH
	DW	BSCR
	DW	SLASH
	DW	SUBB
	DW	DLINE
	DW	SPACE	;ENDIF
MESS2	DW	BRAN	;ELSE
	DW	OFFSET MESS3-$
MESS1	DW	PDOTQ
	DB	6
	DB	'MSG # '
	DW	DOT	;ENDIF
MESS3	DW	SEMIS
	PAGE
	; At line     LINE ~3000
;--------------------------------------------
;
;	8086/88 PORT FETCH AND STORE
;
;--------------------------------------------
;
;	PC@
;
; FETCH CHARACTER (BYTE) FROM PORT
;
	DB	83H
	DB	'PC'
	DB	'@'+80H
	DW	MESS-0AH
PTCAT	DW	$+2
	POP	DX	; PORT ADDR
	IN	AL,DX	; BYTE INPUT
	SUB	AH,AH
	JMP	APUSH
;
;	PC!
;
; STORE CHARACTER (BYTE) FETCH PORT
;
	DB	83H
	DB	'PC'
	DB	'!'+80H
	DW	PTCAT-6
PTCSTO	DW	$+2
	POP	DX	;PORT ADDR
	POP	AX	;DATA
	OUT	DX,AL	; BYTE OUTPUT
	JMP	NEXT
;
;	P@
; FETCH WORD FROM PORT
;
	DB	82H
	DB	'P'
	DB	'@'+80H
	DW	PTCSTO-6
PTAT	DW	$+2
	POP	DX	;PORT ADDR
	IN	AX,DX	;WORD INPUT
	JMP	APUSH
;
;	PC!
; STORE WORD FETCH PORT
;
	DB	82H
	DB	'P'
	DB	'!'+80H
	DW	PTAT-5
PTSTO	DW	$+2
	POP	DX	;PORT ADDR
	POP	AX	;DATA
	OUT	DX,AX	;WORD OUTPUT
	JMP	NEXT
;
BPS	EQU	512	;BYTES PER SECTOR
MXDRV	EQU	2	; MAX # DRIVES
;
;
;	USE
;
	DB	83H	;ADDR OF NEXT BUFR TO USE
	DB	'US'
	DB	'E'+80H
	DW	PTSTO-5
USE	DW	DOVAR
	DW BUF1
;
;	PREV
;
	DB	84H	;ADDR OF PREV USED BUFR
	DB	'PRE'
	DB	'V'+80H
	DW	USE-6
PREV	DW	DOVAR
	DW	BUF1
;
;	SEC/BLK
;
	DB	87H	;# SECTORS/BLOCK
	DB	'SEC/BL'
	DB	'K'+80H
	DW	PREV-7
SPBLK	DW	DOCON
	DW	KBBUF/BPS
	PAGE
;	#BUFF
;
	DB	85H	;NO. OF BUFFERS
	DB	'#BUF'
	DB	'F'+80H
	DW	SPBLK-10
NOBUF	DW	DOCON,NBUF
;
;	+BUF
;
	DB	84H
	DB	'+BU'
	DB	'F'+80H
	DW	NOBUF-8
PBUF	DW	DOCOL
	DW	LIT,CO
	DW	PLUS,DUPE
	DW	LIMIT,EQUAL
	DW	ZBRAN
	DW	OFFSET PBUF1-$
	DW	DROP,FIRST
PBUF1	DW	DUPE,PREV
	DW	FETCH,SUBB
	DW	SEMIS
;
;	UPDATE
;
	DB	86H
	DB	'UPDAT'
	DB	'E'+80H
	DW	PBUF-7
UPDAT	DW	DOCOL,PREV
	DW	FETCH,FETCH
	DW	LIT,8000H
	DW	ORR
	DW	PREV,FETCH
	DW	STORE,SEMIS
;
;	EMPTY-BUFFERS
;
	DB	8DH
	DB	'EMPTY-BUFFER'
	DB	'S'+80H
	DW	UPDAT-9
MTBUF	DW	DOCOL,FIRST
	DW	LIMIT,OVER
	DW	SUBB,ERASEE
	DW	SEMIS
	PAGE
;	DR0
;
	DB	83H
	DB	'DR'
	DB	'0'+80H
	DW	MTBUF-16
DRZER	DW	DOCOL,ZERO
	DW	OFSET,STORE
	DW	SEMIS
;
;	BUFFER
;
; NOTE: THIS WORD WON'T WORK IF ONLY
;	USING SINGLE BUFFER
;
	DB	86H
	DB	'BUFFE'
	DB	'R'+80H
	DW	DRZER-6
BUFFE	DW	DOCOL,USE
	DW	FETCH,DUPE
	DW	TOR
BUFF1	DW	PBUF
	DW	ZBRAN
	DW	OFFSET BUFF1-$
	DW	USE,STORE
	DW	RR,FETCH
	DW	ZLESS
	DW	ZBRAN
	DW	OFFSET BUFF2-$
	DW	RR,TWOP
	DW	RR,FETCH
	DW	LIT,7FFFH
	DW	ANDD,ZERO
	DW	RSLW
BUFF2	DW	RR,STORE
	DW	RR,PREV
	DW	STORE,FROMR
	DW	TWOP,SEMIS
	PAGE
;	BLOCK
;
	DB	85H
	DB	'BLOC'
	DB	'K'+80H
	DW	BUFFE-9
BLOCK	DW	DOCOL,OFSET
	DW	FETCH,PLUS
	DW	TOR,PREV
	DW	FETCH,DUPE
	DW	FETCH,RR
	DW	SUBB
	DW	DUPE,PLUS
	DW	ZBRAN
	DW	OFFSET BLOC1-$
BLOC2	DW	PBUF,ZEQU
	DW	ZBRAN
	DW	OFFSET BLOC3-$
	DW	DROP,RR
	DW	BUFFE,DUPE
	DW	RR,ONE
	DW	RSLW
	DW	TWO,SUBB
BLOC3	DW	DUPE,FETCH
	DW	RR,SUBB
	DW	DUPE,PLUS
	DW	ZEQU
	DW	ZBRAN
	DW	OFFSET BLOC2-$
	DW	DUPE,PREV
	DW	STORE
BLOC1	DW	FROMR,DROP
	DW	TWOP,SEMIS
	PAGE
WERR	DB  	'DISK WRITE ERROR  $'
RERR	DB  	'DISK READ ERROR   $'
;
SSEC	PROC	NEAR
;	( ADDR  SEC# -- )
;	THIS ROUTINE WILL SELECT THE HEAD & DRIVE
	POP	DI	;SAVE RETURN
	POP	AX	;SECTOR #
	CMP	AX,SEC_DSK	;B DRIVE?
	JB	LDR0
	SUB	AX,SEC_DSK
	MOV	DX,AX	;LOAD LOGICAL SECTOR #
	MOV	AL,1	;SELECT DR B
	JMP	GSEC1
LDR0:    MOV     DX,AX   ;DR A
	MOV	AL,0	;SELECT DR A
GSEC1:	POP	BX	;TRANSFER ADDR
	MOV	CX,1	;READ 1 SECTOR
	PUSH	DI	;GET THAT RETURN BACK
	RET
;SSEC    ENDP
;
;	RSEC
;
	DB	84H
	DB	'RSE'
	DB	'C'+80H
	DW	BLOCK-8
RSEC	DW	$+2
	CALL	SSEC
	PUSH	SI	;PRESERVE INTERPRETER POINTER
	PUSH	BP	;RETURN POINTER
	INT	25H
	JNC	DOK	;NO ERRORS
	LEA	DX,[RERR]
	JMP	DERR
;
;	WSEC
;
	DB	84H
	DB	'WSE'
	DB	'C'+80H
	DW	RSEC-7
WSEC	DW	$+2
    	CALL	SSEC
	PUSH	SI
	PUSH	BP
	INT	26H
	JNC	DOK
	LEA	DX,[WERR]
DERR:	PUSH	AX
	MOV	AH,9	;STRING WRITE FNCN
	INT	21H
	POP	AX	;ERROR CODE IN AX
;  WRITE ERROR MESSAGE HERE
;
DOK:	POPF		;POP FLAGS
	POP	BP	;RETURN STACK
	POP	SI	;INTERPRETER PNTR
	JMP	NEXT
;
;	R/W
;
;	( ADDR  SECTOR#  FLAG (0=W, 1=R) --- )
 	DB	83H
	DB	'R/'
	DB	'W'+80H
	DW	WSEC-7
RSLW	DW	DOCOL
	DW	ZBRAN
	DW	OFFSET RSLW1-$
	DW	RSEC
	DW	BRAN
	DW	OFFSET RSLW2-$
RSLW1	DW	WSEC
RSLW2	DW	SEMIS
	PAGE
;	FLUSH
;
	DB	85H
	DB	'FLUS'
	DB	'H'+80H
	DW	RSLW-6
FLUSH	DW	DOCOL
	DW	NOBUF,ONEP
	DW	ZERO,XDO
FLUS1	DW	ZERO,BUFFE
	DW	DROP
	DW	XLOOP
	DW	OFFSET FLUS1-$
	DW	SEMIS
;
;	LOAD
;
	DB	84H
	DB	'LOA'
	DB	'D'+80H
	DW	FLUSH-8
LOAD	DW	DOCOL,BLK
	DW	FETCH,TOR
	DW	INN,FETCH
	DW	TOR,ZERO
	DW	INN,STORE
	DW	BSCR,STAR
	DW	BLK,STORE	;BLK <- SCR * B/SCR
	DW	INTER	;INTERPRET FROM OTHER
SCREEN	DW	FROMR,INN
	DW	STORE
	DW	FROMR,BLK
	DW	STORE
	DW	SEMIS
	PAGE
;	-->
;
	DB	0C3H
	DB	'--'
	DB	'>'+80H
	DW	LOAD-7
ARROW	DW	DOCOL
	DW	QLOAD
	DW	ZERO
	DW	INN
	DW	STORE
	DW	BSCR
	DW	BLK
	DW	FETCH
	DW	OVER
	DW	MODD
	DW	SUBB
	DW	BLK
	DW	PSTOR
	DW	SEMIS
	PAGE
;
;------------------------------------
; QUERY KEYBOARD FOR KEY PRESSED
;------------------------------------
;
; ( TRUE = CHAR READY, FALSE = NO CHAR )
;
; CALLED FROM  "?TERMINAL"
;
; USE 'KEY' TO GET KEY VALUE
;
PQTER:	CALL	CSTAT	;TEST FOR KEY
	OR	AL,AL	;ANY KEY?
	JZ	PQTER1	;NO
	MOV	AL,1	;TRUE = CHAR FOUND
PQTER1:	MOV	AH,0	;MAKE 16 BITS
	JMP	APUSH	;SAVE STATUS
;
;----------------------------
; CONSOLE INPUT ROUTINE
;----------------------------
;
; WAITS FOR A KEYBOARD CHAR
;
; CTRL-P WILL TOGGLE PRINTER ECHO FLAG
;
; CALLED FROM 'KEY'
;
PKEY:	CALL	CI	;CONSOLE INPUT
	CMP	AL,DLE	;PRINTER TOGGLE?
	JNE	PKEY1	;NO
	XOR BYTE      [EPRINT], 1        ;TOGGLE ECHO
	JMP	PKEY	;GET ANOTHER KEY
PKEY1:	MOV	AH,0	;MAKE 16 BITS
	JMP	APUSH	;SAVE KEY VALUE
;
;---------------------------------------
; CONSOLE/PRINTER CHAR OUTPUT
;---------------------------------------
;
; CALLED FROM 'EMIT'
;
PEMIT	DW	$+2
	POP	AX	;GET CHAR
	CALL	POUT	;CHAR OUTPUT
	JMP	NEXT
	PAGE
;------------------------------
; CRLF TO CONSOLE/PRINTER
;------------------------------
;
; CALLED FROM 'CR'
;
PCR:	MOV	AL,ACR
	CALL	POUT	;CHAR OUTPUT
	MOV	AL,LF
	CALL	POUT
	JMP	NEXT
;
;-------------------------------------
; TRUE CONSOLE/PRINTER OUTPUT ROUTINE
;-------------------------------------
;
POUT	PROC	NEAR
     	CALL	CHO	;CONSOLE OUT
	TEST BYTE   [EPRINT],1        ;PRINTER ECHO?
        NOP     ; To get the same code layout as with MASM
	JZ	POUT1	;OFF
	CALL	LO	;LIST OUTPUT
POUT1:	RET
;POUT    ENDP
;
; PRINTER ECHO FLAG
;
; VALUE: 0 = OFF, 1 = ON
;
EPRINT	DB	0,0
;
;------------------------
; GET KEYBOARD STATUS
;------------------------
;
; RETURNS KEYBOARD STATUS
;
;
; EXIT: REG AL = 0 IF NO KEY PRESSED
;       REG AL = CHAR IF  KEY PRESSED
;
CSTAT	PROC	NEAR
	PUSH	DX
	MOV	DX,0FFH
	MOV	AX,0600H
	INT	21H
	POP	DX
STATRT: RET
;CSTAT   ENDP
;
;-------------------------
; CONSOLE INPUT
;-------------------------
;
; WAITS FOR KEY FROM KEYBOARD
;
CI	PROC	NEAR
   	MOV	AH,0	; READ CHAR FUNCTION
	INT	16H
	RET
;CI      ENDP
	PAGE
;--------------------
; CONSOLE OUTPUT
;--------------------
;
; OUTPUTS CHAR IN REG AL TO CONSOLE
;
; EXIT:	REG AL = CHAR
;
CHO	PROC	NEAR
	PUSH	DX
    	PUSH	AX	;SAVE CHAR
	MOV	DL,AL	;CHAR TO WRITE
	MOV	AH,2	;CHAR OUT FUNCTION
	INT	21H	;DOS
	POP	AX
	POP	DX
	RET
;CHO     ENDP
;
;----------------------
;	LIST OUTPUT
;----------------------
;
; OUTPUTS CHAR IN REG AL TO
; LIST DEVICE (PRINTER)
;
; EXIT: REG AL = CHAR
;
LO	PROC	NEAR
   	PUSH	AX	;SAVE CHAR
	PUSH	DX
	MOV	DX,PRINTER_NO
	MOV	AH,0	;PRINT CHAR
	INT	17H
	POP	DX
	POP	AX
	RET
;LO      ENDP
	PAGE
	; At line     LINE ~3500
;	'
;
	DB	0C1H
	DB	0A7H
	DW	ARROW-6
TICK	DW	DOCOL
	DW	DFIND
	DW	ZEQU
	DW	ZERO
	DW	QERR
	DW	DROP
	DW	LITER
	DW	SEMIS
;
;	FORGET
;
	DB	86H
	DB	'FORGE'
	DB	'T'+80H
	DW	TICK-4
FORG	DW	DOCOL
	DW	CURR
	DW	FETCH
	DW	CONT
	DW	FETCH
	DW	SUBB
	DW	LIT,18H
	DW	QERR
	DW	TICK
	DW	DUPE
	DW	FENCE
	DW	FETCH
	DW	LESS
	DW	LIT,15H
	DW	QERR
	DW	DUPE
	DW	NFA
	DW	DP
	DW	STORE
	DW	LFA
	DW	FETCH
	DW	CONT
	DW	FETCH
	DW	STORE
	DW	SEMIS
	PAGE
;	BACK
;
	DB	84H
	DB	'BAC'
	DB	'K'+80H
	DW	FORG-9
BACK	DW	DOCOL
	DW	HERE
	DW	SUBB
	DW	COMMA
	DW	SEMIS
;
;	BEGIN
;
	DB	0C5H
	DB	'BEGI'
	DB	'N'+80H
	DW	BACK-7
BEGIN	DW	DOCOL
	DW	QCOMP
	DW	HERE
	DW	ONE
	DW	SEMIS
;
;	ENDIF
;
	DB	0C5H
	DB	'ENDI'
	DB	'F'+80H
	DW	BEGIN-8
ENDIFF	DW	DOCOL
	DW	QCOMP
	DW	TWO
	DW	QPAIR
	DW	HERE
	DW	OVER
	DW	SUBB
	DW	SWAP
	DW	STORE
	DW	SEMIS
	PAGE
;	THEN
;
	DB	0C4H
	DB	'THE'
	DB	'N'+80H
	DW	ENDIFF-8
THEN	DW	DOCOL
	DW	ENDIFF
	DW	SEMIS
;
;	DO
;
	DB	0C2H
	DB	'D'
	DB	'O'+80H
	DW	THEN-7
DO	DW	DOCOL
	DW	COMP
	DW	XDO
	DW	HERE
	DW	THREE
	DW	SEMIS
;
;	LOOP
;
	DB	0C4H
	DB	'LOO'
	DB	'P'+80H
	DW	DO-5
LOOPC	DW	DOCOL
	DW	THREE
	DW	QPAIR
	DW	COMP
	DW	XLOOP
	DW	BACK
	DW	SEMIS
	PAGE
;	+LOOP
;
	DB	0C5H
	DB	'+LOO'
	DB	'P'+80H
	DW	LOOPC-7
PLOOP	DW	DOCOL
	DW	THREE
	DW	QPAIR
	DW	COMP
	DW	XPLOO
	DW	BACK
	DW	SEMIS
;
;	UNTIL
;
	DB	0C5H
	DB	'UNTI'
	DB	'L'+80H
	DW	PLOOP-8
UNTIL	DW	DOCOL
	DW	ONE
	DW	QPAIR
	DW	COMP
	DW	ZBRAN
	DW	BACK
	DW	SEMIS
;
;	END
;
	DB	0C3H
	DB	'EN'
	DB	'D'+80H
	DW	UNTIL-8
ENDD	DW	DOCOL
	DW	UNTIL
	DW	SEMIS
	PAGE
;	AGAIN
;
	DB	0C5H
	DB	'AGAI'
	DB	'N'+80H
	DW	ENDD-6
AGAIN	DW	DOCOL
	DW	ONE
	DW	QPAIR
	DW	COMP
	DW	BRAN
	DW	BACK
	DW	SEMIS
;
;	REPEAT
;
	DB	0C6H
	DB	'REPEA'
	DB	'T'+80H
	DW	AGAIN-8
REPEA	DW	DOCOL
	DW	TOR
	DW	TOR
	DW	AGAIN
	DW	FROMR
	DW	FROMR
	DW	TWO
	DW	SUBB
	DW	ENDIFF
	DW	SEMIS
;
;	IF
;
	DB	0C2H
	DB	'I'
	DB	'F'+80H
	DW	REPEA-9
IFF	DW	DOCOL
	DW	COMP
	DW	ZBRAN
	DW	HERE
	DW	ZERO
	DW	COMMA
	DW	TWO
	DW	SEMIS
	PAGE
;	ELSE
;
	DB	0C4H
	DB	'ELS'
	DB	'E'+80H
	DW	IFF-5
ELSEE	DW	DOCOL
	DW	TWO
	DW	QPAIR
	DW	COMP
	DW	BRAN
	DW	HERE
	DW	ZERO
	DW	COMMA
	DW	SWAP
	DW	TWO
	DW	ENDIFF
	DW	TWO
	DW	SEMIS
;
;	WHILE
;
	DB	0C5H
	DB	'WHIL'
	DB	'E'+80H
	DW	ELSEE-7
WHILE	DW	DOCOL
	DW	IFF
	DW	TWOP
	DW	SEMIS
	PAGE
;	SPACES
;
	DB	86H
	DB	'SPACE'
	DB	'S'+80H
	DW	WHILE-8
SPACS	DW	DOCOL
	DW	ZERO
	DW	MAX
	DW	DDUP
	DW	ZBRAN
	DW	OFFSET SPAX1-$
	DW	ZERO
	DW	XDO	;DO
SPAX2	DW	SPACE
	DW	XLOOP	;LOOP
	DW	OFFSET SPAX2-$
SPAX1	DW	SEMIS
;
;	<#
;
	DB	82H
	DB	'<'
	DB	'#'+80H
	DW	SPACS-9
BDIGS	DW	DOCOL
	DW	PAD
	DW	HLD
	DW	STORE
	DW	SEMIS
;
;	#>
;
	DB	82H
	DB	'#'
	DB	'>'+80H
	DW	BDIGS-5
EDIGS	DW	DOCOL
	DW	DROP
	DW	DROP
	DW	HLD
	DW	FETCH
	DW	PAD
	DW	OVER
	DW	SUBB
	DW	SEMIS
	PAGE
;	SIGN
;
	DB	84H
	DB	'SIG'
	DB	'N'+80H
	DW	EDIGS-5
SIGN	DW	DOCOL
	DW	ROT
	DW	ZLESS
	DW	ZBRAN	;IF
	DW	OFFSET SIGN1-$
	DW	LIT,2DH
	DW	HOLD	;ENDIF
SIGN1	DW	SEMIS
;
;	#
;
	DB	81H
	DB	'#'+80H
	DW	SIGN-7
DIG	DW	DOCOL
	DW	BASE
	DW	FETCH
	DW	MSMOD
	DW	ROT
	DW	LIT,9
	DW	OVER
	DW	LESS
	DW	ZBRAN	;IF
	DW	OFFSET DIG1-$
	DW	LIT,7
	DW	PLUS	;ENDIF
DIG1	DW	LIT,30H
	DW	PLUS
	DW	HOLD
	DW	SEMIS
;
;	#S
;
	DB	82H
	DB	'#'
	DB	'S'+80H
	DW	DIG-4
DIGS	DW	DOCOL
DIGS1	DW	DIG	;BEGIN
	DW	OVER
	DW	OVER
	DW	ORR
	DW	ZEQU
	DW	ZBRAN	;UNTIL
	DW	OFFSET DIGS1-$
	DW	SEMIS
;
;	D.R.
;
	DB	83H
	DB	'D.'
	DB	'R'+80H
	DW	DIGS-5
DDOTR	DW	DOCOL
	DW	TOR
	DW	SWAP
	DW	OVER
	DW	DABS
	DW	BDIGS
	DW	DIGS
	DW	SIGN
	DW	EDIGS
	DW	FROMR
	DW	OVER
	DW	SUBB
	DW	SPACS
	DW	TYPES
	DW	SEMIS
;
;	.R
;
	DB	82H
	DB	'.'
	DB	'R'+80H
	DW	DDOTR-6
DOTR	DW	DOCOL
	DW	TOR
	DW	STOD
	DW	FROMR
	DW	DDOTR
	DW	SEMIS
	PAGE
;	D.
;
	DB	82H
	DB	'D'
	DB	'.'+80H
	DW	DOTR-5
DDOT	DW	DOCOL
	DW	ZERO
	DW	DDOTR
	DW	SPACE
	DW	SEMIS
;
;	.
;
	DB	81H
	DB	'.'+80H
	DW	DDOT-5
DOT	DW	DOCOL
	DW	STOD
	DW	DDOT
	DW	SEMIS
;
;	?
;
	DB	81H
	DB	'?'+80H
	DW	DOT-4
QUES	DW	DOCOL
	DW	FETCH
	DW	DOT
	DW	SEMIS
;
;	U.
;
	DB	82H
	DB	'U'
	DB	'.'+80H
	DW	QUES-4
UDOT	DW	DOCOL
	DW	ZERO
	DW	DDOT
	DW	SEMIS
	PAGE
	; At line     LINE ~4000
;	VLIST
;
	DB	85H
	DB	'VLIS'
	DB	'T'+80H
	DW	UDOT-5
VLIST	DW	DOCOL
	DW	LIT,80H
	DW	OUTT
	DW	STORE
	DW	CONT
	DW	FETCH
	DW	FETCH
VLIS1	DW	OUTT	;BEGIN
	DW	FETCH
	DW	CSLL
	DW	GREAT
	DW	ZBRAN	;IF
	DW	OFFSET VLIS2-$
	DW	CR
	DW	ZERO
	DW	OUTT
	DW	STORE	;ENDIF
VLIS2	DW	DUPE
	DW	IDDOT
	DW	SPACE
	DW	SPACE
	DW	PFA
	DW	LFA
	DW	FETCH
	DW	DUPE
	DW	ZEQU
	DW	QTERM
	DW	ORR
	DW	ZBRAN	;UNTIL
	DW	OFFSET VLIS1-$
	DW	DROP
	DW	SEMIS
;
;	BYE
;
; EXIT TO PC-DOS
;
	DB	83H
	DB	'BY'
	DB	'E'+80H
	DW	VLIST-8
BYE	DW	$+2
	INT	27H	;I'M HISTORY
	PAGE
;	LIST
;
	DB	84H
	DB	'LIS'
	DB	'T'+80H
	DW	BYE-6
LISTC	DW	DOCOL,DECA
	DW	CR,DUPE
	DW	SCR,STORE
	DW	PDOTQ
	DB	6,'SCR # '
	DW	DOT
	DW	LIT,10H
	DW	ZERO,XDO
LIST1	DW	CR,IDO
	DW	LIT,3
	DW	DOTR,SPACE
	DW	IDO,SCR
	DW	FETCH,DLINE
	DW	QTERM	; ?TERMINAL
	DW	ZBRAN
	DW	OFFSET LIST2-$	;IF
	DW	LLEAV
LIST2	DW	XLOOP
	DW	OFFSET LIST1-$	;ENDIF
	DW	CR,SEMIS
;
;	INDEX
;
	DB	85H
	DB	'INDE'
	DB	'X'+80H
	DW	LISTC-7
INDEX	DW	DOCOL
	DW	LIT,FF
	DW	EMIT,CR
	DW	ONEP,SWAP
	DW	XDO
INDE1	DW	CR,IDO
	DW	LIT,3
	DW	DOTR,SPACE
	DW	ZERO,IDO
	DW	DLINE,QTERM
	DW	ZBRAN
	DW	OFFSET INDE2-$
	DW	LLEAV
INDE2	DW	XLOOP
	DW	OFFSET INDE1-$
	DW	SEMIS
	PAGE
;	TRIAD
;
	DB	85H
	DB	'TRIA'
	DB	'D'+80H
	DW	INDEX-8
TRIAD	DW	DOCOL
	DW	LIT,FF
	DW	EMIT
	DW	LIT,3
	DW	SLASH
	DW	LIT,3
	DW	STAR
	DW	LIT,3
	DW	OVER,PLUS
	DW	SWAP,XDO
TRIA1	DW	CR,IDO
	DW	LISTC
	DW	QTERM	; ?TERMINAL
	DW	ZBRAN
	DW	OFFSET TRIA2-$	;IF
	DW	LLEAV   ;LEAVE
TRIA2	DW	XLOOP	;ENDIF
	DW	OFFSET TRIA1-$
	DW	CR
	DW	SEMIS
;
;	.CPU
;
; PRINT CPU TYPE (8088)
;
	DB	84H
	DB	'.CP'
	DB	'U'+80H
	DW	TRIAD-8
DOTCPU	DW	DOCOL
	DW	BASE,FETCH
	DW	LIT,36
	DW	BASE,STORE
	DW	LIT,22H
	DW	PORIG,TAT
	DW	DDOT
	DW	BASE,STORE
	DW	SEMIS
	PAGE
%if 0 

            CODE LEVEL "MATCH" DEFINITIONS

 STACK PARAMETERS:

 ( cursor:addr   byte:left   str:addr  str:len
           ---   flag  new:cursor:offset         )

 This version of MATCH will handle string lengths
      up to 65535 bytes in length.

%endif
	DB	85H	; MATCH
	DB	'MATC'
	DB	'H'+80H
	DW	DOTCPU-7
MATCH	DW	$+2
	MOV	DI,SI	; SAVE IP
	POP	CX	; STRING COUNT
	POP	BX	;STRING ADDR
	POP	DX	;BYTES LEFT TO SEARCH
	POP	SI	;CURSOR ADDR
	PUSH	SI	;SAVE COPY
MAT1:	LODSB		;GET FIRST BYTE
	CMP	AL,[BX]	;MATCH?
	JNZ	MAT3	;NO
	PUSH	BX	;SAVE STRING ADDR
	PUSH	CX	; &   STRING COUNT
	PUSH	SI	; &   CURSOR ADDR
; TRY TO MATCH REMAINING CHARS IN STRING
;
MAT2:	DEC	CX	;STR. COUNT -1
	JZ	MATCHOK	;EXIT - MATCH FOUND
	DEC	DX	;BYTES LEFT -1
	JZ	NOMATCH	;EXIT - NO MATCH
	INC	BX	;NEXT STR CHAR ADDR
	LODSB		;GET FIRST BYTE
	CMP	AL,[BX]	;MATCH?
	JZ	MAT2	;YES, GET MORE
; NO MATCH YET
	POP	SI
	POP	CX
	POP	BX	;RESTORE POINTERS
MAT3:	DEC	DX	;BYTE LEFT COUNT -1
	JNZ	MAT1	;START OVER
	JMP	MAT4	;EXIT...NO MATCH
MATCHOK:
NOMATCH:
	POP	CX	;ADJUST STACK
	POP	CX	;FOR EXIT
	POP	CX
; EXIT HERE: DX = TRUE/FALSE FLAG ( 0=NO MATCH)
;
MAT4:	MOV	AX,SI	;NEW CURSOR ADDR
	POP	SI	;GET STARTING ADDR
	SUB	AX,SI	;COMPUTE CURSOR OFFSET
	MOV	SI,DI	;GET BACK UP
	JMP	DPUSH	; BYE..BYE
	PAGE
;
;**** LAST DICTIONARY WORD ****
;            T A S K
;
	DB	84H
	DB	'TAS'
	DB	'K'+80H
	DW	MATCH-8
TASK	DW	DOCOL
	DW	SEMIS
;
INITDP	EQU	$	;SHOW END OF DICTIONARY
;
%if 0 

The remaining memory ( up to 'EM' ) is 
used for:

	1. EXTENSION DICTIONARY
	2. PARAMETER STACK
	3. TERMINAL INPUT BUFFER
	4. RETURN STACK
	5. USER VARIABLE AREA
	6. DISK BUFFERS


%endif
					
	RESB    EM-($-$$)    ; Make EM The last location.
 CSEG    ENDS
; ORIG    ENDP
	PAGE
%if 0 

  MISC. NOTES AND SCATTERED THOUGHTS

- This source will assemble on all platforms where NASM is available by the
  command line:
  nasm -fbin fig86.asm -o fig86.exe
  The result will run on MSDOS systems only.

- When in FORTH, <Ctrl> P  will echo all output to the
  printer.

- Use the installation manual.  Descriptions for all FIG
  words are given.  Those ERROR messages you get in FORTH
  correspond to the relative line numbers in blocks
  4 and 5 of the installation manual's model.  

- Remember that all the FORTH words in this version are
  upper case letters.  Use <CAPS LOCK> when in FORTH.

- Changing variable EM will allow you to create a larger
  dictionary space.  However I suggest you develop and
  DEBUG with EM set to 4000H.  Setting it to a larger value
  will result in a larger FORTH.EXE file, and you may
  need to run EXE2BIN ( Chap 10, DOS 2.0 ) to get enough
  disk space.  Once you are satisfied with what you have,
  then by all means take that extra memory.

- Reading the section on batch files may speed up your
  developement.  See the example files that came with
  the Macro Assembler.

- Subscribe to FORTH Dimensions.  It is a valuable source
  of system and application ideas.  Talking with fellow
  FORTH programmers is sure to stir up some exciting ideas.
  Consider joining a FIG chapter.  See the back of FORTH
  Dimensions for more info.

- <Ctrl-Break> will vector to WARM start ( Label WRM: )

%endif

	END	ORIG
