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
/// File last update : 2025-02-25T18:11:28.000+01:00
/// Signature : 80098381e548617d71a17bf36b99fd33958014b8
/// ***************************************************************************
/// </summary>

unit uDocumentsAncestor;

interface

// If you want to be able to update the template files in your project,
// we recommend that you don't modify this file. Its operation should support
// all standard use cases. Save the file in your project and work on the copy.
// In this case, we suggest you open a ticket on the code repository to explain
// your needs and the changes to be made to the template.
//
// If you want to add features to TDocumentAncestor, don't change this file, simply use
// the helpers.
//
// If you want to add fields or properties, create a new class in your project
// and inherits from current TDocumentAncestor. Override all needed methods and add what
// you have to manage for your project.

uses
  System.Types,
  System.Messaging,
  System.Classes;

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
  /// Subscribe to this message if you need to be informed when we changed current document
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
  /// Manage a document and had the ability to be saved and restored.
  /// </summary>
  /// <remarks>
  /// To add new features and store other things, it's better to inherits from
  /// this class. It allows you to update these file with the future starter kit
  /// updates.
  /// </remarks>
  TDocumentAncestor = class
  private const
    /// <summary>
    /// Version level of this class. It is used to check compatibility between
    /// the program and the files it saves or tries to load.
    /// </summary>
    CProjectDataVersion = 1;

  var
    FFilePath: string;
    function GetFileName: string;
    function GetPath: string;
    procedure SetPath(const Value: string);
  protected
    FPath: string;
    FHasChanged: boolean;
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
    /// Never call it, use only "Free" or "FreeAndNil" if you called the
    /// Create() method to get a new instance of this document.
    /// </summary>
    destructor Destroy; override;
    /// <summary>
    /// Used to load the document from a file after clearing the instance.
    /// </summary>
    procedure LoadFromFile(const AFilePath: string);
    /// <summary>
    /// Used to save current document to a file
    /// </summary>
    procedure SaveToFile(const AFilePath: string = '');
    /// <summary>
    /// Used to load the document from a stream.
    /// </summary>
    /// <remarks>
    /// No Clear() is called, it only loads the saved fields, it doesn't initialize
    /// other things from your document.
    /// </remarks>
    procedure LoadFromStream(const AStream: TStream); virtual;
    /// <summary>
    /// Used to save current document to a stream
    /// </summary>
    procedure SaveToStream(const AStream: TStream); virtual;
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
    /// Returns the XOR Key to use in RELEASE mode to crypt/uncrypt the document file.
    /// </summary>
    /// <remarks>
    /// Override this method in your TDocument class descendant.
    /// </remarks>
    function GetDocumentXorKey: TByteDynArray; virtual; abstract;
  end;

implementation

uses
  System.SysUtils,
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

{ TDocument }

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

destructor TDocumentAncestor.Destroy;
begin
  inherited;
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

procedure TDocumentAncestor.LoadFromFile(const AFilePath: string);
var
  FS: tfilestream;
{$IFDEF RELEASE}
  MS: TMemoryStream;
{$ENDIF}
begin
  if (not AFilePath.IsEmpty) and tfile.exists(AFilePath) then
  begin
    Clear;
    FS := tfilestream.Create(AFilePath, fmOpenRead);
    try
{$IFDEF RELEASE}
      MS := TOlfCryptDecrypt.XORDecrypt(FS, GetDocumentXorKey);
      try
        MS.Position := 0;
        LoadFromStream(MS);
      finally
        MS.Free;
      end;
{$ELSE}
      LoadFromStream(FS);
{$ENDIF}
    finally
      FS.Free;
      FFilePath := AFilePath;
      SetHasChanged(false);
    end;
  end;
end;

procedure TDocumentAncestor.LoadFromStream(const AStream: TStream);
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
  if (VersionNum > CProjectDataVersion) then
    raise exception.Create
      ('Can''t open this file. Please update the program before trying again.');
  // TODO -oDeveloppeurPascal : à traduire

  SetHasChanged(false);
end;

procedure TDocumentAncestor.SaveToFile(const AFilePath: string);
var
  LFilePath: string;
  Folder: string;
  FS: tfilestream;
{$IFDEF RELEASE}
  MS, MS2: TMemoryStream;
{$ENDIF}
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
{$IFDEF RELEASE}
      MS := TMemoryStream.Create;
      try
        SaveToStream(MS);
        MS.Position := 0;
        MS2 := TOlfCryptDecrypt.XORcrypt(MS, GetDocumentXorKey);
        try
          MS2.Position := 0;
          FS.CopyFrom(MS2);
        finally
          MS2.Free;
        end;
      finally
        MS.Free;
      end;
{$ELSE}
      SaveToStream(FS);
{$ENDIF}
    finally
      FS.Free;
      FFilePath := LFilePath;
      SetHasChanged(false);
    end;
  end;
end;

procedure TDocumentAncestor.SaveToStream(const AStream: TStream);
var
  Guid: string;
  VersionNum: integer;
begin
  Guid := GetDocumentGUID;
  SaveStringToStream(Guid, AStream);
  VersionNum := CProjectDataVersion;
  AStream.Write(VersionNum, sizeof(VersionNum));
  SetHasChanged(false);
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

end.
