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
/// File last update : 2024-09-02T13:55:38.000+02:00
/// Signature : b96f9ca1d67ad14ebc468741e104c59778925933
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
  FMX.Menus;

type
  T__MainFormAncestor = class(T__TFormAncestor)
    MainFormAncestorMenu: TMainMenu;
    mnuMacOS: TMenuItem;
    mnuFile: TMenuItem;
    mnuProject: TMenuItem;
    mnuTools: TMenuItem;
    mnuHelp: TMenuItem;
    mnuFileQuit: TMenuItem;
    mnuProjectOptions: TMenuItem;
    mnuToolsOptions: TMenuItem;
    mnuToolsLanguage: TMenuItem;
    mnuToolsStyle: TMenuItem;
    mnuHelpAbout: TMenuItem;
    mnuHelpSupport: TMenuItem;
    MainFormAncestorActionList: TActionList;
    actQuit: TAction;
    actAbout: TAction;
    actSupport: TAction;
    actProjectOptions: TAction;
    actLanguageChange: TAction;
    actStyleChange: TAction;
    actToolsOptions: TAction;
    procedure actQuitExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actSupportExecute(Sender: TObject);
    procedure actProjectOptionsExecute(Sender: TObject);
    procedure actLanguageChangeExecute(Sender: TObject);
    procedure actStyleChangeExecute(Sender: TObject);
    procedure actToolsOptionsExecute(Sender: TObject);
  private
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
    /// Called by the actProjectOptions action used for Project/Options menu option.
    /// </summary>
    /// <remarks>
    /// Nothing is done by default. Overrire this method if you want to do something.
    /// </remarks>
    procedure DoProjectOptionsAction(Sender: TObject); virtual; abstract;
    /// <summary>
    /// Called by the actLanguages action used for Tools/Languages menu option.
    /// </summary>
    /// <remarks>
    /// Nothing is done by default. Overrire this method if you want to do something.
    /// </remarks>
    procedure DoLanguageChangeAction(Sender: TObject); virtual; abstract;
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
  public
    procedure AfterConstruction; override;
    procedure TranslateTexts(const Language: string); override;
  end;

{$IFDEF DEBUG}

var
  __MainFormAncestor: T__MainFormAncestor;
{$ENDIF}

implementation

{$R *.fmx}

uses
  uDMAboutBox,
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

procedure T__MainFormAncestor.actProjectOptionsExecute(Sender: TObject);
begin
  DoProjectOptionsAction(Sender);
end;

procedure T__MainFormAncestor.actQuitExecute(Sender: TObject);
begin
  DoQuitAction(Sender);
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
  TAboutBox.Current.ShowModal;
end;

procedure T__MainFormAncestor.DoQuitAction(Sender: TObject);
begin
  close;
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

procedure T__MainFormAncestor.TranslateTexts(const Language: string);
begin
  inherited;
{$IF Defined(IOS) or Defined(ANDROID)}
{$ELSE}
  mnuFile.Text := 'File';
  mnuProject.Text := 'Project';
{$IFDEF MACOS}
  if Language = 'fr' then
    mnuTools.Text := 'Réglages'
  else
    mnuTools.Text := 'Preferences';
{$ELSE}
  mnuTools.Text := 'Tools';
{$ENDIF}
  mnuHelp.Text := 'Help';
{$ENDIF}
  actQuit.Text := 'Quit';
  actProjectOptions.Text := 'Options';
  actLanguageChange.Text := 'Language';
  actStyleChange.Text := 'Style';
  actToolsOptions.Text := 'Options';
  actAbout.Text := TAboutBox.Current.GetCaption;
  actSupport.Text := 'Support site';
  // TODO -oDeveloppeurPascal : translate texts
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
  mnuProjectOptions.Visible := CShowProjectOptionsMenuItem;
  mnuHelpSupport.Visible := CShowHelpSupportMenuItem;

  if assigned(Menu) and (Menu.ItemsCount > 0) then
    for i := 0 to Menu.ItemsCount - 1 do
      if (Menu.Items[i] is TMenuItem) then
        (Menu.Items[i] as TMenuItem).Visible :=
          RefreshMenuItemsVisibility((Menu.Items[i] as TMenuItem), true);
{$ENDIF}
end;

end.
