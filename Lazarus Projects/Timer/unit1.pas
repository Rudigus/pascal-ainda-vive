unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, MaskEdit;

type

  { TTimerForm }

  TTimerForm = class(TForm)
    StartButton: TButton;
    StopButton: TButton;
    ClearButton: TButton;
    Display: TLabel;
    Timer: TTimer;
    procedure ClearButtonClick(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private

  public

  end;

var
  TimerForm: TTimerForm;
  //Counter: Integer;

implementation

{$R *.lfm}

{ TTimerForm }

{
      I could've also just created a global variable, instead of
  getting the time from the display component. Still, I like
  the way it is. So, it'll remain this way.
  UPDATE: The other way would be hella easier, but it seems
  like a challenge, so I'll do it the hard way. I'm following
  a tutorial, and always doing the same things as shown gets
  stale after a while.
      By the way, I'm following Devstructor tutorials. They have been really
  great, the pace is nice. I'm watching the videos at 1.5x speed lol.
      To be honest, I'll have to learn how to manipulate strings
  properly in Pascal, so this is not gonna go to waste.
}
{
      Pascal is case-insensitive. So it doesn't matter if you
  write identifiers with some uppercases or not.
  So I can write 'TRUE', 'True' or 'true'. All are correct.
  It seems like 'true' is the most used, but it doesn't matter.
  Also, one could argue that in Lazarus' Object Inspector,
  the booleans show as a checkbox, then '(True)' or '(False)'.
      I know they're capitalized because it's better for displaying
  outside of code, but I just wanted an argument to use it
  capitalized. Also, this is Pascal, and Pascal has PascalCase,
  so another point! Well, just for this application, I'll use
  'True' and 'False' instead of 'true' and 'false'. Naming
  Conventions are a thing, y'know :(
}
procedure TTimerForm.TimerTimer(Sender: TObject);
var
  Counter: Integer = 0;
  // i is not in PascalCase because it just feels weird. Sorry Pascal community.
  i: Integer = 1;
  Multiplier: Integer = 1;
  Letter: Char = #0;
  ReceivedCaption: String = '';
  SentCaption: String = '';
  UnitNameLength: Integer = 1;
  CounterReady: Boolean = false;
begin
  ReceivedCaption := Display.Caption;
  repeat
    Letter := ReceivedCaption[i];
    //WriteLn(Letter);
    case Letter of
      'h', 'm', 's':
      begin
        if Letter = 's' then begin Multiplier := 1; UnitNameLength := 1; end;
        if Letter = 'm' then begin Multiplier := 60; UnitNameLength := 3; end;
        if Letter = 'h' then begin Multiplier := 3600; UnitNameLength := 1; end;
        Counter := Counter + Multiplier *
        StrToInt(Copy(ReceivedCaption, 1, i - 1));
        Delete(ReceivedCaption, 1, i - 1 + UnitNameLength);
        i := 0;
      end;
      ' ': begin Delete(ReceivedCaption, 1, 1); i := 0; end;
    end;
    i := i + 1;
  until (CounterReady) or (i > length(ReceivedCaption));
  Inc(Counter);
  if (Counter div 60) div 60 >= 1 then
    SentCaption := SentCaption + IntToStr((Counter div 60) div 60) + 'h ';
  if Counter div 60 >= 1 then
    SentCaption := SentCaption + IntToStr((Counter div 60) mod 60) + 'min ';
  { (anInteger mod 60) returns an integer from 0 to 59, so
  it's really handy in this situation. The other situations are similar }
  SentCaption := SentCaption + IntToStr(Counter mod 60) + 's';
  Display.Caption := SentCaption;
end;

procedure TTimerForm.StartButtonClick(Sender: TObject);
begin
  Timer.Enabled := True;
end;

procedure TTimerForm.ClearButtonClick(Sender: TObject);
begin
  Display.Caption := '0s';
end;

procedure TTimerForm.StopButtonClick(Sender: TObject);
begin
  Timer.Enabled := False;
end;

end.

