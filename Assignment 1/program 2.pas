PROGRAM assignment1_2;
    
PROCEDURE printAry(VAR inputAry : ARRAY OF integer; size : integer);
{Passes in an array by refrence and prints out each value in order}
    VAR
        i : integer;
    BEGIN   
        FOR i:=0 TO size-1 DO 
        BEGIN
            write(inputAry[i], ' ');
        END;
    END;

PROCEDURE sortAry(VAR numbers : ARRAY OF integer; size : integer);
{Passes in an array by refrence and uses bubble sort to sort in ascending order}
    VAR
        i, j, temp : Integer;

    BEGIN
        FOR i := size-1 DOWNTO 0 DO
            FOR j := 1 to i DO
                IF (numbers[j-1] > numbers[j]) THEN
                BEGIN
                    temp := numbers[j-1];
                    numbers[j-1] := numbers[j];
                    numbers[j] := temp;
                END;
    END;

VAR
    inputAry : ARRAY [0..19] OF integer;
	{An array of max size 20 is declared}
    size : integer = 0;
        
BEGIN
    WHILE NOT Eoln DO
	{reads in each integer input to the array in the order given}
    BEGIN
        read(inputAry[size]);
        size := size + 1;
    END;
    
    write('Unsorted Array: ');
    printAry(inputAry, size);
	{Unsorted Array is printed to the stdout}
	
    sortAry(inputAry, size);
    writeln();
    
    write('Sorted Array: ');
    printAry(inputAry, size); 
	{The original array is now sorted and printed out again}
END.