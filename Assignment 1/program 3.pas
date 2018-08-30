PROGRAM assignment1_3;

CONST
    MAX_NAME_LENGTH = 9;
TYPE
    nameString = PACKED ARRAY [0..MAX_NAME_LENGTH] OF char;
    
    presidentRec = RECORD
        id: integer;
        fname : nameString;
        lname : nameString;
    END;
VAR
    presidentCount : integer = 0;
    presidents : ARRAY [0..19] OF presidentRec;

{Puts each char in an array that holds a first or last name of a president.}
PROCEDURE readName(VAR name : nameString);
    VAR
        i : integer;
        ch : char;
    BEGIN
        i := 0;
        name := ' ';
        REPEAT
            IF NOT eoln THEN BEGIN
                read(ch);  {name character}
                IF  (ch <> ' ')
                AND (i <= MAX_NAME_LENGTH) THEN BEGIN
                    name[i] := ch; {adds char to next position in array}
                    i := i + 1;
                END;
            END;
            UNTIL eoln OR (i = MAX_NAME_LENGTH) OR (ch=' '); {Read until a space, length limit, or end of line is hit}
    END;

{Reads the president's id}
FUNCTION readID: integer;
    VAR
        id: integer;
        space : char;
    BEGIN
        read(id);
        readID := id;
        read(space); 
        {Gets rid of space before the first name. Dumb workaround but it allowed me 
        to use the space as a delimiter for my read name function.}
    END;

{Read the president records.}
PROCEDURE readPresidents;

    VAR
        i : integer = 0;
        idchk : integer = 0;
    BEGIN
        writeln('Reading in presidents from standard input.');
        WHILE (NOT eof) AND (idchk <> -1) DO BEGIN
            WITH presidents[i] DO BEGIN
                id := readID;
                idchk := id; {allows me to extract the read id from the record and check if its -1 in the loop}
                IF(id<>-1) THEN BEGIN {only call the read string function if there is a string to be read. ie: not the -1 line.}
                    readName(fname);
                    readName(lname);
                    i := i + 1; {holds the count for presidents}
                END;
            END;
        END;

        presidentCount := i; {Global president count}
        writeln('Finished Reading.');
        writeln;
    END;

{Prints out the data from each president record in a readable fashion.}
PROCEDURE printPresidents;
    VAR
        i : integer;
    BEGIN
        writeln('Printing array of presidents.');
        FOR i := 0 TO presidentCount-1 DO BEGIN
            writeln;
            WITH presidents[i] DO BEGIN
                writeln('        Id: ', id);
                writeln('First Name: ', fname);
                writeln(' Last Name: ', lname);
            END;
        END;
        writeln;
    END;

{Given the ID read, this will search the array of president records for a matching ID}
PROCEDURE checkID;
    VAR
        id, i: integer;
        match : boolean;   
    BEGIN
        WHILE NOT eof DO BEGIN
            read(id);
            writeln('Checking ID: ', id , '.');
            match := false;
            FOR i := 0 TO presidentCount-1 DO BEGIN
                IF presidents[i].id = id THEN BEGIN
                    writeln('Match: ', presidents[i].fname, ' ', presidents[i].lname,'.');
                    writeln;
                    match := true;
                END;
            END;
            IF (match = false) THEN BEGIN
                writeln('No match.');
                writeln;
            END;
        END;
    END;

{Main Program}
BEGIN
    readPresidents;
    printPresidents;
    
    writeln('Checking given president ID''s against known ID''s.');
    writeln;
    
    while NOT eof DO BEGIN 
    {because the current procedures leave me on the line with all the id's to be 
    checked I can just call this function until I get to the end of file to check the 4 id's}
        checkid;
    END;
    writeln('Program Finished.');
END.