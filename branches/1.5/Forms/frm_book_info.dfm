object frmBookDetails: TfrmBookDetails
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1082#1085#1080#1075#1077
  ClientHeight = 475
  ClientWidth = 582
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object RzPageControl1: TRzPageControl
    Left = 0
    Top = 0
    Width = 582
    Height = 438
    ActivePage = TabSheet2
    Align = alClient
    TabIndex = 1
    TabOrder = 0
    FixedDimension = 19
    object TabSheet1: TRzTabSheet
      DisabledIndex = 0
      Caption = 'Fb2 '#1080#1085#1092#1086
      object Img: TImage
        Left = 8
        Top = 13
        Width = 201
        Height = 281
        Hint = #1054#1073#1083#1086#1078#1082#1072
        Center = True
        ParentShowHint = False
        Proportional = True
        ShowHint = True
        Stretch = True
      end
      object mmShort: TMemo
        Left = 8
        Top = 300
        Width = 560
        Height = 113
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object mmInfo: TMemo
        Left = 214
        Top = 13
        Width = 353
        Height = 281
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 1
      end
    end
    object TabSheet2: TRzTabSheet
      Caption = #1056#1077#1094#1077#1085#1079#1080#1103
      object btnLoadReview: TRzBitBtn
        Left = 8
        Top = 384
        Width = 129
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
        TabOrder = 0
        Visible = False
        OnClick = btnLoadReviewClick
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00F1EF
          F000A49E9700DDD3CC00F5F0F000444250009E9DA5009E9B9D0028476A002F53
          77002B5B8C004E627A00E6E0D800E7E1DC00F0F0F000E7E2DD00E7EAF100D9DC
          E90088868600DEDFDF00F5EDE700423D4A00D3CCC700CFCBC900285482004386
          C60099B4CD0096AABE00D1CCC500D8D2CC00F0EDE800E2DDD800F7F4F100F7F1
          ED00B0ACA900DDDEDC00FBF5F100383F4200BCB3A700C9C3BF0021486B00527C
          9B00F0ECE600D2CAC400B9ADA400D3C9C200E7DDD500D5CCC400F5EFEA008E83
          7900CCC9C5008C887A00404E42001F3F3E002E454800393F43001A353E003D59
          5200BEB49F00E0D8CC003B4864009FA9D200F0F0EE00E5DFD900D8D4D4005465
          7D009194980038424100142347002A2D49003F3E530049485E0046466000383F
          6400504E7900DFD4C600526CA6005B7AC500A5A5B100E6E2DD005377B600435C
          8600746E7F0013155E003F3E6100978C8A00B7AFAD00C1B8B600BBB3B200AEA5
          A400837E87007F6E6A00435862002B4F8700788CB500E3DCD6003C6380008497
          A2003B385A0027405A007E797700CAC1C200D3C9C900D3C9C800D8CBCA00D3C9
          C800A3A0A20061667100465D54006B72790098979700B6AA9E0041665E007A8E
          7D00435752004A736B0097919200BBB6BD00C9C1C100CAC5C500A59D99009595
          9B00536CB400426CD800657AB100DAD0C700B0AAA400C0BEBB00738475006378
          6C0042594F0050777400A29C9E00A1A3AE008E93A60082899C004F5C7700375A
          A7004C80F0005C94FF006285DA00DFD6CA0097928D00F6F3F000EFEAE8005B7A
          7100486C61003A5E5B00838594006B78A500495C8500355EB4003F71D3005798
          FF0064A9FF005794FB00BABDCD00E5DFD90078787600E5E1DD0093A0B9007588
          99005A6E6E00475C70006783C800B7BCCE00A0A2A5002E54A4004776CF00628B
          C200879DBF00D0D1D500E6E2DF00E7E2DE00B9BAB900979290007A9AC1003D89
          E100407CC8004C619E006166B600A0B2DB008595C3003F62B800394B85005852
          5E00D2C0AC00D9D2CD00D9D4CF00DFD9D400F0EFE900B4ABA300849AA7004EAB
          FF0060CBFF0059A6F900826D9D003562B3002B4699002D50A0002F5AAF003A69
          B60087ACD000C3C2C200D8CEC400DBCFC700EFE4DA00D9D0C700E1DBD4006E93
          D60059A3EA005874A100645F83006A8FC300477FBE00558ABF005E90BF0086A5
          C700DBDEE300D5D0CA00E0D9D300DFD9D300F0F0E900E4DFD900988574006F6F
          F30056529D006F798800ACA9BC00C4A58C00999BA000C3A18300C5A88F00C5A2
          8400D6AD8A00C59E7C00C49C7A00C19A7700D1A78200C49C7B00626066007F81
          B600CBC2DE00AAE9DA00DFC0A300D6A77F00D5A88000D1A78100D2A78100D2A7
          8100E5B68D00D5AA8400D2A88200D2A88400E3B58E00D5AE8A00}
      end
      object mmReview: TRzMemo
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 572
        Height = 377
        Margins.Bottom = 35
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 1
        ReadOnlyColor = 15794175
        ReadOnlyColorOnFocus = True
      end
      object btnClearReview: TRzBitBtn
        Left = 158
        Top = 384
        Width = 91
        Caption = #1054#1095#1080#1089#1090#1080#1090#1100
        TabOrder = 2
        OnClick = btnClearReviewClick
        Glyph.Data = {
          36060000424D3606000000000000360400002800000020000000100000000100
          0800000000000002000000000000000000000001000000000000000000003300
          00006600000099000000CC000000FF0000000033000033330000663300009933
          0000CC330000FF33000000660000336600006666000099660000CC660000FF66
          000000990000339900006699000099990000CC990000FF99000000CC000033CC
          000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
          0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
          330000333300333333006633330099333300CC333300FF333300006633003366
          33006666330099663300CC663300FF6633000099330033993300669933009999
          3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
          330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
          66006600660099006600CC006600FF0066000033660033336600663366009933
          6600CC336600FF33660000666600336666006666660099666600CC666600FF66
          660000996600339966006699660099996600CC996600FF99660000CC660033CC
          660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
          6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
          990000339900333399006633990099339900CC339900FF339900006699003366
          99006666990099669900CC669900FF6699000099990033999900669999009999
          9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
          990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
          CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
          CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
          CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
          CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
          CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
          FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
          FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
          FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
          FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
          000000808000800000008000800080800000C0C0C00080808000191919004C4C
          4C00B2B2B200E5E5E5005A1E1E00783C3C0096646400C8969600FFC8C800465F
          82005591B9006EB9D7008CD2E600B4E6F000D8E9EC0099A8AC00646F7100E2EF
          F100C56A31000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000EEEEEEEEEEEE
          EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE7E5E5E5E5
          EEEEEEEEEEEEEEEEEEEEEEAC81818181EEEEEEEEEEEEEEEEEEEEE7E5EEEEEEEE
          E5E5EEEEEEE5EEEEEEEEAC81EEEEEEEE8181EEEEEE81EEEEEEEEE5EEEEEEEEEE
          EEEEE5EEE5E5EEEEEEEE81EEEEEEEEEEEEEE81EE8181EEEEEEEEE5EEEEEEEEEE
          EEEEEEE5E5E5EEEEEEEE81EEEEEEEEEEEEEEEE818181EEEEEEEEE5EEEEEEEEEE
          EEEEE5E5E5E5EEEEEEEE81EEEEEEEEEEEEEE81818181EEEEEEEEE7E5EEEEEEEE
          EEE5E5E5E5E5EEEEEEEEAC81EEEEEEEEEE8181818181EEEEEEEEEEE5E7EEEEEE
          EEEEEEEEEEEEEEEEEEEEEE81ACEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
          EEEEEEEEEEEEE7E5EEEEEEEEEEEEEEEEEEEEEEEEEEEEAC81EEEEEEEEEEE5E5E5
          E5E5EEEEEEEEEEE5E7EEEEEEEE8181818181EEEEEEEEEE81ACEEEEEEEEE5E5E5
          E5EEEEEEEEEEEEEEE5EEEEEEEE81818181EEEEEEEEEEEEEE81EEEEEEEEE5E5E5
          EEEEEEEEEEEEEEEEE5EEEEEEEE818181EEEEEEEEEEEEEEEE81EEEEEEEEE5E5EE
          E5EEEEEEEEEEEEEEE5EEEEEEEE8181EE81EEEEEEEEEEEEEE81EEEEEEEEE5EEEE
          EEE5E5EEEEEEEEE5E7EEEEEEEE81EEEEEE8181EEEEEEEE81ACEEEEEEEEEEEEEE
          EEEEEEE5E5E5E5E7EEEEEEEEEEEEEEEEEEEEEE81818181ACEEEEEEEEEEEEEEEE
          EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE}
        NumGlyphs = 2
      end
    end
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 438
    Width = 582
    Height = 37
    Align = alBottom
    BorderOuter = fsFlatBold
    TabOrder = 1
    DesignSize = (
      582
      37)
    object RzBitBtn1: TRzBitBtn
      Left = 472
      Top = 6
      Width = 104
      Anchors = [akRight, akBottom]
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 0
      OnClick = RzBitBtn1Click
      Kind = bkClose
    end
  end
end
