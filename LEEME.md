# Sitio de campaña — Fredy Zegarra Black (versión reparada)

## ⚠️ Lo más importante: cómo abrir el sitio

**No abras `index.html` con doble clic.** El sitio usa módulos de JavaScript (React),
y los navegadores los bloquean cuando la página se abre como archivo local (`file://`).
Ese era el motivo principal por el que el chat "Black Smart AI" no respondía:
la página se veía, pero la aplicación nunca arrancaba.

Para verlo en tu computadora, sirve la carpeta con un servidor local:

**Mac** — doble clic en `iniciar-mac.command`
(si macOS lo bloquea: clic derecho → Abrir, o en Terminal: `sh iniciar.sh`)

**Windows** — doble clic en `iniciar-windows.bat`

**Manual (cualquier sistema con Python):**
```
cd carpeta-del-sitio
python3 -m http.server 8000
```
y abre http://localhost:8000 en el navegador.

Para publicarlo en internet (Netlify, Vercel, GitHub Pages, cPanel, etc.) solo sube
el contenido de esta carpeta; ahí funcionará directamente. Las rutas ahora son
relativas, así que también funciona si lo colocas en una subcarpeta del dominio.

## ✅ Qué se arregló

### 1. El chat "Black Smart AI" (el "RAG")
El buscador de respuestas era muy literal: solo acertaba si escribías casi las mismas
palabras que la pregunta guardada. En una batería de 33 preguntas realistas acertaba
el 61%. El motor nuevo acierta el 100% de una batería ampliada de 42 casos:

- **Sinónimos y variaciones**: "¿cuándo se vota?" → elecciones; "¿qué estudios tiene?"
  → formación; "¿cuánto invirtió?" → inversión; "¿quién encabeza la lista?" → fórmula, etc.
- **Plurales y conjugaciones**: "propuestas/propone/plan" encuentran las propuestas.
- **Errores de tipeo**: "eleciones 2026", "semaforos" igual encuentran respuesta.
- **Saludos y cortesía**: "hola", "gracias", "¿quién eres?" reciben respuesta amable.
- **Cuando no está seguro**, en vez de "no te puedo entender" ahora sugiere las
  3 preguntas más parecidas de su base de conocimiento.
- **Fuera de tema**: si la pregunta no tiene relación (p. ej. gastronomía), lo dice
  con honestidad en lugar de responder cualquier cosa.

Sigue siendo 100% local: funciona en el navegador del visitante, sin servidor y sin
enviar datos a ningún lado, tal como anuncia la propia página. **No se agregó ni
modificó ningún contenido político**: las respuestas son exactamente las que ya
estaban en la base de conocimiento (solo se actualizó la descripción de cómo
funciona el propio asistente).

### 2. Limpieza del código (sin perder funcionalidad)
El sitio venía de una exportación de Lovable con restos que daban errores:

- ❌ `~flock.js`: script de analytics que no existe en el paquete y apuntaba a un
  proxy (`/~api/analytics`) que solo existe en los servidores de Lovable. Eliminado.
- ❌ `__l5e/events.js` (44 KB): telemetría y grabación de sesión de Lovable.
  Eliminado (las fotos en `__l5e/assets-v1/` se conservan, el sitio las usa).
- ❌ CSS y JavaScript del "badge" de Lovable: código muerto — el elemento ni siquiera
  existe en la página. Eliminado (~5 KB menos).
- 🔧 **Tipografías**: el enlace a Google Fonts estaba reescrito hacia un archivo local
  inexistente, por lo que Playfair Display e Inter nunca cargaban. Restaurado al
  enlace real de Google Fonts.
- 🔧 **Rutas absolutas** `/assets/...` en el manifiesto de arranque: rotas si el sitio
  no está en la raíz del dominio. Convertidas a relativas.

## 📁 Estructura

```
index.html                  ← página principal
favicon.ico
assets/                     ← estilos y aplicación (incluye el chat mejorado)
__l5e/assets-v1/            ← fotos (candidato y logo del partido)
iniciar-mac.command         ← servidor local con doble clic (Mac)
iniciar.sh                  ← alternativa por terminal (Mac/Linux)
iniciar-windows.bat         ← servidor local con doble clic (Windows)
LEEME.md                    ← este archivo
```

## 📝 Nota menor
Las etiquetas `og:image` / `twitter:image` (la imagen que aparece al compartir el
enlace en redes) usan la ruta `/__l5e/...`. Cuando publiques el sitio en su dominio
definitivo, conviene cambiarlas por la URL completa, por ejemplo:
`https://tudominio.pe/__l5e/assets-v1/2763be67-.../zegarra-black.jpg`.
