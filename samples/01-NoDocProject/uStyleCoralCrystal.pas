(* C2PP
  ***************************************************************************

  FMX Tools Starter Kit

  Copyright 2024-2025 Patrick Prémartin under AGPL 3.0 license.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  DEALINGS IN THE SOFTWARE.

  ***************************************************************************

  A starter kit for your FireMonkey projects in Delphi.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://fmxtoolsstarterkit.developpeur-pascal.fr/

  Project site :
  https://github.com/DeveloppeurPascal/FMX-Tools-Starter-Kit

  ***************************************************************************
  File last update : 2025-07-14T16:40:16.000+02:00
  Signature : b4259a5416bf369f98a331c04278dfdbe67a6c0e
  ***************************************************************************
*)

unit uStyleCoralCrystal;

interface

uses
  System.SysUtils,
  System.Classes,
  _StyleContainerAncestor,
  FMX.Types,
  FMX.Controls,
  uStyleManager;

type
  TdmStyleCoralCrystal = class(T__StyleContainerAncestor)
  private
  public
    class function GetStyleType: TProjectStyleType; override;
    class function GetStyleName: string; override;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TdmStyleCoralCrystal }

class function TdmStyleCoralCrystal.GetStyleName: string;
begin
  result := 'Coral Crystal';
end;

class function TdmStyleCoralCrystal.GetStyleType: TProjectStyleType;
begin
  result := TProjectStyleType.light;
end;

initialization

TdmStyleCoralCrystal.RegisterStyle;

end.
