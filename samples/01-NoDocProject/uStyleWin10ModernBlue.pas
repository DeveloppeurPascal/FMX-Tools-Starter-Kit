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
  Signature : d54de1b40bef1e68b418a60783698466f8ebdd6b
  ***************************************************************************
*)

unit uStyleWin10ModernBlue;

interface

uses
  System.SysUtils,
  System.Classes,
  _StyleContainerAncestor,
  FMX.Types,
  FMX.Controls,
  uStyleManager;

type
  TdmStyleWin10ModernBlue = class(T__StyleContainerAncestor)
  private
  public
    class function GetStyleName: string; override;
    class function GetStyleType: TProjectStyleType; override;
  end;

var
  dmStyleWin10ModernBlue: TdmStyleWin10ModernBlue;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TdmStyleWin10ModernBlue }

class function TdmStyleWin10ModernBlue.GetStyleName: string;
begin
  result := 'Windows 10 Modern Blue';
end;

class function TdmStyleWin10ModernBlue.GetStyleType: TProjectStyleType;
begin
  result := TProjectStyleType.other;
end;

initialization

TdmStyleWin10ModernBlue.RegisterStyle;

end.
