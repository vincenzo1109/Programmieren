program Verschl�sselung;

uses
  Vcl.Forms,
  UVerschl�sselung in '..\UVerschl�sselung.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
