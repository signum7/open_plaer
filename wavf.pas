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
В начале, как и при записи с использованием TMemoryStream, опишем запись для заголовка WAV данных.
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

 После этого задекларируем две переменные. Первая будет хранить информацию заголовка WAV, а вторая поток записываемых звуковых данных.
 var
 …
 rchan: HRECORD;
 WaveHdr: WAVHDR;

 И выполним при запуске программы (желательно) инициализацию библиотеки bass.dll для записи.

Delphi/Pascal
if Bass_RecordInit(-1) = false then
 ShowMessage('Не могу инициализировать запись!');

if Bass_RecordInit(-1) = false then
 ShowMessage('Не могу инициализировать запись!');
Далее объявим в классе формы открытое поле типа TFileStream.

Delphi/Pascal
fs: TfileStream;

fs: TfileStream;
Напишем функцию обратного вызова таким образом, чтобы записываемые данные сохранялись именно в это поле.

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
Для того чтобы начать запись нужно инициализировать файловый поток с правами на запись.

Delphi/Pascal
fs := TfileStream.Create('FileName.wav', fmCreate or fmOpenWrite);
1
fs := TfileStream.Create('FileName.wav', fmCreate or fmOpenWrite);
Затем сформировать и записать в него заголовок

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
Так как продолжительность записи заранее неизвестна, присвоим элементу dwDataLen значение «0».

После этого можно запустить процесс записи.

rchan := BASS_RecordStart(44100, 2, 0, @RecordingCallback, nil);

rchan := BASS_RecordStart(44100, 2, 0, @RecordingCallback, nil);
По завершении записи вычисляем её продолжительность и записываем в элемент dwDataLen заголовка (иначе файл не будет воспроизводиться) и освобождаем поток.

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
Если всё сделано правильно, по указанному адресу можно будет найти файл .wav со звукозаписью и прослушать её.
 }
