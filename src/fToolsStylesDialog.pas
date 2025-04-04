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
/// File last update : 2025-04-04T11:18:28.000+02:00
/// Signature : d95155e74e36972c817d35941c7f36b4d1a6c4fe
/// ***************************************************************************
/// </summary>

unit fToolsStylesDialog;

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
  FMX.Layouts,
  FMX.Controls.Presentation;

type
  TfrmToolsStylesDialog = class(T__TFormAncestor)
    VertScrollBox1: TVertScrollBox;
    GridPanelLayout1: TGridPanelLayout;
    btnOk: TButton;
    btnCancel: TButton;
    cbSystemStyle: TCheckBox;
    cbCustomStyle: TCheckBox;
    lCustomStyle: TLayout;
    lSystemStyle: TLayout;
    lCSLight: TFlowLayout;
    lCSDark: TFlowLayout;
    lCSOthers: TFlowLayout;
    lblCSLight: TLabel;
    lblCSDark: TLabel;
    lblCSOthers: TLabel;
    FlowLayoutBreak1: TFlowLayoutBreak;
    FlowLayoutBreak2: TFlowLayoutBreak;
    FlowLayoutBreak3: TFlowLayoutBreak;
    lSSLight: TFlowLayout;
    lSSDark: TFlowLayout;
    lblSSDark: TLabel;
    lblSSLight: TLabel;
    FlowLayoutBreak4: TFlowLayoutBreak;
    FlowLayoutBreak5: TFlowLayoutBreak;
    procedure cbCustomStyleChange(Sender: TObject);
    procedure cbSystemStyleChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    FCustomStyleName: string;
    FSystemDarkStyleName: string;
    FSystemLightStyleName: string;
    procedure SetCustomStyleName(const Value: string);
    procedure SetSystemDarkStyleName(const Value: string);
    procedure SetSystemLightStyleName(const Value: string);
  protected
    procedure AddStylesToFlow(const Styles: TStringDynArray;
      const FlowLayout: TFlowLayout; const GroupIndex: integer;
      const CurrentStyle: string);
    procedure ResizeLayout(const Layout: TControl);
    procedure StyleChecked(Sender: TObject);
  public
    property CustomStyleName: string read FCustomStyleName
      write SetCustomStyleName;
    property SystemDarkStyleName: string read FSystemDarkStyleName
      write SetSystemDarkStyleName;
    property SystemLightStyleName: string read FSystemLightStyleName
      write SetSystemLightStyleName;
    procedure TranslateTexts(const Language: string); override;
  end;

implementation

{$R *.fmx}

uses
  uStyleManager,
  uConfig,
  uConsts,
  uStyleManagerHelpers;

procedure TfrmToolsStylesDialog.AddStylesToFlow(const Styles: TStringDynArray;
  const FlowLayout: TFlowLayout; const GroupIndex: integer;
  const CurrentStyle: string);
var
  cb: TCheckBox;
  i: integer;
begin
  if length(Styles) < 1 then
    FlowLayout.Visible := false
  else
  begin
    FlowLayout.Visible := true;

    for i := 0 to length(Styles) - 1 do
    begin
      cb := TCheckBox.Create(self);
      cb.Parent := FlowLayout;
      cb.Text := Styles[i];
      cb.tag := GroupIndex;
      cb.Margins.top := 5;
      cb.Margins.Left := 5;
      cb.OnChange := StyleChecked;
      cb.IsChecked := (CurrentStyle.ToLower = Styles[i].ToLower);
    end;

    ResizeLayout(FlowLayout);
  end;
end;

procedure TfrmToolsStylesDialog.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmToolsStylesDialog.btnOkClick(Sender: TObject);
begin
  // TODO : -oDeveloppeurPascal : add a BeginUpdate/EndUpdate on TConfig to call the SAVE only once
  if not SystemLightStyleName.IsEmpty then
    tconfig.Current.LightStyleName := SystemLightStyleName;
  if not SystemDarkStyleName.IsEmpty then
    tconfig.Current.DarkStyleName := SystemDarkStyleName;
  if not CustomStyleName.IsEmpty then
    tconfig.Current.CustomStyleName := CustomStyleName;
  if cbCustomStyle.IsChecked then
    tconfig.Current.StyleMode := TStyleMode.Custom
  else
    tconfig.Current.StyleMode := TStyleMode.System;

  TProjectStyle.Current.EnableDefaultStyle;

  Close;
end;

procedure TfrmToolsStylesDialog.cbCustomStyleChange(Sender: TObject);
begin
  if cbCustomStyle.IsChecked = cbSystemStyle.IsChecked then
    cbSystemStyle.IsChecked := not cbCustomStyle.IsChecked;

  lCustomStyle.Visible := cbCustomStyle.IsChecked;

  if lCustomStyle.Visible then
  begin
    ResizeLayout(lCSLight);
    ResizeLayout(lCSDark);
    ResizeLayout(lCSOthers);
    ResizeLayout(lCustomStyle);
  end;
end;

procedure TfrmToolsStylesDialog.cbSystemStyleChange(Sender: TObject);
begin
  if cbSystemStyle.IsChecked = cbCustomStyle.IsChecked then
    cbCustomStyle.IsChecked := not cbSystemStyle.IsChecked;

  lSystemStyle.Visible := cbSystemStyle.IsChecked;

  if lSystemStyle.Visible then
  begin
    ResizeLayout(lSSLight);
    ResizeLayout(lSSDark);
    ResizeLayout(lSystemStyle);
  end;
end;

procedure TfrmToolsStylesDialog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
{$IF Defined(IOS) or Defined(ANDROID)}
  tthread.ForceQueue(nil,
    procedure
    begin
      self.free;
    end);
{$ENDIF}
end;

procedure TfrmToolsStylesDialog.FormCreate(Sender: TObject);
var
  Styles: TStringDynArray;
begin
  Styles := TProjectStyle.Current.GetStyles(tprojectstyletype.light);
  AddStylesToFlow(Styles, lCSLight, 1, tconfig.Current.CustomStyleName);
  AddStylesToFlow(Styles, lSSLight, 2, tconfig.Current.LightStyleName);
  Styles := TProjectStyle.Current.GetStyles(tprojectstyletype.dark);
  AddStylesToFlow(Styles, lCSDark, 1, tconfig.Current.CustomStyleName);
  AddStylesToFlow(Styles, lSSDark, 3, tconfig.Current.DarkStyleName);
  Styles := TProjectStyle.Current.GetStyles(tprojectstyletype.other);
  AddStylesToFlow(Styles, lCSOthers, 1, tconfig.Current.CustomStyleName);

  ResizeLayout(lCustomStyle);
  ResizeLayout(lSystemStyle);

  cbSystemStyle.IsChecked := tconfig.Current.StyleMode = TStyleMode.System;
  cbSystemStyleChange(cbSystemStyle);
  cbCustomStyle.IsChecked := not cbSystemStyle.IsChecked;
  cbCustomStyleChange(cbCustomStyle);
end;

procedure TfrmToolsStylesDialog.FormResize(Sender: TObject);
begin
  ResizeLayout(lCSLight);
  ResizeLayout(lCSDark);
  ResizeLayout(lCSOthers);
  ResizeLayout(lCustomStyle);
  ResizeLayout(lSSLight);
  ResizeLayout(lSSDark);
  ResizeLayout(lSystemStyle);
end;

procedure TfrmToolsStylesDialog.ResizeLayout(const Layout: TControl);
var
  h1, h2: single;
  i: integer;
  c: TControl;
begin
  h1 := 0;
  h2 := 0;
  for i := 0 to Layout.ControlsCount - 1 do
  begin
    c := Layout.Controls[i];
    if c.Visible then
    begin
      h2 := c.Position.y + c.Height + c.Margins.Bottom;
      if h1 < h2 then
        h1 := h2;
    end;
  end;
  Layout.Height := h2;
end;

procedure TfrmToolsStylesDialog.SetCustomStyleName(const Value: string);
begin
  FCustomStyleName := Value;
end;

procedure TfrmToolsStylesDialog.SetSystemDarkStyleName(const Value: string);
begin
  FSystemDarkStyleName := Value;
end;

procedure TfrmToolsStylesDialog.SetSystemLightStyleName(const Value: string);
begin
  FSystemLightStyleName := Value;
end;

procedure TfrmToolsStylesDialog.StyleChecked(Sender: TObject);
var
  cb: TCheckBox;
  i: integer;
begin
  if Sender is TCheckBox then
  begin
    cb := Sender as TCheckBox;
    if cb.IsChecked then
    begin
      for i := 0 to ComponentCount - 1 do
        if (Components[i] <> cb) and (Components[i] is TCheckBox) and
          ((Components[i] as TCheckBox).tag = cb.tag) then
          (Components[i] as TCheckBox).IsChecked := false;
      case cb.tag of
        1: // Custom Style
          CustomStyleName := cb.Text;
        2: // System light style
          SystemLightStyleName := cb.Text;
        3: // System dark style
          SystemDarkStyleName := cb.Text;
      else
        raise Exception.Create('Unknow style group.');
      end;
    end;
  end;
end;

procedure TfrmToolsStylesDialog.TranslateTexts(const Language: string);
begin
  inherited;
  if Language = 'fr' then
  begin
    caption := 'Choix du style';
    cbSystemStyle.Text := 'Selon le système d''exploitation';
    lblSSLight.Text := 'Thèmes clairs :';
    lblSSDark.Text := 'Thèmes sombres :';
    cbCustomStyle.Text := 'Personnalisé';
    lblCSLight.Text := 'Thèmes clairs :';
    lblCSDark.Text := 'Thèmes sombres :';
    lblCSOthers.Text := 'Autres :';
    btnOk.Text := 'Ok';
    btnCancel.Text := 'Annuler';
  end
  else // default language
  begin
    caption := 'Styles options';
    cbSystemStyle.Text := 'System default';
    lblSSLight.Text := 'Light themes:';
    lblSSDark.Text := 'Dark themes:';
    cbCustomStyle.Text := 'Your choice';
    lblCSLight.Text := 'Light themes:';
    lblCSDark.Text := 'Dark themes:';
    lblCSOthers.Text := 'Other themes:';
    btnOk.Text := 'Ok';
    btnCancel.Text := 'Cancel';
  end;
end;

end.
