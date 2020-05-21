unit spectrum_vis;
{ Spectrum Visualyzation by Alessandro Cappellozza
  version 0.8 05/2002
  http://digilander.iol.it/Kappe/audioobject

  Modification 1.0. Editor Antonenko Vyacheslav 2020 email: 777signum@gmail.com.
  Added:
  1: text output.
  2: destructor.
}

interface
  uses Windows, Dialogs, Graphics, SysUtils, CommonTypes, Classes;

 type TSpectrum = Class(TObject)
    private
      VisBuff : TBitmap;
      BackBmp : TBitmap;

      BkgColor : TColor;
      SpecHeight : Integer;
      PenColor : TColor;
      PeakColor: TColor;
      DrawType : Integer;
      DrawRes  : Integer;
      FrmClear : Boolean;
      UseBkg   : Boolean;
      PeakFall : Integer;
      LineFall : Integer;
      ColWidth : Integer;
      ShowPeak : Boolean;

       FFTPeacks  : array [0..128] of Integer;
       FFTFallOff : array [0..128] of Integer;

    public
     Constructor Create (Width, Height : Integer);
     Destructor Destruct;
     procedure Draw(HWND : THandle; FFTData : TFFTData; X, Y : Integer; Str : String);
     procedure SetBackGround (Active : Boolean; BkgCanvas : TGraphic);

     property BackColor : TColor read BkgColor write BkgColor;
     property Height : Integer read SpecHeight write SpecHeight;
     property Width  : Integer read ColWidth write ColWidth;
     property Pen  : TColor read PenColor write PenColor;
     property Peak : TColor read PeakColor write PeakColor;
     property Mode : Integer read DrawType write DrawType;
     property Res  : Integer read DrawRes write DrawRes;
     property FrameClear : Boolean read FrmClear write FrmClear;
     property PeakFallOff: Integer read PeakFall write PeakFall;
     property LineFallOff: Integer read LineFall write LineFall;
     property DrawPeak   : Boolean read ShowPeak write ShowPeak;
  end;

 var Spectrum : TSpectrum;

implementation
//==============================================================================
Constructor TSpectrum.Create(Width, Height : Integer);
      begin
        VisBuff := TBitmap.Create;
        BackBmp := TBitmap.Create;

          VisBuff.Width := Width;
          VisBuff.Height := Height;
          BackBmp.Width := Width;
          BackBmp.Height := Height;

          BkgColor := clBlack;
          SpecHeight := 100;
          PenColor := clWhite;
          PeakColor := clYellow;
          DrawType := 0;
          DrawRes  := 1;
          FrmClear := True;
          UseBkg := False;
          PeakFall := 1;
          LineFall := 3;
          ColWidth := 4;
          ShowPeak := True; 
      end;

//------------------------------------------------------------------------------
destructor TSpectrum.Destruct;
begin
  FreeAndNil(VisBuff);
  FreeAndNil(BackBmp);
end;
//------------------------------------------------------------------------------
procedure TSpectrum.SetBackGround (Active : Boolean; BkgCanvas : TGraphic);
 begin
  UseBkg := Active;
  BackBmp.Canvas.Draw(0, 0, BkgCanvas);
 end;
//------------------------------------------------------------------------------
procedure TSpectrum.Draw(HWND : THandle; FFTData : TFFTData; X, Y : Integer; Str : String);
        var
        i, YPos : LongInt;
        YVal : Single;
        Rct: TRect;
begin
 if FrmClear then
   begin
     VisBuff.Canvas.Pen.Color := BkgColor;
     VisBuff.Canvas.Brush.Color := BkgColor;
     VisBuff.Canvas.Rectangle(0, 0, VisBuff.Width, VisBuff.Height);
       if UseBkg then
         begin
          VisBuff.Canvas.CopyRect(Rect(0, 0, BackBmp.Width, BackBmp.Height),
                                  BackBmp.Canvas,
                                  Rect(0, 0, BackBmp.Width, BackBmp.Height));
         end;
   end;
   //----------------------------------------------------------
    VisBuff.Canvas.Font.Size := 8; //размер
    VisBuff.Canvas.Font.Name := 'Century Gothik'; //
    VisBuff.Canvas.Font.Style := [fsItalic]; //начертание
    VisBuff.Canvas.Font.Color := clLime; //цвет
    VisBuff.Canvas.Brush.Color := BkgColor; //заливка

        //рамка где вывести текст, лишнее обрежется
    Rct.Left := 0; //начало экрана
    Rct.Top := 0;
    Rct.Right := VisBuff.Width; //вся ширина
    Rct.Bottom := VisBuff.Canvas.Font.Size + 6;

    VisBuff.Canvas.TextRect(Rct, 1, 1, str);

   VisBuff.Canvas.Pen.Color := PenColor;
   //-----------------------------------------------------------
   VisBuff.Canvas.Pen.Color := PenColor;
     for i := 0 to 128 do
     begin
       YVal := Abs(FFTData[(i * DrawRes) + 5]);
       YPos := Trunc((YVal) * 500);
         if YPos > Height then YPos := SpecHeight;
         if YPos >= FFTPeacks[i] then begin FFTPeacks[i] := YPos; end
              else begin FFTPeacks[i] := FFTPeacks[i] - PeakFall; end;

         if YPos >= FFTFallOff[i] then begin FFTFallOff[i] := YPos; end
              else begin FFTFallOff[i] := FFTFallOff[i] - LineFall; end;

         if (VisBuff.Height - FFTPeacks[i]) > VisBuff.Height then FFTPeacks[i] := 0;
         if (VisBuff.Height - FFTFallOff[i]) > VisBuff.Height then FFTFallOff[i] := 0;

              case DrawType of
                0 : begin
                       VisBuff.Canvas.MoveTo(X + i, Y + VisBuff.Height);
                       VisBuff.Canvas.LineTo(X + i, Y + VisBuff.Height - FFTFallOff[i]);
                       if ShowPeak then VisBuff.Canvas.Pixels[X + i, Y + VisBuff.Height - FFTPeacks[i]] := Pen;
                    end;

                1 : begin
                     if ShowPeak then VisBuff.Canvas.Pen.Color := PeakColor;
                     if ShowPeak then VisBuff.Canvas.MoveTo(X + i * (ColWidth + 1), Y + VisBuff.Height - FFTPeacks[i]);
                     if ShowPeak then VisBuff.Canvas.LineTo(X + i * (ColWidth + 1) + ColWidth, Y + VisBuff.Height - FFTPeacks[i]);

                     VisBuff.Canvas.Pen.Color := PenColor;
                     VisBuff.Canvas.Brush.Color := PenColor;
                     VisBuff.Canvas.Rectangle(X + i * (ColWidth + 1), Y + VisBuff.Height - FFTFallOff[i], X + i * (ColWidth + 1) + ColWidth, Y + VisBuff.Height);
                    end;
              end;
     end;
    BitBlt(HWND, 0, 0, VisBuff.Width, VisBuff.Height, VisBuff.Canvas.Handle, 0, 0, srccopy)
end;
end.
                                                              // ExtractFileName(FileName)     ExtractFileName(FileName)
