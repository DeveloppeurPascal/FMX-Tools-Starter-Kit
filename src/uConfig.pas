﻿/// <summary>
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
/// File last update : 2024-08-28T12:49:12.000+02:00
/// Signature : 1ec5744b7d7ec56836902a76a708ee60df283910
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
  Olf.RTL.Params;

type
  TConfig = class
  private
    FParams: TParamsFile;
    function GetLanguage: string;
    procedure SetLanguage(const Value: string);
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
  uConsts,
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

function TConfig.GetLanguage: string;
var
  lng: string;
begin
  lng := GetCurrentLanguageISOCode;
  if lng.IsEmpty then
    lng := CDefaultLanguage;

  result := FParams.getValue('Language', lng);
end;

function TConfig.GetPath: string;
begin
  result := FParams.getFilePath;
end;

procedure TConfig.SetLanguage(const Value: string);
var
  lng: string;
begin
  lng := Value.tolower;
  if lng.IsEmpty then
    lng := CDefaultLanguage;

  FParams.setValue('Language', Value);
  FParams.Save;
  TTranslateTextsMessage.Broadcast(Value);
end;

initialization

ConfigInstance := nil;

finalization

ConfigInstance.free;

end.
