unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

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
  Counter: Integer;
  TreatedCaption: String;
begin
  TreatedCaption := Display.Caption;
  // Deletes the last character, which will always be 's' (seconds)
  Delete(TreatedCaption, length(TreatedCaption), 1);
  Counter := StrToInt(TreatedCaption);
  Inc(Counter);
  Display.Caption := IntToStr(Counter) + 's';
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

