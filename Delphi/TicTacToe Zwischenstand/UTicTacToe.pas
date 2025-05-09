unit UTicTacToe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    PanelTopLeft: TPanel;
    PanelTopMiddle: TPanel;
    PanelTopRight: TPanel;
    PanelMiddleLeft: TPanel;
    PanelMiddleMiddle: TPanel;
    PanelMiddleRight: TPanel;
    PanelBottomLeft: TPanel;
    PanelBottomMiddle: TPanel;
    PanelBottomRight: TPanel;
    LabelPoints: TLabel;
    LabelPointsSchow: TLabel;
    Button1: TButton;
    ButtonNewGame: TButton;
    RadioGroup1: TRadioGroup;
    procedure PanelTopLeftClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonNewGameClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure WirHabenGewinner(PlayerString: String);
    procedure ShowField();
    procedure neuesSpiel();
    procedure Unentschieden();
    function rating(gameField: array of char): integer;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  a, x, o, AllCaptions, GameTypeI: integer;
  panels: array [1 .. 9] of TPanel;
  fieldShow: array [1 .. 9] of char;
  gametype: string;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  x := 0;
  o := 0;
  LabelPointsSchow.Caption := '0 : 0';
end;

procedure TForm1.ShowField();
var
  i: integer;
begin
  for i := 1 to 9 do
    panels[i].Caption := fieldShow[i];
end;

procedure TForm1.ButtonNewGameClick(Sender: TObject);
begin
  neuesSpiel();
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
begin
  a := 0;
  panels[1] := PanelTopLeft;
  panels[2] := PanelTopMiddle;
  panels[3] := PanelTopRight;
  panels[4] := PanelMiddleLeft;
  panels[5] := PanelMiddleMiddle;
  panels[6] := PanelMiddleRight;
  panels[7] := PanelBottomLeft;
  panels[8] := PanelBottomMiddle;
  panels[9] := PanelBottomRight;
  for i := 1 to 9 do
  begin
    panels[i].Tag := i;
    panels[i].OnClick := PanelTopLeftClick;
  end;
  RadioGroup1.ItemIndex := -1;
  neuesSpiel();
end;

procedure TForm1.PanelTopLeftClick(Sender: TObject);
var
  index, r, i, j, b: integer;
begin
  GameTypeI := RadioGroup1.ItemIndex;
  if GameTypeI = 1 then
    gametype := 'TwoPlayer'
  else if GameTypeI = 2 then
    gametype := 'CPU first'
  else
    gametype := 'CPU second';

  index := (Sender as TComponent).Tag;

  if panels[index].Caption = ' ' then
  begin
    b := 0;
    a := a + 1;

    if a mod 2 = 1 then
      fieldShow[index] := 'X'
    else
      fieldShow[index] := 'O';

    r := rating(fieldShow);

    if r = -1 then
      WirHabenGewinner('X');
    if r = 1 then
      WirHabenGewinner('O');

    ShowField()
  end
  else
    MessageDlg('Schon belegt', mtWarning, [mbOK, mbYes], 0);

  for j := 1 to 9 do
    if fieldShow[j] <> ' ' then
    begin
      b := b + 1;
      if b > 8 then
        Unentschieden();
    end;

end;

procedure TForm1.WirHabenGewinner(PlayerString: String);
var
  i: integer;
begin
  ShowField();
  if PlayerString = 'X' then

  begin
    MessageDlg('X hat gewonnen', mtWarning, [mbOK], 0);
    x := x + 1;
  end
  else

  begin
    MessageDlg('O hat gewonnen', mtWarning, [mbOK], 0);
    o := o + 1;
  end;

  neuesSpiel();
end;

procedure TForm1.neuesSpiel();
var
  i: integer;
begin
  for i := 1 to 9 do
    fieldShow[i] := ' ';
  ShowField();
  LabelPointsSchow.Caption := IntToStr(x) + ' : ' + IntToStr(o);
  a := 0;
end;

procedure TForm1.Unentschieden();
begin
  MessageDlg('Keiner hat gewonnen... Es ist ein Unentschieden', mtWarning,
    [mbOK], 0);
  neuesSpiel();
end;

function TForm1.rating(gameField: array of char): integer;
var
  i: integer;
begin
  result := 0;
  // Pr�fung Zeilen
  for i := 0 to 2 do
  begin
    if ((gameField[i * 3] = gameField[i * 3 + 1]) AND
      (gameField[i * 3 + 1] = gameField[i * 3 + 2])) then
    begin
      if (gameField[i * 3] = 'X') then
        result := -1;
      if (gameField[i * 3] = 'O') then
        result := 1;
    end;
  end;

  // Pr�fung Spalten
  for i := 0 to 2 do
  begin
    if ((gameField[i] = gameField[i + 3]) AND
      (gameField[i + 3] = gameField[i + 6])) then
    begin
      if (gameField[i + 3] = 'X') then
        result := -1;
      if (gameField[i + 3] = 'O') then
        result := 1;
    end;
  end;

  // Pr�fung Diagonale\
  i := 0;
  if ((gameField[i] = gameField[i + 4]) AND
    (gameField[i + 4] = gameField[i + 8])) then
  begin
    if (gameField[i + 8] = 'X') then
      result := -1;
    if (gameField[i + 8] = 'O') then
      result := 1;

  end;

  // Pr�fung Diagonale/
  i := 0;
  if ((gameField[i + 2] = gameField[i + 4]) AND
    (gameField[i + 4] = gameField[i + 6])) then
  begin
    if (gameField[i + 6] = 'X') then
      result := -1;
    if (gameField[i + 6] = 'O') then
      result := 1;
  end;

end;

end.
