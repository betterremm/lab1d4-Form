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
    Private
        FirstFillAmnt: Integer;
        SecondFillAmnt: Integer;
        IsFileSaved: Boolean;
        FirstAnswerArray: Array Of Integer;
        SecondAnswerArray: Array Of Integer;

    End;

Const
    TAllowedKeys: Set Of Char = ['0' .. '9', #8, '-'];
    TAllowedAmnt: Set Of Char = ['0' .. '9', #8];
    MAXAMOUNT = 30;
    MAXNUM = 10000000;
    MINNUM = -10000000;

Var
    MainForm: TMainForm;

Implementation

{$R *.dfm}

Procedure TMainForm.BtnAnswerClick(Sender: TObject);
Var
    TempNum, I, K, D: Integer;
Begin

End;

Procedure TMainForm.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Begin

    If SGAnswer.Visible And (IsFileSaved = False) Then
        Repeat

            ExitCode := MessageBox(MainForm.Handle, 'Вы не сохранили данные.', 'Желаете сохранить?', MB_ICONQUESTION + MB_YESNOCANCEL);
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
    //IsFirstEditFilled := False;
    //IsSecondEditFilled := False;
    IsFileSaved := False;
    NSave.Enabled := False;
    SGAnswer.Visible := False;
    SGAnswer.Enabled := True;
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
            MessageBox(MainForm.Handle, 'Введите путь к другому файлу', 'Файл не ''.txt''', MB_ICONWARNING + MB_OK)
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
                                MessageBox(MainForm.Handle, 'Введите путь к другому файлу', 'В файле недостаточно информации',
                                    MB_ICONWARNING + MB_OK);
                            0:
                                MessageBox(MainForm.Handle, 'Введите путь к другому файлу', 'В файле есть лишняя информация',
                                    MB_ICONWARNING + MB_OK)
                        End;
                    106: { Invalid number }
                        MessageBox(MainForm.Handle, 'Введите путь к другому файлу', 'Данные в файле не являются числами',
                            MB_ICONWARNING + MB_OK)
                Else
                    MessageBox(MainForm.Handle, 'Введите путь к другому файлу', 'Ошибка при открытии вайла', MB_ICONWARNING + MB_OK)

                End;
            End
            Else
                MessageBox(MainForm.Handle, 'Введите путь к другому файлу', 'Ошибка при назначении файла', MB_ICONWARNING + MB_OK);
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
            MessageBox(MainForm.Handle, 'Введите путь к другому файлу', 'Файл не ''.txt''', MB_ICONWARNING + MB_OK)
        Else
        Begin
            {$I-}
            AssignFile(OutputFile, FilePath);
            Rewrite(OutputFile);
            {$I+}
            If IOResult = 0 Then
            Begin
                //Write(OutputFile, 'Коэффициент k - ');
                //WriteLn(OutputFile, EdKKoef.Text);
                //Write(OutputFile, 'Коэффициент d - ');
                //WriteLn(OutputFile, EdDKoef.Text);
                //Write(OutputFile, 'Последовательность: ');  тоже пиздец
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
                MessageBox(MainForm.Handle, 'Введите путь к другому файлу', 'Ошибка при сохранении данных в файл', MB_ICONWARNING + MB_OK);
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
Begin

    SGAnswer.Visible := False;
    NSave.Enabled := False;
    If (Value <> '') Then
    Begin
        If SGFirstArr.Cells[ACol, ARow] = '' Then
            Inc(FirstFillAmnt);

        If StrToInt(Value) > MAXNUM Then
            SGFirstArr.Cells[ACol, ARow] := IntToStr(MAXNUM)

        Else
            If StrToInt(Value) < MINNUM Then
                SGFirstArr.Cells[ACol, ARow] := IntToStr(MINNUM)

            Else
                If IntToStr(StrToInt(Value)) <> Value Then
                    SGFirstArr.Cells[ACol, ARow] := IntToStr(StrToInt(Value));

    End
    Else
        If SGSecArr.Cells[ACol, ARow] = '' Then
            Dec(FirstFillAmnt);

    If (FirstFillAmnt = SGFirstArr.ColCount - 1) And (SecondFillAmnt = SGSecArr.ColCount - 1) Then
    Begin
        BtnAnswer.Enabled := True;
    End;

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
Begin

    SGAnswer.Visible := False;
    NSave.Enabled := False;
    If (Value <> '') Then
    Begin
        If SGSecArr.Cells[ACol, ARow] = '' Then
            Inc(SecondFillAmnt);

        If StrToInt(Value) > MAXNUM Then
            SGSecArr.Cells[ACol, ARow] := IntToStr(MAXNUM)

        Else
            If StrToInt(Value) < MINNUM Then
                SGSecArr.Cells[ACol, ARow] := IntToStr(MINNUM)

            Else
                If IntToStr(StrToInt(Value)) <> Value Then
                    SGSecArr.Cells[ACol, ARow] := IntToStr(StrToInt(Value));

    End
    Else
        If SGSecArr.Cells[ACol, ARow] = '' Then
            Dec(SecondFillAmnt);

    If (SecondFillAmnt = SGSecArr.ColCount - 1) And (FirstFillAmnt = SGFirstArr.ColCount - 1) Then
        BtnAnswer.Enabled := True
    Else
        BtnAnswer.Enabled := False;
End;

End.
