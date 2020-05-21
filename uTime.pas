unit uTime;

//������������ �� ����� �����
//��������� ����� ������ � ������ ������

interface

uses
  System.SysUtils, System.Classes, bass, Vcl.ExtCtrls;

type
  TDMTime = class(TDataModule)

  private
    { Private declarations }
  public
  // ��������� ���������� ������� �����
  function qbass_gettime(const Channel: DWORD): DWORD; //����� ����� ������
  function qbass_formattime(const Sec: Integer; //��������� �� mm:ss
  const IsURL: boolean): string;


    { Public declarations }
  end;

var
  DMTime: TDMTime;

implementation



//-----�������� �� ����� ����� � ��������--------------------------------------
function TDMTime.qbass_gettime(const Channel: DWORD): DWORD;
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


//---��������� ������� � ������ * RESULT: " 99:99" | "999:99" * | " Radio" *
// ��� ������� �� ������������
function TDMTime.qbass_formattime(const Sec: Integer; const IsURL: boolean): string;

(*******************************************
* RESULT: " 99:99" | "999:99" * | " Radio" *
*******************************************)
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


end.
