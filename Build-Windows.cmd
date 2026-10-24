@echo off
setlocal
rem Run from an x64 Visual Studio 2022 Developer Command Prompt.
rem Clone this repository including its blender source directory first.
rem Set OPTIX_ROOT_DIR to your separately obtained NVIDIA OptiX SDK.
where cl.exe >nul 2>nul
if errorlevel 1 (
  echo Please use an x64 Visual Studio 2022 Developer Command Prompt.
  exit /b 1
)
set SOURCE_DIR=%~dp0blender
cmake -S "%SOURCE_DIR%" -B "%~dp0build" -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="%~dp0app" -DWITH_GTESTS=ON -DWITH_GPU_DRAW_TESTS=ON -DWITH_TESTS_SINGLE_BINARY=ON -DWITH_BLENDER_THUMBNAILER=OFF -DWITH_WINDOWS_BUNDLE_CRT=ON -DWITH_WINDOWS_RELEASE_STRIPPED_PDB=OFF -DWITH_BUILDINFO=ON -DWITH_CYCLES_DEVICE_ONEAPI=OFF -DWITH_CYCLES_DEVICE_OPTIX=ON -DOPTIX_ROOT_DIR="%OPTIX_ROOT_DIR%"
if errorlevel 1 exit /b %errorlevel%
cmake --build "%~dp0build" --target install --parallel 8
exit /b %errorlevel%
