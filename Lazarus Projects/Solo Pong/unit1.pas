unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, simpleipc, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ExtDlgs, DBGrids, EditBtn, ShellCtrls, ShortPathEdit, TAGraph,
  TASources, TAStyles;

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
  private
    procedure InitGame;
    procedure UpdateScore;
    procedure GameOver;
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
     (Ball.Top + Ball.Height >= Paddle.Top) and
     (abs(Ball.Left - Paddle.Left) >= abs(Ball.Top - Paddle.Top))
    then SpeedY := -SpeedY; { TODO : Fix the collision. Remember that the last condition (the abs one) is
not adapted to both left and right of paddle's center }
  {if (Ball.Top + Ball.Height >= Paddle.Top) and
     (Ball.Top <= Paddle.Top + Paddle.Height) and
     ((Ball.Left + Ball.Width >= Paddle.Left) or
     (Ball.Left <= Paddle.Left + Paddle.Width)) then
  begin
    SpeedX := -SpeedX;
    SpeedY := -SpeedY;
  end;             }
end;

procedure TForm1.PaddleMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  ControlPaddle(Sender, Shift, X + Paddle.Left, Y + Paddle.Top);
end;

procedure TForm1.InitGame;
begin
  Score := 0;
  SpeedX := 4;
  SpeedY := 4;
  GameOverLabel.Hide;
  RestartLabel.Hide;
  UpdateScore;
end;

procedure TForm1.UpdateScore;
begin
  ScoreLabel.Caption := 'Score: ' + IntToStr(Score);
end;

procedure TForm1.GameOver;
begin
  { TODO : Create game over screen }
end;

end.

