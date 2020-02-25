unit MainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  MaskEdit, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Calculate: TButton;
    Log: TLabel;
    OperationSymbol: TComboBox;
    Operand1: TEdit;
    ResultBox: TEdit;
    Operand2: TEdit;
    procedure CalculateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Operand1KeyPress(Sender: TObject; var Key: char);
    procedure OperandKeyPress(Sender: TObject; var Key: char);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.Operand1KeyPress(Sender: TObject; var Key: char);
begin

end;

procedure TForm1.OperandKeyPress(Sender: TObject; var Key: char);
begin
  //if (Key in ['a'..'z', 'A'..'Z']) then Key := #0;
  //if not (Key in ['0'..'9', '.', #8, #9]) then Key := #0;
  if not (Key in ['0'..'9', #8, #9]) then Key := #0;
end;

procedure TForm1.CalculateClick(Sender: TObject);
var
  Number1, Number2, NumberResult: Integer;
  ChosenOperation: Char;
begin
  if(Operand1.Text = '') or (Operand2.Text = '') then
  begin
    Log.Caption := 'Invalid Operands';
    exit;
  end
  else
    if (OperationSymbol.Text = '') then
    begin
       Log.Caption := 'Invalid Operation';
       exit;
    end;
  Number1 := StrToInt(Operand1.Text);
  Number2 := StrToInt(Operand2.Text);
  ChosenOperation := OperationSymbol.Text[1];
  Case ChosenOperation of
    '+': NumberResult := Number1 + Number2;
    '-': NumberResult := Number1 - Number2;
    '*': NumberResult := Number1 * Number2;
    '/': NumberResult := Number1 div Number2;
  end;
  ResultBox.Text := IntToStr(NumberResult);
end;

end.

