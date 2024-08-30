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
  FMX.Controls.Presentation;

type
  TfrmMain = class(T__MainFormAncestor)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
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
  TProjectStyle.Current.StyleName:='impressive dark';
//    TProjectStyle.Current.StyleName:='dark';
end;

end.
