unit unit_SystemDatabase;

{.$DEFINE USE_SQLITE}

interface

uses
  unit_Interfaces,
  unit_SystemDatabase_ABS,
  unit_SystemDatabase_SQLite;

  procedure CreateSystemTables(const DBUserFile: string);

  function CreateSystemData(ADefaultSession: Boolean = True): ISystemData;
  function GetSystemData: ISystemData;

implementation

uses
  Windows,
  SysUtils,
  unit_Settings;

var
  g_SystemData: ISystemData;
  g_SystemDataLock: TRTLCriticalSection;

procedure CreateSystemTables(const DBUserFile: string);
begin
{$IFDEF USE_SQLITE}
  CreateSystemTables_SQLite(DBUserFile);
{$ELSE}
  CreateSystemTables_ABS(DBUserFile);
{$ENDIF}
end;

function CreateSystemData(ADefaultSession: Boolean = True): ISystemData;
begin
{$IFDEF USE_SQLITE}
  Result := TSystemData_SQLite.Create(Settings.SystemFileName[sfSystemDB]);
{$ELSE}
  Result := TSystemData_ABS.Create(Settings.SystemFileName[sfSystemDB], ADefaultSession);
{$ENDIF}
end;

function GetSystemData: ISystemData;
begin
  if not Assigned(g_SystemData) then
  begin
    EnterCriticalSection(g_SystemDataLock);
    if not Assigned(g_SystemData) then
      g_SystemData := CreateSystemData;
    LeaveCriticalSection(g_SystemDataLock);
  end;

  Result := g_SystemData;
end;


initialization
  g_SystemData := nil; // do not load to support first-time App start-up without system data
  InitializeCriticalSection(g_SystemDataLock);

finalization
  g_SystemData := nil;
  DeleteCriticalSection(g_SystemDataLock);
end.

