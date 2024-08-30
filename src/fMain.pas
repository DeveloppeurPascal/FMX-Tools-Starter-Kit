/// <summary>
/// ***************************************************************************
///
/// FMX Tools Starter Kit
///
/// Copyright 2024 Patrick Prémartin under AGPL 3.0 license.
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
/// File last update : 2024-08-28T12:20:14.000+02:00
/// Signature : ea74cbf6fa47a481bac17dd2c72450440784751f
/// ***************************************************************************
/// </summary>

unit fMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  _TFormAncestor;

type
  TfrmMainAncestor = class(T__TFormAncestor)
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frmMainAncestor: TfrmMainAncestor;

implementation

{$R *.fmx}

end.
