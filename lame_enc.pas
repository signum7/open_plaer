Unit Lame_Enc; 
 
Interface 
 
Uses Windows; 
 
Type 
  THBE_STREAM = LongWord; 
  PHBE_STREAM = ^THBE_STREAM; 
  BE_ERR = LongWord; 
 
Const 
  BE_CONFIG_MP3 = 0; 
  BE_CONFIG_LAME = 256; 
 
  BE_ERR_SUCCESSFUL: LongWord = 0; 
  BE_ERR_INVALID_FORMAT: LongWord = 1; 
  BE_ERR_INVALID_FORMAT_PARAMETERS: LongWord = 2; 
  BE_ERR_NO_MORE_HANDLES: LongWord = 3; 
  BE_ERR_INVALID_HANDLE: LongWord = 4; 
  BE_ERR_BUFFER_TOO_SMALL: LongWord = 5; 
 
  // other constants 
  BE_MAX_HOMEPAGE = 256; 
 
  // format specific variables 
  BE_MP3_MODE_STEREO = 0; 
  BE_MP3_MODE_JSTEREO = 1; 
  BE_MP3_MODE_DUALCHANNEL = 2; 
  BE_MP3_MODE_MONO = 3; 
 
  MPEG1 = 1; 
  MPEG2 = 0; 
 
  CURRENT_STRUCT_VERSION = 1; 
   
  MAJORVERSION = 1; 
  MINORVERSION = 32; 
   
Type 
  TVBRMETHOD = ( 
    VBR_METHOD_NONE = -1, 
    VBR_METHOD_DEFAULT = 0, 
    VBR_METHOD_OLD = 1, 
    VBR_METHOD_NEW = 2, 
    VBR_METHOD_MTRH = 3, 
    VBR_METHOD_ABR = 4 
    ); 
 
  TLAME_QUALITY_PRESET = ( 
 
    LQP_NOPRESET = -1, 
 
    // QUALITY PRESETS 
    LQP_NORMAL_QUALITY = 0, 
    LQP_LOW_QUALITY = 1, 
    LQP_HIGH_QUALITY = 2, 
    LQP_VOICE_QUALITY = 3, 
    LQP_R3MIX = 4, 
    LQP_VERYHIGH_QUALITY = 5, 
    LQP_STANDARD = 6, 
    LQP_FAST_STANDARD = 7, 
    LQP_EXTREME = 8, 
    LQP_FAST_EXTREME = 9, 
    LQP_INSANE = 10, 
    LQP_ABR = 11, 
    LQP_CBR = 12, 
    LQP_MEDIUM = 13, 
    LQP_FAST_MEDIUM = 14, 
 
    // NEW PRESET VALUES 
    LQP_PHONE = 1000, 
    LQP_SW = 2000, 
    LQP_AM = 3000, 
    LQP_FM = 4000, 
    LQP_VOICE = 5000, 
    LQP_RADIO = 6000, 
    LQP_TAPE = 7000, 
    LQP_HIFI = 8000, 
    LQP_CD = 9000, 
    LQP_STUDIO = 10000 
    ); 
 
  TMP3 = Packed Record 
    dwSampleRate: LongWord; 
    byMode: Byte; 
    wBitRate: Word; 
    bPrivate: LONGBOOL; 
    bCRC: LongWord;                     //LONGBOOL; 
    bCopyright: LONGBOOL; 
    bOriginal: LONGBOOL; 
  End; 
 
  TLHV1 = Packed Record 
    // STRUCTURE INFORMATION 
    dwStructVersion: DWORD; 
    dwStructSize: DWORD; 
 
    // BASIC ENCODER SETTINGS 
    dwSampleRate: DWORD;                // ALLOWED SAMPLERATE VALUES DEPENDS ON dwMPEGVersion 
    dwReSampleRate: DWORD;              // DOWNSAMPLERATE, 0=ENCODER DECIDES 
    nMode: Integer;                     // BE_MP3_MODE_STEREO, BE_MP3_MODE_DUALCHANNEL, BE_MP3_MODE_MONO 
    dwBitrate: DWORD;                   // CBR bitrate, VBR min bitrate 
    dwMaxBitrate: DWORD;                // CBR ignored, VBR Max bitrate 
    nPreset: TLAME_QUALITY_PRESET;      // Quality preset, use one of the settings of the LAME_QUALITY_PRESET enum 
    dwMpegVersion: DWORD;               // MPEG-1 OR MPEG-2 
    dwPsyModel: DWORD;                  // FUTURE USE, SET TO 0 
    dwEmphasis: DWORD;                  // FUTURE USE, SET TO 0 
 
    // BIT STREAM SETTINGS 
    bPrivate: LONGBOOL;                 // Set Private Bit (TRUE/FALSE) 
    bCRC: LONGBOOL;                     // Insert CRC (TRUE/FALSE) 
    bCopyright: LONGBOOL;               // Set Copyright Bit (TRUE/FALSE) 
    bOriginal: LONGBOOL;                // Set Original Bit (TRUE/FALSE_ 
 
    // VBR STUFF 
    bWriteVBRHeader: LONGBOOL;          // WRITE XING VBR HEADER (TRUE/FALSE) 
    bEnableVBR: LONGBOOL;               // USE VBR ENCODING (TRUE/FALSE) 
    nVBRQuality: Integer;               // VBR QUALITY 0..9 
    dwVbrAbr_bps: DWORD;                // Use ABR in stead of nVBRQuality 
    nVbrMethod: TVBRMETHOD; 
    bNoRes: LONGBOOL;                   // Disable Bit resorvoir (TRUE/FALSE) 
 
    bStrictIso: LONGBOOL;               // Use strict ISO encoding rules (TRUE/FALSE) 
    nQuality: Integer;                  // Quality setting (NORMAL,HIGH,LOW,VOICE) 
    btReserved: Array[0..255 - 4 * SizeOf(DWORD) - SizeOf(Word) - 1] Of Byte; // FUTURE USE, SET TO 0 
  End; 
 
  TAAC = Packed Record 
    dwSampleRate: LongWord; 
    byMode: Byte; 
    wBitRate: Word; 
    byEncodingMethod: Byte; 
  End; 
 
  TFormat = Packed Record 
    Case Byte Of 
      1: (mp3: TMP3); 
      2: (lhv1: TLHV1); 
      3: (aac: TAAC); 
  End; 
 
  TBE_Config = Packed Record 
    dwConfig: LongWord; 
    Format: TFormat; 
  End; 
  PBE_Config = ^TBE_Config; 
 
  TBE_Version = Record 
    byDLLMajorVersion: Byte; 
    byDLLMinorVersion: Byte; 
 
    byMajorVersion: Byte; 
    byMinorVersion: Byte; 
 
    byDay: Byte; 
    byMonth: Byte; 
    wYear: Word; 
 
    zHomePage: Array[0..BE_MAX_HOMEPAGE + 1] Of Char; 
    byAlphaLevel: Byte; 
    byBetaLevel: Byte; 
    byMMXEnabled: Byte; 
    btReserved: Array[0..125 - 1] Of Byte; 
  End; 
  PBE_Version = ^TBE_Version; 
 
Const 
  Lame_EncLib = 'Lame_enc.dll'; 
 
Function beInitStream(pbeConfig: PBE_Config; dwSample: PLongWord; dwBufferSize: PLongWord; phbeStream: PHBE_STREAM): BE_ERR; cdecl; external Lame_EncLib; 
Function beEncodeChunk(hbeStream: THBE_STREAM; nSamples: LongWord; pSample: PSmallInt; pOutput: PByte; pdwOutput: PLongWord): BE_ERR; cdecl; external Lame_EncLib; 
//Function beEncodeChunk(hbeStream: THBE_STREAM; nSamples: LongWord; Var pSample; Var pOutput; Var pdwOutput: LongWord): BE_ERR; cdecl; external Lame_EncLib; 
Function beEncodeChunkFloatS16NI(hbeStream: THBE_STREAM; nSamples: LongWord; Buffer_l, Buffer_r: PSingle; pOutput: PByte; pdwOutput: PLongWord): BE_ERR; cdecl; external Lame_EncLib; 
Function beDeinitStream(hbeStream: THBE_STREAM; pOutput: PByte; pdwOutput: PLongWord): BE_ERR; cdecl; external Lame_EncLib; 
Function beCloseStream(hbeStream: THBE_STREAM): BE_ERR; cdecl; external Lame_EncLib; 
Procedure beVersion(pbeVersion: PBE_Version); cdecl; external Lame_EncLib; 
Function beWriteVBRHeader(lpszFileName: LPCSTR): BE_ERR; cdecl; external Lame_EncLib; 
Function beFlushNoGap(hbeStream: THBE_STREAM; pOutput: PByte; pdwOutput: PLongWord): BE_ERR; cdecl; external Lame_EncLib; 
Function beWriteInfoTag(hbeStream: THBE_STREAM; lpszFileName: LPCSTR): BE_ERR; cdecl; external Lame_EncLib; 
 
Implementation 
 
End. 