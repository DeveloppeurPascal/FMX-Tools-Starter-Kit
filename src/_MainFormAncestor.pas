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
/// File last update : 2024-08-30T13:33:08.000+02:00
/// Signature : b553ee82ed8d79b7369017e9e6d28775c1bab4e7
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
    MainMenu1: TMainMenu;
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
    ActionList1: TActionList;
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
  uStyleManager;

procedure T__MainFormAncestor.actAboutExecute(Sender: TObject);
begin
  TAboutBox.Current.ShowModal;
end;

procedure T__MainFormAncestor.actLanguageChangeExecute(Sender: TObject);
begin
  // TODO -oDeveloppeurPascal : à compléter
  raise exception.Create('Not implemented.');
end;

procedure T__MainFormAncestor.actProjectOptionsExecute(Sender: TObject);
begin
  // Nothing to do here, fill it in your main form descendant
  raise exception.Create('Not implemented in the starter kit.');
end;

procedure T__MainFormAncestor.actQuitExecute(Sender: TObject);
begin
  Close;
end;

procedure T__MainFormAncestor.actStyleChangeExecute(Sender: TObject);
begin
  // TODO -oDeveloppeurPascal : à compléter
  raise exception.Create('Not implemented.');
end;

procedure T__MainFormAncestor.actSupportExecute(Sender: TObject);
begin
  if not CSupportURL.IsEmpty then
    url_Open_In_Browser(CSupportURL)
  else
    raise exception.Create('Missing support website URL.');
end;

procedure T__MainFormAncestor.actToolsOptionsExecute(Sender: TObject);
begin
  // TODO -oDeveloppeurPascal : à compléter
  raise exception.Create('Not implemented.');
end;

procedure T__MainFormAncestor.AfterConstruction;
begin
  inherited;
{$IFDEF MACOS}
  mnuFileQuit.Visible := false;
  mnuHelpAbout.parent := mnuMacOS;
{$ENDIF}
  mnuToolsLanguage.Visible := CShowToolsLanguagesMenuItem;
  mnuToolsStyle.Visible := CShowToolsStylesMenuItem;
  mnuToolsOptions.Visible := CShowToolsOptionsMenuItem;
  mnuProjectOptions.Visible := CShowProjectOptionsMenuItem;
  mnuHelpSupport.Visible := CShowHelpSupportMenuItem;
  RefreshMenuItemsVisibility(MainMenu1);

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

function T__MainFormAncestor.RefreshMenuItemsVisibility(const MenuItem
  : TMenuItem; const FirstLevel: boolean): boolean;
var
  i: integer;
begin
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
  mnuFile.Text := 'File';
  actQuit.Text := 'Quit';
  mnuProject.Text := 'Project';
  actProjectOptions.Text := 'Options';
  mnuTools.Text := 'Tools';
  actLanguageChange.Text := 'Language';
  actStyleChange.Text := 'Style';
  actToolsOptions.Text := 'Options';
  mnuHelp.Text := 'Help';
  actAbout.Text := TAboutBox.Current.GetCaption;
  actSupport.Text := 'Support site';
end;

procedure T__MainFormAncestor.RefreshMenuItemsVisibility(const Menu: TMainMenu);
var
  i: integer;
begin
  if assigned(Menu) and (Menu.ItemsCount > 0) then
    for i := 0 to Menu.ItemsCount - 1 do
      if (Menu.Items[i] is TMenuItem) then
        (Menu.Items[i] as TMenuItem).Visible :=
          RefreshMenuItemsVisibility((Menu.Items[i] as TMenuItem), true);
end;

end.
