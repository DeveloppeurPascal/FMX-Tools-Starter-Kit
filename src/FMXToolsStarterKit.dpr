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
/// File last update : 2024-08-28T12:31:32.000+02:00
/// Signature : bbcbfc803f45a2425e3be724993c7d10dc018627
/// ***************************************************************************
/// </summary>

program FMXToolsStarterKit;

uses
  System.StartUpCopy,
  FMX.Forms,
  uConfig in 'uConfig.pas',
  uConsts in 'uConsts.pas',
  uDMAboutBox in 'uDMAboutBox.pas' {AboutBox: TDataModule},
  uDMAboutBoxLogoStorrage in 'uDMAboutBoxLogoStorrage.pas' {dmAboutBoxLogo: TDataModule},
  uTranslate in 'uTranslate.pas',
  uTxtAboutDescription in 'uTxtAboutDescription.pas',
  uTxtAboutLicense in 'uTxtAboutLicense.pas',
  Olf.FMX.AboutDialog in '..\lib-externes\AboutDialog-Delphi-Component\src\Olf.FMX.AboutDialog.pas',
  Olf.FMX.AboutDialogForm in '..\lib-externes\AboutDialog-Delphi-Component\src\Olf.FMX.AboutDialogForm.pas' {OlfAboutDialogForm},
  Olf.FMX.SelectDirectory in '..\lib-externes\Delphi-FMXExtend-Library\src\Olf.FMX.SelectDirectory.pas',
  Olf.RTL.CryptDecrypt in '..\lib-externes\librairies\src\Olf.RTL.CryptDecrypt.pas',
  Olf.RTL.Language in '..\lib-externes\librairies\src\Olf.RTL.Language.pas',
  Olf.RTL.Params in '..\lib-externes\librairies\src\Olf.RTL.Params.pas',
  u_urlOpen in '..\lib-externes\librairies\src\u_urlOpen.pas',
  _TFrameAncestor in '_TFrameAncestor.pas' {__TFrameAncestor: TFrame},
  _TFormAncestor in '_TFormAncestor.pas' {__TFormAncestor},
  _MainFormAncestor in '_MainFormAncestor.pas' {__MainFormAncestor},
  uProjectData in 'uProjectData.pas',
  Olf.RTL.Streams in '..\lib-externes\librairies\src\Olf.RTL.Streams.pas',
  Olf.RTL.Maths.Conversions in '..\lib-externes\librairies\src\Olf.RTL.Maths.Conversions.pas',
  uStyleManager in 'uStyleManager.pas',
  _StyleContainerAncestor in '_StyleContainerAncestor.pas' {__StyleContainerAncestor: TDataModule},
  uStyleLightByDefault in 'uStyleLightByDefault.pas' {StyleLightByDefault: TDataModule},
  uStyleDarkByDefault in 'uStyleDarkByDefault.pas' {StyleDarkByDefault: TDataModule},
  Olf.RTL.SystemAppearance in '..\lib-externes\librairies\src\Olf.RTL.SystemAppearance.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(T__MainFormAncestor, __MainFormAncestor);
  Application.Run;
end.
