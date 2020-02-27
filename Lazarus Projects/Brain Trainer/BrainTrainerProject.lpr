program BrainTrainerProject;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Unit1
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TBrainTrainer, BrainTrainer);
  Application.Run;
end.
{ If the -Xg flag is active, there'll be a linking error if your
  project path has spaces along the way. Just when I thought
  spaces weren't a problem anymore.}

