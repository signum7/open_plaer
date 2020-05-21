unit CommonTypes;
{ CommonTypes by Alessandro Cappellozza
  version 0.8 02/2002
  http://digilander.Libero.it/Kappe/audioobject
}

interface
 uses Windows, Dialogs, Forms, Controls, StdCtrls, Classes, ExtCtrls, SysUtils;

  Type TWaveData = array [ 0..8192] of DWORD;
  Type TFFTData  = array [0..4096] of Single;

implementation

end.
