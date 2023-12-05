@echo off

rem Generate timestamp
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set datetime=%%a
set timestamp=%datetime:~0,8%_%datetime:~8,6%

rem Set volume path (current directory)
set volume_path=%cd%\jmeter-scripts

rem Set JMeter path
set jmeter_path=/mnt/jmeter

rem Run Docker command
docker run ^
  --volume "%volume_path%":%jmeter_path% ^
  jmeter ^
  -n ^
  -t %jmeter_path%/%1 ^
  -JINFLUXDB_HOST="host.docker.internal" ^
  -l %jmeter_path%/results/result_%timestamp%.jtl ^
  -j %jmeter_path%/results/jmeter_%timestamp%.log

