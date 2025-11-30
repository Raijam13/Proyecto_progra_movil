# Plan de Resolución de Bugs - Frontend

## Objetivo
Corregir los errores reportados en la aplicación Flutter para mejorar la estabilidad y experiencia de usuario.

## Bugs Identificados y Soluciones

### 1. Editar foto no funciona
*   **Problema**: La funcionalidad de cambiar la foto de perfil no responde o no guarda.
*   **Solución**:
    *   Revisar `PerfilController` y `PerfilService`.
    *   Verificar permisos de galería/cámara.
    *   Asegurar que la imagen se envíe correctamente al backend (multipart/form-data o base64).

### 2. Cuenta creada no se muestra en el panel
*   **Problema**: Al crear una cuenta, la lista en el Dashboard o lista de cuentas no se actualiza.
*   **Solución**:
    *   En `CuentasController`, asegurar que se llame a `fetchCuentas()` (o similar) después de una creación exitosa.
    *   Verificar si se está usando `Get.find<CuentasController>()` para actualizar la instancia correcta.

### 3. Navegación buggeada
*   **Problema**: Comportamiento errático al navegar entre pantallas.
*   **Solución**:
    *   Revisar el uso de `Get.toNamed`, `Get.off`, `Get.offAll`.
    *   Asegurar que no se apilen pantallas innecesariamente.

### 4. Servicios con URL hardcodeada
*   **Estado**: **Corregido**. Se actualizaron todos los servicios a `127.0.0.1`.
*   **Acción**: Verificar que no quede ninguno pendiente.

### 5. Login/Register tapados por teclado
*   **Problema**: Los campos de texto quedan ocultos al abrir el teclado.
*   **Solución**:
    *   Envolver el contenido de `LoginPage` y `SignUpPage` en un `SingleChildScrollView`.
    *   Usar `Physics` adecuado para permitir scroll.

### 6. Error al guardar registro (FormatException)
*   **Problema**: Error de formato al procesar la respuesta o input, la vista no se actualiza aunque la BD sí.
*   **Solución**:
    *   Revisar el parsing de la respuesta en `RegistrosService`.
    *   Manejar la excepción en `RegistrosController` para actualizar la UI incluso si el formato de respuesta no es el esperado (o corregir el formato).

### 7. Botón guardar deshabilitado (Ingreso/Gasto)
*   **Problema**: Al cambiar el tipo de transacción, la validación del formulario falla o no se resetea.
*   **Solución**:
    *   Revisar la lógica reactiva (`Obx` o `GetBuilder`) en el botón de guardar.
    *   Asegurar que las variables de estado (`tipo`, `categoria`, `cuenta`) sean válidas para el nuevo tipo seleccionado.

### 8. Loop en Pagos Planificados
*   **Problema**: Navegación circular entre Splash y Agregar Pago.
*   **Solución**:
    *   En `PagosPlanificadosPage`, ajustar la navegación del botón "Agregar" para que vaya a la página de formulario y permita volver atrás correctamente.

### 9. Error al cargar categorías
*   **Problema**: La estructura del JSON de respuesta no coincide con el modelo.
*   **Solución**:
    *   Actualizar `CategoriasModel` (o el parsing en el servicio) para manejar la estructura anidada:
        ```json
        { "data": { "categorias": [...], "frecuencias": [...], ... } }
        ```
    *   Asegurar que se mapeen correctamente los campos `id` y `nombre`.
