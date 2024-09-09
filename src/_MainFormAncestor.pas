/// <summary>
/// ***************************************************************************
///
/// FMX Tools Starter Kit
///
/// Copyright 2024 Patrick Pr�martin under AGPL 3.0 license.
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
/// File last update : 2024-09-06T11:58:38.000+02:00
/// Signature : a4af3e4df28d33ff8ca5aeb8ff5237afacfe3f13
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
  Olf.FMX.AboutDialogForm;

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
  private
    FonGetLanguageName: TOnGetLanguageName;
    FOnAboutBoxTranslateTexts: TOnAboutBoxTranslateTexts;
    procedure SetonGetLanguageName(const Value: TOnGetLanguageName);
    procedure SetOnAboutBoxTranslateTexts(const Value
      : TOnAboutBoxTranslateTexts);
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
      const FirstLevel: boolean): boolean; overload; virtual;
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
    /// Called by the actDocumentOptions action used for Document/Options menu option.
    /// </summary>
    /// <remarks>
    /// Nothing is done by default. Overrire this method if you want to do something.
    /// </remarks>
    procedure DoDocumentOptionsAction(Sender: TObject); virtual; abstract;
    /// <summary>
    /// Called by the actLanguages action used for Tools/Languages menu option.
    /// </summary>
    /// <remarks>
    /// Nothing is done by default. Overrire this method if you want to do something.
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
    /// Nothing is done by default. Overrire this method if you want to do something.
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
    procedure DoDocumentNewAction(Sender: TObject); virtual;
    procedure DoDocumentOpenAction(Sender: TObject); virtual;
    procedure DoDocumentSaveAction(Sender: TObject); virtual;
    procedure DoDocumentSaveAsAction(Sender: TObject); virtual;
    procedure DoDocumentCloseAction(Sender: TObject); virtual;
    procedure DoSaveAllAction(Sender: TObject); virtual;
    procedure DoOpenPreviousAction(Sender: TObject); virtual;
    procedure DoGoToDocAction(Sender: TObject); virtual;
    procedure DoCloseAllAction(Sender: TObject); virtual;
    procedure DoRecentDocumentsOptionsAction(Sender: TObject); virtual;
  public
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
  fToolsStylesDialog;

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

procedure T__MainFormAncestor.DoCloseAllAction(Sender: TObject);
begin
  // TODO -oDeveloppeurPacal : � compl�ter
end;

procedure T__MainFormAncestor.DoDocumentCloseAction(Sender: TObject);
begin
  // TODO -oDeveloppeurPacal : � compl�ter
end;

procedure T__MainFormAncestor.DoDocumentNewAction(Sender: TObject);
begin
  // TODO -oDeveloppeurPacal : � compl�ter
end;

procedure T__MainFormAncestor.DoDocumentOpenAction(Sender: TObject);
begin
  // TODO -oDeveloppeurPacal : � compl�ter
end;

procedure T__MainFormAncestor.DoDocumentSaveAction(Sender: TObject);
begin
  // TODO -oDeveloppeurPacal : � compl�ter
end;

procedure T__MainFormAncestor.DoDocumentSaveAsAction(Sender: TObject);
begin
  // TODO -oDeveloppeurPacal : � compl�ter
end;

function T__MainFormAncestor.DoGetLanguageName(const ISOCode: string): string;
begin
  // Do nothing at this level
  result := '';
end;

procedure T__MainFormAncestor.DoGoToDocAction(Sender: TObject);
begin
  // TODO -oDeveloppeurPacal : � compl�ter
end;

procedure T__MainFormAncestor.DoLanguageChangeAction(Sender: TObject);
var
  f: TfrmToolsLanguagesDialog;
begin
  f := TfrmToolsLanguagesDialog.create(self);
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
begin
  // TODO -oDeveloppeurPacal : � compl�ter
end;

procedure T__MainFormAncestor.DoQuitAction(Sender: TObject);
begin
  close;
end;

procedure T__MainFormAncestor.DoRecentDocumentsOptionsAction(Sender: TObject);
begin
  // TODO -oDeveloppeurPacal : � compl�ter
end;

procedure T__MainFormAncestor.DoSaveAllAction(Sender: TObject);
begin
  // TODO -oDeveloppeurPacal : � compl�ter
end;

procedure T__MainFormAncestor.DoStyleChangeAction(Sender: TObject);
var
  f: TfrmToolsStylesDialog;
begin
  f := TfrmToolsStylesDialog.create(self);
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
    raise exception.create('Missing support website URL.');
end;

function T__MainFormAncestor.RefreshMenuItemsVisibility(const MenuItem
  : TMenuItem; const FirstLevel: boolean): boolean;
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
    mnuTools.Text := 'R�glages';
{$ELSE}
    mnuTools.Text := 'Outils';
{$ENDIF}
    mnuWindows.Text := 'Fen�tres';
    mnuHelp.Text := 'Aide';
{$ENDIF}
    actQuit.Text := 'Quitter';
    actDocumentOptions.Text := 'Options';
    actLanguageChange.Text := 'Langue';
    actStyleChange.Text := 'Style';
    actToolsOptions.Text := 'Options';
    actAbout.Text := TAboutBox.Current.GetCaption;
    actSupport.Text := 'Aide en ligne';
    actNewDocument.Text := 'Nouveau';
    actOpenDocument.Text := 'Ouvrir';
    actSaveDocument.Text := 'Enregistrer';
    actSaveDocumentAs.Text := 'Enregistrer sous';
    actSaveAllDocuments.Text := 'Enregistrer tout';
    actCloseDocument.Text := 'Fermer';
    actCloseAllDocuments.Text := 'Fermer tout';
    actRecentFilesOptions.Text := 'Options';
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
    actNewDocument.Text := 'New';
    actOpenDocument.Text := 'Open';
    actSaveDocument.Text := 'Save';
    actSaveDocumentAs.Text := 'Save as';
    actSaveAllDocuments.Text := 'Save all';
    actCloseDocument.Text := 'Close';
    actCloseAllDocuments.Text := 'Close all';
    actRecentFilesOptions.Text := 'Options';
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
  mnuHelpAbout.parent := mnuMacOS;
  mnuTools.parent := mnuMacOS;
{$ENDIF}
  mnuToolsLanguage.Visible := CShowToolsLanguagesMenuItem;
  mnuToolsStyle.Visible := CShowToolsStylesMenuItem;
  mnuToolsOptions.Visible := CShowToolsOptionsMenuItem;
  mnuDocumentOptions.Visible := CShowDocumentOptionsMenuItem;
  mnuHelpSupport.Visible := CShowHelpSupportMenuItem;

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

end.
