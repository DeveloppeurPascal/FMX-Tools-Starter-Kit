/// <summary>
/// ***************************************************************************
///
/// FMX Tools Starter Kit
///
/// Copyright 2024-2025 Patrick Prémartin under AGPL 3.0 license.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
/// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
/// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
/// DEALINGS IN THE SOFTWARE.
///
/// ***************************************************************************
///
/// A starter kit for your FireMonkey projects in Delphi.
///
/// ***************************************************************************
///
/// Author(s) :
/// Patrick PREMARTIN
///
/// Site :
/// https://fmxtoolsstarterkit.developpeur-pascal.fr/
///
/// Project site :
/// https://github.com/DeveloppeurPascal/FMX-Tools-Starter-Kit
///
/// ***************************************************************************
/// File last update : 2025-05-24T10:00:57.688+02:00
/// Signature : 09de6b3a34fb75a323d7e7dec4d9a6ed5b15946a
/// ***************************************************************************
/// </summary>

unit uDocumentsAncestor;

interface

uses
  System.Types,
  System.Messaging,
  System.Classes,
  System.SysUtils,
  System.JSON;

type
  TDocumentAncestor = class;

  /// <summary>
  /// Subscribe to this message if you need to be informed about a document change
  /// </summary>
  TDocumentChangedMessage = class(TMessage)
  private
    FDocument: TDocumentAncestor;
  protected
  public
    property Document: TDocumentAncestor read FDocument;
    constructor Create(const ADocument: TDocumentAncestor);
    class procedure Broadcast(const ADocument: TDocumentAncestor);
  end;

  /// <summary>
  /// Subscribe to this message if you need to be informed when a document is closing
  /// </summary>
  TDocumentClosingMessage = class(TMessage)
  private
    FDocument: TDocumentAncestor;
  protected
  public
    property Document: TDocumentAncestor read FDocument;
    constructor Create(const ADocument: TDocumentAncestor);
    class procedure Broadcast(const ADocument: TDocumentAncestor);
  end;

  /// <summary>
  /// Subscribe to this message if you need to be informed when "current" document has changed
  /// </summary>
  TCurrentDocumentChangedMessage = class(TMessage)
  private
    FCurrentDocument: TDocumentAncestor;
  protected
  public
    property CurrentDocument: TDocumentAncestor read FCurrentDocument;
    constructor Create(const ACurrentDocument: TDocumentAncestor);
    class procedure Broadcast(const ACurrentDocument: TDocumentAncestor);
  end;

  /// <summary>
  /// Manage an abstracted document file.
  /// </summary>
  /// <remarks>
  /// Descend from its descendants for your real documents.
  /// </remarks>
  TDocumentAncestor = class
  private
    FHasChanged: boolean;
    FFilePath: string;
    FPath: string;
    function GetFileName: string;
    function GetPath: string;
    procedure SetPath(const Value: string);
  protected
    procedure SetHasChanged(const Value: boolean); virtual;
  public
    /// <summary>
    /// Path to the folder where this document will be saved.
    /// </summary>
    /// <remarks>
    /// If the document has been loaded or saved, the returned path if the
    /// current document path. If this document has been saved before, the
    /// default path is the system "Documents" path.
    /// </remarks>
    property Path: string read GetPath write SetPath;
    /// <summary>
    /// The FileName for this document (no path, no extension) if opened by
    /// LoadFromFile(WithAName) or it has been saved by SaveToFile(WithAName)
    /// </summary>
    property FileName: string read GetFileName;
    /// <summary>
    /// Returns True if a document parameter has changed since last Clear(),
    /// LoadXXX() or SaveXXX()
    /// </summary>
    property HasChanged: boolean read FHasChanged;
    /// <summary>
    /// Used to create a new instance of this class.
    /// It's better to use TDocument.DefaultDocument if you have only one
    /// document in your project, but create instances for each document if you
    /// want to edit more than one at the same time.
    /// </summary>
    constructor Create; virtual;
    /// <summary>
    /// Used to load the document from a file after clearing the instance.
    /// </summary>
    procedure LoadFromFile(const AFilePath: string); virtual; abstract;
    /// <summary>
    /// Used to save current document to a file
    /// </summary>
    procedure SaveToFile(const AFilePath: string = ''); virtual; abstract;
    /// <summary>
    /// Used to clean current instance and reset all properties and fields to
    /// their default values
    /// </summary>
    procedure Clear; virtual;
    /// <summary>
    /// Returns the unique identifier used in the document jeader to check if
    /// the file is compatible with this project.
    /// </summary>
    /// <remarks>
    /// Override this method in your TDocument class descendant.
    /// </remarks>
    function GetDocumentGUID: string; virtual; abstract;
    /// <summary>
    /// Returns the file extension for the storrage file of this document.
    /// </summary>
    /// <remarks>
    /// Override this method in your TDocument class descendant.
    /// </remarks>
    function GetDocumentExtension: string; virtual; abstract;
    /// <summary>
    /// Return True if this document is crypted.
    /// </summary>
    function IsCrypted: boolean; virtual; abstract;
  end;

  /// <summary>
  /// Manage documents as binary files. If you provide a private key they are
  /// encrypted with a XOR algorithm.
  /// </summary>
  /// <remarks>
  /// In your descendants, don't forget to override the methods
  /// GetDocumentGUID, GetDocumentExtension and GetPrivateXORKey
  /// </remarks>
  TBinaryDocumentAncestor = class(TDocumentAncestor)
  private const
    /// <summary>
    /// Version level of this class. It is used to check compatibility between
    /// the program and the files it saves or tries to load.
    /// </summary>
    CBinaryDocumentVersion = 1;

  protected
  public
    /// <summary>
    /// Load this document from a file.
    /// </summary>
    /// <remarks>
    /// This method manage the physical document file and uncrypt it if needed.
    /// </remarks>
    procedure LoadFromFile(const AFilePath: string); override;
    /// <summary>
    /// Load the document content in this instance.
    /// </summary>
    /// <remarks>
    /// No Clear() is called, it only loads the saved fields, it doesn't initialize
    /// other things from your document.
    /// </remarks>
    procedure LoadFromStream(const AStream: TStream); virtual;
    /// <summary>
    /// Save this document to a file.
    /// </summary>
    /// <remarks>
    /// This method manage the physical document file and crypt it if needed.
    /// </remarks>
    procedure SaveToFile(const AFilePath: string = ''); override;
    /// <summary>
    /// Save this instance to the given stream.
    /// </summary>
    procedure SaveToStream(const AStream: TStream); virtual;
    /// <summary>
    /// Returns the optional key to use to crypt/uncrypt the document file.
    /// </summary>
    /// <remarks>
    /// Override this method in your TDocument class descendant.
    /// </remarks>
    function GetPrivateXORKey: TByteDynArray; virtual;
    /// <summary>
    /// Returns True if this document as a Private XOR Key and should by crypted
    /// </summary>
    function IsCrypted: boolean; override;
  end;

  /// <summary>
  /// Manage documents as JSON files. If you provide a private key they are
  /// encrypted with a ??? algorithm.
  /// </summary>
  /// <remarks>
  /// In your descendants, don't forget to override the methods
  /// GetDocumentGUID, GetDocumentExtension and GetPrivateKey
  /// </remarks>
  TJSONDocumentAncestor = class(TDocumentAncestor)
  private const
    /// <summary>
    /// Version level of this class. It is used to check compatibility between
    /// the program and the files it saves or tries to load.
    /// </summary>
    CJSONDocumentVersion = 1;
  protected
  public
    /// <summary>
    /// Load this document from a file.
    /// </summary>
    /// <remarks>
    /// This method manage the physical document file and uncrypt it if needed.
    /// </remarks>
    procedure LoadFromFile(const AFilePath: string); override;
    /// <summary>
    /// Fill this instance from a JSON object.
    /// </summary>
    procedure LoadFromJSONObject(const JSO: TJSONObject); virtual;
    /// <summary>
    /// Save this document to a file.
    /// </summary>
    /// <remarks>
    /// This method manage the physical document file and crypt it if needed.
    /// </remarks>
    procedure SaveToFile(const AFilePath: string = ''); override;
    /// <summary>
    /// Get the JSON object version of this instance.
    /// </summary>
    function AsJSON: TJSONObject; virtual;
    /// <summary>
    /// Get the JSON source version of this instance.
    /// </summary>
    function ToJSON: string; virtual;
    /// <summary>
    /// Returns the optional key to use to crypt/uncrypt the document file.
    /// </summary>
    /// <remarks>
    /// Override this method in your TDocument class descendant.
    /// </remarks>
    function GetPrivateXORKey: TByteDynArray; virtual;
    /// <summary>
    /// Returns True if this document has a Private XOR Key and should by crypted
    /// </summary>
    function IsCrypted: boolean; override;
    /// <summary>
    /// Returns the encoding format of the JSON document source string
    /// </summary>
    /// <remarks>
    /// Changing the encoding can have side effects during a document load with previous files.
    /// By default the JSON is encoded in UTF8.
    /// </remarks>
    function GetEncoding: TEncoding; virtual;
  end;

implementation

uses
  System.IOUtils,
  uConfig,
  Olf.RTL.Streams,
  Olf.RTL.CryptDecrypt,
  uConsts;

{ TDocumentChangedMessage }

class procedure TDocumentChangedMessage.Broadcast(const ADocument
  : TDocumentAncestor);
var
  LDocument: TDocumentAncestor;
begin
  LDocument := ADocument;
  tthread.Queue(nil,
    procedure
    begin
      TMessageManager.DefaultManager.SendMessage(nil,
        TDocumentChangedMessage.Create(LDocument));
    end);
end;

constructor TDocumentChangedMessage.Create(const ADocument: TDocumentAncestor);
begin
  inherited Create;
  FDocument := ADocument;
end;

{ TBinaryDocumentAncestor }

function TBinaryDocumentAncestor.GetPrivateXORKey: TByteDynArray;
begin
  setlength(result, 0);
end;

function TBinaryDocumentAncestor.IsCrypted: boolean;
begin
  result := length(GetPrivateXORKey) > 0;
end;

procedure TBinaryDocumentAncestor.LoadFromFile(const AFilePath: string);
var
  FS: tfilestream;
  MS: TMemoryStream;
begin
  if (not AFilePath.IsEmpty) and tfile.exists(AFilePath) then
  begin
    Clear;
    FS := tfilestream.Create(AFilePath, fmOpenRead);
    try
      if IsCrypted then
      begin
        MS := TOlfCryptDecrypt.XORDecrypt(FS, GetPrivateXORKey);
        try
          MS.Position := 0;
          LoadFromStream(MS);
        finally
          MS.Free;
        end;
      end
      else
        LoadFromStream(FS);
    finally
      FS.Free;
      FFilePath := AFilePath;
      SetHasChanged(false);
    end;
  end;
end;

procedure TBinaryDocumentAncestor.LoadFromStream(const AStream: TStream);
var
  Guid: string;
  VersionNum: integer;
begin
  // Check is this document file is for current project.
  Guid := LoadStringFromStream(AStream);
  if (Guid <> GetDocumentGUID) then
    raise exception.Create('This file is not recognized !');
  // TODO -oDeveloppeurPascal : à traduire

  // Check if the document file has a block version number.
  if (sizeof(VersionNum) <> AStream.read(VersionNum, sizeof(VersionNum))) then
    raise exception.Create('Wrong File format !');
  // TODO -oDeveloppeurPascal : à traduire

  // Check if the program can open this document.
  if (VersionNum > CBinaryDocumentVersion) then
    raise exception.Create
      ('Can''t open this file. Please update the program before trying again.');
  // TODO -oDeveloppeurPascal : à traduire
end;

procedure TBinaryDocumentAncestor.SaveToFile(const AFilePath: string);
var
  LFilePath: string;
  Folder: string;
  FS: tfilestream;
  MS, MS2: TMemoryStream;
begin
  if AFilePath.IsEmpty then
    LFilePath := FFilePath
  else
    LFilePath := AFilePath;

  if LFilePath.IsEmpty then
    raise exception.Create
      ('Specify a file path where to save current document.');
  // TODO -oDeveloppeurPascal : à traduire

  Folder := tpath.GetDirectoryName(LFilePath);
  if (not Folder.IsEmpty) then
  begin
    if not tdirectory.exists(Folder) then
      tdirectory.CreateDirectory(Folder);
    FS := tfilestream.Create(LFilePath, fmcreate + fmOpenWrite);
    try
      if IsCrypted then
      begin
        MS := TMemoryStream.Create;
        try
          SaveToStream(MS);
          MS.Position := 0;
          MS2 := TOlfCryptDecrypt.XORcrypt(MS, GetPrivateXORKey);
          try
            MS2.Position := 0;
            FS.CopyFrom(MS2);
          finally
            MS2.Free;
          end;
        finally
          MS.Free;
        end;
      end
      else
        SaveToStream(FS);
    finally
      FS.Free;
      FFilePath := LFilePath;
      SetHasChanged(false);
    end;
  end;
end;

procedure TBinaryDocumentAncestor.SaveToStream(const AStream: TStream);
var
  Guid: string;
  VersionNum: integer;
begin
  Guid := GetDocumentGUID;
  SaveStringToStream(Guid, AStream);
  VersionNum := CBinaryDocumentVersion;
  AStream.Write(VersionNum, sizeof(VersionNum));
end;

{ TDocumentClosingMessage }

class procedure TDocumentClosingMessage.Broadcast(const ADocument
  : TDocumentAncestor);
var
  LDocument: TDocumentAncestor;
begin
  LDocument := ADocument;
  tthread.Queue(nil,
    procedure
    begin
      TMessageManager.DefaultManager.SendMessage(nil,
        TDocumentClosingMessage.Create(LDocument));
    end);
end;

constructor TDocumentClosingMessage.Create(const ADocument: TDocumentAncestor);
begin
  inherited Create;
  FDocument := ADocument;
end;

{ TCurrentDocumentChangedMessage }

class procedure TCurrentDocumentChangedMessage.Broadcast(const ACurrentDocument
  : TDocumentAncestor);
var
  LCurrentDocument: TDocumentAncestor;
begin
  LCurrentDocument := ACurrentDocument;
  tthread.Queue(nil,
    procedure
    begin
      TMessageManager.DefaultManager.SendMessage(nil,
        TDocumentClosingMessage.Create(LCurrentDocument));
    end);
end;

constructor TCurrentDocumentChangedMessage.Create(const ACurrentDocument
  : TDocumentAncestor);
begin
  inherited Create;
  FCurrentDocument := ACurrentDocument;
end;

{ TDocumentAncestor }

procedure TDocumentAncestor.Clear;
begin
  FFilePath := '';
  SetHasChanged(false);
end;

constructor TDocumentAncestor.Create;
begin
  inherited;
  FPath := '';
  FFilePath := '';
  FHasChanged := false;
end;

function TDocumentAncestor.GetFileName: string;
begin
  result := tpath.GetFileNameWithoutExtension(FFilePath);
end;

function TDocumentAncestor.GetPath: string;
begin
  if not FFilePath.IsEmpty then
    result := tpath.GetDirectoryName(FFilePath)
  else if (not FPath.IsEmpty) and tdirectory.exists(FPath) then
    result := FPath
  else
    result := tpath.getdocumentspath;
end;

procedure TDocumentAncestor.SetHasChanged(const Value: boolean);
begin
  if (FHasChanged <> Value) then
  begin
    FHasChanged := Value;
    TDocumentChangedMessage.Broadcast(self);
  end;
end;

procedure TDocumentAncestor.SetPath(const Value: string);
begin
  if Value.IsEmpty or tdirectory.exists(Value) then
    FPath := Value;
end;

{ TJSONDocumentAncestor }

function TJSONDocumentAncestor.AsJSON: TJSONObject;
begin
  result := TJSONObject.Create;
  result.addpair('JSONDocumentGUID', GetDocumentGUID);
  result.addpair('JSONDocumentVersion', CJSONDocumentVersion);
end;

function TJSONDocumentAncestor.ToJSON: string;
var
  JSO: TJSONObject;
begin
  JSO := AsJSON;
  try
    result := JSO.ToJSON;
    // TODO -oDeveloppeurPascal : add an option to get a JSON source compatible with a code versioning system
  finally
    JSO.Free;
  end;
end;

function TJSONDocumentAncestor.GetEncoding: TEncoding;
begin
  result := TEncoding.UTF8;
end;

function TJSONDocumentAncestor.GetPrivateXORKey: TByteDynArray;
begin
  setlength(result, 0);
end;

function TJSONDocumentAncestor.IsCrypted: boolean;
begin
  result := length(GetPrivateXORKey) > 0;
end;

procedure TJSONDocumentAncestor.LoadFromFile(const AFilePath: string);
var
  FileStream: tfilestream;
  MemoryStream: TMemoryStream;
  StringStream: TStringStream;
  S: string;
  JSO: TJSONObject;
begin
  if (not AFilePath.IsEmpty) and tfile.exists(AFilePath) then
    try
      Clear;
      if IsCrypted then
      begin
        FileStream := tfilestream.Create(AFilePath, fmOpenRead);
        try
          MemoryStream := TOlfCryptDecrypt.XORDecrypt(FileStream,
            GetPrivateXORKey);
          try
            MemoryStream.Position := 0;
            StringStream := TStringStream.Create;
            try
              StringStream.CopyFrom(MemoryStream);
              S := StringStream.DataString;
            finally
              StringStream.Free;
            end;
          finally
            MemoryStream.Free;
          end;
        finally
          FileStream.Free;
        end;
      end
      else
        S := tfile.ReadAllText(AFilePath, GetEncoding);
      JSO := TJSONObject.ParseJSONValue(S) as TJSONObject;
      try
        LoadFromJSONObject(JSO);
      finally
        JSO.Free;
      end;
    finally
      FFilePath := AFilePath;
      SetHasChanged(false);
    end;
end;

procedure TJSONDocumentAncestor.LoadFromJSONObject(const JSO: TJSONObject);
var
  Guid: string;
  VersionNum: integer;
begin
  // Check is this document file is for current project.
  if not JSO.TryGetValue<string>('JSONDocumentGUID', Guid) then
    Guid := '';

  if (Guid <> GetDocumentGUID) then
    raise exception.Create('This file is not recognized !');
  // TODO -oDeveloppeurPascal : à traduire

  // Check if the document file has a version number.
  if not JSO.TryGetValue<integer>('JSONDocumentVersion', VersionNum) then
    VersionNum := maxint;

  // Check if the program can open this document.
  if (VersionNum > CJSONDocumentVersion) then
    raise exception.Create
      ('Can''t open this file. Please update the program before trying again.');
  // TODO -oDeveloppeurPascal : à traduire
end;

procedure TJSONDocumentAncestor.SaveToFile(const AFilePath: string);
var
  LFilePath: string;
  Folder: string;
  FileStream: tfilestream;
  StringStream: TStringStream;
  MemoryStream: TMemoryStream;
begin
  if AFilePath.IsEmpty then
    LFilePath := FFilePath
  else
    LFilePath := AFilePath;

  if LFilePath.IsEmpty then
    raise exception.Create
      ('Specify a file path where to save current document.');
  // TODO -oDeveloppeurPascal : à traduire

  Folder := tpath.GetDirectoryName(LFilePath);
  if (not Folder.IsEmpty) then
    try
      if not tdirectory.exists(Folder) then
        tdirectory.CreateDirectory(Folder);
      if IsCrypted then
      begin
        FileStream := tfilestream.Create(LFilePath, fmcreate + fmOpenWrite);
        try
          StringStream := TStringStream.Create(ToJSON, GetEncoding);
          try
            StringStream.Position := 0;
            MemoryStream := TOlfCryptDecrypt.XORcrypt(StringStream,
              GetPrivateXORKey);
            try
              MemoryStream.Position := 0;
              FileStream.CopyFrom(MemoryStream);
            finally
              MemoryStream.Free;
            end;
          finally
            StringStream.Free;
          end;
        finally
          FileStream.Free;
        end;
      end
      else
        tfile.WriteAllText(LFilePath, ToJSON, GetEncoding);
    finally
      FFilePath := LFilePath;
      SetHasChanged(false);
    end;
end;

end.
