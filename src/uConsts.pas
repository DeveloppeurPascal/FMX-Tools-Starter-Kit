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
/// File last update : 2024-09-06T10:24:10.000+02:00
/// Signature : b3a32ce29afd8c77bdea6b1be57931833a34bdd9
/// ***************************************************************************
/// </summary>

unit uConsts;

interface

{$MESSAGE WARN 'Save uConsts.pas in your project folder and customize its constants. Don''t change the template version if you want to be able to update it.'}
// TODO : Save uConsts.pas in your project folder and customize its constants. Don't change the template version if you want to be able to update it.

uses
  System.Types;

{$SCOPEDENUMS ON}

const
  /// <summary>
  /// Version number of your project, don't forget to update the
  /// Project/Options/Versions infos before compiling a public RELEASE
  /// </summary>
  CAboutVersionNumber = '0.0';

  /// <summary>
  /// Version date of your project, change it when you publish a new public release
  /// </summary>
  CAboutVersionDate = '20240824';

  /// <summary>
  /// Title of your project used in the About box and as the main form caption
  /// </summary>
  CAboutTitle = 'FMX Tools Starter Kit';

  /// <summary>
  /// The copyright to show in the About box
  /// </summary>
  CAboutCopyright = ''; // 2024 your name or anything else

  /// <summary>
  /// The website URL of your project (used in the About box)
  /// </summary>
  CAboutURL = 'https://fmxtoolsstarterkit.developpeur-pascal.fr/';

  /// <summary>
  /// Website open by Tools / Support menu option
  /// </summary>
  CSupportURL = CAboutURL + 'userhelp.html';

  /// <summary>
  /// Show (if true) / hide (if false) the Help/Support menu item
  /// </summary>
  /// <remarks>
  /// By default its conditionned by the existence of CSupportURL constant but
  /// you can replace it by a boolean and override the DoHelpSupport method in
  /// your main form.
  /// </remarks>
  CShowHelpSupportMenuItem = (CSupportURL <> '');

  /// <summary>
  /// Default language used if the system language is not supported
  /// (of course you have to translate all textes of the program in this
  /// language, so use yours or English by default)
  /// </summary>
  /// <remarks>
  /// Use 2 letters ISO code
  /// </remarks>
  CDefaultLanguage = 'en';

  /// <summary>
  /// Show (if true) / hide (if false) the Tool/Languages menu item
  /// </summary>
  CShowToolsLanguagesMenuItem = true;

  /// <summary>
  /// Available languages in this project as an array of 2 letters language ISO
  /// code strings.
  /// </summary>
  /// <remarks>
  /// If you want to define the languages list by code, fill the global variable "GLanguages".
  /// If you don't use default language selection, you can ignore this constant.
  /// </remarks>
  CLanguages: array [0 .. 1] of string = ('en', 'fr');

  /// <summary>
  /// Used as a folder name to store your projects settings
  /// </summary>
  /// <remarks>
  /// Don't use a path, only a name to use as a folder name.
  /// The real paths are calculated automatically depending on the platform.
  /// </remarks>
  // for example your name, label or company name (avoid spaces, accents and special characters)
  CEditorFolderName = 'Test';

  /// <summary>
  /// Used as a subfolder name to store your projects settings
  /// </summary>
  /// Don't use a path, only a name to use a a folder name.
  /// The real paths are calculated automatically depending on the platform.
  /// </remarks>
  // for exemple your project title (avoid spaces, accents and special characters)
  CProjectFolderName = 'Test';

  /// <summary>
  /// The GUID to use for this project when saving/loading files like a project
  /// documentto check they are from this program and not an other one.
  /// </summary>
  // Use Shift+Ctrl+G to generate a new GUID and replace current value by the new one
  // TODO : Set your GUID. Each project must have it's GUID, don't use the same !
{$MESSAGE WARN 'Set your GUID, don''t use the default value !!!'}
  CProjectGUID = '{8346EB88-E9AB-4578-A416-DA1D904229D4}';

  /// <summary>
  /// Show the About box dialog when F1 key is used
  /// </summary>
  CShowAboutBoxWithF1 = true;

type
  TStyleMode = (Light, Dark, System, Custom);

const
  /// <summary>
  /// Name of the default style used when the user choose the light mode.
  /// </summary>
  CDefaultStyleLight = 'light';

  /// <summary>
  /// Name of the default style used when the user choose the dark mode.
  /// </summary>
  CDefaultStyleDark = 'dark';

  /// <summary>
  /// Name of the default style used when the user choose the custom mode.
  /// </summary>
  CDefaultStyleCustom = 'dark';

  /// <summary>
  /// Default style mode to use in the program.
  /// </summary>
  CDefaultStyleMode = TStyleMode.System;

  /// <summary>
  /// Show (if true) / hide (if false) the Tool/Styles menu item
  /// </summary>
  CShowToolsStylesMenuItem = true;

  /// <summary>
  /// Show (if true) / hide (if false) the Tool/Options menu item
  /// </summary>
  CShowToolsOptionsMenuItem = false;

  /// <summary>
  /// Show (if true) / hide (if false) the Project/Options menu item
  /// </summary>
  CShowProjectOptionsMenuItem = false;

type
  /// <summary>
  /// None - no default options or features about documents editing.
  /// Solo - edit only one document at a time, if "New" or "Open" are used,
  /// current document is closed.
  /// Multi - allow opening/creating more than one document at the same time
  /// </summary>
  TDocumentsMode = (None, Solo, Multi);

const
  /// <summary>
  /// Define if the program manage documents wiuth default classes and their
  /// descendants
  /// </summary>
  CDocumentsMode = TDocumentsMode.Multi;
  /// <summary>
  /// If the program has to manage documents (mode solo or multi), define if
  /// the default menus are visible or not.
  /// </summary>
  CShowDocumentsMenuItems = true;

var
  /// <summary>
  /// Contains the list of languages available in the program.
  /// </summary>
  /// <remarks>
  /// By default it's filled by CLanguages but you can give an other value by
  /// code in your program. It's used in the SelectLanguage screen called by
  /// Tools/Languages default action.
  /// If you don't use default language selection, you can ignore this variable.
  /// </remarks>
  GLanguages: TStringDynArray;
{$IF Defined(RELEASE)}
  GConfigXORKey: TByteDynArray;
  GDocumentsXORKey: TByteDynArray;
{$ENDIF}

implementation

uses
  System.Classes,
  System.SysUtils;

procedure InitLanguages;
var
  i: integer;
begin
  setlength(GLanguages, length(CLanguages));
  for i := 0 to length(GLanguages) - 1 do
    GLanguages[i] := CLanguages[i];
end;

initialization

try
  InitLanguages;

  if CAboutTitle.Trim.IsEmpty then
    raise Exception.Create
      ('Please give a title to your project in CAboutTitle !');

  if CEditorFolderName.Trim.IsEmpty then
    raise Exception.Create
      ('Please give an editor folder name in CEditorFolderName !');

  if CProjectFolderName.Trim.IsEmpty then
    raise Exception.Create
      ('Please give a project folder name in CProjectFolderName !');

  if CDefaultLanguage.Trim.IsEmpty then
    raise Exception.Create
      ('Please specify a default language ISO code in CDefaultLanguage !');

  if (CDefaultLanguage <> CDefaultLanguage.Trim.ToLower) then
    raise Exception.Create('Please use "' + CDefaultLanguage.Trim.ToLower +
      '" as CDefaultLanguage value.');

{$IFDEF RELEASE}
  if (CProjectGUID = '{8346EB88-E9AB-4578-A416-DA1D904229D4}') then
    raise Exception.Create('Wrong GUID. Change it in project settings !');
{$ENDIF}
{$IFDEF DEBUG}
  // TODO : it's a recommended value but you can remove it if you want
  ReportMemoryLeaksOnShutdown := true;
{$ELSE}
  ReportMemoryLeaksOnShutdown := false;
{$ENDIF}
{$IF Defined(RELEASE)}
  // Path to the Pascal file where you fill GConfigXORKey variable.
  // This variable is used to crypt/decrypt the settings data in RELEASE mode.
  //
  // Template file is in ____PRIVATE\src\ConfigFileXORKey.inc
  // Copy it to a private folder (not in the code repository for security reasons)
  // Customize it
  // Update it's path to the Include directive
  //
  // Don't share the key file. If you need to modify it, you won't be able to
  // open the previous configuration file!
{$I '..\____PRIVATE\src\ConfigFileXORKey.inc'}
  // TODO : don't forget to change ConfigFileXORKey.inc path before releasing your project

  // Path to the Pascal file where you fill GProjectDataXORKey variable.
  // This variable is used to crypt/decrypt the settings data in RELEASE mode.
  //
  // Template file is in ____PRIVATE\src\DocumentsFileXORKey.inc
  // Copy it to a private folder (not in the code repository for security reasons)
  // Customize it
  // Update it's path to the Include directive
  //
  // Don't share the key file. If you need to modify it, you won't be able to
  // open the previous configuration file!
{$I '..\____PRIVATE\src\DocumentsFileXORKey.inc'}
  // TODO : don't forget to change ProjectDataFileXORKey.inc path before releasing your project

{$ENDIF}
except
  on e: Exception do
  begin
    var
    s := e.message;
    tthread.forcequeue(nil,
      procedure
      begin
        raise Exception.Create(s);
      end);
  end;
end;

end.
