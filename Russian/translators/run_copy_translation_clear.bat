echo off
echo.
echo.
echo ################################################################################################
echo prepare %2.apk

SET _DEVICE=%1
SET _APKFILE=%2
SET _EXT=%3

SET _run=D:\Android\XMLCompare\
SET _src=D:\Android\Github\Xiaomi.eu-HyperOS-1.0-XML-Compare\%_DEVICE%\%_APKFILE%.apk\res\values\
SET _dst=D:\Android\Github\HyperOS-XML-1.0-RUSSIAN\Russian\main\%_APKFILE%.apk\res\values-ru%_EXT%\
SET _dat=D:\Android\Github\HyperOS-XML-1.0-RUSSIAN\Russian\translators\

echo.
IF EXIST %_src%strings.xml (
  copy %_src%strings.xml D:\Android\XMLCompare\SRC 
) ELSE (
  echo checking... [STRINGS] - SRC_NOT_FOUND
  goto _end_strings
)
IF NOT EXIST %_dst%strings.xml (
  echo checking... [STRINGS] - DST_NOT_FOUND
  goto _end_strings
)

IF EXIST %_run%result.xml (
del %_run%result.xml
)
%_run%XMLCompare /at /nochin /s %_run%SRC\strings.xml /d %_run%empty.xml  /i %_dat%ignore.xml /t %_dst%strings.xml /n 4 /silent_t

IF EXIST %_run%result.xml (
  copy %_run%result.xml %_dst%strings.xml
) ELSE (
  echo processing... [STRINGS] - EXEC_ERROR
  pause
)

:_end_strings

echo.
IF EXIST %_src%plurals.xml (
  copy %_src%plurals.xml D:\Android\XMLCompare\SRC 
) ELSE (
  echo checking... [PLURALS] - SRC_NOT_FOUND
  goto _end_plurals
)
IF NOT EXIST %_dst%plurals.xml (
  echo checking... [PLURALS] - DST_NOT_FOUND
  goto _end_plurals
)

IF EXIST %_run%result.xml (
del %_run%result.xml
)
%_run%XMLCompare /at /fp /nochin /s %_run%SRC\plurals.xml /d %_run%empty.xml /i %_dat%ignore_p.xml /t %_dst%plurals.xml /n 4 /silent_t


IF EXIST %_run%DST\result.xml (
  copy %_run%result.xml %_dst%plurals.xml
) ELSE (
  echo processing... [PLURALS] - EXEC_ERROR
)

:_end_plurals

echo.
IF EXIST %_src%arrays.xml (
  copy %_src%arrays.xml D:\Android\XMLCompare\SRC 
) ELSE (
  echo checking... [ARRAYS] - SRC_NOT_FOUND
  goto _end_arrays
)
IF NOT EXIST %_dst%arrays.xml (
  echo checking... [ARRAYS] - DST_NOT_FOUND
  goto _end_arrays
)

IF EXIST %_run%result.xml (
del %_run%result.xml
)
%_run%XMLCompare /at /fa /nochin /s %_run%SRC\arrays.xml /d %_run%empty.xml /i %_dat%ignore_a.xml /t %_dst%arrays.xml /n 4 /silent_t

IF EXIST %_run%DST\result.xml (
  copy %_run%result.xml %_dst%arrays.xml
) ELSE (
  echo processing... [ARRAYS] - EXEC_ERROR
)

:_end_arrays
