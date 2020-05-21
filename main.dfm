object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Form1'
  ClientHeight = 513
  ClientWidth = 659
  Color = clCream
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lAllTime: TLabel
    Left = 595
    Top = 135
    Width = 35
    Height = 13
    Caption = 'lAllTime'
  end
  object lRemainingTime: TLabel
    Left = 91
    Top = 135
    Width = 73
    Height = 13
    Caption = 'lRemainingTime'
  end
  object lEllapsedTime: TLabel
    Left = 8
    Top = 135
    Width = 63
    Height = 13
    Caption = 'lEllapsedTime'
  end
  object Bevel2: TBevel
    Left = 0
    Top = 130
    Width = 659
    Height = 27
    Align = alTop
    Shape = bsFrame
    Style = bsRaised
  end
  object Panel2: TPanel
    Left = 0
    Top = 296
    Width = 659
    Height = 217
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 288
    object Bevel3: TBevel
      Left = 463
      Top = 37
      Width = 185
      Height = 171
    end
    object Bevel1: TBevel
      Left = 8
      Top = 37
      Width = 449
      Height = 171
    end
    object Label14: TLabel
      Left = 413
      Top = 65
      Width = 33
      Height = 13
      Caption = '14 '#1082#1043#1094
    end
    object Label13: TLabel
      Left = 370
      Top = 65
      Width = 33
      Height = 13
      Caption = '12 '#1082#1043#1094
    end
    object Label12: TLabel
      Left = 324
      Top = 65
      Width = 33
      Height = 13
      Caption = '10 '#1082#1043#1094
    end
    object Label11: TLabel
      Left = 282
      Top = 65
      Width = 27
      Height = 13
      Caption = '6 '#1082#1043#1094
    end
    object Label10: TLabel
      Left = 240
      Top = 65
      Width = 27
      Height = 13
      Caption = '3 '#1082#1043#1094
    end
    object Label9: TLabel
      Left = 197
      Top = 65
      Width = 27
      Height = 13
      Caption = '1 '#1082#1043#1094
    end
    object Label8: TLabel
      Left = 155
      Top = 65
      Width = 33
      Height = 13
      Caption = '600 '#1043#1094
    end
    object Label7: TLabel
      Left = 110
      Top = 65
      Width = 33
      Height = 13
      Caption = '310 '#1043#1094
    end
    object Label1: TLabel
      Left = 27
      Top = 65
      Width = 27
      Height = 13
      Caption = '80 '#1043#1094
    end
    object Label2: TLabel
      Left = 65
      Top = 65
      Width = 33
      Height = 13
      Caption = '170 '#1043#1094
    end
    object LBalance: TLabel
      Left = 477
      Top = 61
      Width = 62
      Height = 17
      AutoSize = False
      Caption = 'Balance'
      Transparent = True
    end
    object Label5: TLabel
      Left = 502
      Top = 136
      Width = 25
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Caption = '0'
      Transparent = True
    end
    object Label3: TLabel
      Left = 545
      Top = 61
      Width = 34
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Caption = 'Volume'
      Transparent = True
    end
    object lVolume: TLabel
      Left = 595
      Top = 62
      Width = 4
      Height = 13
      Caption = '-'
    end
    object Loops: TSpeedButton
      Left = 381
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Loop'
      OnClick = LoopsClick
    end
    object PaintBox2: TPaintBox
      Left = 569
      Top = 91
      Width = 10
      Height = 103
    end
    object PaintBox3: TPaintBox
      Left = 585
      Top = 91
      Width = 10
      Height = 103
    end
    object Label6: TLabel
      Left = 501
      Top = 84
      Width = 25
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Caption = '-'
      Transparent = True
    end
    object Label16: TLabel
      Left = 501
      Top = 185
      Width = 25
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Caption = '-'
      Transparent = True
    end
    object Bprev: TSpeedButton
      Left = 277
      Top = 6
      Width = 38
      Height = 25
      Caption = 'Prev'
      OnClick = BprevClick
    end
    object Bnext: TSpeedButton
      Left = 318
      Top = 6
      Width = 38
      Height = 25
      Caption = 'Next'
      OnClick = BnextClick
    end
    object BPlay: TSpeedButton
      Left = 8
      Top = 6
      Width = 59
      Height = 25
      Caption = 'Play'
      OnClick = BPlayClick
    end
    object BPause: TSpeedButton
      Left = 70
      Top = 6
      Width = 59
      Height = 25
      Caption = 'Pause'
      OnClick = BPauseClick
    end
    object BStop: TSpeedButton
      Left = 131
      Top = 6
      Width = 59
      Height = 25
      Caption = 'Stop'
      OnClick = BStopClick
    end
    object BRestart: TSpeedButton
      Left = 192
      Top = 6
      Width = 59
      Height = 25
      Caption = 'Restart'
      OnClick = RestartClick
    end
    object TrackBar2: TTrackBar
      Left = 477
      Top = 84
      Width = 28
      Height = 118
      Max = 5
      Min = -5
      Orientation = trVertical
      SelEnd = 5
      SelStart = -5
      TabOrder = 0
      ThumbLength = 15
      OnChange = TrackBar2Change
    end
    object TrackBar3: TTrackBar
      Left = 16
      Top = 84
      Width = 45
      Height = 118
      DoubleBuffered = False
      Max = 30
      Orientation = trVertical
      ParentDoubleBuffered = False
      Position = 15
      TabOrder = 1
      TickMarks = tmBoth
      OnChange = TrackBar3Change
    end
    object TrackBar4: TTrackBar
      Left = 60
      Top = 84
      Width = 45
      Height = 118
      Max = 30
      Orientation = trVertical
      Position = 15
      TabOrder = 2
      TickMarks = tmBoth
      OnChange = TrackBar4Change
    end
    object TrackBar5: TTrackBar
      Left = 103
      Top = 84
      Width = 45
      Height = 118
      Max = 30
      Orientation = trVertical
      Position = 15
      TabOrder = 3
      TickMarks = tmBoth
      OnChange = TrackBar5Change
    end
    object TrackBar6: TTrackBar
      Left = 145
      Top = 84
      Width = 45
      Height = 118
      Max = 30
      Orientation = trVertical
      Position = 15
      TabOrder = 4
      TickMarks = tmBoth
      OnChange = TrackBar6Change
    end
    object TrackBar7: TTrackBar
      Left = 189
      Top = 84
      Width = 45
      Height = 118
      Max = 30
      Orientation = trVertical
      Position = 15
      TabOrder = 5
      TickMarks = tmBoth
      OnChange = TrackBar7Change
    end
    object TrackBar8: TTrackBar
      Left = 231
      Top = 84
      Width = 45
      Height = 118
      Max = 30
      Orientation = trVertical
      Position = 15
      TabOrder = 6
      TickMarks = tmBoth
      OnChange = TrackBar8Change
    end
    object TrackBar9: TTrackBar
      Left = 273
      Top = 84
      Width = 45
      Height = 118
      Max = 30
      Orientation = trVertical
      Position = 15
      TabOrder = 7
      TickMarks = tmBoth
      OnChange = TrackBar9Change
    end
    object TrackBar10: TTrackBar
      Left = 318
      Top = 84
      Width = 45
      Height = 118
      Max = 30
      Orientation = trVertical
      Position = 15
      TabOrder = 8
      TickMarks = tmBoth
      OnChange = TrackBar10Change
    end
    object TrackBar11: TTrackBar
      Left = 364
      Top = 84
      Width = 45
      Height = 118
      Max = 30
      Orientation = trVertical
      Position = 15
      TabOrder = 9
      TickMarks = tmBoth
      OnChange = TrackBar11Change
    end
    object TrackBar12: TTrackBar
      Left = 405
      Top = 84
      Width = 33
      Height = 118
      ParentCustomHint = False
      Max = 30
      Orientation = trVertical
      Position = 15
      TabOrder = 10
      TickMarks = tmBoth
      OnChange = TrackBar12Change
    end
    object TrackBar1: TTrackBar
      Left = 539
      Top = 84
      Width = 24
      Height = 118
      Max = 100
      Orientation = trVertical
      Position = 90
      SelEnd = 100
      TabOrder = 11
      OnChange = TrackBar1Change
    end
    object CBEqualizer: TCheckBox
      Left = 24
      Top = 42
      Width = 74
      Height = 17
      Caption = 'Equalizer'
      Checked = True
      State = cbChecked
      TabOrder = 12
      OnClick = CBEqualizerClick
    end
  end
  object LMeta: TStaticText
    Left = 176
    Top = 135
    Width = 8
    Height = 17
    ParentCustomHint = False
    BiDiMode = bdLeftToRight
    Caption = '-'
    Color = clBtnFace
    DoubleBuffered = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBiDiMode = False
    ParentColor = False
    ParentDoubleBuffered = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
  end
  object TimeScrollBar: TScrollBar
    Left = 0
    Top = 113
    Width = 659
    Height = 17
    Align = alTop
    PageSize = 0
    TabOrder = 2
    OnScroll = TimeScrollBarScroll
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 659
    Height = 113
    Align = alTop
    TabOrder = 3
    object PaintBox1: TPaintBox
      Left = 1
      Top = 1
      Width = 657
      Height = 111
      Align = alClient
      ExplicitLeft = 2
      ExplicitTop = 13
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 157
    Width = 659
    Height = 139
    Align = alClient
    TabOrder = 4
    ExplicitLeft = -1
    ExplicitTop = 154
    ExplicitHeight = 91
    object BAdd: TSpeedButton
      Left = 250
      Top = 24
      Width = 77
      Height = 30
      Caption = 'Add Treck'
      OnClick = BOpenClick
    end
    object BAddPlayList: TSpeedButton
      Left = 250
      Top = 60
      Width = 77
      Height = 30
      Caption = 'Add Play List'
      OnClick = BAddPlayListClick
    end
    object CPU: TLabel
      Left = 559
      Top = 6
      Width = 20
      Height = 13
      Caption = 'CPU'
    end
    object PlayListLoop: TSpeedButton
      Left = 573
      Top = 96
      Width = 75
      Height = 25
      OnClick = PlayListLoopClick
    end
    object CheckBox1: TCheckBox
      Left = 334
      Top = 3
      Width = 71
      Height = 16
      Caption = 'Hide player'
      TabOrder = 1
    end
    object ListBox2: TListBox
      Left = 318
      Top = 24
      Width = 9
      Height = 34
      ItemHeight = 13
      TabOrder = 2
    end
    object ListBox1: TListBox
      Left = 333
      Top = 24
      Width = 316
      Height = 66
      ItemHeight = 13
      PopupMenu = PopupMenu1
      TabOrder = 0
      OnDblClick = ListBox1DblClick
      OnMouseDown = ListBox1MouseDown
      OnMouseMove = ListBox1MouseMove
      OnMouseUp = ListBox1MouseUp
    end
    object GroupBox1: TGroupBox
      Left = 6
      Top = 3
      Width = 234
      Height = 128
      Caption = 'Record'
      TabOrder = 3
      object SBPath: TSpeedButton
        Left = 164
        Top = 17
        Width = 64
        Height = 24
        Caption = '...'
        OnClick = SBPathClick
      end
      object SpeedButton2: TSpeedButton
        Left = 164
        Top = 47
        Width = 64
        Height = 24
      end
      object SBRecord: TSpeedButton
        Left = 164
        Top = 77
        Width = 64
        Height = 25
        Caption = 'Rec'
        OnClick = SBRecordClick
      end
      object RGExtension: TRadioGroup
        Left = 4
        Top = 15
        Width = 66
        Height = 47
        Caption = 'Extension'
        ItemIndex = 0
        Items.Strings = (
          '*.mp3'
          '*.wav')
        TabOrder = 2
        OnClick = RGExtensionClick
      end
      object MicIn: TCheckBox
        Left = 75
        Top = 20
        Width = 67
        Height = 17
        Caption = 'Mic In'
        TabOrder = 0
      end
      object StreamIn: TCheckBox
        Left = 75
        Top = 35
        Width = 67
        Height = 17
        Caption = 'Stream In'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object RGBitrate: TRadioGroup
        Left = 4
        Top = 63
        Width = 130
        Height = 61
        Caption = 'Bitrate Kbps'
        ItemIndex = 0
        Items.Strings = (
          'mp3 - VBR 170-210'
          'mp3 - VBR 220-260'
          'mp3 - CBR 320 ')
        TabOrder = 3
      end
      object StrStpPlayRec: TCheckBox
        Left = 75
        Top = 50
        Width = 86
        Height = 17
        Caption = 'Enb Play Rec'
        TabOrder = 4
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 
      'Playable files|*.mo3;*.xm;*.mod;*.s3m;*.it;*.mtm;*.umx;*.mp3;*.m' +
      'p2;*.mp1;*.ogg;*.wav;*.aif|All files|*.*'
    Options = [ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 288
    Top = 24
  end
  object Timer1: TTimer
    Interval = 50
    OnTimer = Timer1Timer
    Left = 210
    Top = 16
  end
  object MainTimer: TTimer
    OnTimer = MainTimerTimer
    Left = 176
    Top = 16
  end
  object ApplicationEvents1: TApplicationEvents
    OnActivate = ApplicationEvents1Activate
    OnDeactivate = ApplicationEvents1Deactivate
    Left = 137
    Top = 14
  end
  object PopupMenu1: TPopupMenu
    Left = 568
    Top = 32
    object N6: TMenuItem
      Caption = 'Play selected'
      OnClick = N6Click
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object N8: TMenuItem
      Caption = 'Sort playlist by extension'
      OnClick = N8Click
    end
    object m3u1: TMenuItem
      Caption = 'Save to playlist...'
      OnClick = m3u1Click
      object Savem3u1: TMenuItem
        Caption = 'Save to m3u; m3u8; pls'
        OnClick = Savem3u1Click
      end
      object f1: TMenuItem
        Caption = 'f'
      end
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object N1: TMenuItem
      Caption = 'Delete selected'
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = 'Clear playlist'
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N4: TMenuItem
      Caption = 'Exit'
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 440
    Top = 32
  end
  object ImageList1: TImageList
    Left = 512
    Top = 32
  end
  object SDRec: TSaveDialog
    Left = 472
    Top = 24
  end
end
