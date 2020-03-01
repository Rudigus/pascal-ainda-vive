unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    AddVatButton: TButton;
    RemoveVatButton: TButton;
    TaxRateComboBox: TComboBox;
    ValueEdit: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ValueVatLabel: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ValueNoVatLabel: TLabel;
    Label7: TLabel;
    VatLabel: TLabel;
    Label9: TLabel;
    procedure AddVatButtonClick(Sender: TObject);
    procedure RemoveVatButtonClick(Sender: TObject);
  private

  public
    function CalcValueWithVat(Value, Rate: Single): Single;
    function CalcValueWithoutVat(Value, Rate: Single): Single;
    function CalcVat(ValueVat, ValueNoVat: Single): Single;
    procedure DisplayResult(ValueVat, ValueNoVat, Vat: Single);
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.AddVatButtonClick(Sender: TObject);
var
  ValueExcl, ValueIncl, Vat: Single;
begin
  ValueExcl := StrToFloat(ValueEdit.Text);
  ValueIncl := CalcValueWithVat(ValueExcl, StrToFloat(TaxRateComboBox.Text));
  Vat := CalcVat(ValueIncl, ValueExcl);
  DisplayResult(ValueIncl, ValueExcl, Vat);
end;

procedure TForm1.RemoveVatButtonClick(Sender: TObject);
var
  ValueExcl, ValueIncl, Vat: Single;
begin
  ValueIncl := StrToFloat(ValueEdit.Text);
  ValueExcl := CalcValueWithoutVat(ValueIncl, StrToFloat(TaxRateComboBox.Text));
  Vat := CalcVat(ValueIncl, ValueExcl);
  DisplayResult(ValueIncl, ValueExcl, Vat);
end;

{
    For CalcValueWithVat and CalcValueWithoutVat, I tried doing using the
  commented lines for calculating the result. However, floating point
  math is tricky. So, I decided to avoid working with decimal places to
  get better results. It works sometimes, like for adding VAT to a value
  of 100 and with 19% tax rate.
    On the other hand, this method still gives imprecise results. Well,
  such is life I guess. EDIT: Now that I'm using FloatToStrF instead of
  FloatToStr, the number is rounded to 2 decimal places. So it doesn't
  matter anymore if the result is slightly off, after the rounding to 2
  decimal places, it will get corrected. So I went back to using the first
  method, since I find it more elegant.
}
function TForm1.CalcValueWithVat(Value, Rate: Single): Single;
begin
  Result := Value * (1 + Rate / 100);
  //Result := Value * (100 + Rate) / 100;
end;

function TForm1.CalcValueWithoutVat(Value, Rate: Single): Single;
begin
  // Value * (1 - Rate / 100) is different from Value / (1 + Rate / 100).
  Result := Value / (1 + Rate / 100);
  //Result := Value * 100 / (100 + Rate);
end;

function TForm1.CalcVat(ValueVat, ValueNoVat: Single): Single;
begin
  Result := ValueVat - ValueNoVat;
end;

procedure TForm1.DisplayResult(ValueVat, ValueNoVat, Vat: Single);
begin
  ValueVatLabel.Caption := 'R$ ' + FloatToStrF(ValueVat, ffNumber, 18, 2);
  ValueNoVatLabel.Caption := 'R$ ' + FloatToStrF(ValueNoVat, ffNumber, 18, 2);
  VatLabel.Caption := 'R$ ' + FloatToStrF(Vat, ffNumber, 18, 2);
end;

end.

