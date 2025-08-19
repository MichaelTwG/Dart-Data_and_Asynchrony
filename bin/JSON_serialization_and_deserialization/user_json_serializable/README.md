# 4. Automatizar con `json_serializable`

## Obligatorio
**Objetivo:** Aprender a automatizar la serialización de JSON.

## Instrucciones:
* Agregar `json_serializable` y `build_runner` a `pubspec.yaml`.
* Anotar la clase `User` con `@JsonSerializable()`.
* Usar la directiva `part` y ejecutar el build para generar el código de serialización.

## Resultado Esperado:**

* Se generan archivos como `user.g.dart`.

* `User.fromJson()` y `User.toJson()` funcionan sin implementación manual.

* **Paquetes:** `json_serializable`, `build_runner`
