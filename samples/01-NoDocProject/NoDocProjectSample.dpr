﻿(* C2PP
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
  File last update : 2025-07-14T16:42:30.000+02:00
  Signature : 67b7e82feb8f9fef893052d23767a7843ebca25e
  ***************************************************************************
*)

program NoDocProjectSample;

uses
  System.StartUpCopy,
  FMX.Forms,
  uConfig in '..\..\src\uConfig.pas',
  uConsts in 'uConsts.pas',
  uDMAboutBox in '..\..\src\uDMAboutBox.pas' {AboutBox: TDataModule},
  uDMAboutBoxLogoStorrage in 'uDMAboutBoxLogoStorrage.pas' {dmAboutBoxLogo: TDataModule},
  uTranslate in '..\..\src\uTranslate.pas',
  uTxtAboutDescription in 'uTxtAboutDescription.pas',
  uTxtAboutLicense in 'uTxtAboutLicense.pas',
  Olf.FMX.AboutDialog in '..\..\lib-externes\AboutDialog-Delphi-Component\src\Olf.FMX.AboutDialog.pas',
  Olf.FMX.AboutDialogForm in '..\..\lib-externes\AboutDialog-Delphi-Component\src\Olf.FMX.AboutDialogForm.pas' {OlfAboutDialogForm},
  Olf.FMX.SelectDirectory in '..\..\lib-externes\Delphi-FMXExtend-Library\src\Olf.FMX.SelectDirectory.pas',
  Olf.RTL.CryptDecrypt in '..\..\lib-externes\librairies\src\Olf.RTL.CryptDecrypt.pas',
  Olf.RTL.Language in '..\..\lib-externes\librairies\src\Olf.RTL.Language.pas',
  Olf.RTL.Params in '..\..\lib-externes\librairies\src\Olf.RTL.Params.pas',
  u_urlOpen in '..\..\lib-externes\librairies\src\u_urlOpen.pas',
  _TFrameAncestor in '..\..\src\_TFrameAncestor.pas' {__TFrameAncestor: TFrame},
  _TFormAncestor in '..\..\src\_TFormAncestor.pas' {__TFormAncestor},
  _MainFormAncestor in '..\..\src\_MainFormAncestor.pas' {__MainFormAncestor},
  Olf.RTL.Streams in '..\..\lib-externes\librairies\src\Olf.RTL.Streams.pas',
  Olf.RTL.Maths.Conversions in '..\..\lib-externes\librairies\src\Olf.RTL.Maths.Conversions.pas',
  Olf.RTL.SystemAppearance in '..\..\lib-externes\librairies\src\Olf.RTL.SystemAppearance.pas',
  fMain in 'fMain.pas' {frmMain},
  fToolsStylesDialog in '..\..\src\fToolsStylesDialog.pas' {frmToolsStylesDialog},
  fToolsLanguagesDialog in '..\..\src\fToolsLanguagesDialog.pas' {frmToolsLanguagesDialog},
  Olf.CilTseg.ClientLib in '..\..\lib-externes\CilTseg4Delphi\src\Olf.CilTseg.ClientLib.pas',
  Olf.RTL.Checksum in '..\..\lib-externes\librairies\src\Olf.RTL.Checksum.pas',
  u_md5 in '..\..\lib-externes\librairies\src\u_md5.pas',
  fCiltsegRegisterOrShowLicense in '..\..\lib-externes\CilTseg4Delphi\src\FMX\fCiltsegRegisterOrShowLicense.pas' {frmCilTsegRegisterOrShowLicense},
  uDocumentsAncestor in '..\..\src\uDocumentsAncestor.pas',
  uStyleGoldenGraphite in 'uStyleGoldenGraphite.pas' {dmStyleGoldenGraphite: TDataModule},
  uStyleTransparent in 'uStyleTransparent.pas' {dmStyleTransparent: TDataModule},
  uStyleWin10ModernBlue in 'uStyleWin10ModernBlue.pas' {dmStyleWin10ModernBlue: TDataModule},
  uStyleCoralCrystal in 'uStyleCoralCrystal.pas' {dmStyleCoralCrystal: TDataModule},
  _StyleContainerAncestor in '..\..\lib-externes\FMX-Styles-Utils\src\_StyleContainerAncestor.pas' {__StyleContainerAncestor: TDataModule},
  uStyleManager in '..\..\lib-externes\FMX-Styles-Utils\src\uStyleManager.pas',
  uStyleDarkByDefault in '..\..\lib-externes\FMX-Styles-Utils\samples\DarkLightSampleProject\uStyleDarkByDefault.pas' {StyleDarkByDefault: TDataModule},
  uStyleLightByDefault in '..\..\lib-externes\FMX-Styles-Utils\samples\DarkLightSampleProject\uStyleLightByDefault.pas' {StyleLightByDefault: TDataModule},
  uStyleManagerHelpers in '..\..\src\uStyleManagerHelpers.pas',
  uGetDeviceName in '..\..\lib-externes\librairies\src\uGetDeviceName.pas',
  uMyconfig in 'uMyconfig.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
