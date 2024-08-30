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
/// File last update : 2024-08-28T12:20:14.000+02:00
/// Signature : ea74cbf6fa47a481bac17dd2c72450440784751f
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
  TfrmMainAncestor = class(T__TFormAncestor)
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
    procedure FormCreate(Sender: TObject);
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
  end;

var
  frmMainAncestor: TfrmMainAncestor;

implementation

{$R *.fmx}

uses
  uDMAboutBox,
  u_urlOpen,
  uConsts;

procedure TfrmMainAncestor.actAboutExecute(Sender: TObject);
begin
  TAboutBox.Current.ShowModal;
end;

procedure TfrmMainAncestor.actLanguageChangeExecute(Sender: TObject);
begin
  // TODO -oDeveloppeurPascal : à compléter
  raise exception.Create('Not implemented.');
end;

procedure TfrmMainAncestor.actProjectOptionsExecute(Sender: TObject);
begin
  // Nothing to do here, fill it in your main form descendant
  raise exception.Create('Not implemented in the starter kit.');
end;

procedure TfrmMainAncestor.actQuitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMainAncestor.actStyleChangeExecute(Sender: TObject);
begin
  // TODO -oDeveloppeurPascal : à compléter
  raise exception.Create('Not implemented.');
end;

procedure TfrmMainAncestor.actSupportExecute(Sender: TObject);
begin
  if not CSupportURL.IsEmpty then
    url_Open_In_Browser(CSupportURL)
  else
    raise exception.Create('Missing support website URL.');
end;

procedure TfrmMainAncestor.actToolsOptionsExecute(Sender: TObject);
begin
  // TODO -oDeveloppeurPascal : à compléter
  raise exception.Create('Not implemented.');
end;

procedure TfrmMainAncestor.FormCreate(Sender: TObject);
begin
{$IFDEF MACOS}
  mnuFileQuit.Visible := false;
  mnuHelpAbout.parent := mnuMacOS;
{$ENDIF}
  actAbout.Text := 'About ' + CAboutTitle;
  // TODO -oDeveloppeurPascal : récupérer texte de titre de about box

  RefreshMenuItemsVisibility(MainMenu1);
end;

function TfrmMainAncestor.RefreshMenuItemsVisibility(const MenuItem: TMenuItem;
  const FirstLevel: boolean): boolean;
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

procedure TfrmMainAncestor.RefreshMenuItemsVisibility(const Menu: TMainMenu);
var
  i: integer;
  item: TMenuItem;
begin
  if assigned(Menu) and (Menu.ItemsCount > 0) then
    for i := 0 to Menu.ItemsCount - 1 do
      if (Menu.Items[i] is TMenuItem) then
        (Menu.Items[i] as TMenuItem).Visible :=
          RefreshMenuItemsVisibility((Menu.Items[i] as TMenuItem), true);
end;

end.
