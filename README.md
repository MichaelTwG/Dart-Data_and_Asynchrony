# Datos y Asincronía en Dart

## Manejo de Archivos

*Introducción y Contexto*
La persistencia de datos es una característica fundamental de cualquier aplicación robusta. Ya sea que estés guardando preferencias de usuario, registros o datos en caché, el acceso a archivos locales es una necesidad común.
Este proyecto introduce a los estudiantes a la librería `dart:io` de Dart y proporciona experiencia práctica en la lectura y escritura en el sistema de archivos. Esto prepara el terreno para módulos posteriores que involucren interacciones de datos más complejas.

---

### 0. Crear y Escribir en un Archivo

**Obligatorio**
**Objetivo:** Introducir la creación básica de archivos y escritura usando la clase `File`.

**Instrucciones:**

* Crea un archivo llamado `data.txt` dentro de un subdirectorio llamado `storage/`.
* Escribe la cadena `"User activity log initialized"` en este archivo.

**Resultado Esperado:**
Un archivo `storage/data.txt` se crea con el contenido:

```
User activity log initialized
```

**Nombre de la función:** `initializeLogFile()`

---

### 1. Agregar Datos a un Archivo

**Obligatorio**
**Objetivo:** Practicar cómo agregar contenido a un archivo existente.

**Instrucciones:**

* Agrega una nueva línea a `data.txt` con la fecha y hora actual usando `DateTime.now().toIso8601String()`.

**Resultado Esperado:**

```
User activity log initialized
2025-07-16T14:22:08.123Z
```

**Nombre de la función:** `appendLogEntry()`

---

### 2. Leer Contenido de un Archivo

**Obligatorio**
**Objetivo:** Aprender a leer contenido de un archivo.

**Instrucciones:**

* Lee el contenido de `data.txt` y devuélvelo como una `List<String>`, donde cada elemento sea una línea.

**Resultado Esperado:**

```
["User activity log initialized", "2025-07-16T14:22:08.123Z"]
```

**Nombre de la función:** `readLogFile()`

---

### 3. Listar Archivos en un Directorio

**Obligatorio**
**Objetivo:** Entender cómo navegar y listar archivos en un directorio.

**Instrucciones:**

* Crea una función que liste todos los nombres de archivos (no directorios) en el directorio `storage/`.

**Resultado Esperado:**

```
["data.txt"]
```

**Nombre de la función:** `listStorageFiles()`

---

### 4. Manejo de Errores

**Obligatorio**
**Objetivo:** Agregar robustez mediante manejo de excepciones.

**Instrucciones:**

* Envuelve las funciones de lectura y escritura de archivos en bloques `try-catch`.
* Registra o devuelve un mensaje amigable si alguna operación de archivo falla.

**Resultado Esperado:**

* Las funciones no se detienen por errores de archivos faltantes o problemas de permisos.
* Mensajes como: `"Error: Could not read file"` o `"Error: File not found"` son devueltos o impresos.

**Nombre de las funciones:** Usar los mismos nombres anteriores (`initializeLogFile`, `appendLogEntry`, etc.) con manejo de errores añadido.

---

### 5. Eliminar un Archivo de Forma Segura

**Obligatorio**
**Objetivo:** Eliminar un archivo de manera segura si existe.

**Instrucciones:**

* Verifica si `data.txt` existe en `storage/`.
* Si existe, elimínalo y devuelve `true`.
* Si no, devuelve `false`.

**Resultado Esperado:**

* El archivo se elimina si está presente, y la función devuelve un booleano (`true` o `false`).

**Nombre de la función:** `deleteLogFileIfExists()`
