program project1;

{$R *.res}

procedure MyProcedure(const A: Integer);
begin
WriteLn('A + 10 is: ', A + 10);
end;

function MyFunction(const S: string): string;
begin
Result := S + 'strings are automatically managed';
Result := Result + ', ok?';
end;

// Seems like global var block placed right after program is also used.
var
X: Single;
begin
WriteLn(MyFunction('Note: '));
MyProcedure(5);
// Division using "/" always makes float result, use "div" for integer
//division
X := 150 / 5;
WriteLn('X is now: ', X); // scientific notation
WriteLn('X is now: ', X:6:2); // 2 decimal places
end.

