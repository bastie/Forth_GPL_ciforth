( Copyright{2000}: Albert van der Horst, HCC FIG Holland by GNU Public License)
( $Id$)

\ This code does the folding such as descibed in the optimiser section of
\ the generic ciforth documentation.

\ It assumes the stack effect bytes and the optimisation properties
\ have been filled in in the flag fields.

REQUIRE $
\   : \D POSTPONE \ ; IMMEDIATE
  : \D ;            IMMEDIATE

\ For DEA : it HAS no side effects, input or output.
: NS?   >FFA @ FMASK-NS AND FMASK-NS = ;

\ How MANY stack cells on top contain a compile time constant?
VARIABLE CSC

\ From WHERE do we have optimisable code. (Ends at ``HERE'')
VARIABLE OPT-START

: !OPT-START   HERE OPT-START !   0 CSC ! ;

\ For STACKEFFECTNIBBLE : it IS no good, because it is unknown or variable.
: NO-GOOD DUP $F = SWAP 0= OR ;

\ For STACKEFFECTBYTE : it IS good, neither unknown or variable.
: SE-GOOD DUP $F AND NO-GOOD SWAP 4 RSHIFT NO-GOOD OR  0= ;

\ For STACKEFFECTBYTE : we CAN still optimise, because we know we have
\ sufficiantly constant stack cells.
: ENOUGH-POPS   DUP SE-GOOD   SWAP 4 RSHIFT 1- CSC @ > 0=  AND ;


\ Combine a STACKEFFECTBYTE into ``CSC''.
\ ``-'' works here because both nibbles have offset 1!
: COMBINE-SE    SE:1>2 SWAP -   CSC +! ;

\ Execute at compile time the ``NONAME'' word: the optimisable code we have collected from
\ ``OPT-START''
\ The result is supposedly ``CSC'' stack items.
: NONAME ;
: EXECUTE-DURING-COMPILE
       POSTPONE (;)    OPT-START @ 'NONAME >DFA !    NONAME ;


\ Throw away the executable code that is to be replaced with optimised code.
: THROW-AWAY   OPT-START @ DP ! ;

\ Compile ``CSC'' constants instead of the code optimised away.
\ They sit on the stack now. We need to store backwards to reverse them.
: COMPILE-CONSTANTS CSC @ 0= 13 ?ERROR
    HERE >R   CSC @ CELLS 2 * ALLOT   HERE >R
    BEGIN R> R> 2DUP <> WHILE >R 2 CELLS - >R
        'LIT R@ !  R@ CELL+ ! REPEAT
    2DROP
    '(;) HERE !     \ To prevent too many crashes while testing.
;


\ Recompile the code from BEGIN END. Leave END as the new begin.
: >HERE SWAP 2DUP -  HL-CODE, ;

\ Optimisation is over. Run the optimisable code and compile constants
\ instead of them. "Cash the optimisation check."
: CASH
    OPT-START @ HERE <> IF   ." TER"
        EXECUTE-DURING-COMPILE THROW-AWAY COMPILE-CONSTANTS
    THEN
;

\ Combining the effect of DEA into the current state, return
\ "the folding optimisation still HOLDS".
: CAN-FOLD?   NS? OVER SE@ ENOUGH-POPS AND ;

\ For BEGIN END DEA : if ``DEA'' allows it, add to optimisation,
\ else cash it and restart it. ``BEGIN'' ``START'' is the code copied.
\ (Mostly ``DEA"" plus inline belonging to it.)
\ Return a new BEGIN for the code to be moved, mostly the old ``END''.
:  ?OPT-FOLD?
    DUP CAN-FOLD?
    IF
        SE@ COMBINE-SE               ( DEA -- )
        >HERE                        ( BEGIN END -- BEGIN' )
    ELSE
        DROP CASH  ( DEA -- )
        >HERE                        ( BEGIN END -- BEGIN' )
        !OPT-START
    THEN ;

\ FIXME : all special optimisations must be tried only if the
\ the special optimisations flag is on, not always.

\ FIXME : the stack effect is no good, not uniform.

\ FIXME : the folowing is the proper criterion for the exec optimisation.
\ Combining the effect of DEA into the current state, return
\ "the ``EXECUTE'' optimisation IS possible"
: CAN-EXEC?   'EXECUTE = CSC @ 0 > AND ;

\ For DEA : if ``DEA'' is ``EXECUTE'' try the execute optimisation.
\ It is assumed that the FOLD optimisation already is tried, such
\ that cashing has been done.
:  ?OPT-EXEC?
    ' EXECUTE ^ =   HERE 3 CELLS - @ 'LIT ^ = AND IF
        "HUURAH, EXECUTING" TYPE
         HERE 2 CELLS - @  -3 CELLS ALLOT ,
         !OPT-START
    THEN ;

\ Copy the SEQUENCE of high level code to ``HERE'' ,  possibly folding it.
: EXPAND
    !OPT-START
    BEGIN DUP
        NEXT-PARSE
    WHILE >R
        R@ ?OPT-FOLD?
        ^ R@ ?OPT-EXEC? ^
    RDROP REPEAT DROP DROP DROP
    CASH   POSTPONE (;)
;

\ Optimise DEA regards folding.
: OPT-FOLD  >DFA HERE    OVER @ EXPAND   SWAP ! ;
\D : test 1 SWAP 3 2 SWAP ;
\D 'test OPT-FOLD
\D "EXPECT `` 1 SWAP 2 3 '' :" CR TYPE CRACK test
\D : test1 1 2 + 3 4 * OR ;
\D 'test1 OPT-FOLD
\D "EXPECT `` F '' :" CR TYPE CRACK test1
\D : test2 1 2 SWAP ;
\D 'test2 OPT-FOLD
\D "EXPECT `` 2 1 '' :" CR TYPE CRACK test2
\D : test3 1 2 'SWAP EXECUTE ;
\D 'test3 OPT-FOLD
\D "EXPECT `` 1 2 SWAP '' :" CR TYPE CRACK test3
\D 'test3 OPT-FOLD
\D "EXPECT `` 2 1 '' :" CR TYPE CRACK test3