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

---

## Integración de APIs

**Introducción y Contexto**
La mayoría de las aplicaciones modernas dependen de datos externos a través de APIs. Ya sea para obtener información del clima, enviar respuestas de formularios o integrarse con servicios en la nube, comprender la comunicación HTTP es esencial.
Este proyecto introduce a los estudiantes a realizar solicitudes HTTP usando el paquete `http` y a convertir las respuestas en estructuras de Dart utilizables mediante parsing y manejo asincrónico.

---

### 0. Realizar una Solicitud GET

**Obligatorio**
**Objetivo:** Aprender a obtener datos de una API pública.

**Instrucciones:**

* Usa el paquete `http` para hacer una solicitud GET al endpoint:
  `https://jsonplaceholder.typicode.com/posts/1`
* Parsear el JSON de la respuesta y extraer: `title` y `body`.

**Salida Esperada:**

```dart
{
  'title': 'some title',
  'body': 'some body'
}
```

**Nombre de la función:** `fetchPost()`

---

### 1. Manejar Errores en Solicitudes GET

**Obligatorio**
**Objetivo:** Introducir manejo de errores para solicitudes fallidas.

**Instrucciones:**

* Modificar `fetchPost()` para capturar y devolver un mapa por defecto si:

  * El código de estado no es 200
  * O ocurre alguna excepción

**Salida Esperada:**

```dart
{
  'title': 'Unavailable',
  'body': 'Error fetching post'
}
```

**Nombre de la función:** `fetchPost()`

---

### 2. Parsear Múltiples Publicaciones

**Obligatorio**
**Objetivo:** Manejar listas en respuestas JSON.

**Instrucciones:**

* Realizar una solicitud GET a:
  `https://jsonplaceholder.typicode.com/posts`
* Devolver únicamente los títulos de los posts como lista.

**Salida Esperada:**

* Una `List<String>` con 100 títulos de publicaciones.

**Nombre de la función:** `fetchPostTitles()`

---

### 3. (Opcional) Usar Headers Personalizados

**Obligatorio**
**Objetivo:** Enviar headers en las solicitudes.

**Instrucciones:**

* Modificar `sendPost()` para incluir el header:

```dart
'Content-type': 'application/json; charset=UTF-8'
```

**Salida Esperada:** Igual que la Tarea 3, con la respuesta exitosa usando headers personalizados.

**Nombre de la función:** `sendPost()`

---

### 4. Manejador Genérico de Solicitudes

**Obligatorio**
**Objetivo:** Abstraer y reutilizar la lógica de solicitudes.

**Instrucciones:**

* Crear una función `getJsonResponse(String url)` que:

  * Realice una solicitud GET
  * Parse la respuesta
  * Devuelva un `dynamic` con el JSON decodificado

**Salida Esperada:**
Puede ser reutilizada en `fetchPost()` y `fetchPostTitles()`.

**Nombre de la función:** `getJsonResponse(String url)`

---
