#!/bin/bash
cd "$(dirname "$0")"
echo "Sirviendo el sitio en http://localhost:8000  (Ctrl+C para detener)"
( sleep 1; open "http://localhost:8000" 2>/dev/null || xdg-open "http://localhost:8000" 2>/dev/null ) &
python3 -m http.server 8000
