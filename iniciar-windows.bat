@echo off
cd /d "%~dp0"
echo Sirviendo el sitio en http://localhost:8000  (cierra esta ventana para detener)
start "" http://localhost:8000
py -m http.server 8000 2>nul || python -m http.server 8000
