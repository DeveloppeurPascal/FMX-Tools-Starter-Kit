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
/// File last update : 2024-09-09T11:40:00.000+02:00
/// Signature : a2f444280b7d37458c323967a155bc9ba4978060
/// ***************************************************************************
/// </summary>

unit uConfig;

interface

// If you want to be able to update the template files in your project,
// we recommend that you don't modify this file. Its operation should support
// all standard use cases. Save the file in your project and work on the copy.
// In this case, we suggest you open a ticket on the code repository to explain
// your needs and the changes to be made to the template.

uses
  Olf.RTL.Params,
  uConsts;

// TODO : -oDeveloppeurPascal : add a BeginUpdate/EndUpdate on TConfig to call the SAVE only once
type
  TConfig = class
  private
    FParams: TParamsFile;
    function GetLanguage: string;
    procedure SetLanguage(const Value: string);
    function GetStyleMode: TStyleMode;
    procedure SetStyleMode(const Value: TStyleMode);
    procedure SetCustomStyleName(const Value: string);
    procedure SetDarkStyleName(const Value: string);
    procedure SetLightStyleName(const Value: string);
    function GetCustomStyleName: string;
    function GetDarkStyleName: string;
    function GetLightStyleName: string;
    function GetRecentDocuments(const Index: integer): string;
    procedure SetRecentDocuments(const Index: integer; const Value: string);
    procedure SetRecentDocumentsCount(const Value: integer);
    procedure SetRecentDocumentsMaxCount(const Value: integer);
    function GetRecentDocumentsCount: integer;
    function GetRecentDocumentsMaxCount: integer;
  protected
  public
    /// <summary>
    /// The language you should use on screen and messages
    /// </summary>
    /// <remarks>
    /// By default it's the operating system language
    /// or the CDefaultLanguage constant if it's not available
    /// </remarks>
    property Language: string read GetLanguage write SetLanguage;
    /// <summary>
    /// Style mode choosen by the user.
    /// </summary>
    /// <remarks>
    /// By default it depends on the CDefaultStyleMode constant and the system
    /// appearance.
    /// </remarks>
    property StyleMode: TStyleMode read GetStyleMode write SetStyleMode;
    /// <summary>
    /// Name of the light style (by default or customized by the user)
    /// </summary>
    property LightStyleName: string read GetLightStyleName
      write SetLightStyleName;
    /// <summary>
    /// Name of the dark style (by default or customized by the user)
    /// </summary>
    property DarkStyleName: string read GetDarkStyleName write SetDarkStyleName;
    /// <summary>
    /// Name of the custom style (by default or customized by the user)
    /// </summary>
    property CustomStyleName: string read GetCustomStyleName
      write SetCustomStyleName;
    /// <summary>
    /// Maximum number of recents documents
    /// </summary>
    property RecentDocumentsMaxCount: integer read GetRecentDocumentsMaxCount
      write SetRecentDocumentsMaxCount;
    /// <summary>
    /// Current number of recent documents
    /// </summary>
    property RecentDocumentsCount: integer read GetRecentDocumentsCount
      write SetRecentDocumentsCount;
    /// <summary>
    /// Recents documents path
    /// </summary>
    property RecentDocuments[const Index: integer]: string
      read GetRecentDocuments write SetRecentDocuments;
    /// <summary>
    /// Return the instance to TConfig singleton
    /// </summary>
    class function Current: TConfig; Virtual;
    /// <summary>
    /// Returns current path of the config file
    /// </summary>
    function GetPath: string;
    /// <summary>
    /// Don't use the constructor, it's used only by the Current() method
    /// </summary>
    constructor Create;
    /// <summary>
    /// Don't use the destructor, it's for internal use only
    /// </summary>
    destructor Destroy; override;
  end;

implementation

uses
  System.Classes,
  System.Types,
  System.IOUtils,
  System.SysUtils,
  FMX.Platform,
  Olf.RTL.CryptDecrypt,
  Olf.RTL.Language,
  uTranslate;

var
  ConfigInstance: TConfig;

  { TConfig }

constructor TConfig.Create;
begin
  FParams := TParamsFile.Create;
  FParams.InitDefaultFileNameV2(CEditorFolderName, CProjectFolderName, false);
{$IF Defined(RELEASE)}
  FParams.onCryptProc := function(Const AParams: string): TStream
    var
      ParStream: TStringStream;
    begin
      ParStream := TStringStream.Create(AParams);
      try
        result := TOlfCryptDecrypt.XORCrypt(ParStream, GConfigXORKey);
      finally
        ParStream.free;
      end;
    end;
  FParams.onDecryptProc := function(Const AStream: TStream): string
    var
      Stream: TStream;
      StringStream: TStringStream;
    begin
      result := '';
      Stream := TOlfCryptDecrypt.XORdeCrypt(AStream, GConfigXORKey);
      try
        if assigned(Stream) and (Stream.Size > 0) then
        begin
          StringStream := TStringStream.Create;
          try
            Stream.Position := 0;
            StringStream.CopyFrom(Stream);
            result := StringStream.DataString;
          finally
            StringStream.free;
          end;
        end;
      finally
        Stream.free;
      end;
    end;
{$ENDIF}
  FParams.Load;
end;

class function TConfig.Current: TConfig;
begin
  if not assigned(ConfigInstance) then
  begin
    ConfigInstance := TConfig.Create;
  end;
  result := ConfigInstance;
end;

destructor TConfig.Destroy;
begin
  FParams.free;
  inherited;
end;

function TConfig.GetCustomStyleName: string;
begin
  result := FParams.getValue('CustomStyleName', CDefaultStyleCustom);
end;

function TConfig.GetDarkStyleName: string;
begin
  result := FParams.getValue('DarkStyleName', CDefaultStyleDark);
end;

function TConfig.GetLanguage: string;
var
  lng: string;
begin
  lng := GetCurrentLanguageISOCode;
  if lng.IsEmpty then
    lng := CDefaultLanguage;

  result := FParams.getValue('Language', lng);
end;

function TConfig.GetLightStyleName: string;
begin
  result := FParams.getValue('LightStyleName', CDefaultStyleLight);
end;

function TConfig.GetPath: string;
begin
  result := FParams.getFilePath;
end;

function TConfig.GetRecentDocuments(const Index: integer): string;
begin
  result := FParams.getValue('RD' + Index.ToString, '');
end;

function TConfig.GetRecentDocumentsCount: integer;
begin
  result := FParams.getValue('RDC', 0);
end;

function TConfig.GetRecentDocumentsMaxCount: integer;
begin
  result := FParams.getValue('RDMC', COpenPreviousDocumentsMaxCount);
end;

function TConfig.GetStyleMode: TStyleMode;
begin
  result := TStyleMode(FParams.getValue('StyleMode', ord(CDefaultStyleMode)));
end;

procedure TConfig.SetCustomStyleName(const Value: string);
begin
  FParams.setValue('CustomStyleName', Value.Trim.ToLower);
  FParams.Save;
end;

procedure TConfig.SetDarkStyleName(const Value: string);
begin
  FParams.setValue('DarkStyleName', Value.Trim.ToLower);
  FParams.Save;
end;

procedure TConfig.SetLanguage(const Value: string);
var
  lng: string;
begin
  lng := Value.ToLower;
  if lng.IsEmpty then
    lng := CDefaultLanguage;

  FParams.setValue('Language', Value);
  FParams.Save;
  TTranslateTextsMessage.Broadcast(Value);
end;

procedure TConfig.SetLightStyleName(const Value: string);
begin
  FParams.setValue('LightStyleName', Value.Trim.ToLower);
  FParams.Save;
end;

procedure TConfig.SetRecentDocuments(const Index: integer; const Value: string);
begin
  FParams.setValue('RD' + Index.ToString, Value);
  FParams.Save;
end;

procedure TConfig.SetRecentDocumentsCount(const Value: integer);
begin
  FParams.setValue('RDC', Value);
  FParams.Save;
end;

procedure TConfig.SetRecentDocumentsMaxCount(const Value: integer);
begin
  FParams.setValue('RDMC', Value);
  FParams.Save;
end;

procedure TConfig.SetStyleMode(const Value: TStyleMode);
begin
  FParams.setValue('StyleMode', ord(Value));
  FParams.Save;
end;

initialization

ConfigInstance := nil;

finalization

ConfigInstance.free;

end.
