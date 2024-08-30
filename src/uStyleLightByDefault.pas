unit uStyleLightByDefault;

interface

uses
  System.SysUtils,
  System.Classes,
  _StyleContainerAncestor,
  FMX.Types,
  FMX.Controls,
  uStyleManager;

type
  TStyleLightByDefault = class(T__StyleContainerAncestor)
  private
  public
    class function GetStyleName: string; override;
    class function GetStyleType: TProjectStyleType; override;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TStyleLightByDefault }

class function TStyleLightByDefault.GetStyleName: string;
begin
  result := 'Light';
end;

class function TStyleLightByDefault.GetStyleType: TProjectStyleType;
begin
  result := TProjectStyleType.light;
end;

initialization

TStyleLightByDefault.Initialize;

end.
