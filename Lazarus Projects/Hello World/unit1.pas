unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonTest: TButton;
    LabelTest: TLabel;
    procedure ButtonTestClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ButtonTestClick(Sender: TObject);
begin
     ButtonTest.Caption := 'ok boomer';
     LabelTest.Caption := 'Not Hello World';
end;

end.

