unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    NumeroEdit: TEdit;
    Label1: TLabel;
    Numero: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure NumeroEditKeyPress(Sender: TObject; var Key: char);
  private
    procedure GenerateRandomNumber;
    procedure CheckAnswer;
  public

  end;

var
  Form1: TForm1;
  RandomNumber: Integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
  GenerateRandomNumber;
end;

procedure TForm1.NumeroEditKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then CheckAnswer;
end;

procedure TForm1.GenerateRandomNumber;
var
  Lista: array[1..14] of Integer = (0, 1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169);
begin
  RandomNumber := Lista[Random(5)];
  Numero.Caption := IntToStr(RandomNumber);
end;

procedure TForm1.CheckAnswer;
begin
  if Sqrt(RandomNumber) = StrToInt(NumeroEdit.Text)
    then ShowMessage('Você acertou Adrya!')
  else
    ShowMessage('Você errou Adrya!');
  GenerateRandomNumber;
end;

end.

