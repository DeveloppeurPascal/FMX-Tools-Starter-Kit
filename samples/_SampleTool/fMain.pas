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
/// File last update : 2024-09-06T11:55:38.000+02:00
/// Signature : 6b8100f55d236612694aa62d335cf73498c16159
/// ***************************************************************************
/// </summary>

unit fMain;

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
  _MainFormAncestor,
  System.Actions,
  FMX.ActnList,
  FMX.Menus,
  FMX.Controls.Presentation,
  Olf.FMX.AboutDialogForm;

type
  TfrmMain = class(T__MainFormAncestor)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  protected
    function DoGetLanguageName(const ISOCode: string): string; override;
    function AboutBoxTranslateTexts(const Language: string;
      const TxtID: TOlfAboutDialogTxtID): string;
  public
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses
  uStyleManager;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  showmessage(tprojectstyle.current.stylename);
  tprojectstyle.current.stylename := 'impressive dark';
  // TProjectStyle.Current.StyleName:='dark';
end;

function TfrmMain.AboutBoxTranslateTexts(const Language: string;
  const TxtID: TOlfAboutDialogTxtID): string;
begin
  if TxtID = TOlfAboutDialogTxtID.Version then
    result := 'MyVersion '
  else
    result := '';
end;

function TfrmMain.DoGetLanguageName(const ISOCode: string): string;
begin
  if ISOCode = 'fr' then
    result := 'Français'
  else if ISOCode = 'it' then
    result := 'Italiano';
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  inherited;
  OnAboutBoxTranslateTexts := AboutBoxTranslateTexts;
end;

end.
