# Proyecto Programación Movil

## Enunciado

Proyecto de aplicación móvil de **wallet** para **gestión de finanzas personales**, que permite a los usuarios definir metas de ahorro personalizadas y registrar tanto ingresos periódicos (como nóminas) como esporádicos, así como gestionar sus gastos mediante categorías predefinidas y personalizables con subcategorías creadas por el usuario. La aplicación registrará automáticamente la fecha de cada transacción y contará con un módulo de reportes que mostrará gráficos evolutivos de los ahorros mensuales, culminando con un informe comparativo que calculará el porcentaje de ahorro respecto a los ingresos totales y su comparativa con el mes anterior.

Además, integrará un **sistema de inteligencia artificial** que actuará como asistente financiero personalizado, el cual tendra funciones de asesoría y educación financiera. Por ejemplo, si el usuario no alcanza su meta de ahorro semanal o mensual, podrá solicitar un análisis a la IA que evaluará todos los gastos, identificará aquellos innecesarios basándose en los comentarios registrados, detectará gastos "hormiga" recurrentes y establecerá límites personalizados antes de que se conviertan en erogaciones significativas, ofreciendo recomendaciones específicas para optimizar sus finanzas.

## Explicación del entorno de desarrollo
**Listado de herramientas del entorno de desarrollo**
- Android Studio: 

    Se utilizará para instalar el Android SDK Command-line tools.
- Flutter SDK: 

    Contiene todo lo necesario para desarrollar el proyecto móvil.
- Visual Studio Code: 

    Es el editor de codigo escogido para el desarrollo.

**Guía de configuración del ambiente de desarrollo en Flutter**
1. Instalación de Android Studio
- Instalamos la última versión de Android Studio.
![](docs/img/image7.png)
- Después de instalarlo, tendremos este menú.
![](docs/img/image10.png)
- Hacemos click en more actions y luego en SDK Manager.
![](docs/img/image5.png)
- Instalamos Android SDK Command-line Tools
![](docs/img/image6.png)
2. Instalación de Flutter SDK
- Una vez instalado podemos cerrar Android Studio. Ahora vamos a la página de flutter y descargamos el Flutter SDK para windows.
![](docs/img/image4.png)
- De preferencia, creamos una carpeta en nuestro disco C llamada dev, allí descomprimimos el Flutter SDK.
![](docs/img/image9.png)
- Entramos en la carpeta y copiamos la ruta del directorio bin, en este caso es ‘C:\dev\flutter\bin’. Apretamos la tecla Win y buscamos ‘Editar las variables de entorno del sistema’ y le damos enter. Debemos estar en la siguiente ventana.
![](docs/img/image3.png)
- Le damos click en Variables de entorno… y luego le damos click al registro ‘Path’.
![](docs/img/image1.png)
- En caso no aparezca ‘Path’ lo demos crear. Presionamos ‘Editar’ y pegamos la ruta ‘C:\dev\flutter\bin’. Luego presionamos en ‘Aceptar’.
![](docs/img/image8.png)
3. Aceptar licencias de Android
- Ahora debemos abrir nuestra terminal y ejecutar el comando ‘flutter doctor --android-licenses’. Aceptamos todas las condiciones. Al final nos debe salir este mensaje.
```bash
flutter doctor --android-licenses
```
![](docs/img/image11.png)

4. Verificar la correcta instalación de Flutter
- Abrimos la terminal y ejecutamos el comando ‘flutter doctor’ y si nos debe salir esta salida.
```bash
flutter doctor
```
![](docs/img/image2.png)
- Si nos sale una alerta en Visual Studio lo podemos obviar ya que no desarrollaremos para Windows.

5. Instalación y configuración de Visual Studio Code
- Vamos a la página de Visual Studio Code y descargamos el instalador, en este caso el de windows.
![](docs/img/image12.png)
- Despues de su instalación, descargamos el plugin de flutter.
![](docs/img/image13.png)
- Probamos crear un proyecto de flutter apretando 'Ctrl + shift + p' y le damos click en 'Flutter: New proyect'.
![](docs/img/image14.png)
- Luego hacemos click en 'Application' y escogemos el folder donde guardaremos la aplicación de prueba.
![](docs/img/image15.png)
- Después de escoger la carpeta nos pedira el nombre de la aplicación, lo dejamos por defecto y presionamos enter. Se generará la estructura del proyecto.
![](docs/img/image16.png)
- Para probar que flutter funciona correctamente podemos probar ejecutar el proytecto en nuestro navegador, en un dispositivo android via USB o en un emulador. En esta ocasion lo probaré en mi navegador. Primero escogemos donde ejecutaremos el proyecto y luego hacemos click en 'Run and Debug'.
![](docs/img/image17.png)
- Deberiamos tener algo similar a esto.
![](docs/img/image18.png)

## Diagrama de despliegue 
La arquitectura está conformada por un dispositivo Android, donde se ejecuta la aplicación móvil desarrollada en Flutter. Este cliente se conecta a través de Internet mediante protocolo HTTPS a una API REST implementada en Ruby, desplegada en un servidor EC2 de AWS. El backend gestiona la lógica de negocio y el acceso a la base de datos SQLite3, encargada de almacenar de manera persistente la información de usuarios, transacciones y metas. Adicionalmente, el backend consume una API externa de LLM (OpenAI), que brinda el servicio de inteligencia artificial para generar análisis financieros y recomendaciones personalizadas.
![](docs/img/Diagrama_de_despliegue1.png)
## Requerimientos no funcionales 
1. **Completitud funcional**

    El producto software cumple todos los requerimientos especificados por el usuario.
2. **Disponibilidad**

    El producto software tiene una disponibilidad del 99%.
3. **Coexistencia**

    El producto software es capaz de coexistir con la API OpenAI, compartiendo recursos e información común.
4. **Aprendizabilidad**

    El usuario puede aprender a usar el software en 1h.
5. **Reconocibilidad de la adecuación**

    El usuario es capaz de entender si el software cubre sus necesidades.
6. **Autenticidad**

    El sistema tiene la capacidad para demostrar que la identidad de un sujeto o recurso es la que se afirma.
7. **Capacidad para ser probado**
    
    Facilidad para probar componentes o modulos dentro del sistema.
8. **Modularidad**

    El producto software puede soportar cambios en un componente sin que afecten a otros componentes.
9. **No repudio**

    Capacidad de demostrar las acciones o eventos que han tenido lugar, de manera que dichas acciones o eventos no puedan ser repudiados posteriormente.
10. **Compatibilidad**

    El sistema puede ser usado en Andorid e iOS sin perder funcionalidades.
## Diagramas de caso de uso (Requerimientos funcionales)
![alt text](image-1.png)
### Descipción de casos de uso
| ID  | Requerimiento                           | Como    | Quiero                                                                 | Para                                                                                       |
|-----|-----------------------------------------|---------|------------------------------------------------------------------------|-------------------------------------------------------------------------------------------|
| 1   | Crear usuario                           | Usuario | Crear una cuenta                                                        | Iniciar sesión y poder guardar mi información en mi cuenta                                |
| 2   | Inicio de sesion (Login)                | Usuario | Ingresar al sistema                                                     | Poder acceder a todas las funcionalidades disponibles dentro del sistema.                 |
| 3   | Recuperar contraseña                    | Usuario | Poder recuperar mi contraseña                                           | Poder acceder al sistema por si olvido mi contraseña                                      |
| 4   | Registro de medio de ingresos de efectivo | Usuario | Crear mis medios de ingresos como efectivo o tarjeta                   | Poder gestionar mi ingreso y salida de efectivo en mi cuenta                              |
| 5   | Mantenimiento de gastos                 | Usuario | Hacer mantenimiento a los registros de mis gastos que realice a lo largo del tiempo | Tener control sobre los posibles errores al registrar mis gastos o revisar al detalle mis gastos |
| 6   | Crear planes de ahorro                  | Usuario | Crear planes de ahorro donde defina una meta de ahorro y un plazo para lograrlo | Mis metas personales financieras                                                          |
| 7   | Asistente financiero                    | Usuario | Tener un asistente financiero con funcionalidades definidas que pueda darme recomendaciones financieras en base a mis gastos, me de tips de educación financiera | Recibir un asesoramiento financiero apropiado acorde a mi realidad                        |
| 8   | Mostrar gráficos de la tendencia del saldo | Usuario | Quiero analizar los ingresos y gastos que realizo mostrando las tendencias de mis gastos con gráficos | Visualizar de mejor manera y entender como ha estado funcionando los gastos dentro de un periodo de tiempo |
| 9   | Límite de gasto                         | Usuario | Definir un límite de gasto semanal, mensual o anual asociado a mi perfil personal | Tener un control sobre lo que espero gastar en esos periodos de tiempo                    |
| 10  | Registrar un gasto                      | Usuario | Registrar manualmente mis gastos                                        | Mantener un registro de mis transacciones.                                                |
| 11  | Registrar un ingreso                    | Usuario | Registrar manualmente mis ingresos                                      | Tener control completo de mi flujo de dinero                                              |
| 12  | Categorizar transacciones               | Usuario | Asignar categorías a mis gastos e ingresos                              | Analizarlos mejor                                                                         |
| 13  | Establecer metas de ahorro              | Usuario | Crear metas de ahorro con un monto y fecha límite                       | Organizar mis finanzas personales                                                         |
| 14  | Recibir alertas de metas                | Usuario | Recibir notificaciones de acuerdo al progreso de mis metas de ahorro    | Mantenerme al tanto                                                                       |
| 15  | Seguimiento de metas de ahorro          | Usuario | Ver el progreso de mis planes de ahorro                                 | Mantenerme motivado y alcanzar mis objetivos                                              |
| 16  | Ver balance total                       | Usuario | Ver un resumen de mi balance total de dinero                            | Tener conocimiento de mis ingresos y gastos mensuales                                     |
| 17  | Ver un reporte de gastos por categoría  | Usuario | Ver el porcentaje de mis gastos según la categoría                      | Saber en qué cosas gasto más                                                              |
| 18  | Ver balance por meses                   | Usuario | Ver el balance de cada mes                                              | Comparar mi rendimiento mensual                                                           |
| 19  | Editar perfil de usuario                | Usuario | Editar mi información personal                                          | Personalizar mi perfil                                                                    |
| 20  | Cambiar moneda                          | Usuario | Cambiar la moneda en la que se muestran mis finanzas                    | Adaptarla según mis necesidades                                                           |

## Descripción de casos de uso (incluye mockups)

Link del figma: https://www.figma.com/design/ZNeflkiIxjQOrTCRmVXfId/Flutter-app---AprendeWallet?node-id=0-1&t=UKAhWFaEcuVQhPK8-1
Contraseña: progmovil

![](docs/img/Mockups/mockup1.png)
![](docs/img/Mockups/mockup2.png)
![](docs/img/Mockups/mockup3.png)
![](docs/img/Mockups/mockup4.png)
![](docs/img/Mockups/mockup5.png)

## Diagrama de base de datos
![](docs/img/Diagrama_bd.png)