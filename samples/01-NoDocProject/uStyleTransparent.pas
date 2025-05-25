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
  File last update : 2025-05-24T20:07:17.052+02:00
  Signature : c563f6790c1ad28aee101d8eecdb250ecff90912
  ***************************************************************************
*)

unit uStyleTransparent;

interface

uses
  System.SysUtils,
  System.Classes,
  _StyleContainerAncestor,
  FMX.Types,
  FMX.Controls,
  uStyleManager;

type
  TdmStyleTransparent = class(T__StyleContainerAncestor)
  private
  public
    class function GetStyleName: string; override;
    class function GetStyleType: TProjectStyleType; override;
  end;

var
  dmStyleTransparent: TdmStyleTransparent;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TdmStyleTransparent }

class function TdmStyleTransparent.GetStyleName: string;
begin
  result := 'Transparent';
end;

class function TdmStyleTransparent.GetStyleType: TProjectStyleType;
begin
  result := TProjectStyleType.dark;
end;

initialization

TdmStyleTransparent.RegisterStyle;

end.
