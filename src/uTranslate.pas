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
  File last update : 2025-02-09T11:13:00.513+01:00
  Signature : 8fcd58b86ba870a6339f356125cbfba96e9ac6ac
  ***************************************************************************
*)

unit uTranslate;

interface

// If you want to be able to update the template files in your project,
// we recommend that you don't modify this file. Its operation should support
// all standard use cases. Save the file in your project and work on the copy.
// In this case, we suggest you open a ticket on the code repository to explain
// your needs and the changes to be made to the template.

uses
  System.Messaging;

type
  TTranslateTextsMessage = class(TMessage)
  private
    FLanguage: string;
  protected
  public
    property Language: string read FLanguage;
    constructor Create(const ALanguage: string);
    /// <summary>
    /// Use this method to translate all texts in your project
    /// </summary>
    class procedure Broadcast(const ALanguage: string);
  end;

implementation

uses
  System.SysUtils,
  System.Classes,
  uConfig;

{ TTranslateTextsMessage }

class procedure TTranslateTextsMessage.Broadcast(const ALanguage: string);
var
  LLanguage: string;
begin
  LLanguage := ALanguage;
  tthread.Queue(nil,
    procedure
    begin
      TMessageManager.DefaultManager.SendMessage(nil,
        TTranslateTextsMessage.Create(LLanguage));
    end);
end;

constructor TTranslateTextsMessage.Create(const ALanguage: string);
begin
  inherited Create;
  FLanguage := ALanguage.ToLower;
  if FLanguage.IsEmpty then
    FLanguage := tconfig.Current.Language;
end;

procedure init;
begin
  TTranslateTextsMessage.Broadcast(tconfig.Current.Language);
end;

initialization

// I know, it's ugly, but with this I'm sure to execute the init after all
// "ForceQueue()" sent during program initialization, after the program has
// started and shown it's window.

tthread.ForceQueue(nil,
  procedure
  begin
    tthread.ForceQueue(nil,
      procedure
      begin
        init;
      end);
  end);

end.
