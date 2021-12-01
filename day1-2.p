/*
--- Part Two ---

Considering every single measurement isn't as useful as you expected: there's just too much noise in the data.

Instead, consider sums of a three-measurement sliding window. Again considering the above example:

199  A      
200  A B    
208  A B C  
210    B C D
200  E   C D
207  E F   D
240  E F G  
269    F G H
260      G H
263        H

Start by comparing the first and second three-measurement windows. The measurements in the first window are marked A (199, 200, 208); their sum is 199 + 200 + 208 = 607. The second window is marked B (200, 208, 210); its sum is 618. The sum of measurements in the second window is larger than the sum of the first, so this first comparison increased.

Your goal now is to count the number of times the sum of measurements in this sliding window increases from the previous sum. So, compare A with B, then compare B with C, then C with D, and so on. Stop when there aren't enough measurements left to create a new three-measurement sum.

In the above example, the sum of each three-measurement window is as follows:

A: 607 (N/A - no previous sum)
B: 618 (increased)
C: 618 (no change)
D: 617 (decreased)
E: 647 (increased)
F: 716 (increased)
G: 769 (increased)
H: 792 (increased)

In this example, there are 5 sums that are larger than the previous sum.

Consider sums of a three-measurement sliding window. How many sums are larger than the previous sum?
*/

DEFINE VARIABLE iDepth AS INTEGER    NO-UNDO.
DEFINE VARIABLE iSum AS INTEGER EXTENT 4   NO-UNDO.
DEFINE VARIABLE iCount AS INTEGER    NO-UNDO.
DEFINE VARIABLE iStep AS INTEGER    NO-UNDO.
DEFINE VARIABLE iStepMod AS INTEGER    NO-UNDO.

ETIME(YES).

INPUT FROM C:\Work\aoc\aoc2021\day1.txt.
REPEAT:
    IMPORT iDepth.
    iStep = iStep + 1.
    iStepMod = iStep MODULO 4.
    IF iStep > 1 AND iStepMod <> 0 THEN
        iSum[1] = iSum[1] + iDepth.
    IF iStep > 1 AND iStepMod <> 1 THEN
        iSum[2] = iSum[2] + iDepth.
    IF iStep > 2 AND iStepMod <> 2 THEN
        iSum[3] = iSum[3] + iDepth.
    IF iStep > 3 AND iStepMod <> 3 THEN
        iSum[4] = iSum[4] + iDepth.

    IF iStep > 3 AND iStepMod = 0 THEN DO:
        IF iSum[2] > iSum[1] THEN iCount = iCount + 1.
        iSum[1] = 0.
    END.
    IF iStep > 4 AND iStepMod = 1 THEN DO:
        IF iSum[3] > iSum[2] THEN iCount = iCount + 1.
        iSum[2] = 0.
    END.
    IF iStep > 5 AND iStepMod = 2 THEN DO:
        IF iSum[4] > iSum[3] THEN iCount = iCount + 1.
        iSum[3] = 0.
    END.
    IF iStep > 6 AND iStepMod = 3 THEN DO:
        IF iSum[1] > iSum[4] THEN iCount = iCount + 1.
        iSum[4] = 0.
    END.

END.
INPUT CLOSE.

MESSAGE ETIME SKIP iCount
    VIEW-AS ALERT-BOX INFO BUTTONS OK.

/*
---------------------------
Renseignement (Press HELP to view stack trace)
---------------------------
23 
1645
---------------------------
OK   Aide   
---------------------------
*/
