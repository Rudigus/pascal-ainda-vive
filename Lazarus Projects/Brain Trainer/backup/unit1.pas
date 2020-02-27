unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

const
  MaxNumber = 20;

type

  { TBrainTrainer }

  TBrainTrainer = class(TForm)
    SubmitButton: TButton;
    ResultEdit: TEdit;
    EqualsSymbol: TLabel;
    OperandNumber1: TLabel;
    OperationSymbol: TLabel;
    OperandNumber2: TLabel;
    ScorePanel: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure ResultEditKeyPress(Sender: TObject; var Key: char);
    procedure SubmitButtonClick(Sender: TObject);
  private

  public
    procedure GenerateFormula;
    procedure CheckAnswer;
  end;

var
  BrainTrainer: TBrainTrainer;
  Score: Integer = 0;

implementation

{$R *.lfm}

{ TBrainTrainer }

procedure TBrainTrainer.SubmitButtonClick(Sender: TObject);
var
  Number1, Number2: Integer;
  NumberResult: Integer = 0;
  Operation: Char;
begin
  Number1 := StrToInt(OperandNumber1.Caption);
  Number2 := StrToInt(OperandNumber2.Caption);
  Operation := OperationSymbol.Caption[1];
  case Operation of
    '+': NumberResult := Number1 + Number2;
    '-': NumberResult := Number1 - Number2;
    '*': NumberResult := Number1 * Number2;
  end;
  { Compares the answer given by the user to the calculated answer.
    Weirdly, ResultEdit.Caption and ResultEdit.Text seem to work
    in the same way, although only ResultEdit.Text should work. }
  if StrToInt(ResultEdit.Text) = NumberResult then
  begin
    Inc(Score);
    { I could've put the update to the ScorePanel in the GenerateFormula
      procedure, but since this will be the only source of change to the
      score, I think this makes the code easier to understand. }
    ScorePanel.Caption := 'Score: ' + IntToStr(Score);
    GenerateFormula;
  end
  else
    ShowMessage('Wrong answer. Please, try again.');
end;

procedure TBrainTrainer.FormCreate(Sender: TObject);
begin
  Randomize;
  GenerateFormula;
end;

{ Basic Input Filtering. I've already used this filtering before, but
  now the '-' character is allowed, since it is utterly necessary when
  the operations result in a negative number. Also, Enter is now enabled too. }
procedure TBrainTrainer.ResultEditKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #8, #9, #13, '-']) then Key := #0;
  if Key = #13 then CheckAnswer;
end;

procedure TBrainTrainer.GenerateFormula;
const
  operations: array[1..3] of Char = ('+', '-', '*');
begin
  OperandNumber1.Caption := IntToStr(Random(MaxNumber));
  OperandNumber2.Caption := IntToStr(Random(MaxNumber));
  OperationSymbol.Caption := operations[random(3) + 1];
end;

procedure TBrainTrainer.CheckAnswer;
var
  Number1, Number2: Integer;
  NumberResult: Integer = 0;
  Operation: Char;
begin
  Number1 := StrToInt(OperandNumber1.Caption);
  Number2 := StrToInt(OperandNumber2.Caption);
  Operation := OperationSymbol.Caption[1];
  case Operation of
    '+': NumberResult := Number1 + Number2;
    '-': NumberResult := Number1 - Number2;
    '*': NumberResult := Number1 * Number2;
  end;
  { Compares the answer given by the user to the calculated answer.
    Weirdly, ResultEdit.Caption and ResultEdit.Text seem to work
    in the same way, although only ResultEdit.Text should work. }
  if StrToInt(ResultEdit.Text) = NumberResult then
  begin
    Inc(Score);
    { I could've put the update to the ScorePanel in the GenerateFormula
      procedure, but since this will be the only source of change to the
      score, I think this makes the code easier to understand. }
    ScorePanel.Caption := 'Score: ' + IntToStr(Score);
    GenerateFormula;
  end
  else
    ShowMessage('Wrong answer. Please, try again.');
end;

end.

