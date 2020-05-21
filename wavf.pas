unit wavf;

interface
uses Bass,bassmix,  ExtCtrls,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.AppEvnts, Vcl.Menus ;
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
implementation
 //------------------------------------------------------------------------------
 function RecordingCallback(Handle: HRECORD; buffer: Pointer; length: DWord;  user: Pointer): boolean; stdcall;
begin
 //fs.Write(buffer^, length);

 Result := True;
end;
function SetWavTitle(): boolean;
 begin
   { fs.Position := 0;
    with WaveHdr do
      begin
      riff := 'RIFF';
      len := 36;
      cWavFmt := 'WAVEfmt ';
      dwHdrLen := 16;
      wFormat := 1;
      wNumChannels := 2;
      dwSampleRate := 44100;
      wBlockAlign := 4;
      dwBytesPerSec := 176400;
      wBitsPerSample := 16;
      cData := 'data';
      dwDataLen := 0;
      end;
    fs.Write(WaveHdr, SizeOf(WAVHDR));  }
 end;
 function EndWavTitle(handle:DWORD): boolean;
 var
 i: int64;
  begin
   { BASS_ChannelStop(handle);
    Form1.fs.Position := 4;
    i := Form1.fs.Size - 8;
    Form1.fs.Write(i, 4);
    i := i - $24;
    Form1.fs.Position := 40;
    Form1.fs.Write(i, 4);
    Form1.fs.Free;  }
  end;

end.
{
� ������, ��� � ��� ������ � �������������� TMemoryStream, ������ ������ ��� ��������� WAV ������.
type
 WAVHDR = packed record
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

 ����� ����� ������������� ��� ����������. ������ ����� ������� ���������� ��������� WAV, � ������ ����� ������������ �������� ������.
 var
 �
 rchan: HRECORD;
 WaveHdr: WAVHDR;

 � �������� ��� ������� ��������� (����������) ������������� ���������� bass.dll ��� ������.

Delphi/Pascal
if Bass_RecordInit(-1) = false then
 ShowMessage('�� ���� ���������������� ������!');

if Bass_RecordInit(-1) = false then
 ShowMessage('�� ���� ���������������� ������!');
����� ������� � ������ ����� �������� ���� ���� TFileStream.

Delphi/Pascal
fs: TfileStream;

fs: TfileStream;
������� ������� ��������� ������ ����� �������, ����� ������������ ������ ����������� ������ � ��� ����.

Delphi/Pascal
function RecordingCallback(Handle: HRECORD; buffer: Pointer; length: DWord;  user: Pointer): boolean; stdcall;
begin
 Main.fs.Write(buffer^, length);
 Result := True;
end;

function RecordingCallback(Handle: HRECORD; buffer: Pointer; length: DWord;  user: Pointer): boolean; stdcall;
begin
 Main.fs.Write(buffer^, length);
 Result := True;
end;
��� ���� ����� ������ ������ ����� ���������������� �������� ����� � ������� �� ������.

Delphi/Pascal
fs := TfileStream.Create('FileName.wav', fmCreate or fmOpenWrite);
1
fs := TfileStream.Create('FileName.wav', fmCreate or fmOpenWrite);
����� ������������ � �������� � ���� ���������

Delphi/Pascal
fs.Position := 0;
with WaveHdr do
begin
   riff := 'RIFF';
   len := 36;
   cWavFmt := 'WAVEfmt ';
   dwHdrLen := 16;
   wFormat := 1;
   wNumChannels := 2;
   dwSampleRate := 44100;
   wBlockAlign := 4;
   dwBytesPerSec := 176400;
   wBitsPerSample := 16;
   cData := 'data';
   dwDataLen := 0;
end;
fs.Write(WaveHdr, SizeOf(WAVHDR));

fs.Position := 0;
with WaveHdr do
begin
   riff := 'RIFF';
   len := 36;
   cWavFmt := 'WAVEfmt ';
   dwHdrLen := 16;
   wFormat := 1;
   wNumChannels := 2;
   dwSampleRate := 44100;
   wBlockAlign := 4;
   dwBytesPerSec := 176400;
   wBitsPerSample := 16;
   cData := 'data';
   dwDataLen := 0;
end;
fs.Write(WaveHdr, SizeOf(WAVHDR));
��� ��� ����������������� ������ ������� ����������, �������� �������� dwDataLen �������� �0�.

����� ����� ����� ��������� ������� ������.

rchan := BASS_RecordStart(44100, 2, 0, @RecordingCallback, nil);

rchan := BASS_RecordStart(44100, 2, 0, @RecordingCallback, nil);
�� ���������� ������ ��������� � ����������������� � ���������� � ������� dwDataLen ��������� (����� ���� �� ����� ����������������) � ����������� �����.

var
 i: int64;
begin
 BASS_ChannelStop(rchan);
 fs.Position := 4;
 i := fs.Size - 8;
 fs.Write(i, 4);
 i := i - $24;
 fs.Position := 40;
 fs.Write(i, 4);
 fs.Free;
end;

var
 i: int64;
begin
 BASS_ChannelStop(rchan);
 fs.Position := 4;
 i := fs.Size - 8;
 fs.Write(i, 4);
 i := i - $24;
 fs.Position := 40;
 fs.Write(i, 4);
 fs.Free;
end;
���� �� ������� ���������, �� ���������� ������ ����� ����� ����� ���� .wav �� ������������ � ���������� �.
 }
