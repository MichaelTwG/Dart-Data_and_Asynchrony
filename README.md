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

## Serialización y Deserialización de JSON  

**Introducción y Contexto**
Interactuar con APIs casi siempre implica trabajar con datos estructurados en formato **JSON**. Para usar estos datos de manera efectiva en aplicaciones Dart, los desarrolladores deben **serializar** (convertir objetos a JSON) y **deserializar** (convertir JSON a objetos).  

Este proyecto guía a los estudiantes a través del mapeo manual y presenta herramientas automatizadas como **json_serializable** para simplificar el proceso.  

---

### Objetivos de Aprendizaje  
Al final de este proyecto, los estudiantes serán capaces de:  

- Serializar y deserializar objetos de Dart usando `dart:convert`.  
- Modelar estructuras JSON anidadas con clases Dart.  
- Implementar manualmente los métodos `fromJson` y `toJson`.  
- Usar el paquete **json_serializable** para la generación automática de código.  

---

## Ejercicios  

### 0. Deserializar un Objeto JSON Simple  
**Obligatorio**  
**Objetivo:** Convertir una cadena JSON en un objeto Dart.  

**Instrucciones:**  
Dado el siguiente JSON:  

```json
{
  "id": 1,
  "name": "Alice",
  "email": "alice@example.com"
}
````

* Crear una clase `User` con los campos `id`, `name` y `email`.
* Implementar un constructor `fromJson(Map<String, dynamic> json)`.

**Resultado Esperado:**
`User.fromJson` crea correctamente un objeto Dart con los campos correspondientes.

* **Nombre de la clase:** `User`
* **Nombre del método:** `User.fromJson(Map<String, dynamic> json)`

---

### 1. Serializar un Objeto Dart a JSON

**Obligatorio**
**Objetivo:** Convertir un objeto Dart en un mapa compatible con JSON.

**Instrucciones:**

* Agregar un método `toJson()` a la clase `User` creada en el ejercicio anterior.
* Debe devolver un `Map<String, dynamic>` representando al usuario.

**Resultado Esperado:**

```json
{
  "id": 1,
  "name": "Alice",
  "email": "alice@example.com"
}
```

* **Nombre del método:** `Map<String, dynamic> toJson()`

---

### 2. Deserializar una Lista de Objetos

**Obligatorio**
**Objetivo:** Manejar un arreglo de objetos JSON.

**Instrucciones:**

* Dado un arreglo JSON de usuarios, analizarlo y devolver una `List<User>`.

**Resultado Esperado:**
Una función que retorne una lista de instancias `User` a partir de un arreglo JSON.

* **Nombre de la función:** `List<User> parseUsers(String jsonStr)`

---

### 3. Trabajar con JSON Anidado

**Obligatorio**
**Objetivo:** Manejar estructuras de datos anidadas.

**Instrucciones:**
Dado el siguiente JSON:

```json
{
  "orderId": 101,
  "customer": {
    "id": 5,
    "name": "Bob"
  },
  "total": 99.99
}
```

* Crear una clase Dart `Order` con un objeto anidado `Customer`.
* Implementar `fromJson` y `toJson` en ambas clases.

**Resultado Esperado:**
Se pueden serializar y deserializar objetos `Order`, incluyendo el objeto anidado `Customer`.

* **Clases:** `Order`, `Customer`
* **Métodos:** `fromJson`, `toJson` en cada clase

---

### 4. Automatizar con `json_serializable`

**Obligatorio**
**Objetivo:** Aprender a automatizar la serialización de JSON.

**Instrucciones:**

* Agregar `json_serializable` y `build_runner` a `pubspec.yaml`.
* Anotar la clase `User` con `@JsonSerializable()`.
* Usar la directiva `part` y ejecutar el build para generar el código de serialización.

**Resultado Esperado:**

* Se generan archivos como `user.g.dart`.

* `User.fromJson()` y `User.toJson()` funcionan sin implementación manual.

* **Paquetes:** `json_serializable`, `build_runner`

---

# Programación Asíncrona en Dart

La programación asíncrona es esencial para aplicaciones modernas que interactúan con archivos, redes o entradas del usuario sin bloquear el hilo principal.  
Dart ofrece herramientas poderosas como `Future`, `Stream` y `async/await` para gestionar estos flujos.  
Este proyecto entrena a los estudiantes a pensar en flujos asíncronos, manejar demoras y concurrencia, y procesar datos continuos como eventos o streams.

---

## 0. Simular una Operación con Retardo  
**Obligatorio**  
**Objetivo:** Aprender a usar `Future.delayed`.

### Instrucciones
- Crear una función que simule una llamada de red con un retardo de 2 segundos.  
- Retornar la cadena `"Data received"` después del retardo.  

**Resultado Esperado:** Después de 2 segundos, la función completa y retorna la cadena.  

**Nombre de la función:**  
```dart
Future<String> simulateNetworkCall()
````

---

## 1. Encadenar Múltiples Futuros

**Obligatorio**
**Objetivo:** Comprender cómo ejecutar tareas asíncronas de manera secuencial.

### Instrucciones

* Escribir una función que:

  1. Espere 1 segundo y muestre `"Step 1"`.
  2. Espere otro segundo y muestre `"Step 2"`.
  3. Retorne `"Done"`.

**Resultado Esperado:** Los mensajes aparecen con 1 segundo de diferencia; la función retorna `"Done"`.

**Nombre de la función:**

```dart
Future<String> multiStepProcess()
```

---

## 2. Crear un Stream desde una Lista

**Obligatorio**
**Objetivo:** Aprender a emitir valores como un stream.

### Instrucciones

* Crear una función que reciba una lista de enteros y retorne un stream que emita cada ítem con un retardo de 500ms entre ellos.

**Resultado Esperado:** Un `Stream<int>` que emite valores a intervalos de 0.5 segundos.

**Nombre de la función:**

```dart
Stream<int> emitWithDelay(List<int> values)
```

---

## 3. Escuchar y Cancelar un Stream

**Obligatorio**
**Objetivo:** Trabajar con suscripciones y control de streams.

### Instrucciones

* Suscribirse al stream creado en la Tarea 2.
* Cancelar la suscripción después de 3 emisiones.

**Resultado Esperado:** Solo se imprimen los primeros 3 ítems de la lista.

**Nombre de la función:**

```dart
void listenAndCancel(Stream<int> stream)
```

---

## 4. Manejar Errores en Código Asíncrono

**Obligatorio**
**Objetivo:** Introducir manejo robusto de errores.

### Instrucciones

* Modificar `simulateNetworkCall()` para que aleatoriamente lance una excepción (`"Network error"`) o retorne datos.
* Usar `try/catch` para manejar la excepción y retornar `"Fallback data"`.

**Resultado Esperado:** La función retorna `"Data received"` o `"Fallback data"`, dependiendo del error.

**Nombre de la función:**

```dart
Future<String> safeNetworkCall()
```

---

## 5. Operaciones Asíncronas en Paralelo

**Obligatorio**
**Objetivo:** Usar `Future.wait` para concurrencia.

### Instrucciones

* Crear 3 llamadas API simuladas usando `Future.delayed` que retornen cadenas distintas después de diferentes retrasos (1s, 2s, 3s).
* Usar `Future.wait` para ejecutarlas todas y retornar el resultado combinado como una `List<String>`.

**Resultado Esperado:**

```dart
["First", "Second", "Third"]
```

**Nombre de la función:**

```dart
Future<List<String>> runParallelCalls()
```