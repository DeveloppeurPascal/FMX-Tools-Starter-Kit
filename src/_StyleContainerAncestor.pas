/// <summary>
/// ***************************************************************************
///
/// FMX Tools Starter Kit
///
/// Copyright 2024-2025 Patrick Prémartin under AGPL 3.0 license.
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
/// File last update : 2025-04-03T18:26:50.000+02:00
/// Signature : c15bbf26e82f58f50c64bae91c4eb2805f7099e5
/// ***************************************************************************
/// </summary>

unit _StyleContainerAncestor;

interface

uses
  System.SysUtils,
  System.Classes,
  FMX.Types,
  FMX.Controls,
  uStyleManager,
  System.Messaging;

type
  /// <summary>
  /// Ancestor class of your styles containers.
  /// </summary>
  /// <remarks>
  /// In your projects create a class descendant for each style you want to add
  /// to your project. Overload GetStyleName and GetStyleType functions and add
  /// a call to TStyleContainerClass.Initialize in the initialization bloc of
  /// your unit.
  /// </remarks>
  T__StyleContainerAncestor = class(TDataModule)
    StyleBook1: TStyleBook;
  private
    class procedure ReceivedProjectStyleChangeMessage(const Sender: TObject;
      const M: TMessage);
  public
    /// <summary>
    /// Register this style in the starter kit styles manager if current platform is available.
    /// </summary>
    class procedure Initialize; virtual;
    /// <summary>
    /// Returns the name of this style. This name could to be shown to end users.
    /// </summary>
    class function GetStyleName: string; virtual; abstract;
    /// <summary>
    /// Returns the type (dark, light, other) of this style. It's used in the default style selection form.
    /// </summary>
    class function GetStyleType: TProjectStyleType; virtual; abstract;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses
  FMX.Styles;

{$R *.dfm}

class procedure T__StyleContainerAncestor.Initialize;
var
  OS: string;
  dm: T__StyleContainerAncestor;
  i: integer;
  Found: boolean;
begin
{$IF Defined(IOS)}
  OS := 'ios';
{$ELSEIF Defined(ANDROID)}
  OS := 'android';
{$ELSEIF Defined(MACOS)}
  OS := 'osx';
{$ELSEIF Defined(MSWINDOWS)}
  OS := 'windows';
{$ELSEIF Defined(LINUX)}
  OS := 'linux';
{$ELSE}
{$MESSAGE FATAL 'OS not supported' }
{$ENDIF}
  Found := false;
  dm := Create(nil);
  try
    for i := 0 to dm.StyleBook1.Styles.Count - 1 do
      if dm.StyleBook1.Styles.items[i].Platform.IsEmpty or
        dm.StyleBook1.Styles.items[i].Platform.Tolower.StartsWith(OS) then
      begin
        Found := true;
        break;
      end;
  finally
    dm.free;
  end;
  if (Found) then
  begin
    TProjectStyle.Current.Register(GetStyleName, GetStyleType);

    TMessageManager.DefaultManager.SubscribeToMessage
      (TProjectStyleChangeMessage, ReceivedProjectStyleChangeMessage);
  end;
end;

class procedure T__StyleContainerAncestor.ReceivedProjectStyleChangeMessage
  (const Sender: TObject; const M: TMessage);
var
  dm: T__StyleContainerAncestor;
  ms: TMemoryStream;
begin
  if (M is TProjectStyleChangeMessage) and
    ((M as TProjectStyleChangeMessage).Value.Tolower = GetStyleName.Tolower)
  then
  begin
    dm := Create(nil);
    try
      ms := TMemoryStream.Create;
      try
        TStyleStreaming.SaveToStream(dm.StyleBook1.Style, ms);
        ms.position := 0;
        TStyleManager.SetStyle(TStyleStreaming.LoadFromStream(ms));
      finally
        ms.free;
      end;
    finally
      dm.free;
    end;
  end;
end;

end.
