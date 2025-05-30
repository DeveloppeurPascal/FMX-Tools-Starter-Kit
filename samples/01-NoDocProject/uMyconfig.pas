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
  File last update : 2025-05-16T19:43:44.893+02:00
  Signature : 6318c8c6ffdbb252af4bd96eed9fdd1d8f443595
  ***************************************************************************
*)

unit uMyconfig;

interface

uses
  uConfig;

Type
  /// <summary>
  /// A sample TConfig extension with a new setting saved the same way than
  /// starterkit's settings.
  /// </summary>
  TMyConfig = class helper for TConfig
  private
    procedure SetMySampleParam(const Value: integer);
    function getMySampleParam: integer;
  protected
  public
    property MySampleParam: integer read getMySampleParam
      write SetMySampleParam;
  end;

implementation

const
  CMySettingsPrefix = 'MyParamSetting.';

  { TMyConfig }

function TMyConfig.getMySampleParam: integer;
begin
  result := GetParams.getValue(CMySettingsPrefix + 'MyParam1', 0);
end;

procedure TMyConfig.SetMySampleParam(const Value: integer);
begin
  GetParams.setValue(CMySettingsPrefix + 'MyParam1', Value);
  GetParams.Save;
end;

end.
