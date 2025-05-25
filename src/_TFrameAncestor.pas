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
  File last update : 2025-02-09T11:13:00.495+01:00
  Signature : d98b7c490cdbccfc25af6934ff2e7a23189418c5
  ***************************************************************************
*)

unit _TFrameAncestor;

interface

// If you want to be able to update the template files in your project,
// we recommend that you don't modify this file. Its operation should support
// all standard use cases. Save the file in your project and work on the copy.
// In this case, we suggest you open a ticket on the code repository to explain
// your needs and the changes to be made to the template.
//
// All frames in your project must inherits from this class or its descendants.

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
  System.Messaging;

type
  /// <summary>
  /// Should be used as your TFrame ancestor.
  /// </summary>
  T__TFrameAncestor = class(TFrame)
  private
  protected
    procedure DoTranslateTexts(const Sender: TObject; const Msg: TMessage);
    procedure Hide; override;
    procedure Show; override;
  public
    /// <summary>
    /// This method is called each time a global translation broadcast is sent
    /// with current language as argument.
    /// </summary>
    procedure TranslateTexts(const Language: string); virtual;
  end;

implementation

{$R *.fmx}

uses
  uTranslate,
  uConfig;

{ T__TFrameAncestor }

procedure T__TFrameAncestor.DoTranslateTexts(const Sender: TObject;
  const Msg: TMessage);
begin
  if not assigned(self) then
    exit;

  if assigned(Msg) and (Msg is TTranslateTextsMessage) then
    TranslateTexts((Msg as TTranslateTextsMessage).Language);
end;

procedure T__TFrameAncestor.Hide;
begin
  inherited;
  TMessageManager.DefaultManager.Unsubscribe(TTranslateTextsMessage,
    DoTranslateTexts, true);
end;

procedure T__TFrameAncestor.Show;
begin
  inherited;
  TranslateTexts(tconfig.Current.Language);
  TMessageManager.DefaultManager.SubscribeToMessage(TTranslateTextsMessage,
    DoTranslateTexts);
end;

procedure T__TFrameAncestor.TranslateTexts(const Language: string);
begin
  // nothing to do here at this level
end;

end.
