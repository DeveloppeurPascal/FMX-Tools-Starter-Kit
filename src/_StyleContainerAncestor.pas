unit _StyleContainerAncestor;

interface

uses
  System.SysUtils,
  System.Classes,
  FMX.Types,
  FMX.Controls,
  uStyleManager;

type
  T__StyleContainerAncestor = class(TDataModule)
    StyleBook1: TStyleBook;
  private
  public
    class procedure Initialize; virtual;
    class function GetStyleName: string; virtual; abstract;
    class function GetStyleType: TProjectStyleType; virtual; abstract;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses
  System.Messaging,
  FMX.Styles;

{$R *.dfm}
{ T__StyleContainerAncestor }

class procedure T__StyleContainerAncestor.Initialize;
begin
  TProjectStyle.Current.Register(GetStyleName, GetStyleType);

  TMessageManager.DefaultManager.SubscribeToMessage(TProjectStyleChangeMessage,
    procedure(const Sender: TObject; const M: TMessage)
    var
      dm: T__StyleContainerAncestor;
    begin
      if (M is TProjectStyleChangeMessage) and
        ((M as TProjectStyleChangeMessage).Value.ToLower = GetStyleName.ToLower)
      then
      begin
        dm := Create(nil);
        try
{$IFDEF MACOS}
          TStyleManager.SetStyle(dm.StyleBook1.Style.clone(dm));
{$ELSE}
          TStyleManager.SetStyle(dm.StyleBook1.Style.clone(nil));
{$ENDIF}
        finally
          dm.free;
        end;
      end;
    end);
end;

initialization

// Call the Initialize method in your styles containers initialization blocs.
// TStyleContainerClass.Initialize;

end.
