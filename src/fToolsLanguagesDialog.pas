unit fToolsLanguagesDialog;

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
  FMX.Controls.Presentation,
  FMX.Layouts;

type
  TOnGetLanguageName = function(const ISOCode: string): string of object;

  TfrmToolsLanguagesDialog = class(T__TFormAncestor)
    VertScrollBox1: TVertScrollBox;
    GridPanelLayout1: TGridPanelLayout;
    btnOk: TButton;
    btnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    FOldLanguage: string;
    FonGetLanguageName: TOnGetLanguageName;
    procedure SetonGetLanguageName(const Value: TOnGetLanguageName);
  protected
    procedure ChangeSelectedLanguage(Sender: TObject);
    function getLanguageName(const ISOCode: string): string; virtual;
  public
    property onGetLanguageName: TOnGetLanguageName read FonGetLanguageName
      write SetonGetLanguageName;
    procedure TranslateTexts(const Language: string); override;
  end;

implementation

{$R *.fmx}

uses
  uConsts,
  uConfig;

{ TfrmToolsLanguagesDialog }

procedure TfrmToolsLanguagesDialog.btnCancelClick(Sender: TObject);
begin
  tconfig.Current.Language := FOldLanguage;
  close;
end;

procedure TfrmToolsLanguagesDialog.btnOkClick(Sender: TObject);
begin
  close;
end;

procedure TfrmToolsLanguagesDialog.ChangeSelectedLanguage(Sender: TObject);
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
      tconfig.Current.Language := cb.TagString;
      // Depending on the current style, changing the language call  main form
      // repaint and it goes to the front, the dialog goes to background and
      // the focus is lost.
      // We need to force the z-index.
      BringToFront;
    end;
  end;
end;

procedure TfrmToolsLanguagesDialog.FormCreate(Sender: TObject);
begin
  inherited;
  FOldLanguage := tconfig.Current.Language;
end;

procedure TfrmToolsLanguagesDialog.FormShow(Sender: TObject);
var
  i: integer;
  cb: TCheckBox;
begin
  while VertScrollBox1.Content.ChildrenCount > 0 do
    VertScrollBox1.Content.Children[0].Free;

  for i := 0 to length(GLanguages) - 1 do
  begin
    cb := TCheckBox.Create(self);
    cb.Parent := VertScrollBox1;
    cb.tag := 1;
    cb.TagString := GLanguages[i];
    cb.Text := getLanguageName(GLanguages[i]);
    cb.Align := TAlignLayout.top;
    cb.IsChecked := (GLanguages[i] = tconfig.Current.Language);
    cb.OnChange := ChangeSelectedLanguage;
  end;
end;

function TfrmToolsLanguagesDialog.getLanguageName(const ISOCode
  : string): string;
begin
  if assigned(FonGetLanguageName) then
    result := FonGetLanguageName(ISOCode)
  else
    result := '';

  if result.IsEmpty then
    if ISOCode = 'fr' then
      result := 'Fran�ais'
    else if ISOCode = 'en' then
      result := 'English'
    else if ISOCode = 'de' then
      result := 'Deutsch'
    else
      result := ISOCode;
end;

procedure TfrmToolsLanguagesDialog.SetonGetLanguageName
  (const Value: TOnGetLanguageName);
begin
  FonGetLanguageName := Value;
end;

procedure TfrmToolsLanguagesDialog.TranslateTexts(const Language: string);
begin
  inherited;
  if Language = 'fr' then
  begin
    caption := 'Choix de la langue';
    btnOk.Text := 'Ok';
    btnCancel.Text := 'Annuler';
  end
  else // Default language
  begin
    caption := 'Languages options';
    btnOk.Text := 'Ok';
    btnCancel.Text := 'Cancel';
  end;
end;

end.