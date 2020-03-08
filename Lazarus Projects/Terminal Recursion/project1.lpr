program project1;

uses SysUtils; // SysUtils is needed to use IntToStr()

{$R *.res}
{
  Why does the placement caret jumps a line after every character,
  but it works as if that hadn't happened? This only happens in
  Lazarus Console In/Output. In Bash it works fine.

  It looks like the () is optional when calling parameter-less function
}
function ReadIntegersUntilZero: string;
var
  I: Integer;
begin
  Read(I);
  Result := IntToStr(I);
  if I = 777 then
    Exit;
  if I = 123 then
    Exit('321');
  if I <> 0 then
    Result := Result + ' ' + ReadIntegersUntilZero();
end;

begin
  WriteLn(ReadIntegersUntilZero);
end.

