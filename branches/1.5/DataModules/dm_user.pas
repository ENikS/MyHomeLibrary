
{******************************************************************************}
{                                                                              }
{                                 MyHomeLib                                    }
{                                                                              }
{                                Version 0.9                                   }
{                                20.08.2008                                    }
{                    Copyright (c) Aleksey Penkov  alex.penkov@gmail.com       }
{                                                                              }
{******************************************************************************}


unit dm_user;

interface

uses
  SysUtils, Classes, DB, ABSMain, unit_globals, ImgList, Controls, unit_Consts;

type
  TCollectionProp = (cpDisplayName, cpFileName, cpRootFolder);

  TMHLCollection = class;

  TDMUser = class(TDataModule)
    DBUser: TABSDatabase;

    tblBases: TABSTable;
    tblBasesID: TAutoIncField;
    tblBasesName: TWideStringField;
    tblBasesRootFolder: TWideStringField;
    tblBasesDBFileName: TWideStringField;
    tblBasesNotes: TWideStringField;
    tblBasesUser: TWideStringField;
    tblBasesPass: TWideStringField;
    tblBasesDate: TDateField;
    tblBasesVersion: TIntegerField;
    tblBasesCode: TIntegerField;
    tblBasesAllowDelete: TBooleanField;

    dsBases: TDataSource;

    tblRates: TABSTable;
    tblGrouppedBooks: TABSTable;
    dsGroupedBooks: TDataSource;
    SeverityImages: TImageList;
    SeverityImagesBig: TImageList;
    dsGroupList: TDataSource;
    tblFinished: TABSTable;
    tblGroupList: TABSTable;
    tblGroupListID: TAutoIncField;
    tblGroupListName: TWideStringField;
    tblGroupListAllowDelete: TBooleanField;
    tblGroupListNotes: TMemoField;
    tblGroupListIcon: TBlobField;
    tblRatesID: TAutoIncField;
    tblRatesBookID: TIntegerField;
    tblRatesDataBaseID: TIntegerField;
    tblRatesRate: TIntegerField;
    tblRatesDate: TDateField;
    tblGrouppedBooksID: TAutoIncField;
    tblGrouppedBooksGroupID: TIntegerField;
    tblGrouppedBooksOuterID: TIntegerField;
    tblGrouppedBooksSerID: TIntegerField;
    tblGrouppedBooksSeqNumber: TSmallintField;
    tblGrouppedBooksDatabaseID: TIntegerField;
    tblGrouppedBooksLibID: TIntegerField;
    tblGrouppedBooksDate: TDateField;
    tblGrouppedBooksTitle: TWideStringField;
    tblGrouppedBooksFullName: TWideStringField;
    tblGrouppedBooksInsideNo: TIntegerField;
    tblGrouppedBooksFileName: TWideStringField;
    tblGrouppedBooksExt: TWideStringField;
    tblGrouppedBooksSize: TIntegerField;
    tblGrouppedBooksCode: TSmallintField;
    tblGrouppedBooksFolder: TWideStringField;
    tblGrouppedBooksDiscID: TIntegerField;
    tblGrouppedBooksLocal: TBooleanField;
    tblGrouppedBooksDeleted: TBooleanField;
    tblGrouppedBooksGenres: TWideStringField;
    tblGrouppedBooksSeries: TWideStringField;
    tblGrouppedBooksRate: TIntegerField;
    tblGrouppedBooksProgress: TSmallintField;
    tblFinishedID: TAutoIncField;
    tblFinishedBookID: TIntegerField;
    tblFinishedDataBaseID: TIntegerField;
    tblFinishedProgress: TSmallintField;
    tblFinishedDate: TDateField;

  private
    FCollection: TMHLCollection;
  public
    const
      INVALID_COLLECTION_ID = -1;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function ActivateCollection(CollectionID: Integer): Boolean;
    procedure RegisterCollection(
      DisplayName: string;
      RootFolder: string;
      DBFileName: string;
      CollectionType: COLLECTION_TYPE;
      AllowDelete: Boolean;
      Version: Integer = UNVERSIONED_COLLECTION;
      Notes: string = '';
      User: string = '';
      Password: string = ''
    );

    procedure UpdateCollectionProps(
      CollectionID: Integer;
      DisplayName: string;
      RootFolder: string;
      DBFileName: string
    );

    function FindCollectionWithProp(
      PropID: TCollectionProp;
      const Value: string;
      IgnoreID: Integer = INVALID_COLLECTION_ID
    ): Boolean;
  public
    //
    // Active Collection
    //
    property ActiveCollection: TMHLCollection read FCollection;
    procedure SetTableStatus(State: boolean);

    function FindFirstExternalCollection: Boolean;
    function FindNextExternalCollection: Boolean;

    function FindFirstCollection: Boolean;
    function FindNextCollection: Boolean;

    procedure SetRate(ID,Rate: integer);
    procedure SetFinished(ID, Progress: integer);

  end;

  TMHLCollection = class
  private
    FSysDataModule: TDMUser;

    function GetActive: Boolean;

    function GetID: Integer;

    function GetName: string;
    procedure SetName(const Value: string);

    function GetRootFolder: string;
    procedure SetRootFolder(const Value: string);

    function GetDBFileName: string;
    procedure SetDBFileName(const Value: string);

    function GetNotes: string;
    procedure SetNotes(const Value: string);

    function GetUser: string;
    procedure SetUser(const Value: string);

    function GetPassword: string;
    procedure SetPassword(const Value: string);

    function GetCreationDate: TDateTime;
    procedure SetCreationDate(const Value: TDateTime);

    function GetVersion: Integer;
    procedure SetVersion(const Value: Integer);

    function GetCollectionType: COLLECTION_TYPE;
    procedure SetCollectionType(const Value: COLLECTION_TYPE);

    function GetAllowDelete: Boolean;
    procedure SetAllowDelete(const Value: Boolean);

  public
    property Active: Boolean read GetActive;

    property ID: Integer read GetID;
    property Name: string read GetName write SetName;
    property RootFolder: string read GetRootFolder write SetRootFolder;
    property DBFileName: string read GetDBFileName write SetDBFileName;
    property Notes: string read GetNotes write SetNotes;
    property User: string read GetUser write SetUser;
    property Password: string read GetPassword write SetPassword;
    property CreationDate: TDateTime read GetCreationDate write SetCreationDate;
    property Version: Integer read GetVersion write SetVersion;
    property CollectionType: COLLECTION_TYPE read GetCollectionType write SetCollectionType;
    property AllowDelete: Boolean read GetAllowDelete write SetAllowDelete;
  end;

var
  DMUser: TDMUser;

implementation

uses
   Variants;


resourcestring
  rstrNamelessColection = '���������� ���������';

{$R *.dfm}

{ TDMUser }

constructor TDMUser.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCollection := TMHLCollection.Create;
  FCollection.FSysDataModule := Self;
end;

destructor TDMUser.Destroy;
begin
  FCollection.Free;
  inherited Destroy;
end;

procedure TDMUser.RegisterCollection(
  DisplayName, RootFolder, DBFileName: string;
  CollectionType: COLLECTION_TYPE;
  AllowDelete: Boolean;
  Version: Integer;
  Notes, User, Password: string
  );
begin
  tblBases.Insert;

  tblBasesID.Value := Random($FFFF);
  tblBasesName.Value := DisplayName;
  tblBasesRootFolder.Value := RootFolder;
  tblBasesDBFileName.Value := DBFileName;
  tblBasesCode.Value := CollectionType;
  tblBasesDate.Value := Now;
  tblBasesVersion.Value := Version;
  tblBasesAllowDelete.Value := AllowDelete;
  tblBasesNotes.Value := Notes;
  tblBasesUser.Value := User;
  tblBasesPass.Value := Password;

  tblBases.Post;
end;

function TDMUser.ActivateCollection(CollectionID: Integer): Boolean;
begin
  Result := tblBases.Locate('ID', CollectionID, []);
end;

procedure TDMUser.UpdateCollectionProps(CollectionID: Integer; DisplayName: string; RootFolder: string; DBFileName: string);
begin
  if ActivateCollection(CollectionID) then
  begin
    tblBases.Edit;

    tblBasesName.Value := DisplayName;
    tblBasesRootFolder.Value := RootFolder;
    tblBasesDBFileName.Value := DBFileName;

    tblBases.Post;
  end;
end;

function TDMUser.FindCollectionWithProp(PropID: TCollectionProp; const Value: string; IgnoreID: Integer): Boolean;
const
  Fields: array [TCollectionProp] of string = (
    'Name',
    'DBFileName',
    'RootFolder'
  );
begin
  Result := False;
  if tblBases.IsEmpty then
    Exit;

  tblBases.First;
  while not tblBases.Eof do
  begin
    if tblBases.FieldByName(Fields[PropID]).AsString = Value then
    begin
      if (IgnoreID = INVALID_COLLECTION_ID) or (IgnoreID <> tblBasesID.Value) then
      begin
        Result := True;
        Exit;
      end;
    end;

    tblBases.Next;
  end;
end;

function TDMUser.FindFirstCollection: Boolean;
begin
  Result := False;
  if tblBases.IsEmpty then
    Exit;

  tblBases.First;
end;

function TDMUser.FindFirstExternalCollection: Boolean;
begin
  Result := False;
  if tblBases.IsEmpty then
    Exit;

  tblBases.First;
  while not tblBases.Eof do
  begin
    if isExternalCollection(ActiveCollection.CollectionType) then
    begin
      Result := True;
      Exit;
    end;

    tblBases.Next;
  end;
end;

function TDMUser.FindNextCollection: Boolean;
begin
  tblBases.Next;
  Result := not tblBases.Eof;
end;

function TDMUser.FindNextExternalCollection: Boolean;
begin
  tblBases.Next;

  while not tblBases.Eof do
  begin
    if isExternalCollection(ActiveCollection.CollectionType) then
    begin
      Result := True;
      Exit;
    end;

    tblBases.Next;
  end;

  Result := False;
end;

procedure TDMUser.SetFinished(ID, Progress: integer);
begin
  if not tblRates.Locate('DataBaseID;BookID',
           VarArrayOf([ActiveCollection.ID, ID]), []) then
  begin
    DMUser.tblFinished.Insert;
    DMUser.tblFinishedBookId.Value := ID;
    DMUser.tblFinishedProgress.Value := Progress;
    DMUser.tblFinishedDataBaseID.Value := DMUser.ActiveCollection.ID;
    DMUser.tblFinishedDate.Value := Now;
    DMUser.tblFinished.Post;
  end
  else
  begin
    DMUser.tblFinished.Edit;
    DMUser.tblFinishedProgress.Value := Progress;
    DMUser.tblFinished.Post;
  end;
end;

procedure TDMUser.SetRate(ID, Rate: integer);
begin
  if not tblRates.Locate('DataBaseID;BookID',
           VarArrayOf([ActiveCollection.ID, ID]), []) then
  begin
    DMUser.tblRates.Insert;
    DMUser.tblRatesBookId.Value := ID;
    DMUser.tblRatesRate.Value := Rate;
    DMUser.tblRatesDataBaseID.Value := DMUser.ActiveCollection.ID;
    DMUser.tblRatesDate.Value := Now;
    DMUser.tblRates.Post;
  end
  else
  begin
    DMUser.tblRates.Edit;
    DMUser.tblRatesRate.Value := Rate;
    DMUser.tblRates.Post;
  end;
end;

procedure TDMUser.SetTableStatus(State: boolean);
begin
  tblGroupList.Active := State;
  tblGrouppedBooks.Active := State;
  tblRates.Active := State;
  tblBases.Active := State;
  tblFinished.Active := State;
end;

{ TMHLCollection }

function TMHLCollection.GetActive: Boolean;
begin
  Assert(Assigned(FSysDataModule));
  Result :=
    FSysDataModule.tblBases.Active and
    not FSysDataModule.tblBasesID.IsNull;
end;

function TMHLCollection.GetID: Integer;
begin
  Assert(Assigned(FSysDataModule));
  if FSysDataModule.tblBasesID.IsNull then
    Result := NO_ACTIVECOLLECTION_ID
  else
    Result := FSysDataModule.tblBasesID.Value;
end;

function TMHLCollection.GetName: string;
begin
  Assert(Assigned(FSysDataModule));
  if FSysDataModule.tblBasesName.IsNull then
    Result := rstrNamelessColection
  else
    Result := FSysDataModule.tblBasesName.Value;
end;

procedure TMHLCollection.SetName(const Value: string);
begin
  Assert(Assigned(FSysDataModule));
  FSysDataModule.tblBasesName.Value := Value;
end;

function TMHLCollection.GetRootFolder: string;
begin
  Assert(Assigned(FSysDataModule));
  Result := FSysDataModule.tblBasesRootFolder.Value;
end;

procedure TMHLCollection.SetRootFolder(const Value: string);
begin
  Assert(Assigned(FSysDataModule));
  FSysDataModule.tblBasesRootFolder.Value := ExcludeTrailingPathDelimiter(Value);
end;

function TMHLCollection.GetDBFileName: string;
begin
  Assert(Assigned(FSysDataModule));
  Result := FSysDataModule.tblBasesDBFileName.Value;
end;

procedure TMHLCollection.SetDBFileName(const Value: string);
begin
  Assert(Assigned(FSysDataModule));
  FSysDataModule.tblBasesDBFileName.Value := Value;
end;

function TMHLCollection.GetNotes: string;
begin
  Assert(Assigned(FSysDataModule));
  Result := FSysDataModule.tblBasesNotes.Value;
end;

procedure TMHLCollection.SetNotes(const Value: string);
begin
  Assert(Assigned(FSysDataModule));
  FSysDataModule.tblBasesNotes.Value := Value;
end;

function TMHLCollection.GetUser: string;
begin
  Assert(Assigned(FSysDataModule));
  Result := FSysDataModule.tblBasesUser.Value;
end;

procedure TMHLCollection.SetUser(const Value: string);
begin
  Assert(Assigned(FSysDataModule));
  FSysDataModule.tblBasesUser.Value := Value;
end;

function TMHLCollection.GetPassword: string;
begin
  Assert(Assigned(FSysDataModule));
  Result := FSysDataModule.tblBasesPass.Value;
end;

procedure TMHLCollection.SetPassword(const Value: string);
begin
  Assert(Assigned(FSysDataModule));
  FSysDataModule.tblBasesPass.Value := Value;
end;

function TMHLCollection.GetCreationDate: TDateTime;
begin
  Assert(Assigned(FSysDataModule));
  Result := FSysDataModule.tblBasesDate.Value;
end;

procedure TMHLCollection.SetCreationDate(const Value: TDateTime);
begin
  Assert(Assigned(FSysDataModule));
  FSysDataModule.tblBasesDate.Value := Value;
end;

function TMHLCollection.GetVersion: Integer;
begin
  Assert(Assigned(FSysDataModule));
  if FSysDataModule.tblBasesVersion.IsNull then
    Result := UNVERSIONED_COLLECTION
  else
    Result := FSysDataModule.tblBasesVersion.Value;
end;

procedure TMHLCollection.SetVersion(const Value: Integer);
begin
  Assert(Assigned(FSysDataModule));
  FSysDataModule.tblBases.Edit;
  FSysDataModule.tblBasesVersion.Value := Value;
  FSysDataModule.tblBases.Post;
end;

function TMHLCollection.GetCollectionType: COLLECTION_TYPE;
begin
  Assert(Assigned(FSysDataModule));
  Result := FSysDataModule.tblBasesCode.Value;

  if Result = CT_DEPRICATED_ONLINE_FB then
    Result := CT_LIBRUSEC_ONLINE_FB;
end;

procedure TMHLCollection.SetCollectionType(const Value: COLLECTION_TYPE);
begin
  Assert(Assigned(FSysDataModule));
  FSysDataModule.tblBasesCode.Value := Value;
end;

function TMHLCollection.GetAllowDelete: Boolean;
begin
  Assert(Assigned(FSysDataModule));
  if FSysDataModule.tblBasesAllowDelete.IsNull then
    Result := True
  else
    Result := FSysDataModule.tblBasesAllowDelete.Value;
end;

procedure TMHLCollection.SetAllowDelete(const Value: Boolean);
begin
  Assert(Assigned(FSysDataModule));
  FSysDataModule.tblBasesAllowDelete.Value := Value;
end;




end.
