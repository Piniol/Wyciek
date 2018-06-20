unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Unit1,
  StdCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    ComboBox1: TComboBox;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.DFM}

procedure TForm2.Button1Click(Sender: TObject);
begin
  ruch:=0;
  pchniecie:=0;
  level:=ComboBox1.ItemIndex+1;
  Form1.Label1.Caption:=IntToStr(level);
  Form1.Label2.Caption:='0';
  Form1.Label3.Caption:='0';
  Form1.LadujLevel(Sender);
  Form1.Zresetuj1.Enabled:=True;
  Gra:=True;
  Form2.Close;
end;

procedure TForm2.FormShow(Sender: TObject);
var
  x: Byte;
begin
  ComboBox1.Clear;
  for x:=1 to level2 do
  ComboBox1.Items.Add(IntToStr(x));
  ComboBox1.ItemIndex:=0;
end;

end.
