unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Grids, SimpleInternet, RegExpr;

type

  { TForm1 }

  TForm1 = class(TForm)
    AccessButton: TButton;
    EventLog: TLabel;
    UrlEdit: TLabeledEdit;
    WebPage: TMemo;
    procedure AccessButtonClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.AccessButtonClick(Sender: TObject);
var
  GivenUrl: String = '';
  SiteHtml: String = '';
  Link: IXQValue;
begin
  EventLog.Caption := '';
  GivenUrl := UrlEdit.Text;
  try
    //begin
    for link in process(GivenUrl, '//a/@href') do
      writeln(link.toString);
    //end
  except
    on E: Exception do ShowMessage('Invalid URL');
  end;
end;

end.

