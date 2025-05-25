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
  File last update : 2025-04-04T11:27:12.002+02:00
  Signature : 79acc80df2b16f85e713c64718af239998e15e91
  ***************************************************************************
*)

unit uStyleManagerHelpers;

interface

uses
  uStyleManager;

// TODO -oDeveloppeurPascal : add XML doc comments
type
  TProjectStyleHelpers = class helper for TProjectStyle
  public
    procedure EnableDefaultStyle;
  end;

implementation

uses
  System.SysUtils,
  System.Classes,
  uConfig,
  uConsts,
  Olf.RTL.SystemAppearance;

procedure TProjectStyleHelpers.EnableDefaultStyle;
var
  StyleMode: TStyleMode;
begin
  StyleMode := tconfig.Current.StyleMode;
  if StyleMode = TStyleMode.System then
    if isSystemThemeInLightMode then
      StyleMode := TStyleMode.light
    else if isSystemThemeInDarkMode then
      StyleMode := TStyleMode.dark
    else
      StyleMode := TStyleMode.custom;
  case StyleMode of
    TStyleMode.light:
      StyleName := tconfig.Current.LightStyleName;
    TStyleMode.dark:
      StyleName := tconfig.Current.DarkStyleName;
    TStyleMode.custom:
      StyleName := tconfig.Current.CustomStyleName;
  else
    raise Exception.Create('Unknow style.');
  end;
end;

end.
