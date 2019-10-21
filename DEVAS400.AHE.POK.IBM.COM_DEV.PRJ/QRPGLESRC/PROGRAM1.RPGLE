000100190624      *
000200190624      * H-Spec to create object with source for compilation
000300190624      * Also to skip IO operation step during debug
000400190624      *
000500190624     H Option(*SrcStmt: *NoDebugIO)
000600190624      *
000700190624      * F-Spec
000800190624      * FILE 1 Declated as Externally Described Input Database file that is keye
000900190624      * FILE 2 Declated as Externally Described Output Database file that is key
001000190624      *
001100190624     FFILE1     IF   E           K DISK
001200190625     FFILE2     UF A E           K DISK
001300180621
001400190624      *
001500190625      * D-Spec
001600190624      *
001700190821     DCOUNTRY2         S              2A   INZ(*BLANKS)
001800190624
001900190624      *
002000190624      * C-Spec
002100190624      *
002200190624      * Positions to the first record but the record is not read yet
002300190624     C     *LOVAL        SETLL     FILE1R
002400190624      *
002500190624        //  Read first record.
002600190624     C                   READ      FILE1                                  30
002700190624      * Indicator 30 in the previous step is set on when End of File is reached
002800190624     C                   DOU       *IN30 = *ON
002900190624      * Write File 2 if country exist in File with Balance is > 0
003000190821     C                   IF        COUNTRY2 <> EDICOUNTRY
003100190624     C                   IF        EDIBALANCE <> *ZERO
003200190624     C                   EVAL      EDICTY = EDICOUNTRY
003300190624     C                   EVAL      EDIEXIST = 'Y'
003400190624     C                   WRITE     FILE2R
003500190821     C                   Eval      COUNTRY2  = EDICOUNTRY
003600190624     C                   EndIF
003700190624     C                   EndIF
003800190624     C                   READ      FILE1                                  30
003900190624     C                   ENDDO
004000190624      *
004100190624     C                   EVAL      *INLR = *ON
004200190624     C                   RETURN
004300190624      *
004400190624     C*                  IF        COUNTRY <> EDICOUNTRY
