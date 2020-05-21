program plaer;

uses
  Vcl.Forms,
  Winapi.Windows,
  Vcl.Dialogs,
  System.SysUtils,
  main in 'main.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  MT19937 in 'MT19937.pas',
  wavf in 'wavf.pas';

var
  HM: THandle;
  NameApplication : PChar;
  PathApplication : PChar;
{$R *.res}
function Check : boolean; {проверка на запуск второй копии программы}
  begin
    NameApplication := 'NoName';
    PathApplication := PChar(GetModuleName(0));
    NameApplication := PChar(ExtractFileName(GetModuleName(0)));


    //ShowMessage(NameApplication);
    //ShowMessage(PathApplication);
    HM := OpenMutex(MUTEX_ALL_ACCESS, false, NameApplication);
    Result := (HM <> 0);
    if HM = 0 then HM := CreateMutex(nil, false, NameApplication)else
    ShowMessage('Программа: ' + NameApplication + ' уже запущена! ');

  end;
begin
  if Check then begin exit;end;
{$IFDEF DEBUG}

   OutputDebugString(PChar('DEBUG IS ON!'));
   OutputDebugString(PChar(floattostr(CompilerVersion)));
{$ELSE}

   OutputDebugString(PChar('DEBUG IS OFF'));
{$ENDIF}

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Amakrits');
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
