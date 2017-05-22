; Copyright 2014 Google Inc
;
; Licensed under the Apache License, Version 2.0 (the "License");
; you may not use this file except in compliance with the License.
; You may obtain a copy of the License at
;
;     http://www.apache.org/licenses/LICENSE-2.0
;
; Unless required by applicable law or agreed to in writing, software
; distributed under the License is distributed on an "AS IS" BASIS,
; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
; See the License for the specific language governing permissions and
; limitations under the License.
;
; Simple 32 and 64 bit installer wrapper.
;------------------------------------------------------------------------------

!include x64.nsh

; Set the name of the installer
Name "��������"

; File to output wrapped installer
OutFile ${OUTPUT_PATH}
Icon "DriveFusion/Images/Folder.ico"
Caption "${PRODUCT_NAME} (Google Inc.)"
VIProductVersion ${Version}
VIAddVersionKey ProductName "${PRODUCT_NAME}"
VIAddVersionKey "Comments" "A build of ${PRODUCT_NAME}"
VIAddVersionKey "CompanyName" "Google Inc."
VIAddVersionKey "LegalCopyright" "Copyright 2014 Google Inc. All Rights Reserved."
VIAddVersionKey "FileDescription" "${PRODUCT_NAME} Installer"
VIAddVersionKey "FileVersion" ${Version}
VIAddVersionKey "ProductVersion" ${Version}
VIAddVersionKey "InternalName" "${PRODUCT_NAME} Installer"
VIAddVersionKey "LegalTrademarks" "Google Inc."
VIAddVersionKey "OriginalFilename" "DriveFusion.exe"

; Request application privileges
RequestExecutionLevel admin

SilentInstall silent

section

  ${If} ${RunningX64}
      Goto Install64Bit
  ${Else}
      Goto Install32Bit
  ${EndIf}

Install64Bit:
  SetOutPath "$PROGRAMFILES64\Google\Google Drive Shell Extension"
  File /oname=DriveFusion32.msi ${32BIT_MSI_FILE_PATH}
  File /oname=DriveFusion64.msi ${64BIT_MSI_FILE_PATH}
  ;File ${DRIVE_PROXY_MSI_PATH}
  GoTo ExecuteInstall64

Install32Bit:
  SetOutPath "$PROGRAMFILES\Google\Google Drive Shell Extension"
  File /oname=DriveFusion32.msi ${32BIT_MSI_FILE_PATH}
  ;File ${DRIVE_PROXY_MSI_PATH}
  GoTo ExecuteInstall32

ExecuteInstall64:
  ExecWait '"$SYSDIR\msiexec.exe" /norestart /qn /i "$OUTDIR\DriveFusion64.msi"'
  Delete /REBOOTOK "$OUTDIR\DriveFusion64.msi"
  ; Continue to 32bit install

ExecuteInstall32:
  ExecWait '"$SYSDIR\msiexec.exe" /norestart /qn /i "$OUTDIR\DriveFusion32.msi"'
  ;ExecWait '"$SYSDIR\msiexec.exe" /norestart /qn /i "$OUTDIR\DriveProxy.msi"'
  Delete /REBOOTOK "$OUTDIR\DriveFusion32.msi"
  ;Delete /REBOOTOK "$OUTDIR\DriveProxy.msi"
  SetRebootFlag false

sectionEnd

