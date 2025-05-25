(* C2PP
  ***************************************************************************

  FMX Tools Starter Kit

  Copyright 2024-2025 Patrick Prémartin under AGPL 3.0 license.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  DEALINGS IN THE SOFTWARE.

  ***************************************************************************

  A starter kit for your FireMonkey projects in Delphi.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://fmxtoolsstarterkit.developpeur-pascal.fr/

  Project site :
  https://github.com/DeveloppeurPascal/FMX-Tools-Starter-Kit

  ***************************************************************************
  File last update : 2025-05-16T19:43:44.981+02:00
  Signature : fe8a70eaa74c636de83fc7c56f4550b860c0c60e
  ***************************************************************************
*)

unit uConfig;

interface

// This file contains the TConfig.Current global instance to access to settings
// of the starter kit from the starter kit and your projects.
//
// If you want to extend it with your own parameters, you just have to create a
// TConfigHelpers (or with an other name) helper class where you'll add your
// properties and their Get/Set methods.
// Copy the content of the Get/Set methods here to have the same behaviour.
//
// To limit risks of duplicate variables names, prefix your own parameters
// by your project name, a GUID or anything else than what we use (= 'FTSK.').

uses
  Olf.RTL.Params,
  uConsts;

type
  TConfig = class
  private const
    CVariableNamePrefix = 'FTSK.';

  var
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
    function GetLicenseActivationNumber: string;
    function GetLicenseDeviceName: string;
    function GetLicenseEmail: string;
    function GetLicenseNumber: string;
    procedure SetLicenseActivationNumber(const Value: string);
    procedure SetLicenseDeviceName(const Value: string);
    procedure SetLicenseEmail(const Value: string);
    procedure SetLicenseNumber(const Value: string);
  protected
    /// <summary>
    /// Use GetParams function in your TConfigHelpers to access global settings
    /// storage and add your own parameters.
    /// </summary>
    function GetParams: TParamsFile;
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
    /// License number, given by the user with its email address when
    /// registering the software
    /// </summary>
    /// <remarks>
    /// This property is used by CilTseg license key manager API but you can use
    /// it even if you don't use this licensing tool.
    /// </remarks>
    property LicenseNumber: string read GetLicenseNumber write SetLicenseNumber;
    /// <summary>
    /// User email, given by the user with its license number when registering
    /// the software.
    /// </summary>
    /// <remarks>
    /// This property is used by CilTseg license key manager API but you can use
    /// it even if you don't use this licensing tool.
    /// </remarks>
    property LicenseEmail: string read GetLicenseEmail write SetLicenseEmail;
    /// <summary>
    /// Activation number, given by the server if the license has been activated.
    /// </summary>
    /// <remarks>
    /// This property is used by CilTseg license key manager API but you can use
    /// it even if you don't use this licensing tool.
    /// </remarks>
    property LicenseActivationNumber: string read GetLicenseActivationNumber
      write SetLicenseActivationNumber;
    /// <summary>
    /// The device name used during the license activation.
    /// Store it only to check if it's still the current one on your device.
    /// (in case the settings have been copied to an other computer)
    /// </summary>
    /// <remarks>
    /// This property is used by CilTseg license key manager API but you can use
    /// it even if you don't use this licensing tool.
    /// </remarks>
    property LicenseDeviceName: string read GetLicenseDeviceName
      write SetLicenseDeviceName;
    /// <summary>
    /// Return the instance to TConfig singleton
    /// </summary>
    class function Current: TConfig; Virtual;
    /// <summary>
    /// Returns current path of the config file (directory+filename)
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
    /// <summary>
    /// Save current settings.
    /// </summary>
    procedure Save;
    /// <summary>
    /// Allow parameters changes but delay the Save operation to the EndUpdate call.
    /// </summary>
    /// <remarks>
    /// If you call BeginUpdate you MUST call its EndUpdate.
    /// Use a try... finally... end !
    /// </remarks>
    procedure BeginUpdate;
    /// <summary>
    /// Closes the block of code started with BeginUpdate. If you did some changes, it saves them by default.
    /// </summary>
    /// <remarks>
    /// If you call BeginUpdate you MUST call its EndUpdate.
    /// Use a try... finally... end !
    /// </remarks>
    procedure EndUpdate(const AutoSaveChanges: boolean = true);
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
  uTranslate,
  uGetDeviceName;

var
  ConfigInstance: TConfig;

  { TConfig }

procedure TConfig.BeginUpdate;
begin
  FParams.BeginUpdate;
end;

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

procedure TConfig.EndUpdate(const AutoSaveChanges: boolean);
begin
  FParams.EndUpdate(AutoSaveChanges);
end;

function TConfig.GetCustomStyleName: string;
begin
  result := FParams.GetValue(CVariableNamePrefix + 'CustomStyleName',
    CDefaultStyleCustom);
end;

function TConfig.GetDarkStyleName: string;
begin
  result := FParams.GetValue(CVariableNamePrefix + 'DarkStyleName',
    CDefaultStyleDark);
end;

function TConfig.GetLanguage: string;
var
  lng: string;
begin
  lng := GetCurrentLanguageISOCode;
  if lng.IsEmpty then
    lng := CDefaultLanguage;

  result := FParams.GetValue(CVariableNamePrefix + 'Language', lng);
end;

function TConfig.GetLicenseActivationNumber: string;
begin
  result := FParams.GetValue(CVariableNamePrefix + 'LicenseActivation', '');
end;

function TConfig.GetLicenseDeviceName: string;
begin
  result := FParams.GetValue(CVariableNamePrefix + 'LicenseDeviceName',
    getDeviceName);
  if result.IsEmpty then
    result := getDeviceName;
end;

function TConfig.GetLicenseEmail: string;
begin
  result := FParams.GetValue(CVariableNamePrefix + 'LicenseUserEmail', '');
end;

function TConfig.GetLicenseNumber: string;
begin
  result := FParams.GetValue(CVariableNamePrefix + 'LicenseNumber', '');
end;

function TConfig.GetLightStyleName: string;
begin
  result := FParams.GetValue(CVariableNamePrefix + 'LightStyleName',
    CDefaultStyleLight);
end;

function TConfig.GetParams: TParamsFile;
begin
  result := FParams;
end;

function TConfig.GetPath: string;
begin
  result := FParams.getFilePath;
end;

function TConfig.GetRecentDocuments(const Index: integer): string;
begin
  result := FParams.GetValue(CVariableNamePrefix + 'RD' + Index.ToString, '');
end;

function TConfig.GetRecentDocumentsCount: integer;
begin
  result := FParams.GetValue(CVariableNamePrefix + 'RDC', 0);
end;

function TConfig.GetRecentDocumentsMaxCount: integer;
begin
  result := FParams.GetValue(CVariableNamePrefix + 'RDMC',
    COpenPreviousDocumentsMaxCount);
end;

function TConfig.GetStyleMode: TStyleMode;
begin
  result := TStyleMode(FParams.GetValue(CVariableNamePrefix + 'StyleMode',
    ord(CDefaultStyleMode)));
end;

procedure TConfig.Save;
begin
  FParams.Save;
end;

procedure TConfig.SetCustomStyleName(const Value: string);
begin
  FParams.SetValue(CVariableNamePrefix + 'CustomStyleName', Value.Trim.ToLower);
  Save;
end;

procedure TConfig.SetDarkStyleName(const Value: string);
begin
  FParams.SetValue(CVariableNamePrefix + 'DarkStyleName', Value.Trim.ToLower);
  Save;
end;

procedure TConfig.SetLanguage(const Value: string);
var
  lng: string;
begin
  lng := Value.ToLower;
  if lng.IsEmpty then
    lng := CDefaultLanguage;

  FParams.SetValue(CVariableNamePrefix + 'Language', Value);
  Save;
  TTranslateTextsMessage.Broadcast(Value);
end;

procedure TConfig.SetLicenseActivationNumber(const Value: string);
begin
  FParams.SetValue(CVariableNamePrefix + 'LicenseActivation', Value);
  Save;
end;

procedure TConfig.SetLicenseDeviceName(const Value: string);
begin
  FParams.SetValue(CVariableNamePrefix + 'LicenseDeviceName', Value);
  Save;
end;

procedure TConfig.SetLicenseEmail(const Value: string);
begin
  FParams.SetValue(CVariableNamePrefix + 'LicenseUserEmail', Value);
  Save;
end;

procedure TConfig.SetLicenseNumber(const Value: string);
begin
  FParams.SetValue(CVariableNamePrefix + 'LicenseNumber', Value);
  Save;
end;

procedure TConfig.SetLightStyleName(const Value: string);
begin
  FParams.SetValue(CVariableNamePrefix + 'LightStyleName', Value.Trim.ToLower);
  Save;
end;

procedure TConfig.SetRecentDocuments(const Index: integer; const Value: string);
begin
  FParams.SetValue(CVariableNamePrefix + 'RD' + Index.ToString, Value);
  Save;
end;

procedure TConfig.SetRecentDocumentsCount(const Value: integer);
begin
  FParams.SetValue(CVariableNamePrefix + 'RDC', Value);
  Save;
end;

procedure TConfig.SetRecentDocumentsMaxCount(const Value: integer);
begin
  FParams.SetValue(CVariableNamePrefix + 'RDMC', Value);
  Save;
end;

procedure TConfig.SetStyleMode(const Value: TStyleMode);
begin
  FParams.SetValue(CVariableNamePrefix + 'StyleMode', ord(Value));
  Save;
end;

initialization

ConfigInstance := nil;

finalization

ConfigInstance.free;

end.
