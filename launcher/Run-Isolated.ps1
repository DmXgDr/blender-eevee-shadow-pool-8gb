# SPDX-License-Identifier: GPL-3.0-or-later
param(
    [string]$Executable = '',
    [string]$Profile = 'daily',
    [Parameter(ValueFromRemainingArguments=$true)][string[]]$BlenderArgs
)
$ErrorActionPreference = 'Stop'
$taskRoot = $PSScriptRoot
if (-not $Executable) { $Executable = Join-Path $taskRoot 'app\blender.exe' }
$profileRoot = Join-Path $taskRoot ('profiles\' + $Profile)
foreach ($sub in @('config','scripts','datafiles','extensions','temp','cache','local','roaming')) {
    New-Item -ItemType Directory -Force -Path (Join-Path $profileRoot $sub) | Out-Null
}
$env:BLENDER_USER_CONFIG = Join-Path $profileRoot 'config'
$env:BLENDER_USER_SCRIPTS = Join-Path $profileRoot 'scripts'
$env:BLENDER_USER_DATAFILES = Join-Path $profileRoot 'datafiles'
$env:BLENDER_USER_EXTENSIONS = Join-Path $profileRoot 'extensions'
$env:TEMP = Join-Path $profileRoot 'temp'
$env:TMP = $env:TEMP
$env:LOCALAPPDATA = Join-Path $profileRoot 'local'
$env:APPDATA = Join-Path $profileRoot 'roaming'
$env:XDG_CACHE_HOME = Join-Path $profileRoot 'cache'
$env:CUDA_CACHE_PATH = Join-Path $profileRoot 'cache\cuda'
$env:__GL_SHADER_DISK_CACHE_PATH = Join-Path $profileRoot 'cache\gl'
Remove-Item Env:OCIO -ErrorAction SilentlyContinue
& $Executable @BlenderArgs
exit $LASTEXITCODE
