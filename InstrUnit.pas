Unit InstrUnit;

Interface

Uses
    Winapi.Windows,
    Winapi.Messages,
    System.SysUtils,
    System.Variants,
    System.Classes,
    Vcl.Graphics,
    Vcl.Controls,
    Vcl.Forms,
    Vcl.Dialogs,
    Vcl.StdCtrls;

Type
    TInstrForm = Class(TForm)
        InstrLabel: TLabel;
        CloseInstrButton: TButton;
        Procedure FormCreate(Sender: TObject);
        Procedure CloseInstrButtonClick(Sender: TObject);
        Function FormHelp(Command: Word; Data: THelpEventData; Var CallHelp: Boolean): Boolean;
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    InstrForm: TInstrForm;

Implementation

{$R *.dfm}

Procedure TInstrForm.CloseInstrButtonClick(Sender: TObject);
Begin
    InstrForm.Close;
End;

Procedure TInstrForm.FormCreate(Sender: TObject);
Begin
    Constraints.MinWidth := Width;
    Constraints.MaxWidth := Width;
    Constraints.MinHeight := Height;
    Constraints.MaxHeight := Height;
End;

Function TInstrForm.FormHelp(Command: Word; Data: THelpEventData; Var CallHelp: Boolean): Boolean;
Begin
    CallHelp := False;
    FormHelp := True;
End;

End.
