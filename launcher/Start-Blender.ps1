# SPDX-License-Identifier: GPL-3.0-or-later
$ErrorActionPreference='Stop'
$startupPath=Join-Path $PSScriptRoot 'profiles\daily\config\startup.blend'
if (!(Test-Path -LiteralPath $startupPath)) {
    & (Join-Path $PSScriptRoot 'Run-Isolated.ps1') -BlenderArgs @('-b','--factory-startup','--python-exit-code','1','--python',(Join-Path $PSScriptRoot 'scripts\first_run.py'))
    if ($LASTEXITCODE -ne 0) { throw 'Unable to initialize portable profile.' }
}
& (Join-Path $PSScriptRoot 'Run-Isolated.ps1') -BlenderArgs $args
