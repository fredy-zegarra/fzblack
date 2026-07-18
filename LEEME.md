# Sitio de campaña — Fredy Zegarra Black (versión reparada v2)

## ✅ Cómo abrir el sitio

**Ahora funciona con doble clic sobre `index.html`.** Ya no es obligatorio usar un
servidor local: si el navegador bloquea la aplicación por abrirse como archivo
(`file://`), la página carga automáticamente una versión alternativa
(`assets/app-local.js`) con exactamente el mismo contenido y el mismo chat.

Los lanzadores locales siguen disponibles por si prefieres ver el sitio igual que
en internet: `iniciar-mac.command` (Mac), `iniciar-windows.bat` (Windows) o
`python3 -m http.server 8000` en una terminal.

Para publicarlo (cPanel, Netlify, GitHub Pages, etc.) sube el contenido de esta
carpeta. Funciona **en la raíz del dominio o en cualquier subcarpeta**, e incluso
si el visitante entra con la URL terminada en `/index.html`.

## 🔧 Qué estaba fallando y qué se corrigió

### 1. El botón del chat (el «RAG») no respondía al presionarlo
Dos causas independientes:

- **Doble clic (`file://`).** Los navegadores bloquean los módulos de JavaScript
  cuando la página se abre como archivo local, así que la aplicación nunca
  arrancaba: el botón se veía, pero estaba muerto. Ahora `index.html` detecta ese
  caso y carga `assets/app-local.js`, una versión en formato clásico que los
  navegadores sí ejecutan desde `file://`.
- **Página fuera de la raíz del dominio.** El enrutador interno solo reconocía la
  ruta `/`; en una subcarpeta (o abriendo `/index.html`) fallaba y **dejaba la
  página en blanco**. Ahora calcula su ruta base automáticamente en cualquier
  ubicación.

### 2. El contenido nuevo se revertía al contenido antiguo
El `index.html` traía el contenido actualizado (gestión organizada por años
2023–2026, 130 semáforos inteligentes, 95.9% de ejecución 2025…), pero el
JavaScript renderizaba una **versión anterior** de la página (300 cámaras, sin
bloques por año). Al terminar de cargar, React detectaba la diferencia y
**reemplazaba el contenido nuevo por el antiguo** ante los ojos del visitante.
Se actualizó el JavaScript para que renderice exactamente el mismo contenido que
el HTML: hoy servidor y navegador muestran lo mismo, sin parpadeos ni reversiones
(verificado con comparación automática: 0 diferencias de texto).

### 3. Rutas absolutas residuales
Quedaban referencias absolutas dentro del JavaScript (`/assets/styles-….css` y
las fotos `/__l5e/…`) que se rompían fuera de la raíz del dominio y generaban
peticiones 404. Se convirtieron a relativas.

## 🤖 Base de conocimiento del chat: datos alineados con la página

El motor del chat no se tocó. Solo se actualizaron las respuestas cuyo dato ya no
coincidía con lo que hoy afirma la propia página (ninguna cifra fue inventada;
todas provienen del contenido del sitio):

- Ejecución presupuestal: se añadió el **95.9% de 2025** (antes solo mencionaba 2024).
- Megaproyecto de seguridad: central de monitoreo con capacidad para **210 cámaras**,
  lectura de placas, fibra óptica, drones autónomos y PAR (antes decía «meta de
  300 cámaras»).
- Obras viales en cinco urbanizaciones: **más de S/ 12 millones** (antes S/ 13).
- Semaforización inteligente: **ya en funcionamiento** —130 semáforos vehiculares,
  182 peatonales y 120 cámaras de flujo, S/ 7 millones vía Obras por Impuestos—
  (antes figuraba como «proyectada»).
- Nueva entrada: **mejoramiento de la Piscina Municipal** (S/ 1.5 millones:
  techado, drenaje pluvial, cuarto de máquinas y tribunas).

## 🧪 Verificación realizada

Probado con un navegador Chromium real en cinco escenarios: dominio raíz,
subcarpeta, subcarpeta con `/index.html` explícito, doble clic (`file://` con
módulos bloqueados) y `file://` con permisos ampliados. En todos: página completa,
botón del chat activo, respuestas correctas con los datos actualizados y consola
sin errores. (Nota: al abrir con doble clic, el navegador registra dos avisos CORS
por los módulos bloqueados; son inofensivos y no visibles para el visitante.)

## 📁 Estructura

```
index.html                  ← página principal (doble clic ya funciona)
favicon.ico
assets/
  styles-….css              ← estilos
  index-….js  routes-….js   ← aplicación (módulos, para servidor/hosting)
  app-local.js              ← misma aplicación en formato clásico (respaldo file://)
__l5e/assets-v1/            ← fotos (candidato y logo del partido)
iniciar-mac.command / iniciar.sh / iniciar-windows.bat  ← servidor local opcional
LEEME.md                    ← este archivo
```

## 📝 Nota para la publicación
Las etiquetas `og:image` / `twitter:image` (imagen al compartir el enlace en
redes) siguen apuntando a `/__l5e/…`. Cuando el sitio tenga su dominio
definitivo, conviene reemplazarlas por la URL completa, por ejemplo:
`https://tudominio.pe/__l5e/assets-v1/2763be67-…/zegarra-black.jpg`.
