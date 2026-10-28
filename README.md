# Proyecto MVC Java - demo-mvc

Aplicación web de ejemplo con Java 17, Maven, Jakarta Servlet 6.0 y JSP. El DAO contiene datos de muestra en memoria.

## Entorno verificado

- JDK Temurin 17.0.20.1 y Maven 3.9.6.
- Extensiones de VS Code: Extension Pack for Java y Community Server Connectors.
- Apache Tomcat 10.1.10, detectado en la instalación local de Community Server Connectors.
- El puerto 8080 está ocupado por otro servicio; el conector HTTP de Tomcat se configuró en el puerto 8081.
- `JAVA_HOME` no está definido globalmente. Para iniciar Tomcat manualmente desde una terminal PowerShell, ejecuta:

```powershell
$env:JAVA_HOME = 'C:\Program Files\Eclipse Adoptium\jdk-17.0.20.101-hotspot'
$env:CATALINA_HOME = 'C:\Users\cuthulu\.rsp\redhat-community-server-connector\runtimes\installations\tomcat-10.1.10\apache-tomcat-10.1.10'
$env:CATALINA_BASE = $env:CATALINA_HOME
& "$env:CATALINA_HOME\bin\catalina.bat" run
```

## Compilar

Desde esta carpeta, ejecutar `mvn clean package`. El artefacto generado es `target/demo-mvc.war`.

## Desplegar y ejecutar

1. En VS Code, abre **Servers** y selecciona la instancia `apache-tomcat-10.1.10`.
2. Si el WAR no aparece en el servidor, usa **Servers: Add Deployment…** y selecciona `target/demo-mvc.war`.
3. Inicia Tomcat desde la vista **Servers**.
4. Abre `http://localhost:8081/demo-mvc/usuarios`.

El controlador `/usuarios` consulta el DAO, añade la lista al request y la reenvía a `index.jsp`.

