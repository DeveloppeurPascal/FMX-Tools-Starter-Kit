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
  File last update : 2025-07-14T16:40:20.000+02:00
  Signature : 11ffbde370ffe0314273a9b7f531101aac4f9d6f
  ***************************************************************************
*)

unit uStyleGoldenGraphite;

interface

uses
  System.SysUtils,
  System.Classes,
  _StyleContainerAncestor,
  FMX.Types,
  FMX.Controls,
  uStyleManager;

type
  TdmStyleGoldenGraphite = class(T__StyleContainerAncestor)
  private
  public
    class function GetStyleName: string; override;
    class function GetStyleType: TProjectStyleType; override;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TdmStyleGoldenGraphite }

class function TdmStyleGoldenGraphite.GetStyleName: string;
begin
  result := 'Golden Graphite';
end;

class function TdmStyleGoldenGraphite.GetStyleType: TProjectStyleType;
begin
  result := TProjectStyleType.other;
end;

initialization

TdmStyleGoldenGraphite.RegisterStyle;

end.
