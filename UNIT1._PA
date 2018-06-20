unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus;

type
TKierunek = (lewo, prawo, gora, dol);
type
TSklad = record
x, y: Byte;
end;
type
  TForm1 = class(TForm)
    Memo1: TMemo;
    PaintBox1: TPaintBox;
    MainMenu1: TMainMenu;
    Plik1: TMenuItem;
    NowaGra1: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Zapisz1: TMenuItem;
    Otwrz1: TMenuItem;
    Poziom1: TMenuItem;
    N1: TMenuItem;
    Wyjcie1: TMenuItem;
    Edycja1: TMenuItem;
    Pomoc1: TMenuItem;
    Informacje1: TMenuItem;
    Image1: TImage;
    Zresetuj1: TMenuItem;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    Cofnij1: TMenuItem;
    procedure Poszukiwanie(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure NowaGra1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LadujLevel(Sender: TObject);
    procedure Koniec(Sender: TObject);
    procedure Edycja1Click(Sender: TObject);
    procedure Zresetuj1Click(Sender: TObject);
    procedure Wyjcie1Click(Sender: TObject);
    procedure Zapisz1Click(Sender: TObject);
    procedure Otwrz1Click(Sender: TObject);
    procedure Poziom1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Informacje1Click(Sender: TObject);
  private
    { Private declarations }
    szukaj: String;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  pole: array[1..18, 1..21] of Byte;
  undo: array[1..18, 1..21] of Byte;
  sklad: array[1..34] of TSklad;
  kier: TKierunek;
  pozx, pozy, ilosc, level, level2: Byte;
  ruch, pchniecie: Integer;
  Gra: Boolean = False;
  co: string;

implementation

uses Unit2, Unit3;

{$R *.DFM}
{$R GRAF.RES}

procedure TForm1.Koniec(Sender: TObject);
var
  x,z: Byte;
begin
  z:=0;
  for x:=1 to ilosc do
  begin
    if pole[sklad[x].y,sklad[x].x]=7 then
    z:=z+1;
  end;
  if ilosc=z then
  begin
    for x:=1 to ilosc do
    begin
      sklad[x].y:=0; sklad[x].x:=0
    end;
    Application.MessageBox(PChar('Ukoñczy³eœ '+IntToStr(level)+' poziom.'),'Gratulacje',mb_ok);
    if level<50 then
    begin
      level:=level+1;
      LadujLevel(Sender);
    end else
    if level=50 then
    begin
      Application.MessageBox(PChar('Ukoñczy³eœ grê!!!'),'Gratulacje',mb_ok);
      Gra:=False;
    end;
  end;
end;

procedure TForm1.LadujLevel(Sender: TObject);
var
  x, y: Byte;
begin
  Gra:=True;
  Label1.Caption:=IntToStr(level);
  Label2.Caption:='0';
  Label3.Caption:='0';
  ilosc:=0;
  ruch:=0;
  pchniecie:=0;
  szukaj:='[LEVEL'+IntToStr(level)+']';
  Poszukiwanie(Sender);
  if level>level2 then
  level2:=level;
  for y:=1 to 18 do
  begin
    for x:=1 to 21 do
      begin
        pole[y,x]:=StrToInt(Memo1.Lines[y-1][x]);
        if pole[y,x]=3 then
        begin
          ilosc:=ilosc+1;
          sklad[ilosc].x:=x;
          sklad[ilosc].y:=y;
        end;
        if pole[y,x]=5 then
        begin
          pozx:=x; pozy:=y;
        end;
      end;
  end;
  kier:=dol;
  PaintBox1Paint(Sender);
end;

procedure TForm1.Poszukiwanie(Sender: TObject);
var
  plik: TextFile;
  linia: string;
begin
  Memo1.Lines.Clear;
  AssignFile(plik, ExtractFilePath(ParamStr(0))+'levels');
  Reset(plik);
  while not Eof(plik) do
  begin
    Readln(plik, linia);
    if linia=szukaj then
    while not Eof(plik) do
    begin
      Readln(plik, linia);
      if linia<>''then
      Memo1.Lines.Add(linia) else
      begin
        CloseFile(plik);
        Exit;
      end;
    end;
  end;
  CloseFile(plik);
end;


procedure TForm1.PaintBox1Paint(Sender: TObject);
var
  x,y: Byte;
  bmp: TBitmap;
begin
  bmp:=TBitmap.Create;
  for y:=0 to 17 do
  begin
    for x:=0 to 20 do
    begin
      PaintBox1.Canvas.Brush.Color:=$00C0A080;
      PaintBox1.Canvas.Brush.Style:=bsSolid;
      PaintBox1.Canvas.Pen.Color:=$00C0A080;
      case pole[y+1,x+1] of
      2: PaintBox1.Canvas.Rectangle(x*16, y*16, x*16+16, y*16+16);
      0: PaintBox1.Canvas.Rectangle(x*16, y*16, x*16+16, y*16+16);
      7: begin
           bmp.LoadFromResourceName(hInstance,'splazma');
           PaintBox1.Canvas.Draw(x*16, y*16, bmp);
         end;
      8: begin
      case kier of
         dol: begin
                bmp.LoadFromResourceName(hInstance,'sdol');
                PaintBox1.Canvas.Draw(x*16, y*16, bmp);
              end;
         gora: begin
                 bmp.LoadFromResourceName(hInstance,'sgora');
                 PaintBox1.Canvas.Draw(x*16, y*16, bmp);
               end;
         lewo: begin
                 bmp.LoadFromResourceName(hInstance,'slewo');
                 PaintBox1.Canvas.Draw(x*16, y*16, bmp);
               end;
         prawo: begin
                  bmp.LoadFromResourceName(hInstance,'sprawo');
                  PaintBox1.Canvas.Draw(x*16, y*16, bmp);
                end;
         end;
      end;
      1: begin
           bmp.LoadFromResourceName(hInstance,'p2');
           PaintBox1.Canvas.Draw(x*16, y*16, bmp);
         end;
      3: begin
           bmp.LoadFromResourceName(hInstance,'sklad');
           PaintBox1.Canvas.Draw(x*16, y*16, bmp);
         end;
      4: begin
           bmp.LoadFromResourceName(hInstance,'plazma');
           PaintBox1.Canvas.Draw(x*16, y*16, bmp);
         end;
      5: begin
         PaintBox1.Canvas.Rectangle(x*16, y*16, x*16+16, y*16+16);
         case kier of
         dol: begin
                bmp.LoadFromResourceName(hInstance,'dol');
                PaintBox1.Canvas.Draw(x*16, y*16, bmp);
              end;
         gora: begin
                 bmp.LoadFromResourceName(hInstance,'gora');
                 PaintBox1.Canvas.Draw(x*16, y*16, bmp);
               end;
         lewo: begin
                 bmp.LoadFromResourceName(hInstance,'lewo');
                 PaintBox1.Canvas.Draw(x*16, y*16, bmp);
               end;
         prawo: begin
                  bmp.LoadFromResourceName(hInstance,'prawo');
                  PaintBox1.Canvas.Draw(x*16, y*16, bmp);
                end;
         end;
         end;
      end;
    end;
  end;
  bmp.Free;
end;

procedure TForm1.NowaGra1Click(Sender: TObject);
begin
  Zresetuj1.Enabled:=True;
  if gra=true then
  begin
    if Application.MessageBox('Czy na pewno chcesz zacz¹æ grê od nowa?',
       'Potwierdzenie',mb_yesno+mb_iconquestion)=idyes then
    begin
      level:=1;
      LadujLevel(Sender);
    end;
  end else
  begin
    level:=1;
    LadujLevel(Sender);
  end;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  x,y: Byte;
begin
  if gra=true then
  begin
    for x:=1 to 21 do
    begin
      for y:=1 to 18 do
      begin
        undo[y,x]:=pole[y,x];
      end;
    end;
    case key of
    vk_up: if pole[pozy-1,pozx] in [0,3] then
           begin
             pole[pozy,pozx]:=pole[pozy,pozx]-5;
             pozy:=pozy-1;
             pole[pozy,pozx]:=pole[pozy,pozx]+5;
             kier:=gora; ruch:=ruch+1;
             Cofnij1.Enabled:=True;
             co:='r';
           end else
           if (pole[pozy-1,pozx] in [4,7]) and (pole[pozy-2,pozx] in [0,3]) then
           begin
             pole[pozy-2,pozx]:=pole[pozy-2,pozx]+4;
             pole[pozy-1,pozx]:=pole[pozy-1,pozx]-4;
             pole[pozy,pozx]:=pole[pozy,pozx]-5;
             pozy:=pozy-1;
             pole[pozy,pozx]:=pole[pozy,pozx]+5;
             kier:=gora;
             pchniecie:=pchniecie+1;
             Cofnij1.Enabled:=True;
             co:='p';
           end;
    vk_down: if pole[pozy+1,pozx] in [0,3] then
             begin
               pole[pozy,pozx]:=pole[pozy,pozx]-5;
               pozy:=pozy+1;
               pole[pozy,pozx]:=pole[pozy,pozx]+5;
               kier:=dol;
               ruch:=ruch+1;
               Cofnij1.Enabled:=True;
               co:='r';
             end else
             if (pole[pozy+1,pozx] in [4,7]) and (pole[pozy+2,pozx] in [0,3]) then
             begin
               pole[pozy+2,pozx]:=pole[pozy+2,pozx]+4;
               pole[pozy+1,pozx]:=pole[pozy+1,pozx]-4;
               pole[pozy,pozx]:=pole[pozy,pozx]-5;
               pozy:=pozy+1;
               pole[pozy,pozx]:=pole[pozy,pozx]+5;
               kier:=dol;
               pchniecie:=pchniecie+1;
               Cofnij1.Enabled:=True;
               co:='p';
             end;
    vk_left: if pole[pozy,pozx-1] in [0,3] then
             begin
               pole[pozy,pozx]:=pole[pozy,pozx]-5;
               pozx:=pozx-1;
               pole[pozy,pozx]:=pole[pozy,pozx]+5;
               kier:=lewo;
               ruch:=ruch+1;
               Cofnij1.Enabled:=True;
               co:='r';
             end else
             if (pole[pozy,pozx-1] in [4,7]) and (pole[pozy,pozx-2] in [0,3]) then
             begin
               pole[pozy,pozx-2]:=pole[pozy,pozx-2]+4;
               pole[pozy,pozx-1]:=pole[pozy,pozx-1]-4;
               pole[pozy,pozx]:=pole[pozy,pozx]-5;
               pozx:=pozx-1;
               pole[pozy,pozx]:=pole[pozy,pozx]+5;
               kier:=lewo;
               pchniecie:=pchniecie+1;
               Cofnij1.Enabled:=True;
               co:='p';
             end;
    vk_right: if pole[pozy,pozx+1] in [0,3] then
              begin
                pole[pozy,pozx]:=pole[pozy,pozx]-5;
                pozx:=pozx+1;
                pole[pozy,pozx]:=pole[pozy,pozx]+5;
                kier:=prawo;
                ruch:=ruch+1;
                Cofnij1.Enabled:=True;
                co:='r';
              end else
              if (pole[pozy,pozx+1] in [4,7]) and (pole[pozy,pozx+2] in [0,3]) then
              begin
                pole[pozy,pozx+2]:=pole[pozy,pozx+2]+4;
                pole[pozy,pozx+1]:=pole[pozy,pozx+1]-4;
                pole[pozy,pozx]:=pole[pozy,pozx]-5;
                pozx:=pozx+1;
                pole[pozy,pozx]:=pole[pozy,pozx]+5;
                kier:=prawo;
                pchniecie:=pchniecie+1;
                Cofnij1.Enabled:=True;
                co:='p';
              end;
    end;
    PaintBox1Paint(Sender);
    Koniec(Sender);
    Label2.Caption:=IntToStr(ruch);
    Label3.Caption:=IntToStr(pchniecie);
  end;
end;

procedure TForm1.Edycja1Click(Sender: TObject);
var
  x,y: Byte;
begin
  for x:=1 to 21 do
  begin
    for y:=1 to 18 do
    begin
      pole[y,x]:=undo[y,x];
    end;
  end;
  case kier of
  lewo: pozx:=pozx+1;
  prawo: pozx:=pozx-1;
  gora: pozy:=pozy+1;
  dol: pozy:=pozy-1;
  end;
  if co='r' then ruch:=ruch-1 else
  if co='p' then pchniecie:=pchniecie-1;
  Label2.Caption:=IntToStr(ruch);
  Label3.Caption:=IntToStr(pchniecie);
  PaintBox1Paint(Sender);
  Cofnij1.Enabled:=False;
end;

procedure TForm1.Zresetuj1Click(Sender: TObject);
begin
  if Application.MessageBox('Czy na pewno chcesz zresetowaæ poziom?','Potwierdzenie',
  mb_yesno+mb_iconquestion)=idYes then
  LadujLevel(Sender);
end;

procedure TForm1.Wyjcie1Click(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.Zapisz1Click(Sender: TObject);
var
  x,y: Byte;
  txt: TextFile;
begin
  SaveDialog1.InitialDir:=ExtractFilePath(ParamStr(0))+'Zapisy';
  if SaveDialog1.Execute then
  begin
    AssignFile(txt, SaveDialog1.FileName);
    Rewrite(txt);
    for y:=1 to 18 do
    begin
      for x:=1 to 21 do
      begin
        Write(txt,pole[y,x]);
      end;
      WriteLn(txt,'');
    end;
    WriteLn(txt,ruch);
    WriteLn(txt,pchniecie);
    WriteLn(txt,level);
    WriteLn(txt,pozx);
    WriteLn(txt,pozy);
    CloseFile(txt);
  end;
end;

procedure TForm1.Otwrz1Click(Sender: TObject);
var
  x,y: Byte;
  txt: TextFile;
begin
  ilosc:=0;
  OpenDialog1.InitialDir:=ExtractFilePath(ParamStr(0))+'Zapisy';
  if OpenDialog1.Execute then
  if Application.MessageBox('Czy na pewno za³adowaæ grê?','Potwierdzenie',
  mb_yesno+mb_iconquestion)=idyes then
  begin
    Memo1.Clear;
    Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
    for y:=1 to 18 do
    begin
      for x:=1 to 21 do
      begin
        pole[y,x]:=StrToInt(Memo1.Lines[y-1][x]);
        if pole[y,x]=3 then
        begin
          ilosc:=ilosc+1;
          sklad[ilosc].x:=x;
          sklad[ilosc].y:=y;
        end;
      end;
    end;
    ruch:=StrToInt(Memo1.Lines[18]);
    pchniecie:=StrToInt(Memo1.Lines[19]);
    level:=StrToInt(Memo1.Lines[20]);
    pozx:=StrToInt(Memo1.Lines[21]);
    pozy:=StrToInt(Memo1.Lines[22]);
    PaintBox1Paint(Sender);
    Zresetuj1.Enabled:=True;
    gra:=true;
    Label1.Caption:=IntToStr(level);
    Label2.Caption:=IntToStr(ruch);
    Label3.Caption:=IntToStr(pchniecie);
  end;
  Memo1.Visible:=False;
end;

procedure TForm1.Poziom1Click(Sender: TObject);
begin
  Form2.ShowModal;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  txt: TextFile;
begin
  AssignFile(txt, ExtractFilePath(ParamStr(0))+'data');
  Reset(txt);
  ReadLn(txt, level2);
  CloseFile(txt);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  txt: TextFile;
begin
  AssignFile(txt, ExtractFilePath(ParamStr(0))+'data');
  Rewrite(txt);
  WriteLn(txt, level2);
  CloseFile(txt);
end;

procedure TForm1.Informacje1Click(Sender: TObject);
begin
Form3.ShowModal;
end;

end.
