/// <summary>
/// ***************************************************************************
///
/// FMX Tools Starter Kit
///
/// Copyright 2024 Patrick Prémartin under AGPL 3.0 license.
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
/// File last update : 2024-08-28T12:42:14.000+02:00
/// Signature : 4e0e7d7e79680d354edd8573da78f8d891e12451
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
// If you want to add features to TDocument, don't change this file, simply use
// the helpers.
//
// If you want to add fields or properties, create a new class in your project
// and inherits from current TDocument. Override all needed methods and add what
// you have to manage for your project.

uses
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
  /// Manage the document and have the ability to be saved/restored
  /// </summary>
  /// <remarks>
  /// To add new features and store other things, it's better to inherits from
  /// this class. It allow you to update thise file with the future templates
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
    /// Path to the folder where this document will be saved
    /// </summary>
    /// <remarks>
    /// Default value is based on TConfig saving path combined to "Projects" folder
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
  else if FPath.IsEmpty or (not tdirectory.exists(FPath)) then
    result := tconfig.current.GetPath
  else
    result := FPath;
end;

procedure TDocumentAncestor.LoadFromFile(const AFilePath: string);
var
  FS: tfilestream;
begin
  if (not AFilePath.IsEmpty) and tfile.exists(AFilePath) then
  begin
    Clear;
    FS := tfilestream.Create(AFilePath, fmOpenRead);
    try
{$IFDEF RELEASE}
      // TODO -oDeveloppeurPascal -cTODO : traiter le chiffrement des données de backup
{$MESSAGE FATAL 'code missing'}
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
  if (Guid <> CProjectGUID) then
    raise exception.Create('This file is not recognized !');

  // Check if the document file has a block version number.
  if (sizeof(VersionNum) <> AStream.read(VersionNum, sizeof(VersionNum))) then
    raise exception.Create('Wrong File format !');

  // Check if the program can open this document.
  if (VersionNum > CProjectDataVersion) then
    raise exception.Create
      ('Can''t open this file. Please update the program before trying again.');

  SetHasChanged(false);
end;

procedure TDocumentAncestor.SaveToFile(const AFilePath: string);
var
  LFilePath: string;
  Folder: string;
  FS: tfilestream;
begin
  if AFilePath.IsEmpty then
    LFilePath := FFilePath
  else
    LFilePath := AFilePath;

  if LFilePath.IsEmpty then
    raise exception.Create
      ('Specify a file path where to save current document.');

  Folder := tpath.GetDirectoryName(LFilePath);
  if (not Folder.IsEmpty) then
  begin
    if not tdirectory.exists(Folder) then
      tdirectory.CreateDirectory(Folder);
    FS := tfilestream.Create(LFilePath, fmcreate + fmOpenWrite);
    try
{$IFDEF RELEASE}
      // TODO -oDeveloppeurPascal -cTODO : traiter le chiffrement des données de backup
{$MESSAGE FATAL 'code missing'}
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
  Guid := CProjectGUID;
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

end.
