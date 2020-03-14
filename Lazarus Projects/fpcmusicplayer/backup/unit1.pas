unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, uos;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
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
uos_LoadLib( PortAudioFileName, nil, Mpg123FileName,  nil, nil, nil); // only PortAudio and Mpg123 are needed.
uos_CreatePlayer( 0 );              // you may create how many players you want, from 0 to to what you computer can do...
uos_AddIntoDevOut( 0 );             // Add Output with default parameters
uos_AddFromFile( 0, 'MySong.mp3' ); // Input from audio file
  // And let's play it...
uos_Play(0);                        // Play the song...
end;

end.

