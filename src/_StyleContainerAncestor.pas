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
/// File last update : 2024-08-30T12:53:20.000+02:00
/// Signature : ef881bc05fbd8f9d52adb7f3d4b747ae0630c4bf
/// ***************************************************************************
/// </summary>

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
