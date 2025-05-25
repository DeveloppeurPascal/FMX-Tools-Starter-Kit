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
  Signature : 00c2604009a0e64f06c44f2ac59425e4f59f6eba
  ***************************************************************************
*)

unit uTxtAboutLicense;

interface

{$MESSAGE WARN 'Save uTxtAboutDescription.pas in your project folder and customize its content. Don''t change the template version if you want to be able to update it.'}
// TODO : Save uTxtAboutDescription.pas in your project folder and customize its content. Don't change the template version if you want to be able to update it.

function GetTxtAboutLicense(const Language: string;
  const Recursif: boolean = false): string;

implementation

// For the languages codes, please use 2 letters ISO codes
// https://en.wikipedia.org/wiki/List_of_ISO_3166_country_codes

uses
  System.SysUtils,
  uConsts;

const
  // TODO : change About box and (default) credits description text
  // TODO : translate the text if you want or need it (you MUST have your "CDefaultLanguage" in the list)
  CTxtEN = 'your EULA (end user license agreement)';
  // CTxtFR = '';
  // CTxtIT = '';
  // CTxtDE = '';
  // CTxtJP = '';
  // CTxtPT = '';
  // CTxtES = '';

function GetTxtAboutLicense(const Language: string;
  const Recursif: boolean): string;
var
  lng: string;
begin
  lng := Language.tolower;
  if (lng = 'en') then
    result := CTxtEN
    // TODO : add your translations here
    // else if (lng = 'fr') then // France
    // result := CTxtFR
    // else if (lng = 'it') then // Italy
    // result := CTxtIT
    // else if (lng = 'de') then // Germany
    // result := CTxtDE
    // else if (lng = 'jp') then // Japan
    // result := CTxtJP
    // else if (lng = 'pt') then // Portugal
    // result := CTxtPT
    // else if (lng = 'es') then // Spain
    // result := CTxtES
    // etc...
  else if not Recursif then
    result := GetTxtAboutLicense(CDefaultLanguage, true)
  else
    raise Exception.Create('Unknow license for language "' + Language + '".');
end;

end.
