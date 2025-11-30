# Plan de Resolución de Bugs - Backend

## Objetivo
Corregir errores lógicos y de seguridad en el backend Ruby/Sinatra.

## Bugs Identificados y Soluciones

### 1. Lista de cuentas no filtra por usuario
*   **Problema**: Al registrar un gasto, se ven las cuentas de todos los usuarios.
*   **Solución**:
    *   En `CuentasController` (o el endpoint usado para el dropdown), asegurar que la consulta SQL filtre por `usuario_id`.
    *   Verificar que el `usuario_id` se esté obteniendo correctamente de la sesión o token.

### 2. Estructura de respuesta de Categorías
*   **Problema**: El frontend reporta una estructura específica que debe mantenerse o validarse.
*   **Solución**:
    *   Verificar `PagosPlanificadosController` (endpoint `/catalogos`) y `CategoriasController`.
    *   Asegurar que devuelvan:
        ```json
        {
          "success": true,
          "data": {
            "categorias": [...],
            "frecuencias": [...],
            ...
          }
        }
        ```
    *   Estandarizar usando el helper `GenericResponse`.
