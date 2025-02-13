Unit MainUnit;

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
    Vcl.StdCtrls,
    Vcl.Menus,
    DevUnit,
    InstrUnit,
    Vcl.Grids;

Type
    TCustomGridAccess = Class(TCustomGrid);

    TMainForm = Class(TForm)
        MainMenu: TMainMenu;
        NFile: TMenuItem;
        NOpen: TMenuItem;
        NSave: TMenuItem;
        NBlank: TMenuItem;
        NClose: TMenuItem;
        NInstr: TMenuItem;
        NDev: TMenuItem;
        SaveDialog: TSaveDialog;
        OpenDialog: TOpenDialog;
        LbTask: TLabel;
        BtnAnswer: TButton;
        SGAnswer: TStringGrid;
        Edit: TEdit;
        SGFirstArr: TStringGrid;
        SGSecArr: TStringGrid;
        BtnArr: TButton;
        Procedure NCloseClick(Sender: TObject);
        Procedure NInstrClick(Sender: TObject);
        Procedure NDevClick(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure FormContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Procedure NSaveClick(Sender: TObject);
        Function FormHelp(Command: Word; Data: THelpEventData; Var CallHelp: Boolean): Boolean;
        Procedure BtnAnswerClick(Sender: TObject);
        Procedure NOpenClick(Sender: TObject);
        Procedure SGFirstArrContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure SGSecArrContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure SGFirstArrKeyPress(Sender: TObject; Var Key: Char);
        Procedure SGSecArrKeyPress(Sender: TObject; Var Key: Char);
        Procedure SGSecArrSetEditText(Sender: TObject; ACol, ARow: LongInt; Const Value: String);
        Procedure SGFirstArrSetEditText(Sender: TObject; ACol, ARow: LongInt; Const Value: String);
        Procedure EditKeyPress(Sender: TObject; Var Key: Char);
        Procedure EditChange(Sender: TObject);
        Procedure BtnArrClick(Sender: TObject);
    Private
        IsFirstFilled, IsSecondFilled, IsFileSaved: Boolean;
        FirstAnswerArray: Array Of Integer;
        SecondAnswerArray: Array Of Integer;

    End;

Const
    TAllowedKeys: Set Of Char = ['0' .. '9', #8, '-', #13];
    TAllowedAmnt: Set Of Char = ['0' .. '9', #8];
    MAXAMOUNT = 30;
    MAXNUM = 10000000;
    MINNUM = -10000000;

Var
    MainForm: TMainForm;

Implementation

{$R *.dfm}

Function CheckFullSG(SGArr: TStringGrid): Boolean;
Var
    I: Integer;
Begin
    CheckFullSG := True;
    For I := 1 To SgArr.ColCount - 1 Do
        If (SGArr.Cells[I, 1] = '') Or (SGArr.Cells[I, 1] = '-') Then
            CheckFullSG := False;
End;

Function CheckSG(Const SGNum: Byte; Var Value: String): Boolean;
Var
    I, CursorPos: Integer;
    IsRight: Boolean;
Begin

    MainForm.SGAnswer.Visible := False;
    MainForm.NSave.Enabled := False;
    IsRight := True;
    If Value.Length > 1 Then
    Begin
        For I := 2 To Value.Length Do
            If Value[I] = '-' Then
            Begin
                Delete(Value, I, 1);
                IsRight := False;
            End;
        If IsRight Then
            If (Value[1] = '0') Or (Value[1] = '-') And (Value[2] = '0') Then
            Begin
                Delete(Value, 1, 1);
                IsRight := False;
            End
            Else
                If StrToInt(Value) > MAXNUM Then
                Begin
                    Value := IntToStr(MAXNUM);
                    IsRight := False
                End
                Else
                    If StrToInt(Value) < MINNUM Then
                    Begin
                        Value := IntToStr(MINNUM);
                        IsRight := False
                    End

    End;
    CheckSG := Not IsRight
End;

Procedure TMainForm.BtnAnswerClick(Sender: TObject);
Var
    I, N: Integer;
Begin

    SGAnswer.ColCount := SGFirstArr.ColCount;
    N := SGAnswer.ColCount - 1;
    For I := 1 To N Do
    Begin
        SGAnswer.Cells[I, 0] := IntToStr(I) + '�';
        SGAnswer.Cells[I, 1] := IntToStr(StrToInt(SGFirstArr.Cells[I, 1]) + StrToInt(SGSecArr.Cells[I, 1]));
        SGAnswer.Cells[I, 2] := IntToStr(StrToInt(SGFirstArr.Cells[I, 1]) - StrToInt(SGSecArr.Cells[I, 1]));
    End;

    SGAnswer.Visible := True;
    NSave.Enabled := True
End;

Procedure TMainForm.BtnArrClick(Sender: TObject);
Var
    Size, I: Integer;
Begin
    SGFirstArr.Visible := True;
    SGSecArr.Visible := True;
    Size := StrToInt(Edit.Text);
    SGFirstArr.ColCount := Size + 1;
    SGSecArr.ColCount := Size + 1;
    SGFirstArr.Cells[0, 0] := 'a';
    SGFirstArr.Cells[0, 1] := '��������:';
    For I := 1 To Size Do
        SGFirstArr.Cells[I, 0] := IntToStr(I) + '-�';

    SGSecArr.Cells[0, 0] := 'b';
    SGSecArr.Cells[0, 1] := '��������:';
    For I := 1 To Size Do
        SGSecArr.Cells[I, 0] := IntToStr(I) + '-�';

End;

Procedure TMainForm.EditChange(Sender: TObject);
Begin

    If (Edit.Text <> '') And (Edit.Text <> '0') Then
    Begin
        If StrToInt(Edit.Text) > MAXAMOUNT Then
        Begin
            Edit.Text := '30';
            Edit.SelStart := Length(Edit.Text)
        End
        Else
            If IntToStr(StrToInt(Edit.Text)) <> Edit.Text Then
            Begin
                Edit.Text := IntToStr(StrToInt(Edit.Text));
                Edit.SelStart := Length(Edit.Text)
            End;
        BtnArr.Enabled := True;
    End
    Else
        BtnArr.Enabled := False;
End;

Procedure TMainForm.EditKeyPress(Sender: TObject; Var Key: Char);
Begin
    If Not(Key In TAllowedAmnt) Then
        Key := #0;
End;

Procedure TMainForm.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Begin

    If SGAnswer.Visible And (IsFileSaved = False) Then
        Repeat

            ExitCode := MessageBox(MainForm.Handle, '�� �� ��������� ������.', '������� ���������?', MB_ICONQUESTION + MB_YESNOCANCEL);
            If ExitCode = ID_Yes Then
            Begin
                NSaveClick(MainForm);
                CanClose := True
            End
            Else
                If ExitCode = ID_NO Then
                    CanClose := True
                Else
                    If ExitCode = ID_CANCEL Then
                        CanClose := False;

        Until IsFileSaved Or (ExitCode = ID_NO) Or (ExitCode = ID_CANCEL);

End;

Procedure TMainForm.FormContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Begin
    Handled := True;
End;

Procedure TMainForm.FormCreate(Sender: TObject);
Begin
    Constraints.MinWidth := Width;
    Constraints.MaxWidth := Width;
    Constraints.MinHeight := Height;
    Constraints.MaxHeight := Height;
    BtnAnswer.Enabled := False;
    IsFileSaved := False;
    NSave.Enabled := False;
    SGAnswer.Visible := False;
    SGAnswer.Enabled := True;
    IsFirstFilled := False;
    IsSecondFilled := False;
    BtnArr.Enabled := False;
    SGFirstArr.Visible := False;
    SGSecArr.Visible := False;
    SGAnswer.Cells[0, 1] := '����� a';
    SGAnswer.Cells[0, 2] := '����� b'
End;

Function TMainForm.FormHelp(Command: Word; Data: THelpEventData; Var CallHelp: Boolean): Boolean;
Begin
    CallHelp := False;
    FormHelp := True;
End;

Procedure TMainForm.NCloseClick(Sender: TObject);
Begin
    MainForm.Close;
End;

Procedure TMainForm.NDevClick(Sender: TObject);
Begin
    DevForm.ShowModal();
End;

Procedure TMainForm.NInstrClick(Sender: TObject);
Begin
    InstrForm.ShowModal();
End;

Procedure TMainForm.NOpenClick(Sender: TObject);
Var
    FilePath: String;
    InputFile: TextFile;
    EOFCounter: Integer;
    Num1, Num2, ErrNum: Integer;
Begin
    If OpenDialog.Execute() Then
    Begin
        EOFCounter := 0;
        FilePath := OpenDialog.FileName;
        If Not FilePath.EndsWith('.txt') Then
            MessageBox(MainForm.Handle, '������� ���� � ������� �����', '���� �� ''.txt''', MB_ICONWARNING + MB_OK)
        Else
        Begin
            {$I-}
            AssignFile(InputFile, FilePath);
            Reset(InputFile);
            {$I+}
            ErrNum := IOResult;
            If ErrNum = 0 Then
            Begin
                {$I-}
                Read(InputFile, Num1);
                If EOF(InputFile) Then
                    Inc(EofCounter);
                Read(InputFile, Num2);
                If EOF(InputFile) Then
                    Inc(EofCounter);
                {$I+}
                ErrNum := IOResult;
                Case ErrNum Of
                    0:
                        Case EOFCounter Of

                            1:
                                Begin
                                    //Pizdez
                                End;
                            2:
                                MessageBox(MainForm.Handle, '������� ���� � ������� �����', '� ����� ������������ ����������',
                                    MB_ICONWARNING + MB_OK);
                            0:
                                MessageBox(MainForm.Handle, '������� ���� � ������� �����', '� ����� ���� ������ ����������',
                                    MB_ICONWARNING + MB_OK)
                        End;
                    106: { Invalid number }
                        MessageBox(MainForm.Handle, '������� ���� � ������� �����', '������ � ����� �� �������� �������',
                            MB_ICONWARNING + MB_OK)
                Else
                    MessageBox(MainForm.Handle, '������� ���� � ������� �����', '������ ��� �������� �����', MB_ICONWARNING + MB_OK)

                End;
            End
            Else
                MessageBox(MainForm.Handle, '������� ���� � ������� �����', '������ ��� ���������� �����', MB_ICONWARNING + MB_OK);
            {$I-}
            CloseFile(InputFile);
            {$I+}
        End;
    End;
End;

Procedure TMainForm.NSaveClick(Sender: TObject);

Var
    I: Integer;
    FilePath: String;
    OutputFile: TextFile;

Begin
    If SaveDialog.Execute() Then
    Begin
        FilePath := SaveDialog.FileName;
        If Not FilePath.EndsWith('.txt') Then
            MessageBox(MainForm.Handle, '������� ���� � ������� �����', '���� �� ''.txt''', MB_ICONWARNING + MB_OK)
        Else
        Begin
            {$I-}
            AssignFile(OutputFile, FilePath);
            Rewrite(OutputFile);
            {$I+}
            If IOResult = 0 Then
            Begin
                //Write(OutputFile, '����������� k - ');
                //WriteLn(OutputFile, EdKKoef.Text);
                //Write(OutputFile, '����������� d - ');
                //WriteLn(OutputFile, EdDKoef.Text);
                //Write(OutputFile, '������������������: ');  ���� ������
                //Write(OutputFile, AnswerArray[0]);
                //For I := 1 To High(AnswerArray) Do
                //Begin
                //Write(OutputFile, ', ');
                //Write(OutputFile, AnswerArray[I]);
                //End;
                Write(OutputFile, '.');
                IsFileSaved := True;
            End
            Else
                MessageBox(MainForm.Handle, '������� ���� � ������� �����', '������ ��� ���������� ������ � ����', MB_ICONWARNING + MB_OK);
        End;
        {$I-}
        CloseFile(OutputFile);
        {$I+}
    End;
End;

Procedure TMainForm.SGFirstArrContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Begin
    Handled := True
End;

Procedure TMainForm.SGFirstArrKeyPress(Sender: TObject; Var Key: Char);
Begin
    If Not(Key In TAllowedKeys) Then
        Key := #0;

End;

Procedure TMainForm.SGFirstArrSetEditText(Sender: TObject; ACol, ARow: LongInt; Const Value: String);
Var
    NewValue: String;
Begin
    NewValue := Value;
    If CheckSG(1, NewValue) Then
        SGFirstArr.Cells[ACol, ARow] := NewValue
    Else
        If (Value <> '') And (Value <> '-') And CheckFullSg(SGFirstArr) Then
            IsFirstFilled := True;

    If IsFirstFilled And IsSecondFilled Then
        BtnAnswer.Enabled := True
    Else
        BtnAnswer.Enabled := False

End;

Procedure TMainForm.SGSecArrContextPopup(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Begin
    Handled := True
End;

Procedure TMainForm.SGSecArrKeyPress(Sender: TObject; Var Key: Char);
Begin
    If Not(Key In TAllowedKeys) Then
        Key := #0
End;

Procedure TMainForm.SGSecArrSetEditText(Sender: TObject; ACol, ARow: LongInt; Const Value: String);
Var
    NewValue: String;
    IsBlank, WasBlank: Boolean;
Begin
    NewValue := Value;
    If CheckSG(1, NewValue) Then
        SGSecArr.Cells[ACol, ARow] := NewValue
    Else
        If (Value <> '') And (Value <> '-') And CheckFullSg(SGSecArr) Then
            IsSecondFilled := True;

    If IsSecondFilled And IsFirstFilled Then
        BtnAnswer.Enabled := True
    Else
        BtnAnswer.Enabled := False
End;

End.
