{$MESSAGE FATAL 'CilTseg client API settings. Fill them if you want to use CilTseg licenses key manager. Remove this comment when it''s done.'}
const
	/// <summary>
	/// Do you want to use CiTseg key licenses manager in your project ?
	/// https://ciltseg.olfsoftware.fr
	/// </summary>
	/// <remarks>
	/// True if you want to use CilTseg
	/// False if not
	/// </remarks>
	CCilTsegInUse = false;

	/// <summary>
	/// CilTseg API server URL
	/// </summary>
	/// <remarks>
	/// Needed to use CilTseg API,
	/// don't share it in a public code repository,
	/// store it as a const or string variable in your source code.
	/// Don't store it in your screen (DFM or FMX files), it will be in the EXE
	/// resources and could be readable as it.
	/// </remarks>
	CCiltsegServerURL = '';

	/// <summary>
	/// ID given by the CilTseg backoffice for this software
	/// </summary>
	/// <remarks>
	/// Needed to use CilTseg API,
	/// don't share it in a public code repository,
	/// store it as a const or integer variable in your source code.
	/// </remarks>
	CCiltsegSoftwareID = 0;

	/// <summary>
	/// Private token given by the CilTseg backoffice for this software
	/// </summary>
	/// <remarks>
	/// Needed to use CilTseg API,
	/// don't share it in a public code repository,
	/// store it as a const or string variable in your source code.
	/// Don't store it in your screen (DFM or FMX files), it will be in the EXE
	/// resources and could be readable as it.
	/// If you can, crypt it in your code and uncrypt it when you need to use it.
	/// </remarks>
	CCiltsegSoftwareToken = '';

	/// <summary>
	/// Name of the platform for this program, depending on its operating
	/// system, compiler or other things. It should correspond to a platform
	/// you declared in CilTseg backoffice and use as a file attached to new
	/// releases of the software.
	/// </summary>
{$IF Defined(MSWINDOWS)}
	CSoftwareCurrentPlatform = 'Windows';
{$ELSE IF Defined(MACOS)}
	CSoftwareCurrentPlatform = 'macOS';
{$ELSE IF Defined(IOS)}
	CSoftwareCurrentPlatform = 'iOS';
{$ELSE IF Defined(ANDROID)}
	CSoftwareCurrentPlatform = 'Android';
{$ELSE IF Defined(LINUX)}
	CSoftwareCurrentPlatform = 'Linux';
{$ENDIF}
