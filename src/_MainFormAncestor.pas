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
/// File last update : 2024-11-28T21:19:52.000+01:00
/// Signature : 3c2d18094e1f2d6dd715106b9f628c10e3fc8034
/// ***************************************************************************
/// </summary>

unit _MainFormAncestor;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  _TFormAncestor,
  System.Actions,
  FMX.ActnList,
  FMX.Menus,
  uDMAboutBox,
  fToolsLanguagesDialog,
  Olf.FMX.AboutDialogForm,
  uDocumentsAncestor;

type
  T__MainFormAncestor = class(T__TFormAncestor)
    MainFormAncestorMenu: TMainMenu;
    mnuMacOS: TMenuItem;
    mnuFile: TMenuItem;
    mnuDocument: TMenuItem;
    mnuTools: TMenuItem;
    mnuHelp: TMenuItem;
    mnuFileQuit: TMenuItem;
    mnuDocumentOptions: TMenuItem;
    mnuToolsOptions: TMenuItem;
    mnuToolsLanguage: TMenuItem;
    mnuToolsStyle: TMenuItem;
    mnuHelpAbout: TMenuItem;
    mnuHelpSupport: TMenuItem;
    MainFormAncestorActionList: TActionList;
    actQuit: TAction;
    actAbout: TAction;
    actSupport: TAction;
    actDocumentOptions: TAction;
    actLanguageChange: TAction;
    actStyleChange: TAction;
    actToolsOptions: TAction;
    mnuFileNew: TMenuItem;
    mnuFileOpen: TMenuItem;
    mnuFileOpenPrevious: TMenuItem;
    mnuFileSave: TMenuItem;
    mnuFileSaveAs: TMenuItem;
    mnuFileClose: TMenuItem;
    mnuWindows: TMenuItem;
    mnuFileCloseAll: TMenuItem;
    mnuFileSaveAll: TMenuItem;
    actNewDocument: TAction;
    actOpenDocument: TAction;
    actSaveDocument: TAction;
    actSaveDocumentAs: TAction;
    actSaveAllDocuments: TAction;
    actCloseDocument: TAction;
    actCloseAllDocuments: TAction;
    mnuFileOpenPreviousOptions: TMenuItem;
    mnuFileOpenPreviousSeparator: TMenuItem;
    actRecentFilesOptions: TAction;
    mnuHelpBuyALicense: TMenuItem;
    actBuyALicense: TAction;
    mnuHelpRegisterALicense: TMenuItem;
    actRegisterALicense: TAction;
    actCheckForANewRelease: TAction;
    mnuHelpCheckForANewRelease: TMenuItem;
    procedure actQuitExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actSupportExecute(Sender: TObject);
    procedure actDocumentOptionsExecute(Sender: TObject);
    procedure actLanguageChangeExecute(Sender: TObject);
    procedure actStyleChangeExecute(Sender: TObject);
    procedure actToolsOptionsExecute(Sender: TObject);
    procedure actNewDocumentExecute(Sender: TObject);
    procedure actOpenDocumentExecute(Sender: TObject);
    procedure actSaveDocumentExecute(Sender: TObject);
    procedure actSaveDocumentAsExecute(Sender: TObject);
    procedure actSaveAllDocumentsExecute(Sender: TObject);
    procedure actCloseDocumentExecute(Sender: TObject);
    procedure actCloseAllDocumentsExecute(Sender: TObject);
    procedure actRecentFilesOptionsExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actBuyALicenseExecute(Sender: TObject);
    procedure actRegisterALicenseExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actCheckForANewReleaseExecute(Sender: TObject);
  private
    FonGetLanguageName: TOnGetLanguageName;
    FOnAboutBoxTranslateTexts: TOnAboutBoxTranslateTexts;
    FCurrentDocument: TDocumentAncestor;
    procedure SetonGetLanguageName(const Value: TOnGetLanguageName);
    procedure SetOnAboutBoxTranslateTexts(const Value
      : TOnAboutBoxTranslateTexts);
    procedure SetCurrentDocument(const Value: TDocumentAncestor);
  protected
    /// <summary>
    /// Show/hide TMainMenu items depending on there sub menus items visibility
    /// </summary>
    procedure RefreshMenuItemsVisibility(const Menu: TMainMenu);
      overload; virtual;
    /// <summary>
    /// Show/hide a TMenuItem depending on its sub menus items visibility
    /// </summary>
    function RefreshMenuItemsVisibility(const MenuItem: TMenuItem;
      const FirstLevel: Boolean): Boolean; overload; virtual;
    /// <summary>
    /// Called by the actQuit action used for File/Quit menu option.
    /// </summary>
    /// <remarks>
    /// By default this method close the main form and the program.
    /// </remarks>
    procedure DoQuitAction(Sender: TObject); virtual;
    /// <summary>
    /// Called by the actAbout action used for Help/About menu option.
    /// </summary>
    /// <remarks>
    /// By default this method show the default About Box dialog.
    /// </remarks>
    procedure DoAboutAction(Sender: TObject); virtual;
    /// <summary>
    /// Called by the actSupport action used for Help/Support menu option.
    /// </summary>
    /// <remarks>
    /// By default this method open the CSupportURL url in the default browser.
    /// </remarks>
    procedure DoSupportAction(Sender: TObject); virtual;
    /// <summary>
    /// Called by the actBuyALicense used for "Help/Buy A License" menu option.
    /// </summary>
    procedure DoBuyALicense(Sender: TObject); virtual;
    /// <summary>
    /// Called when we need to register a license from the "Help/Register" menu option
    /// </summary>
    procedure DoRegisterALicense(Sender: TObject); virtual;
    /// <summary>
    /// Called by the actDocumentOptions action used for Document/Options menu option.
    /// </summary>
    /// <remarks>
    /// Nothing is done by default. Override this method if you want to do something.
    /// </remarks>
    procedure DoDocumentOptionsAction(Sender: TObject); virtual; abstract;
    /// <summary>
    /// Called by the actLanguages action used for Tools/Languages menu option.
    /// </summary>
    /// <remarks>
    /// Nothing is done by default. Override this method if you want to do something.
    /// </remarks>
    procedure DoLanguageChangeAction(Sender: TObject); virtual;
    /// <summary>
    /// Called by the actStyles action used for Tools/Styles menu option.
    /// </summary>
    /// <remarks>
    /// By default it show the Styls selection dialog box
    /// </remarks>
    procedure DoStyleChangeAction(Sender: TObject); virtual;
    /// <summary>
    /// Called by the actToolsOptions action used for Tools/Options menu option.
    /// </summary>
    /// <remarks>
    /// Nothing is done by default. Override this method if you want to do something.
    /// </remarks>
    procedure DoToolsOptionsAction(Sender: TObject); virtual; abstract;
    /// <summary>
    /// Used as onGetLanguageName event in the current language selection dialog
    /// if onGetLanguageName property is not assigned.
    /// </summary>
    /// <remarks>
    /// Override it in your main form or assign an other method to
    /// onGetLanguageName if you added languages to the starter kit list of
    /// languages.
    /// </remarks>
    function DoGetLanguageName(const ISOCode: string): string; virtual;
    /// <summary>
    /// Used as OnAboutBoxTranslateTexts event in the about box dialog
    /// if OnAboutBoxTranslateTexts property is not assigned.
    /// </summary>
    /// <remarks>
    /// Override it in your main form or assign an other method to
    /// OnAboutBoxTranslateTexts
    /// languages.
    /// </remarks>
    function DoAboutBoxTranslateTexts(const Language: string;
      const TxtID: TOlfAboutDialogTxtID): string; virtual;
    /// <summary>
    /// Called when we need to create a new document
    /// </summary>
    /// <remarks>
    /// Override this method to change the document type and use your descendant type
    /// </remarks>
    procedure DoDocumentNewAction(Sender: TObject); virtual;
    /// <summary>
    /// Called when we need to open a document
    /// </summary>
    /// <remarks>
    /// Override this method to change the document type and use your descendant type
    /// </remarks>
    procedure DoDocumentOpenAction(Sender: TObject); virtual;
    /// <summary>
    /// Called when we need to save a document
    /// </summary>
    /// <remarks>
    /// Override this method to change default behaviour
    /// </remarks>
    procedure DoDocumentSaveAction(Sender: TObject); virtual;
    /// <summary>
    /// Called when we need to save a document as an other file (or a new one)
    /// </summary>
    /// <remarks>
    /// Override this method to change default behaviour
    /// </remarks>
    procedure DoDocumentSaveAsAction(Sender: TObject); virtual;
    /// <summary>
    /// Called when we need to close a document
    /// </summary>
    /// <remarks>
    /// Override this method to change default behaviour
    /// </remarks>
    procedure DoDocumentCloseAction(Sender: TObject;
      const Proc: TProc = nil); virtual;
    /// <summary>
    /// Called when we need to save all opened (and changed) documents
    /// </summary>
    /// <remarks>
    /// Override this method to change default behaviour
    /// </remarks>
    procedure DoSaveAllAction(Sender: TObject); virtual;
    /// <summary>
    /// Called when we need to open a recent opened document
    /// </summary>
    /// <remarks>
    /// Override this method to change default behaviour
    /// </remarks>
    procedure DoOpenPreviousAction(Sender: TObject); virtual;
    /// <summary>
    /// Called when we want to change current document and use an other opened one
    /// </summary>
    /// <remarks>
    /// Override this method to change default behaviour
    /// </remarks>
    procedure DoGoToDocAction(Sender: TObject); virtual;
    /// <summary>
    /// Called when we need to close all documents
    /// </summary>
    /// <remarks>
    /// Override this method to change default behaviour
    /// </remarks>
    procedure DoCloseAllAction(Sender: TObject); virtual;
    /// <summary>
    /// Called when we open the options dialog to change "recent files" properties
    /// </summary>
    /// <remarks>
    /// Override this method to change default behaviour
    /// </remarks>
    procedure DoRecentDocumentsOptionsAction(Sender: TObject); virtual;
    /// <summary>
    /// Check if a license in needed and if the program has been registered.
    /// It uses the CilTseg API, override it if you want an other key licensing
    /// system.
    /// </summary>
    procedure DoCheckLicenseOnStartup(Sender: TObject); virtual;
    /// <summary>
    /// Check if a new release is available for this program and allow to update
    /// </summary>
    procedure DoCheckForANewRelease(Sender: TObject); virtual;
    /// <summary>
    /// Returns a document instance.
    /// Override it in your main form descendant to create an instance of the good class (yours)
    /// </summary>
    function GetNewDoc: TDocumentAncestor; virtual;
  public
    /// <summary>
    /// Current opened document
    /// </summary>
    property CurrentDocument: TDocumentAncestor read FCurrentDocument
      write SetCurrentDocument;
    /// <summary>
    /// Called in the Tools/Languages dialog to get the language name for an ISO code.
    /// </summary>
    property onGetLanguageName: TOnGetLanguageName read FonGetLanguageName
      write SetonGetLanguageName;
    /// <summary>
    /// Use it if you want to override about box texts translation or add your languages.
    /// </summary>
    property OnAboutBoxTranslateTexts: TOnAboutBoxTranslateTexts
      read FOnAboutBoxTranslateTexts write SetOnAboutBoxTranslateTexts;
    /// <summary>
    /// Class constructor
    /// </summary>
    constructor Create(AOwner: TComponent); override;
    /// <summary>
    /// Execute some code after the form instance construction
    /// </summary>
    procedure AfterConstruction; override;
    /// <summary>
    /// Translate texts for this form
    /// </summary>
    procedure TranslateTexts(const Language: string); override;
  end;

{$IFDEF DEBUG}

var
  __MainFormAncestor: T__MainFormAncestor;
{$ENDIF}

implementation

{$R *.fmx}

uses
  u_urlOpen,
  uConsts,
  uStyleManager,
  fToolsStylesDialog,
  System.IOUtils,
  uConfig,
  fCiltsegRegisterOrShowLicense,
  Olf.CilTseg.ClientLib,
  System.DateUtils,
  FMX.DialogService;

procedure T__MainFormAncestor.actAboutExecute(Sender: TObject);
begin
  DoAboutAction(Sender);
end;

procedure T__MainFormAncestor.actLanguageChangeExecute(Sender: TObject);
begin
  DoLanguageChangeAction(Sender);
end;

procedure T__MainFormAncestor.actNewDocumentExecute(Sender: TObject);
begin
  DoDocumentNewAction(Sender);
end;

procedure T__MainFormAncestor.actOpenDocumentExecute(Sender: TObject);
begin
  DoDocumentOpenAction(Sender);
end;

procedure T__MainFormAncestor.actBuyALicenseExecute(Sender: TObject);
begin
  DoBuyALicense(Sender);
end;

procedure T__MainFormAncestor.actCheckForANewReleaseExecute(Sender: TObject);
begin
  DoCheckForANewRelease(Sender);
end;

procedure T__MainFormAncestor.actCloseAllDocumentsExecute(Sender: TObject);
begin
  DoCloseAllAction(Sender);
end;

procedure T__MainFormAncestor.actCloseDocumentExecute(Sender: TObject);
begin
  DoDocumentCloseAction(Sender);
end;

procedure T__MainFormAncestor.actDocumentOptionsExecute(Sender: TObject);
begin
  DoDocumentOptionsAction(Sender);
end;

procedure T__MainFormAncestor.actQuitExecute(Sender: TObject);
begin
  DoQuitAction(Sender);
end;

procedure T__MainFormAncestor.actRecentFilesOptionsExecute(Sender: TObject);
begin
  DoRecentDocumentsOptionsAction(Sender);
end;

procedure T__MainFormAncestor.actRegisterALicenseExecute(Sender: TObject);
begin
  DoRegisterALicense(Sender);
end;

procedure T__MainFormAncestor.actSaveAllDocumentsExecute(Sender: TObject);
begin
  DoSaveAllAction(Sender);
end;

procedure T__MainFormAncestor.actSaveDocumentAsExecute(Sender: TObject);
begin
  DoDocumentSaveAsAction(Sender);
end;

procedure T__MainFormAncestor.actSaveDocumentExecute(Sender: TObject);
begin
  DoDocumentSaveAction(Sender);
end;

procedure T__MainFormAncestor.actStyleChangeExecute(Sender: TObject);
begin
  DoStyleChangeAction(Sender);
end;

procedure T__MainFormAncestor.actSupportExecute(Sender: TObject);
begin
  DoSupportAction(Sender)
end;

procedure T__MainFormAncestor.actToolsOptionsExecute(Sender: TObject);
begin
  DoToolsOptionsAction(Sender);
end;

procedure T__MainFormAncestor.AfterConstruction;
begin
  inherited;
  // Menu
{$IF Defined(IOS) or Defined(ANDROID)}
  MainFormAncestorMenu.free;
  // TODO -oDeveloppeurPascal : add a TToolBar for iOS/Android users
{$ELSE}
  RefreshMenuItemsVisibility(MainFormAncestorMenu);
{$ENDIF}

  // Styles
{$IFDEF MACOS}
  tthread.forcequeue(nil,
    procedure
    begin
      TProjectStyle.Current.EnableDefaultStyle;
    end);
{$ELSE}
  TProjectStyle.Current.EnableDefaultStyle;
{$ENDIF}
end;

constructor T__MainFormAncestor.Create(AOwner: TComponent);
begin
  inherited;
  FonGetLanguageName := nil;
  FOnAboutBoxTranslateTexts := nil;
  FCurrentDocument := nil;
end;

procedure T__MainFormAncestor.DoAboutAction(Sender: TObject);
begin
  if assigned(OnAboutBoxTranslateTexts) then
    TAboutBox.Current.OnAboutBoxTranslateTexts := OnAboutBoxTranslateTexts
  else
    TAboutBox.Current.OnAboutBoxTranslateTexts := DoAboutBoxTranslateTexts;
  TAboutBox.Current.ShowModal;
end;

function T__MainFormAncestor.DoAboutBoxTranslateTexts(const Language: string;
const TxtID: TOlfAboutDialogTxtID): string;
begin
  // Do nothing at this level
  result := '';
end;

procedure T__MainFormAncestor.DoBuyALicense(Sender: TObject);
begin
  if not CSoftwareBuyURL.IsEmpty then
    url_Open_In_Browser(CSoftwareBuyURL);
end;

procedure T__MainFormAncestor.DoCheckLicenseOnStartup(Sender: TObject);
begin
  if CNeedALicenseNumber and tconfig.Current.LicenseNumber.IsEmpty then
    // TODO : attendre un nombre de lancement ou de jours avant de faire une nouvelle demande
    tthread.CreateAnonymousThread(
      procedure
      begin
        sleep(2000);
        tthread.queue(nil,
          procedure
          begin
            if CCilTsegInUse and tconfig.Current.LicenseActivationNumber.IsEmpty
            then
              DoRegisterALicense(self)
            else
              DoAboutAction(self);
          end);
      end).Start;
end;

procedure T__MainFormAncestor.DoCheckForANewRelease(Sender: TObject);
var
  CilTsegAPI: TCilTsegClientLib;
  result: TCilTsegLastRelease;
  i: integer;
  s: string;
  Tab: TStringDynArray;
  CurPlatform: string;
  CurReleaseDate: TDate;
  DownloadURL: string;
begin
  CilTsegAPI := TCilTsegClientLib.Create(CCiltsegServerURL, CCiltsegSoftwareID,
    CCiltsegSoftwareToken);
  try
    result := CilTsegAPI.GetSoftwareLastRelease;
    try
      if result.Error then
        ShowMessage('A technical problem prevents us from checking whether a ' +
          'new version of the program is available. Please try again later or '
          + 'contact the support if the problem persists.')
        // TODO : à traduire
      else
      begin
        CurReleaseDate := ISO8601ToDate(CAboutVersionDate);
        CurPlatform := CSoftwareCurrentPlatform.ToLower;
        DownloadURL := '';
        Tab := result.GetPlatforms;
        s := '';
        for i := 0 to length(Tab) - 1 do
          if Tab[i].ToLower = CurPlatform then
          begin
            DownloadURL := Tab[i];
            break;
          end;
        if DownloadURL.IsEmpty then
          ShowMessage('No new release available.') // TODO : à traduire
        else
          TDialogService.MessageDialog // TODO : à traduire
            ('A new release is available, do you want to download it ?',
            TMsgDlgType.mtConfirmation, mbYesNo, TMsgDlgBtn.mbYes, 0,
            procedure(const AModalResult: TModalResult)
            begin
              if AModalResult = mrYes then
                url_Open_In_Browser(DownloadURL);
            end);
      end;
    finally
      result.free;
    end;
  finally
    CilTsegAPI.free;
  end;
end;

procedure T__MainFormAncestor.DoCloseAllAction(Sender: TObject);
begin
  // TODO -oDeveloppeurPascal : à compléter
end;

procedure T__MainFormAncestor.DoDocumentCloseAction(Sender: TObject;
const Proc: TProc);
var
  i: integer;
begin
  // TODO -oDeveloppeurPascal : à compléter

  for i := mnuWindows.ItemsCount - 1 downto 0 do
    if (FCurrentDocument = mnuWindows.Items[i].TagObject) then
      mnuWindows.Items[i].free;

  freeandnil(FCurrentDocument);

  if assigned(Proc) then
    tthread.forcequeue(nil,
      procedure
      begin
        Proc;
      end);
end;

procedure T__MainFormAncestor.DoDocumentNewAction(Sender: TObject);
var
  NewDoc: TDocumentAncestor;
  MI: TMenuItem;
begin
  NewDoc := GetNewDoc;
  // TODO -oDeveloppeurPascal : ajouter le document à la liste des documents

  MI := TMenuItem.Create(self);
  MI.Parent := mnuWindows;
  MI.Text := NewDoc.FileName;
  MI.TagObject := NewDoc;
  MI.OnClick := DoGoToDocAction;
  mnuWindows.Visible := RefreshMenuItemsVisibility(mnuWindows, true);

  CurrentDocument := NewDoc;
end;

procedure T__MainFormAncestor.DoDocumentOpenAction(Sender: TObject);
begin
  // TODO -oDeveloppeurPascal : choisir un fichier
  // TODO -oDeveloppeurPascal : ajouter une option de menu dans les "Windows" pour ce document
  // TODO -oDeveloppeurPascal : ajouter ce document aux fichiers récents
end;

procedure T__MainFormAncestor.DoDocumentSaveAction(Sender: TObject);
begin
  if FCurrentDocument.FileName.IsEmpty then
    DoDocumentSaveAsAction(Sender)
  else
    FCurrentDocument.SaveToFile;
end;

procedure T__MainFormAncestor.DoDocumentSaveAsAction(Sender: TObject);
var
  i: integer;
begin
  // TODO -oDeveloppeurPascal : choisir le dossier et nom de fichier de stockage
  // TODO -oDeveloppeurPascal : faire l'enregistrement du fichier
  // TODO -oDeveloppeurPascal : ajouter le nouveau nom/chemin aux fichiers récents

  for i := 0 to mnuWindows.ItemsCount - 1 do
    if (FCurrentDocument = mnuWindows.Items[i].TagObject) then
    begin
      mnuWindows.Items[i].Text := FCurrentDocument.FileName;
      break;
    end;

  TAboutBox.Current.OlfAboutDialog1.MainFormCaptionPrefix :=
    FCurrentDocument.FileName + ' - ';
end;

function T__MainFormAncestor.DoGetLanguageName(const ISOCode: string): string;
begin
  // Do nothing at this level
  result := '';
end;

procedure T__MainFormAncestor.DoGoToDocAction(Sender: TObject);
begin
  if assigned(Sender) and (Sender is TMenuItem) and
    assigned((Sender as TMenuItem).TagObject) and
    ((Sender as TMenuItem).TagObject is TDocumentAncestor) then
    CurrentDocument := (Sender as TMenuItem).TagObject as TDocumentAncestor;
end;

procedure T__MainFormAncestor.DoLanguageChangeAction(Sender: TObject);
var
  f: TfrmToolsLanguagesDialog;
begin
  f := TfrmToolsLanguagesDialog.Create(self);
  if assigned(onGetLanguageName) then
    f.onGetLanguageName := onGetLanguageName
  else
    f.onGetLanguageName := DoGetLanguageName;
{$IF Defined(IOS) or Defined(ANDROID)}
  f.show;
{$ELSE}
  try
    f.ShowModal;
  finally
    f.free;
  end;
{$ENDIF}
end;

procedure T__MainFormAncestor.DoOpenPreviousAction(Sender: TObject);
var
  NewDoc: TDocumentAncestor;
begin
  if assigned(Sender) and (Sender is TMenuItem) and
    (not(Sender as TMenuItem).TagString.IsEmpty) and
    TFile.Exists((Sender as TMenuItem).TagString) then
  begin
    // TODO -oDeveloppeurPascal : check if this file is already opened and go to it
    NewDoc := GetNewDoc;
    NewDoc.LoadFromFile((Sender as TMenuItem).TagString);
    CurrentDocument := NewDoc;
  end;
end;

procedure T__MainFormAncestor.DoQuitAction(Sender: TObject);
begin
  close;
end;

procedure T__MainFormAncestor.DoRecentDocumentsOptionsAction(Sender: TObject);
begin
  // TODO -oDeveloppeurPascal : à compléter
end;

procedure T__MainFormAncestor.DoRegisterALicense(Sender: TObject);
var
  f: TfrmCilTsegRegisterOrShowLicense;
begin
  f := TfrmCilTsegRegisterOrShowLicense.Create(self);
  try
{$IF Defined(IOS) or Defined(ANDROID)}
    f.show;
{$ELSE}
    f.ShowModal;
{$ENDIF}
  finally
    f.free;
  end;
end;

procedure T__MainFormAncestor.DoSaveAllAction(Sender: TObject);
begin
  // TODO -oDeveloppeurPascal : boucler sur tous les documents ouvert et enregistrer ceux qui ne le sont pas
end;

procedure T__MainFormAncestor.DoStyleChangeAction(Sender: TObject);
var
  f: TfrmToolsStylesDialog;
begin
  f := TfrmToolsStylesDialog.Create(self);
{$IF Defined(IOS) or Defined(ANDROID)}
  f.show;
{$ELSE}
  try
    f.ShowModal;
  finally
    f.free;
  end;
{$ENDIF}
end;

procedure T__MainFormAncestor.DoSupportAction(Sender: TObject);
begin
  if not CSupportURL.IsEmpty then
    url_Open_In_Browser(CSupportURL)
  else
    raise Exception.Create('Missing support website URL.');
end;

procedure T__MainFormAncestor.FormClose(Sender: TObject;
var Action: TCloseAction);
begin
  DoCloseAllAction(Sender);
end;

procedure T__MainFormAncestor.FormCloseQuery(Sender: TObject;
var CanClose: Boolean);
begin
  // TODO -oDeveloppeurPascal : tester si des documents sont ouverts et non enregistrés
end;

procedure T__MainFormAncestor.FormShow(Sender: TObject);
begin
  DoCheckLicenseOnStartup(Sender);
end;

function T__MainFormAncestor.GetNewDoc: TDocumentAncestor;
begin
{$IFDEF RELEASE}
  raise Exception.Create
    ('Don''t call ancestor GetNewDoc, override it with your own document class descendant !');
{$ELSE}
  result := TDocumentAncestor.Create;
{$ENDIF}
end;

function T__MainFormAncestor.RefreshMenuItemsVisibility(const MenuItem
  : TMenuItem; const FirstLevel: Boolean): Boolean;
var
  i: integer;
begin
{$IF Defined(IOS) or Defined(ANDROID)}
  exit;
{$ENDIF}
  if assigned(MenuItem) then
  begin
    if (MenuItem.ItemsCount > 0) then
    begin
      result := false;
      for i := 0 to MenuItem.ItemsCount - 1 do
      begin
        MenuItem.Items[i].Visible := MenuItem.Items[i].Visible and
          RefreshMenuItemsVisibility(MenuItem.Items[i], false);
        result := result or MenuItem.Items[i].Visible;
      end;
    end
    else
      result := not FirstLevel;
  end
  else
    result := false;
end;

procedure T__MainFormAncestor.SetCurrentDocument(const Value
  : TDocumentAncestor);
var
  NewDoc: TDocumentAncestor;
  i: integer;
begin
  if (FCurrentDocument <> Value) then
  begin
    if assigned(FCurrentDocument) and (CDocumentsMode <> TDocumentsMode.Multi)
    then
    begin
      NewDoc := Value;
      DoDocumentCloseAction(nil,
        procedure
        begin
          CurrentDocument := NewDoc;
        end);
    end
    else
    begin
      if assigned(FCurrentDocument) then
      begin
        for i := 0 to mnuWindows.ItemsCount - 1 do
          if (mnuWindows.Items[i].IsChecked) and
            (FCurrentDocument = mnuWindows.Items[i].TagObject) then
          begin
            mnuWindows.Items[i].IsChecked := false;
            break;
          end;
      end;

      FCurrentDocument := Value;
      if assigned(FCurrentDocument) then
      begin
        if FCurrentDocument.HasChanged then
          TAboutBox.Current.OlfAboutDialog1.MainFormCaptionPrefix :=
            FCurrentDocument.FileName + '(*) - '
        else
          TAboutBox.Current.OlfAboutDialog1.MainFormCaptionPrefix :=
            FCurrentDocument.FileName + ' - ';
        for i := 0 to mnuWindows.ItemsCount - 1 do
          if (FCurrentDocument = mnuWindows.Items[i].TagObject) then
          begin
            mnuWindows.Items[i].IsChecked := true;
            break;
          end;
      end
      else
        TAboutBox.Current.OlfAboutDialog1.MainFormCaptionPrefix := '';

      TCurrentDocumentChangedMessage.Broadcast(FCurrentDocument);
    end;
  end;
end;

procedure T__MainFormAncestor.SetOnAboutBoxTranslateTexts
  (const Value: TOnAboutBoxTranslateTexts);
begin
  FOnAboutBoxTranslateTexts := Value;
end;

procedure T__MainFormAncestor.SetonGetLanguageName
  (const Value: TOnGetLanguageName);
begin
  FonGetLanguageName := Value;
end;

procedure T__MainFormAncestor.TranslateTexts(const Language: string);
begin
  inherited;
  if Language = 'fr' then
  begin
{$IF Defined(IOS) or Defined(ANDROID)}
{$ELSE}
    mnuFile.Text := 'Fichier';
    mnuFileOpenPrevious.Text := 'Open recent';
    mnuDocument.Text := 'Projet';
{$IFDEF MACOS}
    mnuTools.Text := 'Réglages';
{$ELSE}
    mnuTools.Text := 'Outils';
{$ENDIF}
    mnuWindows.Text := 'Fenêtres';
    mnuHelp.Text := 'Aide';
{$ENDIF}
    actQuit.Text := 'Quitter';
    actDocumentOptions.Text := 'Options';
    actLanguageChange.Text := 'Langue';
    actStyleChange.Text := 'Style';
    actToolsOptions.Text := 'Options';
    actAbout.Text := TAboutBox.Current.GetCaption;
    actSupport.Text := 'Aide en ligne';
    actBuyALicense.Text := 'Acheter une licence';
    actRegisterALicense.Text := 'Enregistrer une licence';
    actNewDocument.Text := 'Nouveau';
    actOpenDocument.Text := 'Ouvrir';
    actSaveDocument.Text := 'Enregistrer';
    actSaveDocumentAs.Text := 'Enregistrer sous';
    actSaveAllDocuments.Text := 'Enregistrer tout';
    actCloseDocument.Text := 'Fermer';
    actCloseAllDocuments.Text := 'Fermer tout';
    actRecentFilesOptions.Text := 'Options';
    actCheckForANewRelease.Text := 'Mettre à jour ' + CAboutTitle;
  end
  else // default language
  begin
{$IF Defined(IOS) or Defined(ANDROID)}
{$ELSE}
    mnuFile.Text := 'File';
    mnuFileOpenPrevious.Text := 'Open ';
    mnuDocument.Text := 'Document';
{$IFDEF MACOS}
    mnuTools.Text := 'Preferences';
{$ELSE}
    mnuTools.Text := 'Tools';
{$ENDIF}
    mnuWindows.Text := 'Windows';
    mnuHelp.Text := 'Help';
{$ENDIF}
    actQuit.Text := 'Quit';
    actDocumentOptions.Text := 'Options';
    actLanguageChange.Text := 'Language';
    actStyleChange.Text := 'Style';
    actToolsOptions.Text := 'Options';
    actAbout.Text := TAboutBox.Current.GetCaption;
    actSupport.Text := 'Online help';
    actBuyALicense.Text := 'Buy a license';
    actRegisterALicense.Text := 'Register a license';
    actNewDocument.Text := 'New';
    actOpenDocument.Text := 'Open';
    actSaveDocument.Text := 'Save';
    actSaveDocumentAs.Text := 'Save as';
    actSaveAllDocuments.Text := 'Save all';
    actCloseDocument.Text := 'Close';
    actCloseAllDocuments.Text := 'Close all';
    actRecentFilesOptions.Text := 'Options';
    actCheckForANewRelease.Text := 'Update ' + CAboutTitle;
  end;
end;

procedure T__MainFormAncestor.RefreshMenuItemsVisibility(const Menu: TMainMenu);
var
  i: integer;
begin
{$IF Defined(IOS) or Defined(ANDROID)}
  exit;
{$ELSE}
{$IFDEF MACOS}
  mnuFileQuit.Visible := false;
  mnuHelpAbout.Parent := mnuMacOS;
  mnuTools.Parent := mnuMacOS;
{$ENDIF}
  mnuToolsLanguage.Visible := CShowToolsLanguagesMenuItem;
  mnuToolsStyle.Visible := CShowToolsStylesMenuItem;
  mnuToolsOptions.Visible := CShowToolsOptionsMenuItem;
  mnuDocumentOptions.Visible := CShowDocumentOptionsMenuItem;
  mnuHelpSupport.Visible := CShowHelpSupportMenuItem;
  mnuHelpBuyALicense.Visible := (not CSoftwareBuyURL.IsEmpty) and
    tconfig.Current.LicenseNumber.IsEmpty;
  mnuHelpRegisterALicense.Visible := CNeedALicenseNumber and
    tconfig.Current.LicenseNumber.IsEmpty;
  mnuHelpCheckForANewRelease.Visible := CShowHelpCheckForANewReleaseMenuItem;

  mnuFileNew.Visible := CShowDocumentsMenuItems;
  mnuFileOpen.Visible := CShowDocumentsMenuItems;
  mnuFileOpenPrevious.Visible := CShowDocumentsMenuItems and
    CShowOpenPreviousDocumentMenuItem;
  mnuFileOpenPreviousOptions.Visible := mnuFileOpenPrevious.Visible and
    CShowOpenPreviousDocumentOptions;
  mnuFileOpenPreviousSeparator.Visible := mnuFileOpenPreviousOptions.Visible;
  mnuFileSave.Visible := CShowDocumentsMenuItems;
  mnuFileSaveAs.Visible := CShowDocumentsMenuItems;
  mnuFileSaveAll.Visible := CShowDocumentsMenuItems and
    (CDocumentsMode = TDocumentsMode.Multi);
  mnuFileClose.Visible := CShowDocumentsMenuItems;
  mnuFileCloseAll.Visible := CShowDocumentsMenuItems and
    (CDocumentsMode = TDocumentsMode.Multi);
  mnuWindows.Visible := CShowHelpSupportMenuItem and
    (CDocumentsMode = TDocumentsMode.Multi);

  if assigned(Menu) and (Menu.ItemsCount > 0) then
    for i := 0 to Menu.ItemsCount - 1 do
      if (Menu.Items[i] is TMenuItem) then
        (Menu.Items[i] as TMenuItem).Visible :=
          RefreshMenuItemsVisibility((Menu.Items[i] as TMenuItem), true);
{$ENDIF}
end;

initialization

TDialogService.PreferredMode := TDialogService.TPreferredMode.Async;

end.
