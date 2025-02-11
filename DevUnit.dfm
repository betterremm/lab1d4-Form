object DevForm: TDevForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1054' '#1088#1072#1079#1088#1072#1073#1086#1090#1080#1095#1080#1082#1077
  ClientHeight = 200
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnHelp = FormHelp
  TextHeight = 15
  object DevLabel: TLabel
    Left = 20
    Top = 16
    Width = 215
    Height = 100
    Caption = #1056#1072#1081#1095#1091#1082' '#1052#1080#1093#1072#1080#1083' '#1057#1077#1088#1075#1077#1077#1074#1080#1095#13#10#1041#1043#1059#1048#1056', '#1060#1050#1057#1048#1057' '#1055#1048#13#10'1 '#1082#1091#1088#1089#13#10'tg: mishas23'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object CloseDevButton: TButton
    Left = 136
    Top = 152
    Width = 99
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 0
    OnClick = CloseDevButtonClick
  end
end
