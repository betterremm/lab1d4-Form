program lab1d4;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  DevUnit in 'DevUnit.pas' {Form1},
  InstrUnit in 'InstrUnit.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDevForm, DevForm);
  Application.CreateForm(TInstrForm, InstrForm);
  Application.Run;
end.
