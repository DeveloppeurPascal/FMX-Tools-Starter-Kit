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
/// File last update : 2025-02-25T19:27:54.000+01:00
/// Signature : b86b678bd4adb7e510d1575dac48fed9e23ce34c
/// ***************************************************************************
/// </summary>

unit uDMAboutBox;

interface

// If you want to be able to update the template files in your project,
// we recommend that you don't modify this file. Its operation should support
// all standard use cases. Save the file in your project and work on the copy.
// In this case, we suggest you open a ticket on the code repository to explain
// your needs and the changes to be made to the template.

uses
  System.Messaging,
  System.SysUtils,
  System.Classes,
  FMX.Types,
  Olf.FMX.AboutDialog,
  Olf.FMX.AboutDialogForm;

type
  TOnAboutBoxTranslateTexts = function(const Language: string;
    const TxtID: TOlfAboutDialogTxtID): string of object;

  TAboutBox = class(TDataModule)
    OlfAboutDialog1: TOlfAboutDialog;
    procedure DataModuleCreate(Sender: TObject);
    procedure OlfAboutDialog1URLClick(const AURL: string);
    procedure DataModuleDestroy(Sender: TObject);
    function OlfAboutDialog1GetText(const ALang: TOlfAboutDialogLang;
      const ATxtID: TOlfAboutDialogTxtID): string;
  private
    FOnAboutBoxTranslateTexts: TOnAboutBoxTranslateTexts;
    procedure SetOnAboutBoxTranslateTexts(const Value
      : TOnAboutBoxTranslateTexts);
  protected
    procedure TranslateTexts(const Sender: TObject; const Msg: TMessage);
    procedure DoButtonBuyClick(Sender: TObject); virtual;
    procedure DoButtonRegisterClick(Sender: TObject); virtual;
    procedure DoButtonLicenseClick(Sender: TObject); virtual;
  public
    property OnAboutBoxTranslateTexts: TOnAboutBoxTranslateTexts
      read FOnAboutBoxTranslateTexts write SetOnAboutBoxTranslateTexts;
    class function Current: TAboutBox;
    class procedure ShowModal;
    class function GetCaption: string;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses
  uDMAboutBoxLogoStorrage,
  uConsts,
  u_urlOpen,
  uTxtAboutDescription,
  uTxtAboutLicense,
  uTranslate,
  uConfig,
  Olf.CilTseg.ClientLib,
  fCiltsegRegisterOrShowLicense;

{$R *.dfm}

var
  LAboutBox: TAboutBox;

  { TAboutBox }

class function TAboutBox.Current: TAboutBox;
begin
  if not assigned(LAboutBox) then
    LAboutBox := TAboutBox.create(nil);

  result := LAboutBox;
end;

procedure TAboutBox.DataModuleCreate(Sender: TObject);
var
  dm: TdmAboutBoxLogo;
begin
  OlfAboutDialog1.Titre := CAboutTitle;
  OlfAboutDialog1.VersionNumero := CAboutVersionNumber;
  OlfAboutDialog1.VersionDate := CAboutVersionDate;
  OlfAboutDialog1.Copyright := CAboutCopyright;
  OlfAboutDialog1.URL := CAboutURL;
  dm := TdmAboutBoxLogo.create(self);
  OlfAboutDialog1.Images := dm.imgLogo;
  OlfAboutDialog1.ImageIndex := 0;
  OlfAboutDialog1.ReplaceMainFormCaption := true;

  if (not CSoftwareBuyURL.IsEmpty) and (TConfig.Current.LicenseNumber.IsEmpty)
  then
    OlfAboutDialog1.onButtonBuyClick := DoButtonBuyClick;

  if CUsedLicenseManager <> TLicenseManagers.None then
  begin
    if TConfig.Current.LicenseNumber.IsEmpty then
      OlfAboutDialog1.onButtonRegisterClick := DoButtonRegisterClick
    else
      OlfAboutDialog1.onButtonLicenseClick := DoButtonLicenseClick;
  end;

  TMessageManager.DefaultManager.SubscribeToMessage(TTranslateTextsMessage,
    TranslateTexts);
end;

procedure TAboutBox.DataModuleDestroy(Sender: TObject);
begin
  TMessageManager.DefaultManager.Unsubscribe(TTranslateTextsMessage,
    TranslateTexts, true);
end;

class function TAboutBox.GetCaption: string;
begin
  // TODO -oDeveloppeurPascal -cNF : à remplacer par mieux un jour, cf https://github.com/DeveloppeurPascal/AboutDialog-Delphi-Component/issues/59
  result := 'About ' + Current.OlfAboutDialog1.Titre;
end;

procedure TAboutBox.DoButtonBuyClick(Sender: TObject);
begin
  url_Open_In_Browser(CSoftwareBuyURL);
end;

procedure TAboutBox.DoButtonLicenseClick(Sender: TObject);
begin
  TfrmCilTsegRegisterOrShowLicense.Execute(self);
end;

procedure TAboutBox.DoButtonRegisterClick(Sender: TObject);
begin
  TfrmCilTsegRegisterOrShowLicense.Execute(self);
end;

function TAboutBox.OlfAboutDialog1GetText(const ALang: TOlfAboutDialogLang;
  const ATxtID: TOlfAboutDialogTxtID): string;
begin
  if assigned(OnAboutBoxTranslateTexts) then
    result := OnAboutBoxTranslateTexts(TConfig.Current.Language, ATxtID)
  else
    result := '';
end;

procedure TAboutBox.OlfAboutDialog1URLClick(const AURL: string);
begin
  url_Open_In_Browser(AURL);
end;

procedure TAboutBox.SetOnAboutBoxTranslateTexts(const Value
  : TOnAboutBoxTranslateTexts);
begin
  FOnAboutBoxTranslateTexts := Value;
end;

class procedure TAboutBox.ShowModal;
begin
  Current.OlfAboutDialog1.Execute;
end;

procedure TAboutBox.TranslateTexts(const Sender: TObject; const Msg: TMessage);
var
  ttm: TTranslateTextsMessage;
begin
  if not assigned(self) then
    exit;

  if assigned(Msg) and (Msg is TTranslateTextsMessage) then
  begin
    ttm := Msg as TTranslateTextsMessage;
    if ttm.Language = 'en' then
      OlfAboutDialog1.Langue := TOlfAboutDialogLang.EN
    else if ttm.Language = 'fr' then
      OlfAboutDialog1.Langue := TOlfAboutDialogLang.FR
    else if ttm.Language = 'it' then
      OlfAboutDialog1.Langue := TOlfAboutDialogLang.IT
    else if ttm.Language = 'pt' then
      OlfAboutDialog1.Langue := TOlfAboutDialogLang.PT
    else if ttm.Language = 'sp' then
      OlfAboutDialog1.Langue := TOlfAboutDialogLang.SP
    else if ttm.Language = 'de' then
      OlfAboutDialog1.Langue := TOlfAboutDialogLang.DE
    else
      OlfAboutDialog1.Langue := TOlfAboutDialogLang.Manual;
    OlfAboutDialog1.Description.Text := GetTxtAboutDescription(ttm.Language);
    OlfAboutDialog1.Licence.Text := GetTxtAboutLicense(ttm.Language);
  end;
end;

initialization

LAboutBox := nil;
TThread.ForceQueue(nil,
  procedure
  begin
    LAboutBox := TAboutBox.Current;
  end);

finalization

LAboutBox.free;

end.
