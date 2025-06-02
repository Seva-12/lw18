PROGRAM AverageScore(INPUT, OUTPUT);
CONST
  NumberOfScores = 4; 
  ClassSize = 4; 
  MaxScore = 100;
  MinScore = 0;
TYPE
  Score = MinScore .. MaxScore; 
VAR
  WhichScore: 1 .. NumberOfScores;
  Student: 1 .. ClassSize;
  NextScore: Score;
  Ave, TotalScore, ClassTotal: INTEGER;
  Check: BOOLEAN;
  
PROCEDURE CheckScore(VAR NowScore: Score; VAR Flag: BOOLEAN);
BEGIN{CheckScore}
  IF (NowScore < MinScore) OR (NowScore > MaxScore)
  THEN
    BEGIN
      WRITELN('ERROR: big score.');
      Flag := FALSE
    END
END;{CheckScore}

PROCEDURE CopySurname(VAR InFile, OutFile: TEXT; VAR Flag: BOOLEAN);
CONST
  SurnameEnd = ' ';
VAR
  Ch: CHAR;
BEGIN{CopySurname}
  WHILE NOT EOLN(InFile) AND Flag 
  DO
    BEGIN
      READ(Ch);
      IF Ch <> SurnameEnd
      THEN
        WRITE(Ch)
      ELSE
        BEGIN
          Flag := FALSE;
          WRITE(': ')
        END   
    END
END;{CopySurname} 
  
BEGIN {AverageScore}
  ClassTotal := 0; 
  WRITELN('Student averages:');
  Student := 1;
  Check := TRUE;
  WHILE (Student <= ClassSize) AND Check
  DO
    BEGIN
      TotalScore := 0;
      WhichScore := 1;
      CopySurname(INPUT, OUTPUT, Check);
      WHILE (WhichScore <= NumberOfScores)
      DO
        BEGIN
          
          Check := TRUE;
          READ(NextScore);
          CheckScore(NextScore, Check);
          TotalScore := TotalScore + NextScore;
          WhichScore := WhichScore + 1
        END;
      READLN;
      IF Check
      THEN
        BEGIN
          TotalScore := TotalScore * 10;
          Ave := TotalScore DIV NumberOfScores;
          IF Ave MOD 10 >= 5
          THEN
            WRITELN(Ave DIV 10 + 1)
          ELSE
            WRITELN(Ave DIV 10);
          ClassTotal := ClassTotal + TotalScore;
          Student := Student + 1
        END  
    END;
  IF Check
  THEN
    BEGIN
      WRITELN('Class average:');
      ClassTotal := ClassTotal DIV (ClassSize * NumberOfScores);
      WRITELN(ClassTotal DIV 10, '.', ClassTotal MOD 10:1)
    END
END.  {AverageScore}
