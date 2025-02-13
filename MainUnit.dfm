object MainForm: TMainForm
  Left = 1513
  Top = 1108
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1051#1072#1073#1086#1088#1072#1090#1086#1088#1085#1072#1103' 1.4 '#1056#1072#1081#1095#1091#1082' '#1052#1080#1093#1072#1080#1083' 451004'
  ClientHeight = 438
  ClientWidth = 1026
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnContextPopup = FormContextPopup
  OnCreate = FormCreate
  OnHelp = FormHelp
  TextHeight = 15
  object LbTask: TLabel
    Left = 186
    Top = 2
    Width = 620
    Height = 152
    Caption = 
      #1044#1072#1085#1085#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072' '#1074#1099#1074#1086#1076#1080#1090' '#1085#1072' '#1101#1082#1088#1072#1085' '#1101#1083#1077#1084#1077#1085#1090#1099' '#13#10#1087#1086#1089#1083#1077#1076#1086#1074#1072#1090#1077#1083#1100#1085#1086#1089#1090#1080' ' +
      'a(n) = a(n-1) + nd,'#13#10#1076#1083#1103' n '#1080#1079#1084#1077#1085#1103#1102#1097#1077#1075#1086#1089#1103' '#1086#1090' 1 '#1076#1086' k.'#13#10#1069#1083#1077#1084#1077#1085#1090#1099' '#1074' ' +
      #1076#1080#1072#1087#1072#1079#1086#1085#1077' [-10000000,10000000]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -28
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object BtnAnswer: TButton
    Left = 424
    Top = 256
    Width = 193
    Height = 49
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#13#10#1085#1086#1074#1099#1077#13#10' '#1084#1072#1089#1089#1080#1074#1099
    TabOrder = 4
    OnClick = BtnAnswerClick
  end
  object SGAnswer: TStringGrid
    Left = 633
    Top = 240
    Width = 320
    Height = 89
    Enabled = False
    RowCount = 3
    ScrollBars = ssHorizontal
    TabOrder = 5
    Visible = False
    ColWidths = (
      64
      64
      61
      64
      64)
  end
  object Edit: TEdit
    Left = 88
    Top = 161
    Width = 121
    Height = 23
    TabOrder = 0
    TextHint = '1-30'
    OnChange = EditChange
    OnContextPopup = EditContextPopup
    OnKeyPress = EditKeyPress
  end
  object SGFirstArr: TStringGrid
    Left = 88
    Top = 211
    Width = 320
    Height = 71
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goFixedRowDefAlign]
    ScrollBars = ssHorizontal
    TabOrder = 2
    OnContextPopup = SGFirstArrContextPopup
    OnKeyPress = SGFirstArrKeyPress
    OnSetEditText = SGFirstArrSetEditText
    ColWidths = (
      64
      64
      64
      64
      64)
  end
  object SGSecArr: TStringGrid
    Left = 88
    Top = 288
    Width = 320
    Height = 73
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goFixedRowDefAlign]
    ScrollBars = ssHorizontal
    TabOrder = 3
    OnContextPopup = SGSecArrContextPopup
    OnKeyPress = SGSecArrKeyPress
    OnSetEditText = SGSecArrSetEditText
    ColWidths = (
      64
      64
      64
      64
      64)
  end
  object BtnArr: TButton
    Left = 247
    Top = 160
    Width = 161
    Height = 25
    Caption = #1047#1072#1087#1086#1083#1085#1080#1090#1100' '#1084#1072#1089#1089#1080#1074#1099
    TabOrder = 1
    OnClick = BtnArrClick
  end
  object MainMenu: TMainMenu
    Left = 864
    Top = 112
    object NFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object NOpen: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100
        ShortCut = 16463
        OnClick = NOpenClick
      end
      object NSave: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        ShortCut = 16467
        OnClick = NSaveClick
      end
      object NBlank: TMenuItem
        Caption = '-'
      end
      object NClose: TMenuItem
        Caption = #1042#1099#1081#1090#1080
        ShortCut = 16465
        OnClick = NCloseClick
      end
    end
    object NInstr: TMenuItem
      Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
      OnClick = NInstrClick
    end
    object NDev: TMenuItem
      Caption = #1054' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1077
      OnClick = NDevClick
    end
  end
  object SaveDialog: TSaveDialog
    Left = 864
    Top = 72
  end
  object OpenDialog: TOpenDialog
    Left = 864
    Top = 40
  end
end
