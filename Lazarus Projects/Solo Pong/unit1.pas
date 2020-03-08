unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DBGrids, EditBtn, TAGraph;

type

  { TForm1 }

  TForm1 = class(TForm)
    GameOverLabel: TLabel;
    RestartLabel: TLabel;
    ScoreLabel: TLabel;
    Paddle: TShape;
    Ball: TShape;
    GameTimer: TTimer;
    procedure ControlPaddle(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure GameTimerTimer(Sender: TObject);
    procedure PaddleMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure RestartLabelClick(Sender: TObject);
    procedure RestartLabelMouseEnter(Sender: TObject);
    procedure RestartLabelMouseLeave(Sender: TObject);
  private
    procedure InitGame;
    procedure UpdateScore;
    procedure GameOver;
    procedure IncreaseSpeed;
  public

  end;

var
  Form1: TForm1;
  Score: Integer;
  SpeedX, SpeedY: Integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ControlPaddle(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Paddle.Left := X - Paddle.Width div 2;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered := True;
  InitGame;
end;

procedure TForm1.GameTimerTimer(Sender: TObject);
begin
  Ball.Left := Ball.Left + SpeedX;
  Ball.Top := Ball.Top + SpeedY;

  if (Ball.Left <= 0) or (Ball.Left + Ball.Width >= ClientWidth)
    then SpeedX := -SpeedX;
  if Ball.Top <= 0 then SpeedY := -SpeedY;

  if Ball.Top + Ball.Height >= ClientHeight then GameOver;

  // Collision with the paddle's top border
  if (Ball.Left + Ball.Width >= Paddle.Left) and
     (Ball.Left <= Paddle.Left + Paddle.Width) and
     (Ball.Top + Ball.Height >= Paddle.Top) then
  begin
    IncreaseSpeed;
    SpeedY := -SpeedY;
    Inc(Score);
    UpdateScore;
  end;
end;

procedure TForm1.PaddleMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  ControlPaddle(Sender, Shift, X + Paddle.Left, Y + Paddle.Top);
end;

procedure TForm1.RestartLabelClick(Sender: TObject);
begin
  InitGame;
end;

procedure TForm1.RestartLabelMouseEnter(Sender: TObject);
begin
  RestartLabel.Font.Style := [fsBold];
end;

procedure TForm1.RestartLabelMouseLeave(Sender: TObject);
begin
  RestartLabel.Font.Style := [];
end;

procedure TForm1.InitGame;
begin
  Score := 0;
  SpeedX := 4;
  SpeedY := 4;

  GameOverLabel.Hide;
  RestartLabel.Hide;
  RestartLabel.Font.Style := [];

  Ball.Left := 10;
  Ball.Top := 10;

  GameTimer.Enabled := True;

  UpdateScore;
end;

procedure TForm1.UpdateScore;
begin
  ScoreLabel.Caption := 'Score: ' + IntToStr(Score);
end;

procedure TForm1.GameOver;
begin
  GameTimer.Enabled := False;
  GameOverLabel.Show();
  RestartLabel.Show();
end;

procedure TForm1.IncreaseSpeed;
begin
  if SpeedX > 0 then Inc(SpeedX) else Dec(SpeedX);
  if SpeedY > 0 then Inc(SpeedY) else Dec(SpeedY);
end;

end.

