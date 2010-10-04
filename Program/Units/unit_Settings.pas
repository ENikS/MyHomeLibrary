(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2010 Aleksey Penkov
  *
  * Author(s)           Nick Rymanov (nrymanov@gmail.com)
  *                     Aleksey Penkov  alex.penkov@gmail.com
  *                     Matvienko Sergei  matv84@mail.ru
  * Created             12.02.2010
  * Description
  *
  * $Id$
  *
  * History
  * NickR 15.02.2010    ��� ����������������
  *
  ****************************************************************************** *)

{
TODO -oNickR -cBug: ���� �������� ���� �� ��������� � ������ ������������� ���� � �������, �� ��� ��������� �����������. ����� ����������� ����� ��� ���������
}

unit unit_Settings;

interface

uses
  Classes,
  SysUtils,
  Forms,
  Graphics,
  IniFiles,
  unit_Scripts,
  unit_Readers,
  unit_globals,
  unit_Lib_Updates;

type

  TMHLSystemFile = (
    sfSystemDB,
    sfGenresFB2,
    sfGenresNonFB2,
    sfServerErrorLog,
    // sfImportErrorLog,  // UNUSED
    sfAppHelp,
    sfLibRusEcUpdate,
    sfAppVerInfo,
    sfLibRusEcInpx,
    // sfCollectionVerInfo, // UNUSED
    sfColumnsStore,
    sfDownloadsStore,
    sfDownloadErrorLog,
    sfCollectionsStore,
    sfPresets
  );

  TSplitters = array of Integer;
  TTreeModes = array of TTreeMode;

  TMHLSettings = class
  private
    //
    // System paths
    //
    FAppPath: string;
    FDataDir: string;
    FTempDir: string;
    FWorkDir: string;
    FReadDir: string;
    FUpdateDir: string;

    //
    // Settings
    //

    // PATH_SECTION
    FDeviceDir: string;

    // SYSTEM_SECTION
    // TODO : REMOVE FTransliterate: Boolean;
    FActiveCollection: Integer;
    FDoCheckUpdate: Boolean;
    FCheckExternalLibUpdate: Boolean;
    FPromptDevicePath: Boolean;
    FFolderTemplate: string;
    FFileNameTemplate: string;
    FExportMode: TExportMode;
    FRemoveSquareBrackets: Boolean;
    FTXTEncoding: TTXTEncoding;

    // INTERFACE_SECTION
    FTreeFontSize: Integer;
    FShortFontSize: Integer;
    FAppLanguage: TAppLanguage;
    FActivePage: Integer;
    FLastAuthor: string;
    FLastSeries: string;
    FLastBookInAuthors: Integer;
    FLastBookInSeries: Integer;
    FLastBookInFavorites: Integer;
    FSplitters: TSplitters;
    FTreeModes: TTreeModes;
    FWindowState: Integer;
    FFormWidth: Integer;
    FFormHeight: Integer;
    FInfoPanelHeight: Integer;

    FBookSRCollapsed: Boolean;
    FFileSRCollapsed: Boolean;
    FOtherSRCollapsed: Boolean;
    FEditToolBarVisible: Boolean;

    // NETWORK_SECTION
    FProxyServer: string;
    FProxyUsername: string;
    FProxyPassword: string;
    FProxyPort: Integer;
    FUpdateURL: string;
    FInpxURL: string;
    FErrorLog: Boolean;
    FTimeOut: Integer;
    FReadTimeOut: Integer;
    FDwnldInterval: Integer;

    FLibUsername: string;
    FLibPassword: string;

    FUseIESettings: Boolean;
    FIEProxyServer: string;
    FIEProxyPort: Integer;

    // COLORS_SECTION
    FBookColor: TColor;
    FSeriesColor: TColor;
    FAuthorColor: TColor;
    FSeriesBookColor: TColor;
    FBGColor: TColor;
    FFontColor: TColor;

    FDeletedColor: TColor;
    FLocalColor: TColor;

    // SEARCH_SECTION
    FFullTextSearch: Boolean;

    // READERS_SECTION
    FReaders: TReaders;

    // UPDATES_SECTION
    FUpdateList: TUpdateInfoList;

    // SCRIPTS_SECTION
    FScripts: TScripts;
    FDefaultScript: Integer;

    // IMPORT_SECTION
    //
    // UNUSED
    //
    //FCheckExistsFiles: Boolean;

    FInitialDirs: TStringList;

    // BEHAVIOR_SECTION
    FMinimizeToTray: Boolean;
    FAutoStartDwnld: Boolean;
    FShowSubGenreBooks: Boolean;
    FAllowMixed: Boolean;

    FAutoRunUpdate: Boolean;

    FShowToolbar: Boolean;
    FShowRusBar: Boolean;
    FShowEngBar: Boolean;
    FShowStatusBar: Boolean;

    FDoNotShowDeleted: Boolean;
    FShowLocalOnly: Boolean;
    FDeleteDeleted: Boolean;
    FAutoLoadReview: Boolean;
    FShowInfoPanel: Boolean;
    FShowBookCover: Boolean;
    FShowBookAnnotation: Boolean;

    FForceConvertToFBD: Boolean;
    FOverwriteFB2Info: Boolean;

    // SORT_SECTION
    FEnableSort: Boolean;
    FImportDir: string;

    FFB2FolderTemplate: string;
    FFB2FileTemplate: string;

    FFBDFolderTemplate: string;
    FFBDFileTemplate: string;
    FDbsFileName: string;
    FIniFileName: string;

    FFBDBookHeaderTemplate: string;
    FFormTop: Integer;
    FFormLeft: Integer;

  private
    FDeleteFiles: Boolean;
    function GetSettingsFileName: string;

    function GetSystemFileName(fileType: TMHLSystemFile): string;

    function GetDataPath: string;
    function GetTempPath: string;
    function GetWorkPath: string;

    function GetDevicePath: string;
    procedure SetDeviceDir(const Value: string);

    function GetReadPath: string;
    procedure SetReadDir(const Value: string);

    procedure LoadReaders(iniFile: TIniFile);
    procedure SaveReaders(iniFile: TIniFile);

    procedure LoadUpdates;

    procedure LoadScripts(iniFile: TIniFile);
    procedure SaveScripts(iniFile: TIniFile);

    procedure SaveSplitters(iniFile: TIniFile);
    procedure LoadSplitters(iniFile: TIniFile);

    procedure LoadInitialDirs(iniFile: TIniFile);
    procedure SaveInitialDirs(iniFile: TIniFile);

    function GetInitialDir(const key: string): string;
    procedure SetInitialDir(const key, Value: string);

    procedure SetUpdateDir(const Value: string);
    function GetUpdatePath: string;

    procedure SetImportDir(const Value: string);
    function GetImportPath: string;

  private
    class var
      mg_objSettings: TMHLSettings;

  public
    class constructor Create;
    class destructor Destroy;

  public
    constructor Create;
    destructor Destroy; override;

    procedure LoadSettings;
    procedure SaveSettings;

    class function ExpandCollectionRoot(const rootFolder: string): string;
    class function ExpandCollectionFileName(const FileName: string): string;

  public
    property AppPath: string read FAppPath;

    property DataDir: string read FDataDir;
    property DataPath: string read GetDataPath;

    property TempDir: string read FTempDir write FTempDir;
    property TempPath: string read GetTempPath;

    property WorkDir: string read FWorkDir;
    property WorkPath: string read GetWorkPath;

    property UpdateDir: string read FUpdateDir write SetUpdateDir;
    property UpdatePath: string read GetUpdatePath;
    //
    // ������ ���� � ��������� ������
    //
    property SystemFileName[fileType: TMHLSystemFile]: string read GetSystemFileName;

    //
    // ���������� ��������� ���������
    //
    property DeviceDir: string read FDeviceDir write SetDeviceDir;
    property DevicePath: string read GetDevicePath;

    property ReadDir: string read FReadDir write SetReadDir;
    property ReadPath: string read GetReadPath;

    // TODO : REMOVE property TransliterateFileName: Boolean read FTransliterate write FTransliterate;
    property ActiveCollection: Integer read FActiveCollection write FActiveCollection;
    property CheckUpdate: Boolean read FDoCheckUpdate write FDoCheckUpdate;
    property CheckExternalLibUpdate: Boolean read FCheckExternalLibUpdate write FCheckExternalLibUpdate;
    property PromptDevicePath: Boolean read FPromptDevicePath write FPromptDevicePath;
    property FolderTemplate: string read FFolderTemplate write FFolderTemplate;
    property FileNameTemplate: string read FFileNameTemplate write FFileNameTemplate;

    property BookHeaderTemplate: string read FFBDBookHeaderTemplate write FFBDBookHeaderTemplate;

    property ExportMode: TExportMode read FExportMode write FExportMode;
    property TXTEncoding: TTXTEncoding read FTXTEncoding write FTXTEncoding;

    property ShowToolbar: Boolean read FShowToolbar write FShowToolbar;
    property ShowRusBar: Boolean read FShowRusBar write FShowRusBar;
    property ShowEngBar: Boolean read FShowEngBar write FShowEngBar;
    property EditToolBarVisible: Boolean read FEditToolBarVisible write FEditToolBarVisible;
    property ShowStatusBar: Boolean read FShowStatusBar write FShowStatusBar;

    property TreeFontSize: Integer read FTreeFontSize write FTreeFontSize;
    property ShortFontSize: Integer read FShortFontSize write FShortFontSize;
    property ShowInfoPanel: Boolean read FShowInfoPanel write FShowInfoPanel;
    property ShowBookCover: Boolean read FShowBookCover write FShowBookCover;
    property ShowBookAnnotation: Boolean read FShowBookAnnotation write FShowBookAnnotation;

    property AppLanguage: TAppLanguage read FAppLanguage write FAppLanguage;
    property HideDeletedBooks: Boolean read FDoNotShowDeleted write FDoNotShowDeleted;
    property ShowLocalOnly: Boolean read FShowLocalOnly write FShowLocalOnly;
    property ShowSubGenreBooks: Boolean read FShowSubGenreBooks write FShowSubGenreBooks;

    property AutoRunUpdate: Boolean read FAutoRunUpdate write FAutoRunUpdate;

    property MinimizeToTray: Boolean read FMinimizeToTray write FMinimizeToTray;
    property AutoStartDwnld: Boolean read FAutoStartDwnld write FAutoStartDwnld;

    property RemoveSquarebrackets: Boolean read FRemoveSquareBrackets write FRemoveSquareBrackets;

    property ActivePage: Integer read FActivePage write FActivePage;
    property LastAuthor: string read FLastAuthor write FLastAuthor;
    property LastSeries: string read FLastSeries write FLastSeries;
    property LastBookInSeries: Integer read FLastBookInSeries write FLastBookInSeries;
    property LastBookInAuthors: Integer read FLastBookInAuthors write FLastBookInAuthors;
    property LastBookInFavorites: Integer read FLastBookInFavorites write FLastBookInFavorites;

    property Splitters: TSplitters read FSplitters write FSplitters;
    property TreeModes: TTreeModes read FTreeModes write FTreeModes;

    property ProxyServer: string read FProxyServer write FProxyServer;
    property ProxyUsername: string read FProxyUsername write FProxyUsername;
    property ProxyPassword: string read FProxyPassword write FProxyPassword;
    property ProxyPort: Integer read FProxyPort write FProxyPort;
    property UpdateURL: string read FUpdateURL write FUpdateURL;
    property InpxURL: string read FInpxURL write FInpxURL;
    property ErrorLog: Boolean read FErrorLog write FErrorLog;
    property TimeOut: Integer read FTimeOut write FTimeOut;
    property ReadTimeOut: Integer read FReadTimeOut write FReadTimeOut;
    property DwnldInterval: Integer read FDwnldInterval write FDwnldInterval;

    property LibUsername: string read FLibUsername write FLibUsername;
    property LibPassword: string read FLibPassword write FLibPassword;

    property UseIESettings: Boolean read FUseIESettings write FUseIESettings;
    property IEProxyServer: string read FIEProxyServer write FIEProxyServer;
    property IEProxyPort: Integer read FIEProxyPort write FIEProxyPort;

    property BookColor: TColor read FBookColor write FBookColor;
    property SeriesColor: TColor read FSeriesColor write FSeriesColor;
    property AuthorColor: TColor read FAuthorColor write FAuthorColor;
    property SeriesBookColor: TColor read FSeriesBookColor write FSeriesBookColor;
    property BGColor: TColor read FBGColor write FBGColor;
    property FontColor: TColor read FFontColor write FFontColor;
    property DeletedColor: TColor read FDeletedColor write FDeletedColor;
    property LocalColor: TColor read FLocalColor write FLocalColor;

    property WindowState: Integer read FWindowState write FWindowState;
    property FormWidth: Integer read FFormWidth write FFormWidth;
    property FormHeight: Integer read FFormHeight write FFormHeight;
    property FormTop: Integer read FFormTop write FFormTop;
    property FormLeft: Integer read FFormLeft write FFormLeft;

    property InfoPanelHeight: Integer read FInfoPanelHeight write FInfoPanelHeight;

    property BookSRCollapsed: Boolean read FBookSRCollapsed write FBookSRCollapsed;
    property FileSRCollapsed: Boolean read FFileSRCollapsed write FFileSRCollapsed;
    property OtherSRCollapsed: Boolean read FOtherSRCollapsed write FOtherSRCollapsed;
    property ForceConvertToFBD: Boolean read FForceConvertToFBD write FForceConvertToFBD;
    property OverwriteFB2Info: Boolean read FOverwriteFB2Info write FOverwriteFB2Info;

    property FullTextSearch: Boolean read FFullTextSearch write FFullTextSearch;

    property Readers: TReaders read FReaders;

    property Updates: TUpdateInfoList read FUpdateList;

    property Scripts: TScripts read FScripts;
    property DefaultScript: Integer read FDefaultScript write FDefaultScript;

    //
    // UNUSED
    //
    // property CheckExistsFiles: Boolean read FCheckExistsFiles write FCheckExistsFiles;

    property InitialDir[const key: string]: string read GetInitialDir write SetInitialDir;

    property AllowMixed: Boolean read FAllowMixed write FAllowMixed;
    property AutoLoadReview: Boolean read FAutoLoadReview write FAutoLoadReview;

    property DeleteDeleted: Boolean read FDeleteDeleted write FDeleteDeleted;
    property DeleteFiles: Boolean read FDeleteFiles write FDeleteFiles;

    // SORT_SECTION
    property EnableSort: Boolean read FEnableSort write FEnableSort;
    property ImportDir: string read FImportDir write SetImportDir;
    property ImportPath: string read GetImportPath;

    property FB2FolderTemplate: string read FFB2FolderTemplate write FFB2FolderTemplate;
    property FB2FileTemplate: string read FFB2FileTemplate write FFB2FileTemplate;

    property FBDFolderTemplate: string read FFBDFolderTemplate write FFBDFolderTemplate;
    property FBDFileTemplate: string read FFBDFileTemplate write FFBDFileTemplate;
  end;

function Settings: TMHLSettings; inline;

implementation

uses
  StrUtils,
  unit_Consts,
  ShlObj,
  ShellAPI,
  Windows,
  IOUtils,
  WinInet,
  unit_Helpers;

function Settings: TMHLSettings;
begin
  Assert(Assigned(TMHLSettings.mg_objSettings));

  Result := TMHLSettings.mg_objSettings;
end;

const
  TOOLS_DIR_NAME = 'Tools';
  TEMP_DIR_NAME = '$tmp';
  APPDATA_DIR_NAME = 'MyHomeLib';

  PATH_SECTION = 'PATH';
  SYSTEM_SECTION = 'SYSTEM';
  INTERFACE_SECTION = 'INTERFACE';
  NETWORK_SECTION = 'NETWORK';
  COLORS_SECTION = 'COLORS';
  CONVERTER_SECTION = 'CONVERTER';
  SEARCH_SECTION = 'SEARCH';
  READERS_SECTION = 'READERS';
  SCRIPTS_SECTION = 'SCRIPTS';
  IMPORT_SECTION = 'IMPORT';
  BEHAVIOR_SECTION = 'BEHAVIOR';
  FILE_SORT_SECTION = 'FILE_SORT';

  UPDATES_SECTION = 'UPDATES';

  READER_KEY_PREFIX = 'Reader';
  SCRIPT_KEY_PREFIX = 'Script';
  UPDATE_KEY_PREFIX = 'Update';

  INITIAL_DIRS_SECTION = 'InitialDirs';

{ TMHLSettings }

constructor TMHLSettings.Create;
const
  STR_USELOCALDATA = 'uselocaldata';
  STR_USELOCALTEMP = 'uselocaltemp';
  STR_USERDBS = 'user';

var
  GlobalAppDataDir: string;

  UseLocalData, UseLocalTemp, UserDatabase: Boolean;
  I: Integer;

  DBFileName: string;

begin
  inherited Create;

  FAppPath := ExtractFilePath(Application.ExeName);
  GlobalAppDataDir := GetSpecialPath(CSIDL_APPDATA) + APPDATA_DIR_NAME;

  // ���������� ������� � ��������� ����� � ����������� �� ����������
  // ��������� ������ ��� �������� ������
  FDbsFileName := SYSTEM_DATABASE_FILENAME;
  FIniFileName := SETTINGS_FILE_NAME;

  UseLocalData := False;
  UseLocalTemp := False;
  UserDatabase := False;

  for I := 1 to ParamCount do
  begin
    if not UseLocalData then
      UseLocalData := (LowerCase(ParamStr(I)) = STR_USELOCALDATA);

    if not UseLocalTemp then
      UseLocalTemp := (LowerCase(ParamStr(I)) = STR_USELOCALTEMP);

    if (LowerCase(ParamStr(I)) = STR_USERDBS) and (ParamStr(I + 1) <> '') then
    begin
      DBFileName := ParamStr(I + 1);
      UserDatabase := True;
    end;
  end;

  UseLocalData := UseLocalData or FileExists(FAppPath + STR_USELOCALDATA) or not DirectoryExists(GlobalAppDataDir);
  UseLocalTemp := UseLocalTemp or FileExists(FAppPath + STR_USELOCALTEMP);

  //
  // ������������� ������� ����� � ����� � �������
  //
  FWorkDir := IfThen(UseLocalData, ExcludeTrailingPathDelimiter(FAppPath), GlobalAppDataDir);
  FDataDir := WorkPath + DATA_DIR_NAME;

  if UserDatabase then // ���������������� ���� �� � ��������
  begin
    FDbsFileName := DBFileName + '.dbs';
    FIniFileName := DBFileName + '.ini';
    if FileExists(WorkPath + SETTINGS_FILE_NAME) and not FileExists(WorkPath + FIniFileName) then
    begin
      // ���� ������ ����� ��� ���, �������� �����������
      unit_globals.CopyFile(WorkPath + SETTINGS_FILE_NAME, WorkPath + FIniFileName);
      // ����� ����� ������������ Windows.CopyFile(PChar(WorkPath + SETTINGS_FILE_NAME), PChar(WorkPath + FIniFileName), False);
    end;
  end;

  //
  // ������������� ��������� �����
  //
  if UseLocalTemp then
    FTempDir := FAppPath + TEMP_DIR_NAME
  else
    FTempDir := TPath.Combine(TPath.GetTempPath, '_myhomelib');

  // -----------------------------------------------------
  FReaders := TReaders.Create;
  FScripts := TScripts.Create;
  FUpdateList := TUpdateInfoList.Create;

  FInitialDirs := TStringList.Create;
end;

destructor TMHLSettings.Destroy;
begin
  FreeAndNil(FInitialDirs);
  FreeAndNil(FUpdateList);
  FreeAndNil(FScripts);
  FreeAndNil(FReaders);

  inherited Destroy;
end;

function TMHLSettings.GetSettingsFileName: string;
begin
  Result := WorkPath + FIniFileName;
end;

function GetIEProxySettings(out ProxyServer: string; out ProxyPort: Integer): Boolean;
var
  proxyInfo: PInternetProxyInfo;
  dwBufLen: Cardinal;
  strProxy: string;
  i: Integer;
  slHelper: TStringList;
begin
  Result := False;

  ProxyServer := '';
  ProxyPort := INTERNET_DEFAULT_HTTP_PORT;

  dwBufLen := 0;
  proxyInfo := nil;

  InternetQueryOption(nil, INTERNET_OPTION_PROXY, proxyInfo, dwBufLen);
  if (dwBufLen = 0) or (GetLastError <> ERROR_INSUFFICIENT_BUFFER) then
  begin
    // InternetQueryOption failed to return buffer size
    Exit;
  end;

  GetMem(proxyInfo, dwBufLen);

  if InternetQueryOption(nil, INTERNET_OPTION_PROXY, proxyInfo, dwBufLen) then
  begin
    if proxyInfo^.dwAccessType = INTERNET_OPEN_TYPE_PROXY then
    begin
      strProxy := proxyInfo^.lpszProxy;
      if strProxy <> '' then
      begin
        if Pos('=', strProxy) <> 0 then
        begin
          //
          // ftp=proxy.domain.com:8082 gopher=proxy.domain.com:8083 http=proxy.domain.com:8080 https=proxy.domain.com:8081"
          // ������ ������ ��� ������ ����������. ������� ������
          //
          slHelper := TStringList.Create;
          try
            slHelper.Delimiter := ';';
            slHelper.DelimitedText := strProxy;
            strProxy := slHelper.Values['http'];
          finally
            slHelper.Free;
          end;
        end;

        //
        // ����� ����� ��������� ������ � ���� "proxy.domain.com[:8082]" ��� ������ ������
        //
        if strProxy <> '' then
        begin
          //
          // ������ ���� �������� ������� �� ������ � ����
          //
          i := Pos(':', strProxy);
          if i = 0 then
          begin
            //
            // ���� �� ������ - ���������� ���� �� ���������
            //
            ProxyServer := strProxy;
            ProxyPort := INTERNET_DEFAULT_HTTP_PORT;
          end
          else
          begin
            ProxyServer := Copy(strProxy, 1, i - 1);
            ProxyPort := StrToIntDef(Copy(strProxy, i + 1, Length(strProxy) - i), INTERNET_DEFAULT_HTTP_PORT);
          end;

          //
          // ������ � ���� ������ ����� ������������ ������-������
          //
          Result := True;
        end;
      end;
    end;
  end;

  FreeMem(proxyInfo);
end;

function SafeGetDirName(const Value: string): string;
begin
  if (Value = '') or (TPath.GetPathRoot(Value) = Value) then
    Result := Value
  else
    Result := ExcludeTrailingPathDelimiter(Value);
end;

function SafeGetPath(const Value: string): string;
begin
  if Value = '' then
    Result := Value
  else
    Result := IncludeTrailingPathDelimiter(Value);
end;

procedure TMHLSettings.LoadSettings;
var
  iniFile: TIniFile;
begin
  iniFile := TIniFile.Create(GetSettingsFileName);
  try
    //
    // PATH_SECTION
    //
    DeviceDir := iniFile.ReadString(PATH_SECTION, 'Device', '');
    ReadDir := iniFile.ReadString(PATH_SECTION, 'Read', '');
    UpdateDir := iniFile.ReadString(PATH_SECTION, 'Update', '');

    //
    // SYSTEM_SECTION
    //
    // TODO : REMOVE FTransliterate := iniFile.ReadBool(SYSTEM_SECTION, 'TransliterateFileName', True);
    FActiveCollection := iniFile.ReadInteger(SYSTEM_SECTION, 'ActiveCollection', 1);
    FDoCheckUpdate := iniFile.ReadBool(SYSTEM_SECTION, 'CheckUpdates', True);
    FCheckExternalLibUpdate := iniFile.ReadBool(SYSTEM_SECTION, 'CheckLibrusecUpdates', True);
    FPromptDevicePath := iniFile.ReadBool(SYSTEM_SECTION, 'PromptDevicePath', True);
    FFolderTemplate := iniFile.ReadString(SYSTEM_SECTION, 'FolderTemplate', '%f\%s');
    FFileNameTemplate := iniFile.ReadString(SYSTEM_SECTION, 'FileNameTemplate', '%n - %t');
    FRemoveSquareBrackets := iniFile.ReadBool(SYSTEM_SECTION, 'RemoveSquareBrackets', True);

    case iniFile.ReadInteger(SYSTEM_SECTION, 'ExpFormat', 0) of
      0: FExportMode := emFB2;
      1: FExportMode := emFB2Zip;
      2: FExportMode := emLrf;
      3: FExportMode := emTxt;
      4: FExportMode := emEpub;
      5: FExportMode := emPDF;
    end;

    case iniFile.ReadInteger(SYSTEM_SECTION, 'TXTEncoding', 0) of
      0: FTXTEncoding := enUTF8;
      1: FTXTEncoding := en1251;
      2: FTXTEncoding := enUnicode;
    end;

    //
    // INTERFACE_SECTION
    //
    FTreeFontSize := iniFile.ReadInteger(INTERFACE_SECTION, 'FontSize', 8);
    FShortFontSize := iniFile.ReadInteger(INTERFACE_SECTION, 'ShortFontSize', 8);
    FActivePage := iniFile.ReadInteger(INTERFACE_SECTION, 'ActivePage', 0);
    FLastAuthor := iniFile.ReadString(INTERFACE_SECTION, 'LastAuthor', '�');
    FLastSeries := iniFile.ReadString(INTERFACE_SECTION, 'LastSeries', '�');

    FLastBookInAuthors := iniFile.ReadInteger(INTERFACE_SECTION, 'LastBookInAuthors', 0);
    FLastBookInSeries := iniFile.ReadInteger(INTERFACE_SECTION, 'LastBookInSeries', 0);
    FLastBookInFavorites := iniFile.ReadInteger(INTERFACE_SECTION, 'LastBookInFavorites', 0);

    FFormHeight := iniFile.ReadInteger(INTERFACE_SECTION, 'FormHeight ', 850);
    FFormWidth := iniFile.ReadInteger(INTERFACE_SECTION, 'FormWidth ', 1000);
    FFormTop := iniFile.ReadInteger(INTERFACE_SECTION, 'FormTop ', 0);
    FFormLeft := iniFile.ReadInteger(INTERFACE_SECTION, 'FormLeft ', 0);

    FInfoPanelHeight := iniFile.ReadInteger(INTERFACE_SECTION, 'InfoPanelHeight ', 250);

    FBookSRCollapsed := iniFile.ReadBool(INTERFACE_SECTION, 'BookSR', False);
    FFileSRCollapsed := iniFile.ReadBool(INTERFACE_SECTION, 'FileSR', False);
    FOtherSRCollapsed := iniFile.ReadBool(INTERFACE_SECTION, 'OtherSR', False);
    FEditToolBarVisible := iniFile.ReadBool(INTERFACE_SECTION, 'ShowEditToolBar', False);

    if iniFile.ReadInteger(INTERFACE_SECTION, 'Lang', 0) = 0 then
      FAppLanguage := alEng
    else
      FAppLanguage := alRus;

    LoadSplitters(iniFile);

    FWindowState := iniFile.ReadInteger(INTERFACE_SECTION, 'WindowState', 2);

    //
    // NETWORK_SECTION
    //
    FProxyServer := iniFile.ReadString(NETWORK_SECTION, 'proxy', '');
    FProxyUsername := iniFile.ReadString(NETWORK_SECTION, 'proxy-user', '');
    FProxyPassword := DecodePassString(iniFile.ReadString(NETWORK_SECTION, 'proxy-pass', ''));
    FProxyPort := iniFile.ReadInteger(NETWORK_SECTION, 'proxy-port', 0);
    FUpdateURL := iniFile.ReadString(NETWORK_SECTION, 'update_server', 'http://home-lib.net/update/');
    FInpxURL := iniFile.ReadString(NETWORK_SECTION, 'inpx-url', 'http://home-lib.net/download/inpx/test/');
    FErrorLog := iniFile.ReadBool(NETWORK_SECTION, 'use_error_log', False);
    FTimeOut := iniFile.ReadInteger(NETWORK_SECTION, 'time-out', 5000);
    FReadTimeOut := iniFile.ReadInteger(NETWORK_SECTION, 'read_time-out', 50000);
    FDwnldInterval := iniFile.ReadInteger(NETWORK_SECTION, 'dwnld_interval', 0);

    FLibUsername := iniFile.ReadString(NETWORK_SECTION, 'lib-user', '');
    FLibPassword := DecodePassString(iniFile.ReadString(NETWORK_SECTION, 'lib-pass', ''));

    FUseIESettings := iniFile.ReadBool(NETWORK_SECTION, 'use_ie_settings', True);
    if FUseIESettings then
      GetIEProxySettings(FIEProxyServer, FIEProxyPort);

    //
    // COLORS_SECTION
    //
    FBookColor := iniFile.ReadInteger(COLORS_SECTION, 'Book', clWhite);
    FSeriesColor := iniFile.ReadInteger(COLORS_SECTION, 'Series', clWhite);
    FAuthorColor := iniFile.ReadInteger(COLORS_SECTION, 'Author', clWhite);
    FSeriesBookColor := iniFile.ReadInteger(COLORS_SECTION, 'SeriesBook', clWhite);
    FBGColor := iniFile.ReadInteger(COLORS_SECTION, 'ASG Tree', clWhite);
    FFontColor := iniFile.ReadInteger(COLORS_SECTION, 'Font', clBlack);

    FLocalColor := iniFile.ReadInteger(COLORS_SECTION, 'Downloaded', clBlack);
    FDeletedColor := iniFile.ReadInteger(COLORS_SECTION, 'Deleted', clGray);

    //
    // SEARCH_SECTION
    //
    FFullTextSearch := iniFile.ReadBool(SEARCH_SECTION, 'FullText', False);

    //
    // READERS_SECTION
    //
    LoadReaders(iniFile);

    //
    // SCRIPTS_SECTION
    //
    LoadScripts(iniFile);
    FDefaultScript := iniFile.ReadInteger(SCRIPTS_SECTION, 'Default', 0);

    //
    // IMPORT_SECTION
    //
    // UNUSED
    //
    //FCheckExistsFiles := iniFile.ReadBool(IMPORT_SECTION, 'CheckFB2Exist', True);

    //
    // BEHAVIOR_SECTION
    //
    FShowToolbar := iniFile.ReadBool(BEHAVIOR_SECTION, 'ShowToolbar', True);
    FShowRusBar := iniFile.ReadBool(BEHAVIOR_SECTION, 'ShowRusABC', True);
    FShowEngBar := iniFile.ReadBool(BEHAVIOR_SECTION, 'ShowEngABC', True);
    FShowStatusBar := iniFile.ReadBool(BEHAVIOR_SECTION, 'ShowStatusBar', True);

    FShowInfoPanel := iniFile.ReadBool(BEHAVIOR_SECTION, 'CoverPanel', True);
    FShowBookCover := iniFile.ReadBool(BEHAVIOR_SECTION, 'ShowCover', True);
    FShowBookAnnotation := iniFile.ReadBool(BEHAVIOR_SECTION, 'ShowAnnotation', True);

    FDoNotShowDeleted := iniFile.ReadBool(BEHAVIOR_SECTION, 'DoNotShowDeleted', True);
    FShowLocalOnly := iniFile.ReadBool(BEHAVIOR_SECTION, 'ShowLocalOnly', False);

    FShowSubGenreBooks := iniFile.ReadBool(BEHAVIOR_SECTION, 'ShowSubGenreBooks', True);
    FMinimizeToTray := iniFile.ReadBool(BEHAVIOR_SECTION, 'MinimizeToTray', False);
    FAutoStartDwnld := iniFile.ReadBool(BEHAVIOR_SECTION, 'AutoStartDwnld', False);
    FAllowMixed := iniFile.ReadBool(BEHAVIOR_SECTION, 'AllowMixed', False);
    FAutoRunUpdate := iniFile.ReadBool(BEHAVIOR_SECTION, 'AutoRunUpdate', False);

    FDeleteDeleted := iniFile.ReadBool(BEHAVIOR_SECTION, 'DeleteDeleted', False);
    FDeleteFiles := iniFile.ReadBool(BEHAVIOR_SECTION, 'DeleteFiles', False);
    FAutoLoadReview := iniFile.ReadBool(BEHAVIOR_SECTION, 'AutoLoadReview', True);
    FForceConvertToFBD := iniFile.ReadBool(BEHAVIOR_SECTION, 'ForceConvertToFBD', True);
    FOverwriteFB2Info := iniFile.ReadBool(BEHAVIOR_SECTION, 'OverwriteFB2Info', False);
    FFBDBookHeaderTemplate := iniFile.ReadString(BEHAVIOR_SECTION, 'BookHeaderTemplate', '%t');

    //
    // FILE_SORT_SECTION
    //

    FEnableSort := iniFile.ReadBool(FILE_SORT_SECTION, 'EnableFileSort', False);
    FImportDir := iniFile.ReadString(FILE_SORT_SECTION, 'InputFolder', '');

    FFB2FolderTemplate := iniFile.ReadString(FILE_SORT_SECTION, 'Fb2FolderTemplate', '');
    FFB2FileTemplate := iniFile.ReadString(FILE_SORT_SECTION, 'Fb2FileTemplate', '');

    FFBDFolderTemplate := iniFile.ReadString(FILE_SORT_SECTION, 'FBDFolderTemplate', '');
    FFBDFileTemplate := iniFile.ReadString(FILE_SORT_SECTION, 'FBDFileTemplate', '');

    //
    // INITIAL_DIRS_SECTION
    //
    LoadInitialDirs(iniFile);

    // LoadUpdates(iniFile);
    LoadUpdates;
  finally
    iniFile.Free;
  end;
end;

procedure TMHLSettings.SaveSettings;
var
  iniFile: TIniFile;
begin
  iniFile := TIniFile.Create(GetSettingsFileName);
  try
    //
    // PATH_SECTION
    //
    iniFile.WriteString(PATH_SECTION, 'Device', FDeviceDir);
    iniFile.WriteString(PATH_SECTION, 'Read', FReadDir);
    iniFile.WriteString(PATH_SECTION, 'Update', FUpdateDir);

    //
    // SYSTEM_SECTION
    //
    // TODO : REMOVE iniFile.WriteBool(SYSTEM_SECTION, 'TransliterateFileName', FTransliterate);
    iniFile.WriteInteger(SYSTEM_SECTION, 'ActiveCollection', FActiveCollection);
    iniFile.WriteBool(SYSTEM_SECTION, 'CheckUpdates', FDoCheckUpdate);
    iniFile.WriteBool(SYSTEM_SECTION, 'CheckLibrusecUpdates', FCheckExternalLibUpdate);
    iniFile.WriteBool(SYSTEM_SECTION, 'PromptDevicePath', FPromptDevicePath);
    iniFile.WriteString(SYSTEM_SECTION, 'FolderTemplate', FFolderTemplate);
    iniFile.WriteString(SYSTEM_SECTION, 'FileNameTemplate', FFileNameTemplate);
    iniFile.WriteInteger(SYSTEM_SECTION, 'ExpFormat', Ord(FExportMode));
    iniFile.WriteBool(SYSTEM_SECTION, 'RemoveSquareBrackets', FRemoveSquareBrackets);
    iniFile.WriteInteger(SYSTEM_SECTION, 'TXTEncoding', Ord(FTXTEncoding));
    //
    // INTERFACE_SECTION
    //
    iniFile.WriteInteger(INTERFACE_SECTION, 'FontSize', FTreeFontSize);
    iniFile.WriteInteger(INTERFACE_SECTION, 'ShortFontSize', FShortFontSize);
    iniFile.WriteInteger(INTERFACE_SECTION, 'Lang', Ord(FAppLanguage));
    iniFile.WriteInteger(INTERFACE_SECTION, 'ActivePage', FActivePage);

    iniFile.WriteString(INTERFACE_SECTION, 'LastAuthor', FLastAuthor);
    iniFile.WriteString(INTERFACE_SECTION, 'LastSeries', FLastSeries);

    iniFile.WriteInteger(INTERFACE_SECTION, 'LastBookInAuthors', FLastBookInAuthors);
    iniFile.WriteInteger(INTERFACE_SECTION, 'LastBookInSeries', FLastBookInSeries);
    iniFile.WriteInteger(INTERFACE_SECTION, 'LastBookInFavorites', FLastBookInFavorites);

    iniFile.WriteInteger(INTERFACE_SECTION, 'WindowState', WindowState);

    iniFile.WriteInteger(INTERFACE_SECTION, 'FormHeight ', FFormHeight);
    iniFile.WriteInteger(INTERFACE_SECTION, 'FormWidth ', FFormWidth);
    iniFile.WriteInteger(INTERFACE_SECTION, 'FormTop ', FFormTop);
    iniFile.WriteInteger(INTERFACE_SECTION, 'FormLeft ', FFormLeft);

    iniFile.WriteInteger(INTERFACE_SECTION, 'InfoPanelHeight ', FInfoPanelHeight);

    iniFile.WriteBool(INTERFACE_SECTION, 'BookSR', FBookSRCollapsed);
    iniFile.WriteBool(INTERFACE_SECTION, 'FileSR', FFileSRCollapsed);
    iniFile.WriteBool(INTERFACE_SECTION, 'OtherSR', FOtherSRCollapsed);
    iniFile.WriteBool(INTERFACE_SECTION, 'ShowEditToolBar', FEditToolBarVisible);

    SaveSplitters(iniFile);

    //
    // NETWORK_SECTION
    //
    iniFile.WriteString(NETWORK_SECTION, 'proxy', FProxyServer);
    iniFile.WriteString(NETWORK_SECTION, 'proxy-user', FProxyUsername);
    iniFile.WriteString(NETWORK_SECTION, 'proxy-pass', EncodePassString(FProxyPassword));
    iniFile.WriteInteger(NETWORK_SECTION, 'proxy-port', FProxyPort);
    iniFile.WriteString(NETWORK_SECTION, 'update_server', FUpdateURL);
    iniFile.WriteString(NETWORK_SECTION, 'inpx-url', FInpxURL);

    iniFile.WriteBool(NETWORK_SECTION, 'use_error_log', FErrorLog);
    iniFile.WriteInteger(NETWORK_SECTION, 'time-out', FTimeOut);
    iniFile.WriteInteger(NETWORK_SECTION, 'read_time-out', FReadTimeOut);
    iniFile.WriteBool(NETWORK_SECTION, 'use_ie_settings', FUseIESettings);
    iniFile.WriteInteger(NETWORK_SECTION, 'dwnld_interval', FDwnldInterval);

    iniFile.WriteString(NETWORK_SECTION, 'lib-user', FLibUsername);
    iniFile.WriteString(NETWORK_SECTION, 'lib-pass', EncodePassString(FLibPassword));

    //
    // COLORS_SECTION
    //
    iniFile.WriteInteger(COLORS_SECTION, 'Book', FBookColor);
    iniFile.WriteInteger(COLORS_SECTION, 'Series', FSeriesColor);
    iniFile.WriteInteger(COLORS_SECTION, 'Author', FAuthorColor);
    iniFile.WriteInteger(COLORS_SECTION, 'SeriesBook', FSeriesBookColor);
    iniFile.WriteInteger(COLORS_SECTION, 'ASG Tree', FBGColor);
    iniFile.WriteInteger(COLORS_SECTION, 'Font', FFontColor);

    iniFile.WriteInteger(COLORS_SECTION, 'Downloaded', FLocalColor);
    iniFile.WriteInteger(COLORS_SECTION, 'Deleted', FDeletedColor);

    //
    // SEARCH_SECTION
    //
    iniFile.WriteBool(SEARCH_SECTION, 'FullText', FFullTextSearch);

    //
    // READERS_SECTION
    //
    SaveReaders(iniFile);

    //
    // SCRIPTS_SECTION
    //
    SaveScripts(iniFile);
    iniFile.WriteInteger(SCRIPTS_SECTION, 'Default', FDefaultScript);

    //
    // IMPORT_SECTION
    //
    // UNUSED
    //
    //iniFile.WriteBool(IMPORT_SECTION, 'CheckFB2Exist', FCheckExistsFiles);

    //
    // BEHAVIOR_SECTION
    //
    iniFile.WriteBool(BEHAVIOR_SECTION, 'ShowToolbar', FShowToolbar);
    iniFile.WriteBool(BEHAVIOR_SECTION, 'ShowRusABC', FShowRusBar);
    iniFile.WriteBool(BEHAVIOR_SECTION, 'ShowEngABC', FShowEngBar);
    iniFile.WriteBool(BEHAVIOR_SECTION, 'ShowStatusBar', FShowStatusBar);

    iniFile.WriteBool(BEHAVIOR_SECTION, 'DoNotShowDeleted', FDoNotShowDeleted);
    iniFile.WriteBool(BEHAVIOR_SECTION, 'ShowLocalOnly', FShowLocalOnly);
    iniFile.WriteBool(BEHAVIOR_SECTION, 'CoverPanel', FShowInfoPanel);
    iniFile.WriteBool(BEHAVIOR_SECTION, 'ShowCover', FShowBookCover);
    iniFile.WriteBool(BEHAVIOR_SECTION, 'ShowAnnotation', FShowBookAnnotation);

    iniFile.WriteBool(BEHAVIOR_SECTION, 'ShowSubGenreBooks', FShowSubGenreBooks);
    iniFile.WriteBool(BEHAVIOR_SECTION, 'MinimizeToTray', FMinimizeToTray);
    iniFile.WriteBool(BEHAVIOR_SECTION, 'AutoStartDwnld', FAutoStartDwnld);
    iniFile.WriteBool(BEHAVIOR_SECTION, 'AllowMixed', FAllowMixed);

    iniFile.WriteBool(BEHAVIOR_SECTION, 'AutoRunUpdate', FAutoRunUpdate);

    iniFile.WriteBool(BEHAVIOR_SECTION, 'DeleteDeleted', FDeleteDeleted);
    iniFile.WriteBool(BEHAVIOR_SECTION, 'DeleteFiles', FDeleteFiles);
    iniFile.WriteBool(BEHAVIOR_SECTION, 'AutoLoadReview', FAutoLoadReview);
    iniFile.WriteBool(BEHAVIOR_SECTION, 'ForceConvertToFBD', FForceConvertToFBD);
    iniFile.WriteBool(BEHAVIOR_SECTION, 'OverwriteFB2Info', FOverwriteFB2Info);
    iniFile.WriteString(BEHAVIOR_SECTION, 'BookHeaderTemplate', FFBDBookHeaderTemplate);

    //
    // FILE_SORT_SECTION
    //
    iniFile.WriteBool(FILE_SORT_SECTION, 'EnableFileSort', FEnableSort);
    iniFile.WriteString(FILE_SORT_SECTION, 'InputFolder', FImportDir);

    iniFile.WriteString(FILE_SORT_SECTION, 'Fb2FolderTemplate', FFB2FolderTemplate);
    iniFile.WriteString(FILE_SORT_SECTION, 'Fb2FileTemplate', FFB2FileTemplate);

    iniFile.WriteString(FILE_SORT_SECTION, 'FBDFolderTemplate', FFBDFolderTemplate);
    iniFile.WriteString(FILE_SORT_SECTION, 'FBDFileTemplate', FFBDFileTemplate);

    //
    // INITIAL_DIRS_SECTION
    //
    SaveInitialDirs(iniFile);
  finally
    iniFile.Free;
  end;
end;

procedure TMHLSettings.LoadSplitters(iniFile: TIniFile);
var
  i: Integer;
  slHelper: TStringList;
begin
  slHelper := TIniStringList.Create;
  try
    //
    // ������� ���������
    //
    slHelper.DelimitedText := iniFile.ReadString(INTERFACE_SECTION, 'Splitters', '250;250;250;250;250');
    SetLength(FSplitters, 5);
    for i := 0 to slHelper.Count - 1 do
      FSplitters[i] := StrToIntDef(slHelper[i], 250);

    //
    // ������ ������
    //
    slHelper.DelimitedText := iniFile.ReadString(INTERFACE_SECTION, 'TreeModes', '0;1;0;1;0;1');
    SetLength(FTreeModes, 6);
    for i := 0 to slHelper.Count - 1 do
      case StrToIntDef(slHelper[i], 0) of
        0: FTreeModes[i] := tmTree;
        1: FTreeModes[i] := tmFlat;
      end;
  finally
    slHelper.Free;
  end;
end;

procedure TMHLSettings.LoadUpdates;
var
  I: Integer;
  sl: TStringList;
  slHelper: TStringList;
  iniFile: TIniFile;
begin
  FUpdateList.Clear;

  FUpdateList.URL := FUpdateURL;
  FUpdateList.Path := UpdatePath;

  iniFile := TIniFile.Create(SystemFileName[sfCollectionsStore]);
  try
    // ������������ ����
    sl := TStringList.Create;
    try
      iniFile.ReadSection(UPDATES_SECTION, sl);
      if sl.Count > 0 then
      begin
        slHelper := TIniStringList.Create;
        try
          for I := 0 to sl.Count - 1 do
          begin
            if Pos(UPDATE_KEY_PREFIX, sl[I]) = 1 then
            begin
              slHelper.DelimitedText := iniFile.ReadString(UPDATES_SECTION, sl[I], '');
              if slHelper.Count > 5 then
                FUpdateList.Add(slHelper[0], slHelper[1], slHelper[2], slHelper[3], StrToBool(slHelper[4]), StrToInt(slHelper[5]));
            end;
          end;
        finally
          slHelper.Free;
        end;
      end // if
      else
      begin
        // ������� ������� �� ���������
        FUpdateList.Add('Lib.rus.ec [FB2]',        '', 'last_librusec.info',       'librusec_update.zip',       True,  CT_EXTERNAL_LOCAL_FB);
        FUpdateList.Add('Lib.rus.ec [FB2]',        '', '',                         'daily_update.zip',          False, CT_EXTERNAL_LOCAL_FB);
        FUpdateList.Add('Lib.rus.ec OnLine [FB2]', '', 'last_librusec.info',       'librusec_update.zip',       True,  CT_EXTERNAL_ONLINE_FB);
        FUpdateList.Add('Lib.rus.ec OnLine [FB2]', '', 'last_extra.info',          'extra_update.zip',          False, CT_EXTERNAL_ONLINE_FB);
        FUpdateList.Add('Lib.rus.ec [USR]',        '', 'last_usr.info',            'usr_update.zip',            True,  CT_EXTERNAL_LOCAL_NONFB);
        FUpdateList.Add('Flibusta OnLine [FB2]',   '', 'last_flibusta.info',       'flubusta_update.zip',       True,  CT_EXTERNAL_ONLINE_FB);
        FUpdateList.Add('Flibusta OnLine [FB2]',   '', 'last_flibusta_extra.info', 'flibusta_extra_update.zip', False, CT_EXTERNAL_ONLINE_FB);
      end;
    finally
      sl.Free;
    end;
  finally
    iniFile.Free;
  end;
end;

procedure TMHLSettings.SaveSplitters(iniFile: TIniFile);
var
  Splitter: Integer;
  Mode: TTreeMode;
  sl: TStringList;
begin
  sl := TIniStringList.Create;
  try
    //
    // ������� ���������
    //
    for Splitter in FSplitters do
      sl.Add(IntToStr(Splitter));
    iniFile.WriteString(INTERFACE_SECTION, 'Splitters', sl.DelimitedText);

    sl.Clear;

    //
    // ����� - ������ �������
    //
    for Mode in FTreeModes do
      sl.Add(IntToStr(Ord(Mode)));
    iniFile.WriteString(INTERFACE_SECTION, 'TreeModes', sl.DelimitedText);
  finally
    sl.Free;
  end;
end;

procedure TMHLSettings.LoadReaders(iniFile: TIniFile);
var
  I: Integer;
  sl: TStringList;
  slHelper: TStringList;
begin
  FReaders.Clear;

  sl := TStringList.Create;
  try
    iniFile.ReadSection(READERS_SECTION, sl);
    if sl.Count > 0 then
    begin
      slHelper := TIniStringList.Create;
      try
        for I := 0 to sl.Count - 1 do
        begin
          if Pos(READER_KEY_PREFIX, sl[I]) = 1 then
          begin
            slHelper.DelimitedText := iniFile.ReadString(READERS_SECTION, sl[I], '');
            if slHelper.Count = 2 then
              FReaders.Add(slHelper[0], slHelper[1]);
          end;
        end;
      finally
        slHelper.Free;
      end;
    end
    else
    begin
      //
      // ������� ��������� ������ �� ���������
      //
      FReaders.Add('fb2', 'AlReader\AlReader2.exe');
      FReaders.Add('doc', 'AlReader\AlReader2.exe');
      FReaders.Add('txt', 'AlReader\AlReader2.exe');
      FReaders.Add('htm', 'AlReader\AlReader2.exe');
      FReaders.Add('html', 'AlReader\AlReader2.exe');

      FReaders.Add('pdf', '');
      FReaders.Add('djvu', '');
      FReaders.Add('mht', '');
      FReaders.Add('chm', '');
    end;
  finally
    sl.Free;
  end;
end;

procedure TMHLSettings.SaveReaders(iniFile: TIniFile);
var
  I: Integer;
  sl: TStringList;
begin
  iniFile.EraseSection(READERS_SECTION);

  if FReaders.Count > 0 then
  begin
    sl := TIniStringList.Create;
    try
      for I := 0 to FReaders.Count - 1 do
      begin
        sl.Clear;
        sl.Add(FReaders[I].Extension);
        sl.Add(FReaders[I].Path);

        iniFile.WriteString(READERS_SECTION, Format('%s%u', [READER_KEY_PREFIX, I]), sl.DelimitedText);
      end;
    finally
      sl.Free;
    end;
  end;
end;

procedure TMHLSettings.LoadScripts(iniFile: TIniFile);
var
  I: Integer;
  sl: TStringList;
  slHelper: TStringList;
  S: string;
begin
  FScripts.Clear;

  sl := TStringList.Create;
  try
    iniFile.ReadSection(SCRIPTS_SECTION, sl);
    if sl.Count > 0 then
    begin
      slHelper := TIniStringList.Create;
      try
        for I := 0 to sl.Count - 1 do
        begin
          if Pos(SCRIPT_KEY_PREFIX, sl[I]) = 1 then
          begin
            S := iniFile.ReadString(SCRIPTS_SECTION, sl[I], '');
            slHelper.DelimitedText := S;
            if slHelper.Count = 3 then
              FScripts.Add(slHelper[0], slHelper[1], slHelper[2]);
          end;
        end;
      finally
        slHelper.Free;
      end;
    end;
  finally
    sl.Free;
  end;
end;

procedure TMHLSettings.SaveScripts(iniFile: TIniFile);
var
  I: Integer;
  sl: TStringList;
begin
  iniFile.EraseSection(SCRIPTS_SECTION);

  if FScripts.Count > 0 then
  begin
    sl := TIniStringList.Create;
    try
      for I := 0 to FScripts.Count - 1 do
      begin
        sl.Clear;
        sl.Add(FScripts[I].Title);
        sl.Add(FScripts[I].Path);
        sl.Add(FScripts[I].Params);

        iniFile.WriteString(SCRIPTS_SECTION, Format('%s%u', [SCRIPT_KEY_PREFIX, I]), sl.DelimitedText);
      end;
    finally
      sl.Free;
    end;
  end;
end;

function TMHLSettings.GetDataPath: string;
begin
  Assert(FDataDir <> '');
  Result := IncludeTrailingPathDelimiter(FDataDir);
end;

function TMHLSettings.GetTempPath: string;
begin
  Assert(FTempDir <> '');
  Result := IncludeTrailingPathDelimiter(FTempDir);
end;

procedure TMHLSettings.SetUpdateDir(const Value: string);
begin
  FUpdateDir := SafeGetDirName(Value);
end;

function TMHLSettings.GetUpdatePath: string;
begin
  //
  // ����������� �� ������� � �������������. ������� ����� �� ��������� � ������ ����������
  //
  if (FUpdateDir = '') or not TDirectory.Exists(FUpdateDir) then
    Result := WorkPath
  else
    Result := IncludeTrailingPathDelimiter(FUpdateDir);
end;

procedure TMHLSettings.SetImportDir(const Value: string);
begin
  FImportDir := SafeGetDirName(Value);
end;

function TMHLSettings.GetImportPath: string;
begin
  Assert(FImportDir <> '');
  Result := SafeGetPath(FImportDir);
end;

function TMHLSettings.GetWorkPath: string;
begin
  Assert(FWorkDir <> '');
  Result := IncludeTrailingPathDelimiter(FWorkDir);
end;

function TMHLSettings.GetDevicePath: string;
begin
  Assert(FDeviceDir <> '');
  Result := IncludeTrailingPathDelimiter(FDeviceDir);
end;

procedure TMHLSettings.SetDeviceDir(const Value: string);
begin
  FDeviceDir := SafeGetDirName(Value);
end;

function TMHLSettings.GetSystemFileName(fileType: TMHLSystemFile): string;
begin
  case fileType of
    sfSystemDB: Result := DataPath + FDbsFileName;
    sfGenresFB2: Result := AppPath + GENRES_FB2_FILENAME;
    sfGenresNonFB2: Result := AppPath + GENRES_NONFB2_FILENAME;
    sfServerErrorLog: Result := WorkPath + SERVER_ERRORLOG_FILENAME;
    // sfImportErrorLog: Result := WorkPath + IMPORT_ERRORLOG_FILENAME;         // UNUSED
    sfAppHelp: Result := AppPath + APP_HELP_FILENAME;
    sfLibRusEcUpdate: Result := UpdatePath + LIBRUSEC_UPDATE_FILENAME;
    sfLibRusEcInpx: Result := WorkPath + LIBRUSEC_INPX_FILENAME;
    sfAppVerInfo: Result := WorkPath + PROGRAM_VERINFO_FILENAME;
    // sfCollectionVerInfo: Result := TempPath + COLLECTION_VERINFO_FILENAME;   // UNUSED
    sfColumnsStore: Result := WorkPath + COLUMNS_STORE_FILENAME;
    sfDownloadsStore: Result := WorkPath + DOWNLOADS_STORE_FILENAME;
    sfDownloadErrorLog: Result := WorkPath + DOWNLOAD_ERRORLOG_FILENAME;
    sfCollectionsStore: Result := WorkPath + COLLECTIONS_FILENAME;
    sfPresets: Result := WorkPath + PRESETS_FILENAME;
  else
    Assert(False);
  end;
end;

procedure TMHLSettings.LoadInitialDirs(iniFile: TIniFile);
var
  I: Integer;
  sl: TStringList;
begin
  FInitialDirs.Clear;

  sl := TStringList.Create;
  try
    iniFile.ReadSection(INITIAL_DIRS_SECTION, sl);
    for I := 0 to sl.Count - 1 do
      FInitialDirs.Values[sl[I]] := iniFile.ReadString(INITIAL_DIRS_SECTION, sl[I], '');
  finally
    sl.Free;
  end;
end;

procedure TMHLSettings.SaveInitialDirs(iniFile: TIniFile);
var
  I: Integer;
begin
  iniFile.EraseSection(INITIAL_DIRS_SECTION);

  for I := 0 to FInitialDirs.Count - 1 do
    iniFile.WriteString(INITIAL_DIRS_SECTION, FInitialDirs.Names[I], FInitialDirs.ValueFromIndex[I]);
end;

function TMHLSettings.GetInitialDir(const key: string): string;
begin
  Result := FInitialDirs.Values[key];
end;

procedure TMHLSettings.SetInitialDir(const key, Value: string);
begin
  FInitialDirs.Values[key] := Value;
end;

function TMHLSettings.GetReadPath: string;
begin
  if (FReadDir = '') or not TDirectory.Exists(FReadDir) then
    Result := TempPath
  else
    Result := SafeGetPath(FReadDir);
end;

procedure TMHLSettings.SetReadDir(const Value: string);
begin
  FReadDir := SafeGetDirName(Value);
end;

class constructor TMHLSettings.Create;
begin
  mg_objSettings := TMHLSettings.Create;
end;

class destructor TMHLSettings.Destroy;
begin
  FreeAndNil(mg_objSettings);
end;

class function TMHLSettings.ExpandCollectionRoot(const rootFolder: string): string;
begin
  Assert(Assigned(mg_objSettings));
  Result := IncludeTrailingPathDelimiter(ExpandFileNameEx(mg_objSettings.DataPath, rootFolder));
end;

class function TMHLSettings.ExpandCollectionFileName(const FileName: string): string;
begin
  Assert(Assigned(mg_objSettings));
  Result := FileName;
  if '' = ExtractFileExt(Result) then
    Result := ChangeFileExt(Result, COLLECTION_EXTENSION);
  Result := ExpandFileNameEx(mg_objSettings.DataPath, Result);
end;

end.
