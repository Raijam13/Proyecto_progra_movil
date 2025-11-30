@echo off
echo Configurando conexion con dispositivo Android...
"C:\Users\MIRIAM\AppData\Local\Android\Sdk\platform-tools\adb.exe" reverse tcp:4567 tcp:4567
if %errorlevel% equ 0 (
    echo [EXITO] Redireccion de puertos activa.
    echo Ahora tu celular puede acceder al backend en http://127.0.0.1:4567
) else (
    echo [ERROR] No se pudo conectar con ADB.
    echo Asegurate de que tu celular este conectado por USB y con depuracion USB activada.
)
pause
