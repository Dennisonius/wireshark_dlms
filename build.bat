@if "%vcinstalldir%"=="" call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"

@setlocal
@set WIRESHARK_BASE_DIR=..
@set WIRESHARK_QT6_PREFIX_PATH=d:\Programs\Qt\6.2.4\msvc2019_64

mkdir ..\wsbuild
cd ..\wsbuild

cmake -G "Visual Studio 16 2019" -A x64 ..\wireshark

msbuild /m /p:Configuration=RelWithDebInfo Wireshark.sln

