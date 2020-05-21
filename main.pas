unit main;

interface

uses Bass,bassmix, wavf, ExtCtrls, spectrum_vis, CommonTypes, Math, inifiles  , AudioGenie3, MT19937,  ShellAPI, bassenc, IOUtils, Wininet,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.AppEvnts, Vcl.Menus, System.ImageList, Vcl.ImgList, OoMisc, AdStatLt,
  CPortCtl;

type


 WAVHDR = packed record  // WAV
    riff: array [0 .. 3] of AnsiChar;
    len: DWord;
    cWavFmt: array [0 .. 7] of AnsiChar;
    dwHdrLen: DWord;
    wFormat: Word;
    wNumChannels: Word;
    dwSampleRate: DWord;
    dwBytesPerSec: DWord;
    wBlockAlign: Word;
    wBitsPerSample: Word;
    cData: array [0 .. 3] of AnsiChar;
    dwDataLen: DWord;
 end;

  TPlayerMode = (Stop, Play, Paused, Restartf, Loopf);

  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    OpenDialog1: TOpenDialog;
    Timer1: TTimer;
    Panel2: TPanel;
    Label14: TLabel;
    Label13: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    TrackBar4: TTrackBar;
    TrackBar5: TTrackBar;
    TrackBar6: TTrackBar;
    TrackBar7: TTrackBar;
    TrackBar8: TTrackBar;
    TrackBar9: TTrackBar;
    TrackBar10: TTrackBar;
    TrackBar11: TTrackBar;
    TrackBar12: TTrackBar;
    LBalance: TLabel;
    Label5: TLabel;
    TrackBar1: TTrackBar;
    Label3: TLabel;
    Bevel1: TBevel;
    ListBox1: TListBox;
    lVolume: TLabel;
    LMeta: TStaticText;
    TimeScrollBar: TScrollBar;
    lAllTime: TLabel;
    lRemainingTime: TLabel;
    lEllapsedTime: TLabel;
    MainTimer: TTimer;
    Loops: TSpeedButton;
    CheckBox1: TCheckBox;
    ApplicationEvents1: TApplicationEvents;
    Bevel2: TBevel;
    Panel1: TPanel;
    PaintBox2: TPaintBox;
    PaintBox3: TPaintBox;
    CPU: TLabel;
    Label6: TLabel;
    Label16: TLabel;
    PlayListLoop: TSpeedButton;
    Bevel3: TBevel;
    Bprev: TSpeedButton;
    Bnext: TSpeedButton;
    SBRecord: TSpeedButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    m3u1: TMenuItem;
    SaveDialog1: TSaveDialog;
    Panel4: TPanel;
    BAdd: TSpeedButton;
    BPlay: TSpeedButton;
    BPause: TSpeedButton;
    BStop: TSpeedButton;
    BRestart: TSpeedButton;
    BAddPlayList: TSpeedButton;
    ImageList1: TImageList;
    Savem3u1: TMenuItem;
    f1: TMenuItem;
    ListBox2: TListBox;
    SDRec: TSaveDialog;
    GroupBox1: TGroupBox;
    MicIn: TCheckBox;
    SBPath: TSpeedButton;
    StreamIn: TCheckBox;
    SpeedButton2: TSpeedButton;
    RGExtension: TRadioGroup;
    RGBitrate: TRadioGroup;
    StrStpPlayRec: TCheckBox;
    CBEqualizer: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure BOpenClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure TrackBar5Change(Sender: TObject);
    procedure TrackBar6Change(Sender: TObject);
    procedure TrackBar7Change(Sender: TObject);
    procedure TrackBar8Change(Sender: TObject);
    procedure TrackBar9Change(Sender: TObject);
    procedure TrackBar10Change(Sender: TObject);
    procedure TrackBar11Change(Sender: TObject);
    procedure TrackBar12Change(Sender: TObject);
    //procedure TrackBar13Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure BPlayClick(Sender: TObject);
    procedure BPauseClick(Sender: TObject);
    procedure BStopClick(Sender: TObject);
    procedure RestartClick(Sender: TObject);
    procedure MainTimerTimer(Sender: TObject);

    procedure TimeScrollBarScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure LoopsClick(Sender: TObject);

    procedure Player;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ApplicationEvents1Activate(Sender: TObject);
    procedure ApplicationEvents1Deactivate(Sender: TObject);
    procedure PlayListLoopClick(Sender: TObject);

    procedure ListBox1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SBRecordClick(Sender: TObject);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure m3u1Click(Sender: TObject);
    procedure ListBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BprevClick(Sender: TObject);
    procedure BnextClick(Sender: TObject);
    procedure BAddPlayListClick(Sender: TObject);
    procedure Savem3u1Click(Sender: TObject);
    procedure SBPathClick(Sender: TObject);
    procedure RGExtensionClick(Sender: TObject);
    procedure CBEqualizerClick(Sender: TObject);



  private
    { Private declarations }

    const
      CDataFoider = 'Files\';
      CTmpFoider = 'Tmp\';
      CLanguageFoider = 'Lang\';
      CConfigFoider = 'Config\';
      CLogFoider = 'Log\';
      CPlayListFoider = 'PlayList\';
      CDatabaseFolder = 'Database\';
      COutputFoider = 'Output\';

      CCR = #13#10;

   var
    chan: DWORD;
    mixer : DWORD;
    streamB : DWORD;
    streamA : DWORD;
    CNTLoop : DWORD;
    RecordCnt : integer;
   // FStream:HSTREAM;
    //FTrack:boolean;
    //FTime: TDMTime;


    FSecondsAtAll:integer; //Всё время трека в секундах
    FRemainingSeconds:integer; // Оставшееся время, после перемотки в секундах
    FEllapsedSeconds:integer; // Прошедшее время в секундах


    FAllTime:string;
    FRemainingTime:string; // Оставшееся время, для вывода в Label
    FEllapsedTime:string;  // Прошедшее время, для вывода в Label

    FEnableLoopTrack : boolean;  //Включатель Loop
    FEnablePlayListLoop : boolean;
    FEnablePlayRandom : boolean;
    FRadio : boolean;
    FRec : boolean;
    procedure CountTime;
    procedure Loop;
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    procedure GetAllFiles( Path: string);
    function FilterExstension (Str : String) : boolean;
    procedure SaveList(SaveFile: string;  pl : integer);

      // Получение тотального времени трека
  function qbass_gettime(const Channel: DWORD): DWORD; //Общее число секунд
  function qbass_formattime(const Sec: Integer; const IsURL: boolean): string;
  function GetChannelBitrate(Channel: DWORD): string;
  function FileVersion(AFileName: string): string;
  function SkreenWArr(Point : TPoint):  boolean;
  function myStringToUTF8(aStr: String): string;// Без бом
  function myUTF8ToString(aStr: String): string;

  procedure WriteLog(AWriteText, PathFile, Extension : String; const AType: integer = 1);
  procedure Error(es: string);

  procedure ExtractFileListFromPlayList(FName: string; OUTPUT: TListBox);
  procedure LAP_To_FileList(FName: string; OUTPUT: TListBox);
  function Is_LAP(FName: string): boolean;
  procedure WPL_To_FileList(FName: string; OUTPUT: TListBox);
  function Is_WPL(FName: string): boolean;
  function Is_SimpleList(FName: string): boolean;
  procedure PLS_To_FileList(FName: string; OUTPUT: TListBox);
  function Is_PLS(FName: string): boolean;
  procedure M3U_To_FileList(FName: string; OUTPUT: TListBox);
  function Is_M3U(FName: string): boolean;
  procedure MEPL_To_FileList(FName: string; OUTPUT: TListBox);
  function Is_MEPL(FName: string): boolean;
  function InternetConnected: Boolean;
  public
    { Public declarations }
    cnt : integer;
    ag3: TAudioGenie3;


  end;

var
  Form1: TForm1;
  Win: HWND;
  FFFData : TFFTData;
  p: BASS_DX8_PARAMEQ;
  pR: BASS_DX8_REVERB;
  fx: array[1..11] of integer;
  TrackBarArr: array[3..12] of integer;
  Volume : single;
  icnt : integer = 0;
  SelectedItem : integer =-1;
  n : integer = 0;
  Filename : string;
  Mode: TPlayerMode;//PlayMode
  IniFile: TIniFile;
  StrM1, StrM2: string;
  FileNumber : integer = 0;
  FileCount : integer = 20;
  RandomArr: array of DWORD;
  RandomCNT: DWORD;
  AUDIODuration  : Integer;
  SDRecFileName : string;

implementation

{$R *.dfm}




//------------------------------------------------------------------------------
function TForm1.FilterExstension (Str : String) : boolean;
const ExstensionArr: array [1..7] of string =
                    (
                    '.mp3',
                    '.mp2',
                    '.mp1',
                    '.ogg',
                    '.wav',
                    '.aiff',
                    '.flac');
Var i : integer;
begin
Finalize(Result);
Result := False;
try
  for i := Low(ExstensionArr) to High(ExstensionArr) do
   begin
       if lowercase(ExtractFileExt(Str)) = ExstensionArr[i] then
       begin
          Result := True;
          exit;
       end;
   end;
except
  begin
    Result := False;
  end;
end;
  Result := False;
end;
//------------------------------------------------------------------------------
function TForm1.myUTF8ToString(aStr: String): string;

var
  Data: TEncoding;
  StrArray: TBytes;
begin
  Data := TEncoding.Create;
  try
    try
      StrArray := BytesOf(aStr);
      Result := StringOf(Data.Convert(Data.UTF8, TEncoding.Default, StrArray));
    except
      Result := aStr;
    end;
  finally
    FreeAndNil(Data);
  end;
end;
//------------------------------------------------------------------------------

function TForm1.myStringToUTF8(aStr: String): string;

var
  Data: TEncoding;
  StrArray: TBytes;
begin
  Data := TEncoding.Create;
  try
    try
      StrArray := BytesOf(aStr);
      Result := StringOf(Data.Convert(Data.Default, TEncoding.UTF8, StrArray));
    except
      Result := aStr;
    end;
  finally
    FreeAndNil(Data);
  end;
end;
//------------------------------------------------------------------------------
  procedure TForm1.WMDropFiles(var Msg: TWMDropFiles);
  var
  i: integer;
  CountFile: integer;
  size: integer;
  Filenames: PChar;
begin
 try
  CountFile := DragQueryFile(Msg.Drop, $FFFFFFFF, Filenames, 255);
  for i := 0 to (CountFile - 1) do
  begin
    size := DragQueryFile(Msg.Drop, i , nil, 0) + 1;
    Filenames:= StrAlloc(size);
    DragQueryFile(Msg.Drop,i , Filenames, size);
    if DirectoryExists(StrPas(filenames)) = True then
    begin
         GetAllFiles(StrPas(filenames));
    end else
    begin
    if FilterExstension(StrPas(filenames)) then
      begin
        listbox2.items.add(StrPas(Filenames));
        listbox1.items.add(ExtractFileName(StrPas(Filenames)));
        inc(icnt);
      end;
    StrDispose(Filenames);
    end;
  end;
finally
  DragFinish(Msg.Drop);
end;
end;
//------------------------------------------------------------------------------
procedure TForm1.GetAllFiles(Path: string);
var
sRec: TSearchRec;
isFound: boolean;
begin
try
  isFound := FindFirst( Path + '\*.*', faAnyFile, sRec ) = 0;
  while isFound do
    begin
    if (sRec.Name <> '.') and (sRec.Name <> '..') then
      begin
      if(sRec.Attr and faDirectory) = faDirectory then GetAllFiles( Path + '\' + sRec.Name);
        if FilterExstension(Path + '\' + sRec.Name) then
          begin
            ListBox2.Items.Add( Path + '\' + sRec.Name );
            ListBox1.Items.Add(sRec.Name );
            inc(icnt);
          end;
      end;
      Application.ProcessMessages;
      isFound := FindNext(sRec) = 0;
    end;
except
  begin
    FindClose(sRec);
  end;
end;

FindClose(sRec);
end;
//-----------------------------------------------------------------------------
procedure TForm1.WriteLog(AWriteText, PathFile, Extension : String; const AType: integer = 1);
var

  WriteText : string;//UTF8String;  AnsiString;
  FileStream : TFileStream;
  FileName : String;
  PathDir : String;
begin

  WriteText:= AWriteText + #13#10;
  try
    //if AType = 1  then CS.Enter;   // Критическая секция не использует

       PathDir :=  PathFile;//

  FileName := PathDir + '_' + inttostr(FileNumber)+ Extension;

    if FileExists(FileName)  then
    begin
      FileStream := TFileStream.Create(FileName, fmOpenWrite + fmShareDenyNone);
      try
        if FileStream.Size > 65535{FileSize} then
        begin
          FileStream.Free;
          inc(FileNumber);
          FileNumber:= FileNumber mod FileCount;
          FileName:= PathDir + '_' + inttostr(FileNumber)+ Extension;
          if FileExists(FileName) then
            FileStream := TFileStream.Create(FileName, fmOpenWrite + fmShareDenyNone)
          else
            FileStream := TFileStream.Create(FileName, fmCreate + fmShareDenyNone);

          FileStream.Position := FileStream.Size;
          FileStream.WriteBuffer(Pointer(WriteText)^, Length(WriteText) * SizeOf(Char));
        end else
        begin
          FileStream.Position := FileStream.Size;
          //FileStream.Write(AnsiString(WriteText)[1], Length(WriteText));
          FileStream.WriteBuffer(Pointer(WriteText)^, Length(WriteText) * SizeOf(Char));
        end;

      finally
        FileStream.Free;
      end;
    end else  //если нужно создать новый файл
    begin
      try
        FileStream := TFileStream.Create(FileName, fmCreate + fmShareDenyNone);
        try
          FileStream.Position := FileStream.Size;
          FileStream.WriteBuffer(Pointer(WriteText)^, Length(WriteText)* SizeOf(Char));  //
        finally
          FileStream.Free;
        end;
      except
      end;
    end;

  finally
    //if AType = 1 then CS.Leave;
  end;
end;
//------------------------------------------------------------------------------
function TForm1.FileVersion(AFileName: string): string;
    var
      szName: array[0..255] of Char;
      P: Pointer;
      Value: Pointer;
      Len: UINT;
      GetTranslationString: string;
      FFileName: PChar;
      FValid: boolean;
      FSize: DWORD;
      FHandle: DWORD;
      FBuffer: PChar;
        begin
          try
            FFileName := StrPCopy(StrAlloc(Length(AFileName) + 1), AFileName);
            FValid := False;
            FSize := GetFileVersionInfoSize(FFileName, FHandle);
            if FSize > 0 then
              try
                GetMem(FBuffer, FSize);
                FValid := GetFileVersionInfo(FFileName, FHandle, FSize, FBuffer);
              except
                FValid := False;
                raise;
              end;
            Result := '';
          if FValid then begin
              VerQueryValue(FBuffer, '\VarFileInfo\Translation', p, Len);
                         end
                else begin p := nil; end;

                  if P <> nil then  begin
                    GetTranslationString := IntToHex(MakeLong(HiWord(Longint(P^)),
                    LoWord(Longint(P^))), 8); end;
                  if FValid then
                    begin
                     StrPCopy(szName, '\StringFileInfo\' + GetTranslationString +
                                      '\FileVersion');
                  if VerQueryValue(FBuffer, szName, Value, Len) then begin
                      Result := StrPas(PChar(Value)); end;
                    end;
            finally
                try
                  if FBuffer <> nil then begin
                    FreeMem(FBuffer, FSize); end;
                  except
                end;
                  try
                    StrDispose(FFileName);
                    except
                  end;
          end;
        end;
//------------------------------------------------------------------------------

procedure TForm1.LAP_To_FileList(FName: string; OUTPUT: TListBox);
const
  FirstTag = '>N';
var
  F : TextFile;
  S : string;
begin
  AssignFile(F, FName);
  Reset(F);
  while not eof(f) do
    begin
      Readln(F, S);
    if (Pos(FirstTag, S) = 0) and (Length(S) > 0) then
    OUTPUT.Items.Add(S);
    end;
CloseFile(F);
end;
//------------------------------------------------------------------------------
function TForm1.Is_LAP(FName: string): boolean;
const
  SectName='>N';
var
  F : TextFile;
  S : string;
begin
  Result := False;
  AssignFile(F, FName);
  Reset(F);
  while not eof(F) do
    begin
      Readln(F, S);
      if Pos(SectName, S) > 0 then Result := True;
    end;
  CloseFile(F);
end;
//------------------------------------------------------------------------------
procedure TForm1.WPL_To_FileList(FName: string; OUTPUT: TListBox);
const
  BeginTag = '<media src="';
  EndTag = '" tid="';
var
  F : TextFile;
  S : string;
  B, E, L: Integer;
begin
  L := Length(BeginTag);
  AssignFile(F, FName);
  Reset(F);
  while not eof(f) do
  begin
  Readln(F, S);
  B := Pos(BeginTag, S);
   if B > 0 then
    begin
     E := Pos(EndTag, S);
     S := Copy(S, B + L, E - B - L);
     OUTPUT.Items.Add(UTF8Decode(S));
    end;
  end;
CloseFile(F);
end;
//------------------------------------------------------------------------------
function TForm1.Is_WPL(FName: string): boolean;
const
  SectName='<?wpl';
var
  F : TextFile;
  S : string;
begin
  AssignFile(F, FName);
  Reset(F);
  Readln(F, S);
  Result := Pos(SectName, S) > 0;
  CloseFile(F);
end;
//------------------------------------------------------------------------------
function TForm1.Is_SimpleList(FName: string): boolean;
var
  F : TextFile;
  S : string;
  B, E : Integer;
begin
  B := 0;
  E := 0;
  AssignFile(F, FName);
  Reset(F);
  while not Eof(F) do
  begin
  Readln(F, S);
  if ExtractFileExt(S) <> '' then Inc(B);//Сменить при необходимости  ///////////////////////////////////
   Inc(E);
  end;
 Result := B = E;
 CloseFile(F);
end;
//------------------------------------------------------------------------------
procedure TForm1.PLS_To_FileList(FName: string; OUTPUT: TListBox);//TStrings
const
  FileTag = 'File';
var
  F : TextFile;
  S : string;
  B, E, L : Integer;
begin
  L := Length(FileTag);
  AssignFile(F, FName);
  Reset(F);
  while not eof(f) do
  begin
    Readln(F, S);
    E := Length(S);
    B := Pos(FileTag, S);
    if B > 0 then
     begin
     S := Copy(S, B + L + 2, E);
     OUTPUT.Items.Add(S);
     end;
  end;
CloseFile(F);
end;
//------------------------------------------------------------------------------
function TForm1.Is_PLS(FName: string): boolean;
const
  SectName = '[playlist]';
var
  F : TextFile;
  S : string;
begin
  AssignFile(F, FName);
  Reset(F);
  Readln(F, S);
  RESULT := Pos(SectName, S ) > 0;
CloseFile(F);
end;
//------------------------------------------------------------------------------
procedure TForm1.M3U_To_FileList(FName: string; OUTPUT: TListBox);
const
 //FirstTag = '#EXTM3U';
 //FileTag = '#EXTINF';
 OtherTag = '#';
var
  F : TextFile;
  S : string;
begin
  AssignFile(F, FName);
  Reset(F);
  while not eof(f) do
  begin
    Readln(F, S);
  if {(Pos(FirstTag, S) = 0) and (Pos(FileTag, S) = 0) and }(Pos(OtherTag, S) = 0) then
  if (lowercase(ExtractFileExt(FName)) = '.m3u8') then
    OUTPUT.Items.Add(myUTF8ToString(S)) else OUTPUT.Items.Add(S);
end;
CloseFile(F);
end;
//------------------------------------------------------------------------------
function TForm1.Is_M3U(FName: string): boolean;
const
SectName='#EXTM3U';
var
F : TextFile;
S : string;
begin
AssignFile(F, FName);
Reset(F);
Readln(F, S);
if Pos(SectName, S) > 0 then Result := True else
if (lowercase(ExtractFileExt(FName)) = '.m3u') OR  // Old Format
   (lowercase(ExtractFileExt(FName)) = '.m3u8') then Result := True else  Result := False;
CloseFile(F);
end;
//------------------------------------------------------------------------------
function TForm1.Is_MEPL(FName: string): boolean;
begin
//
end;
 //------------------------------------------------------------------------------
procedure TForm1.MEPL_To_FileList(FName: string; OUTPUT: TListBox);
begin
 //
end;
//------------------------------------------------------------------------------
procedure TForm1.ExtractFileListFromPlayList(FName: string; OUTPUT: TListBox);
const
Unknown = 'This type of playlists is not supported.';
begin
if Is_PLS(FName) then PLS_To_FileList(FName, OUTPUT) else
if Is_WPL(FName) then WPL_To_FileList(FName, OUTPUT) else
if Is_M3U(FName) then M3U_To_FileList(FName, OUTPUT) else
if Is_LAP(FName) then LAP_To_FileList(FName, OUTPUT) else
//if Is_SimpleList(FName) then OUTPUT.LoadFromFile(FName) else
ShowMessage(Unknown);
end;
//------------------------------------------------------------------------------
procedure TForm1.SaveList(SaveFile: string;  pl : integer);

var List: TStringList;
     i: integer;
     F:TextFile;
     TagsStr : cardinal;
     Str, Str1 : string;
     S  : UTF8String;
     MyStrings: TStrings;
     TrackLen: Double;
     ValLen: Double;
begin  //

Assignfile(F,SaveFile);
Rewrite(F);

if pl = 3 then
begin
  Writeln(F,'[playlist]');
end else
if pl = 2 then
begin
  S := myStringToUTF8('#EXTM3U' + CCR + '#PLAYLIST: Playlist ' + trim(ExtractFileName(Savedialog1.FileName)));
  Writeln(F,S);
end else if pl = 1 then
begin
  Writeln(F,'#EXTM3U' + CCR + '#PLAYLIST:Playlist ' + trim(ExtractFileName(Savedialog1.FileName)));
end;
{if  TagsStr <> 0 then }BASS_StreamFree(TagsStr);
 for i := 0 to ListBox2.Items.Count - 1 do
     begin
     TagsStr := BASS_StreamCreateFile(FALSE, PChar(ListBox2.Items.Strings[i]), 0, 0, 0 {$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
     Str := IntToStr(qbass_gettime(TagsStr));
     if ag3.ID3V1ExistsW = false  then
        begin
          Str1 :={'Title ' +}  ChangeFileExt(extractfilename(ListBox2.Items.Strings[i]),'');
        end
        else begin
          Str1 :={'Artist ' +} Trim(ag3.AUDIOArtistW)+ ' - '{+ 'Title '} + Trim(ag3.AUDIOTitleW);
        end;
     BASS_StreamFree(TagsStr);
     if pl = 3 then
      begin
        Writeln(F,'File' + IntToStr(i + 1) + '=' +  ListBox2.Items.Strings[i]
        + CCR + 'Title' + IntToStr(i + 1) + '=' + Str1
        + CCR + 'Length' + IntToStr(i + 1) + '=' + Str);
        if (i + 1) = ListBox2.Items.Count then Writeln(F,'NumberOfEntries=' + IntToStr(i + 1)+ CCR + 'Version=2');
      end else
     if pl = 2 then
      begin
         S := myStringToUTF8('#EXTINF:' + Str + ',' + Str1 + CCR + ListBox2.Items.Strings[i]);
         Writeln(F,S);
      end else if pl = 1 then
      begin
         Writeln(F,'#EXTINF:' + Str + ',' + Str1 + CCR + ListBox2.Items.Strings[i]);
      end;
     end;
Closefile(F);
end;

//------------------------------------------------------------------------------
procedure TForm1.Savem3u1Click(Sender: TObject);


begin
  SaveDialog1.Title := 'Save your play list file';
  SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName) + CDataFoider + CPlayListFoider;
  SaveDialog1.Filter := 'Play list file m3u|*.m3u|Play list file m3u8|*.m3u8|Play list file pls|*.pls';
  SaveDialog1.DefaultExt := 'm3u';
  SaveDialog1.FilterIndex := 1;
if Savedialog1.Execute then
begin
  if ExtractFileExt(SaveDialog1.FileName) = '.m3u' then  SaveList(SaveDialog1.FileName,1) else
  if ExtractFileExt(SaveDialog1.FileName) = '.m3u8' then  SaveList(SaveDialog1.FileName,2) else
  if ExtractFileExt(SaveDialog1.FileName) = '.pls' then  SaveList(SaveDialog1.FileName,3) else
  SaveList(SaveDialog1.FileName + '.m3u',1);
end;

end;
//------------------------------------------------------------------------------
function TForm1.SkreenWArr(Point : TPoint):  boolean;
  var P : TPoint;
  begin
    P.X := Form1.Top;
    P.Y := Form1.Left;
    Result := False;
    if P = Point then exit else
      Form1.Top  := Point.X;
      Form1.Left := Point.Y;
      Result := True;
  end;
procedure TForm1.SBPathClick(Sender: TObject);
    function GetFileName(fname : String) : String;
      begin
        Result := TPath.GetFileNameWithoutExtension(fname);
      end;
begin

  SDRec.Title := 'Save your record file';
  SDRec.InitialDir := ExtractFilePath(Application.ExeName) + CDataFoider + COutputFoider;
  SDRec.Filter := 'Record file mp3,wav|*.mp3;*.wav';
  SDRec.DefaultExt := 'mp3';
  SDRec.FilterIndex := 1;
if SDRec.Execute then
begin

  if lowercase(ExtractFileExt(SDRec.FileName)) = '.mp3' then begin
                SDRecFileName := SDRec.FileName; end  else
  if lowercase(ExtractFileExt(SDRec.FileName)) = '.wav' then begin
                SDRecFileName := SDRec.FileName; end else  SDRecFileName := ''; end;
  if SDRecFileName <> '' then
  begin
      SDRecFileName := ExtractFilePath(SDRecFileName) + GetFileName(SDRecFileName) ;
  end;
end;

//------------------------------------------------------------------------------
procedure TForm1.ApplicationEvents1Activate(Sender: TObject);
var P : TPoint;
begin
  AlphaBlend := False;
  AlphaBlendValue :=  255;
  if CheckBox1.Checked then
     begin
      P.X :=(Screen.WorkAreaRect.Bottom - Height) div 2; //
      P.Y :=(Screen.WorkAreaRect.Right - Width) div 2;
      SkreenWArr(P);
     end;
end;
//------------------------------------------------------------------------------
 //------------------------------------------------------------------------------
procedure TForm1.Error(es: string);
begin
  MessageBox(win, PChar(es + #13#10 + '(error code: ' +
  IntToStr(BASS_ErrorGetCode) + ')'), nil, 0);

end;
//------------------------------------------------------------------------------

procedure Ch_EndPlay();
var
number: integer;
begin
  Form1.BStop.Click;
  if Form1.FEnablePlayRandom then
  begin
   //repeat
    repeat
      number := RandomRangeMT19937(0, Form1.ListBox2.Items.Count);
    until icnt <> number;

   // if RandomCNT < Form1.ListBox1.Items.Count then
    //begin
     //  RandomArr[]
   // end;
   //until False;

     icnt := number;
     Filename := Form1.ListBox2.Items.Strings[icnt];
     Form1.ListBox1.ItemIndex := icnt;
     Form1.ListBox2.ItemIndex := icnt;
  end else
  begin
   if icnt < Form1.ListBox2.Items.Count - 1 then
      begin
       inc(icnt);
      end else
      begin
       icnt := 0;
      end;
       Filename := Form1.ListBox2.Items.Strings[icnt];
       Form1.ListBox1.ItemIndex := icnt;
       Form1.ListBox2.ItemIndex := icnt;
  end;

       mode  :=  stop;
       Form1.player;
 //      if BASS_ChannelIsActive(Chan) = 0 then
 //begin   end else
 //begin
   //  LMeta.Caption := 'Play';
 //end;



end;
//------------------------------------------------------------------------------
procedure TForm1.ApplicationEvents1Deactivate(Sender: TObject);
 var
  P : TPoint;
begin
  AlphaBlend := True;
  AlphaBlendValue := 200;
  if CheckBox1.Checked then
   begin
   P.X := 0 - (Height - (10 + 8)); //
   P.Y := Screen.WorkAreaRect.Right - Width;
   SkreenWArr(P);
   end;
end;

//------------------------------------------------------------------------------
procedure TForm1.BAddPlayListClick(Sender: TObject);
var n : integer;
begin

  OpenDialog1.Options := [ofFileMustExist];
  OpenDialog1.Title  := 'Open Play List';
  OpenDialog1.Filter := 'Play List (m3u/m3u8/pls)|*.m3u;*.m3u8;*.pls|Files (All)|*.*';
  OpenDialog1.FilterIndex := 1;
  if opendialog1.Execute then
begin
  //ListBox1.Clear;
  ExtractFileListFromPlayList(OpenDialog1.FileName, ListBox2);
  icnt := 0;
  Filename := ListBox2.Items.Strings[icnt];
  ListBox1.clear;
  for n := 0 to ListBox2.Items.Count - 1 do
   begin
    ListBox1.Items.Add(ExtractFileName(ListBox2.Items[n]));
   end;

   ListBox2.ItemIndex := icnt;
   ListBox1.ItemIndex := icnt;
   mode := Stop;

end;


end;
//------------------------------------------------------------------------------
procedure TForm1.BnextClick(Sender: TObject);
begin
if icnt < (ListBox2.Items.Count - 1) then
begin
inc(icnt);
end else
begin
 icnt := 0;
end;
  ListBox1.ItemIndex := icnt;
  ListBox2.ItemIndex := icnt;
  Filename := Form1.ListBox2.Items.Strings[icnt];
  mode  :=  stop;
  Form1.player;
end;
//------------------------------------------------------------------------------
procedure TForm1.BOpenClick(Sender: TObject);
var
  j, i : integer;
begin

  OpenDialog1.Options := [ofAllowMultiSelect, ofFileMustExist];
  OpenDialog1.Title  := 'Open Files';
  OpenDialog1.Filter := 'Files (MP3/MP2/MP1/OGG/WAV/AIFF/FLAC)' +
                         '|*.mp3;*.mp2;*.mp1;*.ogg;*.wav;*.aiff;*.flac|' +
                          'Files (mp3)|*.mp3|Files (All)|*.*';
  OpenDialog1.FilterIndex := 1;
    if listbox2.Count <> 0 then icnt := ListBox2.ItemIndex else icnt := 0;
  if not OpenDialog1.Execute then exit;
  begin
  //if chan <> 0 then BASS_StreamFree(chan);
  ListBox1.clear;
   for j := 0 to OpenDialog1.Files.Count - 1 do
    begin

      ListBox2.Items.Add(OpenDialog1.Files.Strings[j]);
      ListBox1.Items.Add(ExtractFileName(OpenDialog1.Files.Strings[j]));
    end;

   Filename := ListBox2.Items.Strings[icnt];

   ListBox1.ItemIndex := icnt;
   ListBox2.ItemIndex := icnt;
   mode := Stop;
  end;
end;
//------------------------------------------------------------------------------
procedure TForm1.BPlayClick(Sender: TObject);
begin
if mode = play then exit ;

player;
if StrStpPlayRec.Checked then SBRecord.Click;
end;
//------------------------------------------------------------------------------
procedure TForm1.BprevClick(Sender: TObject);
begin
if icnt > 0 then
begin
dec(icnt);
end else
begin
 Icnt := ListBox2.Items.Count - 1;
end;
  ListBox1.ItemIndex := icnt;
  ListBox2.ItemIndex := icnt;
  Filename := Form1.ListBox2.Items.Strings[icnt];
  mode  :=  stop;
  Form1.player;
end;

//------------------------------------------------------------------------------
procedure TForm1.BPauseClick(Sender: TObject);
var c : integer;
begin
  for c := Low(Fx) to High(Fx) do
  begin
    BASS_ChannelRemoveFX(chan, Fx[c]);
  end;

if mode = play then
begin
 BASS_ChannelPause(chan);
 CountTime;
 mode := paused;
end;
end;
//------------------------------------------------------------------------------
procedure TForm1.BStopClick(Sender: TObject);
begin
if mode = play then
begin
 BASS_ChannelStop(chan);
 BASS_ChannelSetPosition(chan,0,0);
 TimeScrollBar.Position := 0;
 CountTime;
 mode := Stop;
 if StrStpPlayRec.Checked then SBRecord.Click;
end;
end;
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
procedure TForm1.ListBox1DblClick(Sender: TObject);
begin
  icnt := Form1.ListBox1.ItemIndex;
  Filename := Form1.ListBox2.Items.Strings[icnt];
  ListBox2.ItemIndex := icnt;
  BStop.Click;
  player;
end;
//------------------------------------------------------------------------------
procedure TForm1.ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if Button = mbLeft then
begin
  selectedItem := ListBox1.ItemAtPos(Point(X,Y),True);
end;
end;
//------------------------------------------------------------------------------
procedure TForm1.ListBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
  var currentItem : integer;
begin
currentItem := ListBox1.ItemAtPos(Point(X,Y), True);
if(currentItem <> -1) AND (selectedItem <> -1) AND (currentItem <> selectedItem) then
  begin
  ListBox1.Items.Exchange(selectedItem, currentItem);
  ListBox2.Items.Exchange(selectedItem, currentItem);
  selectedItem := currentItem;
  ListBox1.Update();
  ListBox2.Update();
  end;
end;
//------------------------------------------------------------------------------
procedure TForm1.ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  selectedItem := -1;
end;
//------------------------------------------------------------------------------
procedure TForm1.Loop;
begin

 //   if  BASS_ChannelIsActive(chan) = BASS_ACTIVE_STOPPED   then
 //  begin
 //     Ch_EndPlay;
 //  end else
  // begin
 if FRemainingSeconds = 0 then // showmessage('ScrollBar.Max');
  begin
  if not FEnablePlayListLoop then
    begin
      BRestart.Click;
    end else
    begin
      Ch_EndPlay;
    end;
  end;
end;
//------------------------------------------------------------------------------
procedure TForm1.LoopsClick(Sender: TObject);
begin
inc(CNTLoop);
if CNTLoop > 3 then CNTLoop := 0;
  case CNTLoop of
   0 : begin
    FEnableLoopTrack := False;
    FEnablePlayListLoop := False;
    FEnablePlayRandom := False;
    Loops.Caption := 'Loop Off';
    Loops.Down := False;
   end;

   1 : begin
    FEnableLoopTrack := True;
    FEnablePlayListLoop := False;
    FEnablePlayRandom := False;
    Loops.Caption := 'Loop On';
    Loops.Down := True;
   end;

   2 : begin
    FEnableLoopTrack := False;
    FEnablePlayListLoop := True;
    FEnablePlayRandom := False;
    Loops.Caption := 'ListLoop On';
    Loops.Down := True;
   end;

   3 : begin
    FEnableLoopTrack := False;
    FEnablePlayListLoop := True;
    FEnablePlayRandom := True;
    Loops.Caption := 'Rand On';
    Loops.Down := True;
   end;
  end;
end;
//------------------------------------------------------------------------------
procedure TForm1.m3u1Click(Sender: TObject);
begin
//
end;

//------------------------------------------------------------------------------
procedure TForm1.MainTimerTimer(Sender: TObject);
var
tag: string;

begin
CountTime;

 if mode = Play then
begin
{$IFDEF DEBUG}

  //CPU.Caption := 'CPU%  ' + FloatToStrF(BASS_GetCPU, ffFixed, 4, 2);
{$ELSE}
 // CPU.Caption := '';

{$ENDIF}
 CPU.Caption := 'CPU%  ' + FloatToStrF(BASS_GetCPU, ffFixed, 4, 2);
   if not FRadio then
 begin
  TimeScrollBar.Position := BASS_ChannelGetPosition(chan, 0);
 end else
 begin
      if not InternetConnected then
    begin
      ShowMessage('This computer is not connected to Internet!');
      FRadio := False;
      Bnext.Click;
    end;
 end;



 LMeta.Caption := '';//qbass_formattime(qbass_gettime(Chan), True);
end;

if FEnableLoopTrack OR FEnablePlayListLoop then Loop;





exit;


end;
//------------------------------------------------------------------------------
procedure TForm1.N1Click(Sender: TObject);
var tmp : integer;
begin
if icnt <> 0 then dec(icnt);
 tmp := ListBox1.ItemIndex;
 ListBox1.Items.Delete(tmp);
 ListBox2.Items.Delete(tmp);
end;
//------------------------------------------------------------------------------
procedure TForm1.N2Click(Sender: TObject);
begin
BStop.Click;
  if chan <> 0 then
  begin
    BASS_ChannelStop(chan);
    BASS_MusicFree(chan);
    BASS_StreamFree(chan);
  end;
  Filename := '';
  ListBox1.Clear;
  ListBox2.Clear;
  icnt := 0;
end;
//------------------------------------------------------------------------------
procedure TForm1.N6Click(Sender: TObject);
begin
  ListBox1DblClick(Self);
end;
//------------------------------------------------------------------------------
procedure TForm1.N8Click(Sender: TObject);
begin
//
end;

//------------------------------------------------------------------------------
 procedure TForm1.Player;
var p1: BASS_CHANNELINFO;
a : Integer;
begin
//проверяем, если не пауза
if mode <> paused then
  begin
  FRadio := False; a := Pos('http', FileName);
  if a = 0 then
  begin
  if not FileExists(FileName) then
  begin
  ShowMessage('The file does not exist');
  exit;
  end;
   end else
  begin
    FRadio := True;
  end;
  //останавливаем и освобождаем канал воспроизведения
  if chan <> 0 then
  begin
    BASS_ChannelStop(chan);
    BASS_MusicFree(chan);
    BASS_StreamFree(chan);
  end;

    //пытаемся загрузить файл и получить дескриптор канала
    chan := BASS_StreamCreateFile(FALSE, PChar(Filename), 0, 0, BASS_SAMPLE_FX {or BASS_SAMPLE_LOOP} {$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
    if (chan = 0) then
      chan := BASS_MusicLoad(FALSE, PChar(Filename), 0, 0, BASS_MUSIC_LOOP or BASS_MUSIC_RAMP or BASS_SAMPLE_FX {$IFDEF UNICODE} or BASS_UNICODE {$ENDIF},1);
    if (chan = 0) then
    begin
      chan := BASS_StreamCreateURL(PChar(Filename), 0,BASS_STREAM_BLOCK or BASS_STREAM_STATUS or BASS_STREAM_AUTOFREE or {$IFDEF UNICODE}BASS_UNICODE{$ELSE}0{$ENDIF}, nil, nil);
      if chan <> 0 then FRadio := True else FRadio := False;

   if not InternetConnected then
    begin
      ShowMessage('This computer is not connected to Internet!');
      FRadio := False;
      chan := 0;
    end;
    end;
    if (chan = 0) then
    begin

      Error('I can not play the file! Please choose another.'); // Не могу воспроизвести файл! Пожалуйста, выберите другой.
      Exit;
    end;
    {if (p1.flags and BASS_SAMPLE_8BITS) > 0 then
    begin
       //not 16-bit stereo
      Error('Only 16-bit stereo sources. Please choose another.');//Только 16-битные источники стерео. Пожалуйста, выберите другой.
      BASS_MusicFree(chan);
      BASS_StreamFree(chan);

      Caption  :=' Player ' + 'Version : ' + FileVersion(Paramstr(0)) + '    ';
     Exit;
    end; }
  end;
   //Настраиваем ScrollBar
 //  if not Flag  then
 //   begin  end;
      TimeScrollBar.Min := 0;
      if not FRadio then  TimeScrollBar.Max := BASS_ChannelGetLength(chan, 0) -1 else
      begin

      end;
      TimeScrollBar.Position := 0;



//Настраиваем счетчик времени
CountTime;

  if not  BASS_ChannelPlay(chan, False)then
	 	begin Error('Playback error!'); exit; end;
    MainTimer.Enabled := True;
    BASS_ChannelSetAttribute(chan, BASS_ATTRIB_VOL, Volume);
    //настройка эквалайзера
    fx[1] := BASS_ChannelSetFX(chan, BASS_FX_DX8_PARAMEQ, 1);//первый канал эквалайзера
    fx[2] := BASS_ChannelSetFX(chan, BASS_FX_DX8_PARAMEQ, 1);//второй канал
    fx[3] := BASS_ChannelSetFX(chan, BASS_FX_DX8_PARAMEQ, 1);
    fx[4] := BASS_ChannelSetFX(chan, BASS_FX_DX8_PARAMEQ, 1);
    fx[5] := BASS_ChannelSetFX(chan, BASS_FX_DX8_PARAMEQ, 1);
    fx[6] := BASS_ChannelSetFX(chan, BASS_FX_DX8_PARAMEQ, 1);
    fx[7] := BASS_ChannelSetFX(chan, BASS_FX_DX8_PARAMEQ, 1);
    fx[8] := BASS_ChannelSetFX(chan, BASS_FX_DX8_PARAMEQ, 1);
    fx[9] := BASS_ChannelSetFX(chan, BASS_FX_DX8_PARAMEQ, 1);
    fx[10] := BASS_ChannelSetFX(chan, BASS_FX_DX8_PARAMEQ, 1);
   // fx[11] := BASS_ChannelSetFX(chan, BASS_FX_DX8_REVERB, 1);

    //настройка первого канала эквалайзера
    p.fGain :=15 - trackbar3.Position; //усиление
    p.fBandwidth := 15; //ширина полосы пропускания
    p.fCenter := 80; //частота регулирования
    BASS_FXSetParameters(fx[1], @p);//применение заданных настроек
    //настройка второго канала эквалайзера
    p.fGain := 15 - trackbar4.Position;
    p.fBandwidth := 15;
    p.fCenter := 170;
    BASS_FXSetParameters(fx[2], @p);
    //и т.д.
    p.fGain := 15 - trackbar5.Position;
    p.fBandwidth := 15;
    p.fCenter := 310;
    BASS_FXSetParameters(fx[3], @p);

    p.fGain := 15 - trackbar6.Position;
    p.fBandwidth := 15;
    p.fCenter := 600;
    BASS_FXSetParameters(fx[4], @p);

    p.fGain := 15 - trackbar7.Position;
    p.fBandwidth := 15;
    p.fCenter := 1000;
    BASS_FXSetParameters(fx[5], @p);

    p.fGain := 15 - trackbar8.Position;
    p.fBandwidth := 15;
    p.fCenter := 3000;
    BASS_FXSetParameters(fx[6], @p);

    p.fGain := 15 - trackbar9.Position;
    p.fBandwidth := 15;
    p.fCenter := 6000;
    BASS_FXSetParameters(fx[7], @p);

    p.fGain := 15 - trackbar10.Position;
    p.fBandwidth := 15;
    p.fCenter := 10000;
    BASS_FXSetParameters(fx[8], @p);

    p.fGain := 15 - trackbar11.Position;
    p.fBandwidth := 15;
    p.fCenter := 12000;
    BASS_FXSetParameters(fx[9], @p);

    p.fGain := 15 - trackbar12.Position;
    p.fBandwidth := 15;
    p.fCenter := 14000;
    BASS_FXSetParameters(fx[10], @p);

  //  BASS_FXGetParameters(fx[11], @pR);
  //  pR.fReverbMix := -96;
  //  pR.fReverbTime := 1200;
  //  pR.fHighFreqRTRatio := 0.1;
  //  BASS_FXSetParameters(fx[11], @pR);

  mode := play;
end;
 function TForm1.InternetConnected: Boolean;
var
  lpdwConnectionTypes: DWORD;
begin
  lpdwConnectionTypes := INTERNET_CONNECTION_MODEM +
                         INTERNET_CONNECTION_LAN +
                         INTERNET_CONNECTION_PROXY;
  { Returns TRUE if there is an active modem or a LAN Internet connection,
    or FALSE if there is no Internet connection, or if all possible Internet
    connections are not currently active.}
  Result := InternetGetConnectedState(@lpdwConnectionTypes, 0);
end;
//------------------------------------------------------------------------------
procedure TForm1.PlayListLoopClick(Sender: TObject);
begin

end;

//------------------------------------------------------------------------------
function TForm1.qbass_formattime(const Sec: Integer; const IsURL: boolean): string;
const
  time = ' 00:00';
  radio = ' Radio';
  null = '      ';
var
  H, M, S: Integer;
  Return: string;
begin
  if Sec = -1 then
    Return := null
  else
    if Sec < 0 then
      Return := time
    else
      if IsURL then
        Return := radio
      else
        begin
          H := Sec div 3600;
          S := Sec mod 3600;
          M := S div 60;
          M := M + (H * 60);
          S := (S mod 60);
         if M > 99 then Return := Format('%2.2d:%2.2d:%2.2d', [H ,M, S])
          else Return := Format('%2.2d:%2.2d:%2.2d', [H, M, S]);
        end;
  Result := Return;
end;
//-----Получает всё время трека в секундах--------------------------------------
function TForm1.qbass_gettime(const Channel: DWORD): DWORD;
var
  pPos: Cardinal;
  AllTime: Cardinal;
begin
  Result := 0;
  pPos := BASS_ChannelGetLength(Channel, BASS_POS_BYTE);
  if (pPos > 0) then
    begin
      Alltime := Trunc(BASS_ChannelBytes2Seconds(Channel, pPos));
      Result := Alltime;
    end;
end;
//------------------------------------------------------------------------------
procedure TForm1.RestartClick(Sender: TObject);
begin
BStop.Click;
MainTimer.Enabled := True;
mode := Restartf;
player;
end;
//------------------------------------------------------------------------------
procedure TForm1.RGExtensionClick(Sender: TObject);
begin
 if RGExtension.ItemIndex = 0 then
 begin
    RGBitrate.Enabled := True;
 end else
 begin
    RGBitrate.Enabled := False;
 end;
end;
//------------------------------------------------------------------------------
 
//------------------------------------------------------------------------------
procedure TForm1.SBRecordClick(Sender: TObject);
var ss : string;
begin
{Кодирование WAV во FLAC со степенью сжатия по умолчанию (5):  flac infile.wav
Кодирование WAV во FLAC с указанной степенью сжатия:
flac -n infile.wav, где n — число от 0 (минимальное сжатие) до 8 (максимальное сжатие).
Декодирование FLAC в WAV: flac -d infile.flac
 Декодирование MP3 в WAV:
 lame --decode infile.mp3 outfile.wav }
 //BASS_RecordStart(8000, 2, BASS_CTYPE_STREAM_WAV, @RecordingCallback, nil);
 //mixer = BassMix.BASS_Mixer_StreamCreate(44100, 2, BASS_SAMPLE_FLOAT );
if SDRecFileName = '' then
begin
ShowMessage('The file save path was not specified !'+ CCR +' specify the path!');
SBPath.Click;
exit;
end else
begin
//if Chan <> 0 then
    if not FRec then
    begin
     if RGExtension.ItemIndex = 0 then  // *.mp3
     begin
      SBRecord.Caption := 'Rec Stp';
      FRec := True;
        case RGBitrate.ItemIndex of
          0 : begin
            ss := 'lame.exe --alt-preset standard  - ';
          end;
          1 : begin
            ss := 'lame.exe --alt-preset extreme  - ';
          end;
          2 : begin
            ss := 'lame.exe --alt-preset insane  - ';
          end;
        end;
      inc(RecordCnt);
      ss := ss + SDRecFileName + IntToStr(RecordCnt) + '.mp3';
      BASS_Encode_Start(Chan, pchar(ss),
      BASS_ENCODE_AUTOFREE {$IFDEF UNICODE} or BASS_UNICODE {$ENDIF}, nil, 0);
     end else
     if RGExtension.ItemIndex = 1 then  // *.wav
     begin




     { if Bass_RecordInit(-1) = False then
      begin
         ShowMessage('I can not initialize the recording!');
         exit;
      end; }
         SBRecord.Caption := 'Rec Stp';
         FRec := True;
         ss := {ss + }SDRecFileName + '.wav'; // ShowMessage(ss);






     end;
    end else
    begin
      SBRecord.Caption := 'Rec Str';
      FRec := False;
      if RGExtension.ItemIndex = 1 then
      begin

      end else
      begin
      BASS_Encode_Stop(Chan);
      end;
    end;
  end;
end;
//------------------------------------------------------------------------------
procedure TForm1.CBEqualizerClick(Sender: TObject);
var i : integer;
begin
 {   }
 if mode = Play then BPause.Click;
  if CBEqualizer.Checked then
  begin
     for i := 3 to 12 do
     begin
     (FindComponent('TrackBar' + Inttostr(i)) as TTrackBar).Enabled := True;
      BASS_FXGetParameters(fx[i], @p);
      p.fgain := 15 - TrackBarArr[i];
      (FindComponent('TrackBar' + Inttostr(i)) as TTrackBar).position := TrackBarArr[i];
      BASS_FXSetParameters(fx[i], @p);
     end;
  end else
  begin
    for i := 3 to 12 do
    begin
      (FindComponent('TrackBar' + Inttostr(i)) as TTrackBar).Enabled := False;
      BASS_FXGetParameters(fx[i], @p);
      TrackBarArr[i] := (FindComponent('TrackBar' + Inttostr(i)) as TTrackBar).position;
      (FindComponent('TrackBar' + Inttostr(i)) as TTrackBar).position := 15;
      p.fgain := 0;
      BASS_FXSetParameters(fx[i], @p);
    end;
  end;
  if mode = Paused then BPlay.Click;

end;
//------------------------------------------------------------------------------
procedure TForm1.CountTime;

var kRemaining, kEllapsed : double;
    HAtAll, MAtAll ,SAtAll : integer;
    HRemaining, MRemaining, SRemaining : integer;
    HEllapsed, MEllapsed, SEllapsed : integer;
begin
  FSecondsAtAll := qbass_gettime(chan);
  kRemaining := (TimeScrollBar.Max - TimeScrollBar.Position) / TimeScrollBar.Max;
  kEllapsed := TimeScrollBar.Position / TimeScrollBar.Max;

  FRemainingSeconds := round(kRemaining * FSecondsAtAll);
  FEllapsedSeconds := round(kEllapsed * FSecondsAtAll);

//Рассчет всего времени

          HAtAll := FSecondsAtAll div 3600;
          SAtAll := FSecondsAtAll mod 3600;
          MAtAll := SAtAll div 60;
          MAtAll := MAtAll + (HAtAll * 60);
          SAtAll := (SAtAll mod 60);

FAllTime := Format('%2.2d:%2.2d:%2.2d', [HAtAll ,MAtAll, SAtAll]);
// Рассчет оставшегося времени

          HEllapsed := FEllapsedSeconds div 3600;
          SEllapsed := FEllapsedSeconds mod 3600;
          MEllapsed := SEllapsed div 60;
          MEllapsed := MEllapsed + (HEllapsed * 60);
          SEllapsed := (SEllapsed mod 60);


FEllapsedTime := Format('%2.2d:%2.2d:%2.2d', [HEllapsed ,MEllapsed, SEllapsed]);
// Рассчет прошедшего времени

          HRemaining := FRemainingSeconds div 3600;
          SRemaining := FRemainingSeconds mod 3600;
          MRemaining := SRemaining div 60;
          MRemaining := MRemaining + (HRemaining * 60);
          SRemaining := (SRemaining mod 60);

FRemainingTime := Format('%2.2d:%2.2d:%2.2d', [HRemaining ,MRemaining, SRemaining]);
//Обновляем лабели

    if not FRadio then
    begin
     lAllTime.Caption := FAllTime;
     lRemainingTime.Caption := FRemainingTime;
     lEllapsedTime.Caption := FEllapsedTime;
    end else
    begin

     //
     lAllTime.Caption := qbass_formattime(AUDIODuration, False);
     lRemainingTime.Caption := qbass_formattime(-2, True);
     lEllapsedTime.Caption :=  qbass_formattime(1, True);
    end;

     ///    BASS_ChannelGetLength(Chan, BASS_POS_BYTE)

end;
//------------------------------------------------------------------------------
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var n : integer;
begin
  //сохраняем настройки в inifile
//форма
  IniFile.WriteInteger('Form info','Left',Left);
  IniFile.WriteInteger('Form info','Top',Top);
  //IniFile.WriteInteger('Form info','Width',Width);
  //IniFile.WriteInteger('Form info','Height',Height);
//громкость звука
  IniFile.WriteInteger('Volue','trackbar1.position',trackbar1.position);
  IniFile.WriteInteger('Balance','trackbar2.position',trackbar2.position);
//эквалайзер
  IniFile.WriteInteger('EQLayzer','trackbar3.position',trackbar3.position);
  IniFile.WriteInteger('EQLayzer','trackbar4.position',trackbar4.position);
  IniFile.WriteInteger('EQLayzer','trackbar5.position',trackbar5.position);
  IniFile.WriteInteger('EQLayzer','trackbar6.position',trackbar6.position);
  IniFile.WriteInteger('EQLayzer','trackbar7.position',trackbar7.position);
  IniFile.WriteInteger('EQLayzer','trackbar8.position',trackbar8.position);
  IniFile.WriteInteger('EQLayzer','trackbar9.position',trackbar9.position);
  IniFile.WriteInteger('EQLayzer','trackbar10.position',trackbar10.position);
  IniFile.WriteInteger('EQLayzer','trackbar11.position',trackbar11.position);
  IniFile.WriteInteger('EQLayzer','trackbar12.position',trackbar12.position);
//количество файлов в PlayList
  IniFile.WriteInteger('ItemsCount','Count',ListBox2.Items.Count);
//очистка секции PlayList
  IniFile.EraseSection('PlayList');
//выгрузка из PlayList
  for n := 0 to ListBox2.Items.Count - 1 do
  IniFile.WriteString('PlayList', 'file' + IntToStr(n + 1), ListBox2.Items.Strings[n]);
//Время создания PlayList
  IniFile.WriteTime('Time','Write time',Time);
//Освобождаем объекты перед закрытием
  IniFile.Free;
end;
//------------------------------------------------------------------------------
procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   BASS_ChannelStop(chan);
   BASS_ChannelSetPosition(chan, 0, 0);
end;
//------------------------------------------------------------------------------
procedure TForm1.FormCreate(Sender: TObject);
 var  n, count : integer;
begin
{$IFDEF DEBUG}
   ReportMemoryLeaksOnShutdown := True;
   ListBox2.Visible  := True;
   OutputDebugString(PChar('DEBUG IS ON!'));
   OutputDebugString(PChar(floattostr(CompilerVersion)));
{$ELSE}
   ListBox2.Visible := False;
   ReportMemoryLeaksOnShutdown := False;
   OutputDebugString(PChar('DEBUG IS OFF'));
{$ENDIF}

if not DirectoryExists(ExtractFilePath(Application.ExeName) + CDataFoider + COutputFoider) then
 begin
  ForceDirectories(ExtractFilePath(Application.ExeName) + CDataFoider + COutputFoider);
 end;

if not DirectoryExists(ExtractFilePath(Application.ExeName) + CDataFoider + CPlayListFoider) then
 begin
  ForceDirectories(ExtractFilePath(Application.ExeName) + CDataFoider + CPlayListFoider);
 end;
if not DirectoryExists(ExtractFilePath(Application.ExeName) + CTmpFoider) then
 begin
  ForceDirectories(ExtractFilePath(Application.ExeName) + CTmpFoider);
 end;
 if not DirectoryExists(ExtractFilePath(Application.ExeName) + CDataFoider + CLanguageFoider) then
 begin
  ForceDirectories(ExtractFilePath(Application.ExeName) + CDataFoider + CLanguageFoider);
 end;
 if not DirectoryExists(ExtractFilePath(Application.ExeName) + CDataFoider + CConfigFoider) then
 begin
  ForceDirectories(ExtractFilePath(Application.ExeName) + CDataFoider + CConfigFoider);
 end;
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + CDataFoider + CLogFoider) then
 begin
  ForceDirectories(ExtractFilePath(Application.ExeName) + CDataFoider + CLogFoider);
 end;



sgenrand_MT19937(Round(Time * 10.0));
win := handle;
  MessageBox(win, PChar('Do not set the input to "WAVE" or "What you hear"(etc...) with' +
  #13#10 + 'the level set high, as that is likely to result in nasty feedback.'),
   PChar('Feedback warning'), $00000030);
CNTLoop := 0;
RecordCnt := 0;
FRadio := False;
FRec := False;
SBRecord.Caption := 'Rec Str';
DragAcceptFiles(Form1{.ListBox1 // убрать комент если не на панели }.Handle, True);
Caption  := ' Player '  + 'Version : ' + FileVersion(Paramstr(0)) + '    ';

ag3 := TAudioGenie3.create;

FEnablePlayListLoop := False;
FEnableLoopTrack := FEnablePlayListLoop;
FEnablePlayRandom := False;
Loops.Caption := 'Loop Off';
Loops.Down := FEnableLoopTrack;
SDRecFileName := '';

 	// check the correct BASS was loaded
	if (HIWORD(BASS_GetVersion) <> BASSVERSION) then
	begin
		MessageBox(0,'An incorrect version of BASS.DLL was loaded',0,MB_ICONERROR);
		Halt;
	end;
  // setup output - default device, 44100hz, stereo, 16 bits
  if not BASS_Init(-1, 44100, 0, handle, nil) then
  begin
    Error('Can''t initialize device, Bass Initialize problem');
    Halt;
  end
  else
  begin
  BASS_Start;

  if BASS_PluginLoad(pchar('.\basswma.dll'), {$IFDEF UNICODE}BASS_UNICODE{$ELSE}0{$ENDIF}) = 0
    then
    begin
    Error('Can''t basswma.dll, Bass Initialize problem');
    Halt;
    end;
  if BASS_PluginLoad(pchar('.\bassflac.dll'), {$IFDEF UNICODE}BASS_UNICODE{$ELSE}0{$ENDIF}) = 0
    then
    begin
    Error('Can''t bassflac.dll, Bass Initialize problem');
    Halt;
    end;
  if BASS_PluginLoad(pchar('.\basswebm.dll'), {$IFDEF UNICODE}BASS_UNICODE{$ELSE}0{$ENDIF}) = 0
    then
    begin
    Error('Can''t basswebm.dll, Bass Initialize problem');
    Halt;
    end;

  BASS_SetConfig(BASS_CONFIG_NET_PLAYLIST, 1); // enable playlist processing
  // Adjust buffer size to balance 'clicks' vs. response time, slower computers need bigger
  BASS_SetConfig(BASS_CONFIG_BUFFER,1000);
  BASS_SetConfig(BASS_CONFIG_NET_PREBUF, 0); // minimize automatic pre-buffering, so we can do it (and display it) instead

  Spectrum := TSpectrum.Create(PaintBox1.Width , PaintBox1.Height);
  Spectrum.Mode := 1;
  Spectrum.Pen := clBlue;
    //Установка громкости
    //
  Volume := 1 - (TrackBar1.Position / TrackBar1.Max);
  lVolume.Caption := RoundTo(Volume * 100 ,-2).ToString+'%';
  //Bass_SetVolume(0.1);

  //создание inifile  с именем Config.ini

  IniFile:=TIniFile.Create(ExtractFilePath(Application.ExeName) + CDataFoider + CConfigFoider + 'Config.ini');
//загрузка настроек из inifile
//положение формы и размер
  Form1.Left:=IniFile.ReadInteger('Form info','Left',285);
  Form1.Top:=IniFile.ReadInteger('Form info','Top',168);
  //Form1.Width:=IniFile.ReadInteger('Form info','Width',520);
  //Form1.Height:=IniFile.ReadInteger('Form info','Height',501);
//громкость звука
  trackbar1.position:=IniFile.ReadInteger('Volue','trackbar1.position',5);
  trackbar2.position:=IniFile.ReadInteger('Balance','trackbar2.position',0);
//настройки эквалайзера
  trackbar3.position:=IniFile.ReadInteger('EQLayzer','trackbar3.position',15);
  trackbar4.position:=IniFile.ReadInteger('EQLayzer','trackbar4.position',15);
  trackbar5.position:=IniFile.ReadInteger('EQLayzer','trackbar5.position',15);
  trackbar6.position:=IniFile.ReadInteger('EQLayzer','trackbar6.position',15);
  trackbar7.position:=IniFile.ReadInteger('EQLayzer','trackbar7.position',15);
  trackbar8.position:=IniFile.ReadInteger('EQLayzer','trackbar8.position',15);
  trackbar9.position:=IniFile.ReadInteger('EQLayzer','trackbar9.position',15);
  trackbar10.position:=IniFile.ReadInteger('EQLayzer','trackbar10.position',15);
  trackbar11.position:=IniFile.ReadInteger('EQLayzer','trackbar11.position',15);
  trackbar12.position:=IniFile.ReadInteger('EQLayzer','trackbar12.position',15);
//количество записей в плейлисте
  Count := IniFile.ReadInteger('ItemsCount','Count',0);
//загрузка плейлиста
  if Count <> 0 then
  begin
for n := 0 to Count - 1 do
   begin
    ListBox2.Items.Add(IniFile.ReadString('PlayList', 'file' + IntToStr(n + 1),'Ошибка чтения'));
    ListBox1.Items.Add(ExtractFileName(ListBox2.Items[n]));
   end;
//установка на первую запись плейлиста
    Filename := ListBox2.Items.Strings[0];
    ListBox1.ItemIndex := 0;
    ListBox2.ItemIndex := ListBox1.ItemIndex
  end;

  end;



end;
//------------------------------------------------------------------------------
procedure TForm1.FormDestroy(Sender: TObject);
begin
  ag3.Free;

  Timer1.Enabled := False;
  MainTimer.Enabled := False;

  Bass_Stop();
  Spectrum.Destruct;
  BASS_StreamFree(chan);
  BASS_MusicFree(chan);
  BASS_Free();
  icnt := 0;
  ListBox1.Clear;
  ListBox1.Free;
end;
//------------------------------------------------------------------------------
procedure TForm1.FormShow(Sender: TObject);
begin
  // Вывод тегов




end;


//------------------------------------------------------------------------------

procedure TForm1.TimeScrollBarScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
 if ScrollCode = scEndScroll then
 begin
    BASS_ChannelSetPosition(chan, TimeScrollBar.Position, 0);
    //FTrack := False;
    CountTime;
  end; //else FTrack := True;

end;
//------------------------------------------------------------------------------
function TForm1.GetChannelBitrate(Channel: DWORD): string;
var
  Bitrate : Single;
  s : string;
begin

    //myUTF8ToString();
     BASS_ChannelGetAttribute(chan,BASS_ATTRIB_BITRATE,Bitrate);
     Result := IntToStr(round(Bitrate)) + ' Kbps.';



end;
 //-----------------------------------------------------------------------------
 procedure MetaSync();
 var meta: String;
 p: integer;
begin
       meta := String(UTF8Decode(BASS_ChannelGetTags(Form1.chan, BASS_TAG_META)));
        if (meta <> '') then
        begin
          p := Pos('StreamTitle=', meta);
            if (p <> 0) then
            begin
              p := p + 13;
              StrM1 := Copy(meta, p, Pos(';', meta) - p - 1);
            end;
        end;
end;

//------------------------------------------------------------------------------
procedure TForm1.Timer1Timer(Sender: TObject);
var
TrackPos: Double;
left, right, l1 , r1 : integer;
level : dword;
s : string;

ChanInfo : BASS_CHANNELINFO;
begin
     randomize_MT19937;
     try

     BASS_ChannelGetData(chan, @FFFData, BASS_DATA_FFT4096);


    if n = -2000 then
    begin
      n := 2000;
     if FRadio then
    begin
        MetaSync;
    end else
    begin
         //ag3.AUDIOAnalyzeFileW(FileName);
        // s := Trim(ag3.AUDIOArtistW);
         //if(s <> '')then StrM1 := StrM1 + ' Artist: ' + s + ' ';
         //s := Trim(ag3.AUDIOAlbumW);
        // if(s <> '')then StrM1 := StrM1 + ' Album: ' + s + ' ';

         //if(s <> '')then
         StrM1 := ' Track : ' + trim(ExtractFileName(FileName));


    end;
        s := copy(StrM1, 1, 130);
      if StrM1 <> s then StrM1 := s + '...' else StrM1 := s;
    end;
    if n = 0 then
    begin
           BASS_ChannelGetInfo(Chan, ChanInfo);
        StrM2 := ' - Channels: ' + FloatToStr(CHANINFO.chans) + //Number of channels... 1=mono, 2=stereo, etc...
            ' - Freq: ' + FloatToStr(CHANINFO.freq) + ' Hz.  ' ; //Default playback rate


         //StrM1 := ' Bitrate: ' + GetChannelBitrate(Chan){inttostr(ag3.AUDIOBitrateW) + ' Kbps. '};
        // s := Trim(ag3.AUDIOArtistW);
        // if(s <> '')then StrM1 := StrM1 + ' Artist: ' + s + ' ';
         //s := Trim(ag3.AUDIOAlbumW);
        // if(s <> '')then StrM1 := StrM1 + ' Album: ' + s + ' ';
        //    s := copy(StrM1, 1, 130);
        // if StrM1 <> s then StrM1 := s + '...' else StrM1 := s;
        // if FRadio then
         // begin
           StrM1 := ' Bitrate: ' +  GetChannelBitrate(Chan) + StrM2;
                       s := copy(StrM1, 1, 130);
         if StrM1 <> s then StrM1 := s + '...' else StrM1 := s;
         // end;
    end; Dec(n, 50); // с шагом



    Spectrum.Draw(PaintBox1.Canvas.Handle, FFFData, 5, -1, StrM1);
      except
        on E: Exception do
        begin

        end;
   end;



   //проверяем, если канал не активный, то выходим

if BASS_ChannelIsActive(chan) <> BASS_Active_Playing then exit;


//получаем уровень сигнала
Level := BASS_ChannelGetLevel(Chan);
// уровень левого канала возвращен в низком слове (низкие 16 битов),
//и уровень правого канала возвращен в высоком слове (высокие 16 битов).
Left := LoWord(Level);
Right := HiWord(Level);
//заливаем PaintBoxы белым цветом
PaintBox2.Canvas.Brush.Color := clBlack;
PaintBox2.Canvas.FillRect(PaintBox2.Canvas.ClipRect);
PaintBox3.Canvas.Brush.Color := clBlack;
PaintBox3.Canvas.FillRect(PaintBox3.Canvas.ClipRect);

//вычисляем какая часть PaintBox будет закрашиваться,
//в зависимости от уровня сигнала
//l1 := round(left / 32768 * PaintBox2.Height);
//r1 := round(right / 32768 * PaintBox3.Height);

//а так можно связать с ползункои громкости
//l1:=round(left / 32768 / TrackBar1.Max * PaintBox2.Height * TrackBar1.Position);
//r1:=round(right / 32768 / TrackBar1.Max * PaintBox3.Height * TrackBar1.Position);


//а так можно связать с ползункои громкости и балансом
if Trackbar2.Position = 0 then
begin
l1 := round(Left / 32768 / trackbar1.Max * PaintBox2.Height * (Volume * 100));
r1 := round(Right / 32768 / trackbar1.Max * PaintBox3.Height * (Volume * 100));
end;

if Trackbar2.Position > 0 then
begin
l1 := round(Right / 32768 / trackbar1.Max / trackbar2.Max * PaintBox3.Height
                  * (Volume * 100) * (trackbar2.Max - trackbar2.Position));
r1 := round(Right / 32768 / trackbar1.Max * PaintBox3.Height * (Volume * 100));
end;
if Trackbar2.Position < 0 then
begin
l1 := round(Left / 32768 / trackbar1.Max * PaintBox2.Height * (Volume * 100));
r1 := round(Right / 32768 / trackbar1.Max / trackbar2.Max * PaintBox3.Height
                  * (Volume * 100) * (trackbar2.Max + trackbar2.Position));
end;

//задаем цвет для рисования уровня сигнала  $990000

if (round((PaintBox2.Height / 3)) > l1)then level := $0EFB33 else
if (round((PaintBox2.Height / 2)) > l1)then level := clYellow else    //
if (round((PaintBox2.Height / 2)) < l1) AND
   (round(PaintBox2.Height - (PaintBox2.Height / 9)) > l1)then level := clOlive else level := clRed;

PaintBox2.Canvas.Brush.Color := level;

if (round((PaintBox3.Height / 3)) > r1)then level := $0EFB33 else
if (round((PaintBox3.Height / 2)) > r1)then level := clYellow else    //
if (round((PaintBox3.Height / 2)) < r1) AND
   (round(PaintBox3.Height - (PaintBox3.Height / 9)) > r1)then level := clOlive else level := clRed;


PaintBox3.Canvas.Brush.Color := level;

//рисуем
PaintBox2.Canvas.Rectangle(0, PaintBox2.Height - l1, PaintBox2.Width, PaintBox2.Height);
PaintBox3.Canvas.Rectangle(0, PaintBox3.Height - r1, PaintBox3.Width, PaintBox3.Height);



//if mode <> play  then exit;
//



// if TimeScrollBar.Position = TimeScrollBar.Max then

     //
//if Ftrack = False then
//begin
   //
  // ShowMessage('воспроизведения!'); exit;


//end;
  BASS_ChannelSetSync(chan, BASS_SYNC_END, 0, @Ch_EndPlay, nil);
end;
//------------------------------------------------------------------------------


procedure TForm1.TrackBar3Change(Sender: TObject);
begin
    BASS_FXGetParameters(fx[1], @p);
    p.fgain := 15 - TrackBar3.position;
    BASS_FXSetParameters(fx[1], @p);
end;
//------------------------------------------------------------------------------

procedure TForm1.TrackBar4Change(Sender: TObject);
begin
    BASS_FXGetParameters(fx[2], @p);
    p.fgain := 15 - TrackBar4.position;
    BASS_FXSetParameters(fx[2], @p);
end;
//------------------------------------------------------------------------------
procedure TForm1.TrackBar5Change(Sender: TObject);
begin
    BASS_FXGetParameters(fx[3], @p);
    p.fgain := 15 - TrackBar5.position;
    BASS_FXSetParameters(fx[3], @p);
end;
 //------------------------------------------------------------------------------
procedure TForm1.TrackBar6Change(Sender: TObject);
begin
    BASS_FXGetParameters(fx[4], @p);
    p.fgain := 15 - TrackBar6.position;
    BASS_FXSetParameters(fx[4], @p);
end;
 //------------------------------------------------------------------------------
procedure TForm1.TrackBar7Change(Sender: TObject);
begin
    BASS_FXGetParameters(fx[5], @p);
    p.fgain := 15 - TrackBar7.position;
    BASS_FXSetParameters(fx[5], @p);
end;
//------------------------------------------------------------------------------
procedure TForm1.TrackBar8Change(Sender: TObject);
begin
    BASS_FXGetParameters(fx[6], @p);
    p.fgain := 15 - TrackBar8.position;
    BASS_FXSetParameters(fx[6], @p);
end;
//------------------------------------------------------------------------------
procedure TForm1.TrackBar9Change(Sender: TObject);
begin
    BASS_FXGetParameters(fx[7], @p);
    p.fgain := 15 - TrackBar9.position;
    BASS_FXSetParameters(fx[7], @p);
end;
 //------------------------------------------------------------------------------
procedure TForm1.TrackBar10Change(Sender: TObject);
begin
       BASS_FXGetParameters(fx[8], @p);
    p.fgain := 15 - TrackBar10.position;
    BASS_FXSetParameters(fx[8], @p);
end;
//------------------------------------------------------------------------------
procedure TForm1.TrackBar11Change(Sender: TObject);
begin
    BASS_FXGetParameters(fx[9], @p);
    p.fgain := 15 - TrackBar11.position;
    BASS_FXSetParameters(fx[9], @p);
end;
//------------------------------------------------------------------------------
procedure TForm1.TrackBar12Change(Sender: TObject);
begin
    BASS_FXGetParameters(fx[10], @p);
    p.fgain := 15 - TrackBar12.position;
    BASS_FXSetParameters(fx[10], @p);
end;
 //------------------------------------------------------------------------------
procedure TForm1.TrackBar1Change(Sender: TObject);

begin
 Volume:= 1 - (TrackBar1.Position / TrackBar1.Max);
 lVolume.Caption:=RoundTo((Volume * 100), -2).ToString + '%';
 BASS_ChannelSetAttribute(chan, BASS_ATTRIB_VOL, Volume);
end;
//------------------------------------------------------------------------------
procedure TForm1.TrackBar2Change(Sender: TObject);
var Balance : single;
begin
  Balance := (Trackbar2.Position / TrackBar2.Max);
  BASS_ChannelSetAttribute(chan, BASS_ATTRIB_PAN, Balance);
  //LBalance.Caption:= 'Balance ' + RoundTo(Balance, -2).ToString
end;
//------------------------------------------------------------------------------
end.
 {
var
 rchan:           HRECORD;
 ServStream : TFileStream;
 pchan:          HStream;
...
//  старт записи в файл
procedure startrec;
 begin

  ServStream:=TFileStream.Create('d:\1.wav',fmCreate);
// здесь запись заголовка wav файла
....
// собственно старт записи
  pchan := BASS_StreamCreate(22050, 1, 0, STREAMPROC_PUSH, nil); //Playing Channel
  rchan := BASS_RecordStart(22050, 1,  MakeLong(0, 10), @RecordingCallback, nil);
 end;

// и callback функция
function RecordingCallback(Handle: HRECORD; buffer: Pointer; length, user: DWord): boolean; stdcall;
 begin
  ServStream.Write(buffer^, length);    // запись потока в файл
  BASS_StreamPutData(pchan, buffer, length);  //  заполнение потока pchan для воспроизведения
  result := True;
 end;           }
