{$MESSAGE WARN 'CilTseg client API settings. Fill them if you want to use CilTseg licenses key manager. Remove this comment when it''s done.' }
// TODO : copy this file to a local private repository and fill it (or not)
// TODO : update the path to this file in uConsts.pas

// Settings for the CilTseg API available from https://ciltseg.olfsoftware.fr
// Never share this file in a public repository with tokens and private infos !

const
  /// <summary>
  /// CilTseg API server URL
  /// </summary>
  CCiltsegServerURL = '';

  /// <summary>
  /// ID given by the CilTseg backoffice for this software
  /// </summary>
  CCiltsegSoftwareID = 0;

  /// <summary>
  /// Private token given by the CilTseg backoffice for this software
  /// </summary>
  CCiltsegSoftwareToken = '';

  /// <summary>
  /// Name of the platform for this program, depending on its operating
  /// system, compiler or other things. It should correspond to a platform
  /// you declared in CilTseg backoffice and use as a file attached to new
  /// releases of the software.
  /// </summary>
{$IF Defined(MSWINDOWS)}
  CCiltsegSoftwareCurrentPlatform = 'Windows';
{$ELSE IF Defined(MACOS)}
  CCiltsegSoftwareCurrentPlatform = 'macOS';
{$ELSE IF Defined(IOS)}
  CCiltsegSoftwareCurrentPlatform = 'iOS';
{$ELSE IF Defined(ANDROID)}
  CCiltsegSoftwareCurrentPlatform = 'Android';
{$ELSE IF Defined(LINUX)}
  CCiltsegSoftwareCurrentPlatform = 'Linux';
{$ENDIF}
