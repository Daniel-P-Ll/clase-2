$ErrorActionPreference = 'Stop'

$projectRoot = $PSScriptRoot
$maven = 'C:\Users\cuthulu\.tools\apache-maven-3.9.6\bin\mvn.cmd'
$tomcat = 'C:\Users\cuthulu\.rsp\redhat-community-server-connector\runtimes\installations\tomcat-10.1.10\apache-tomcat-10.1.10'
$war = Join-Path $projectRoot 'target\demo-mvc.war'
$tomcatWebapps = Join-Path $tomcat 'webapps'
$url = 'http://localhost:8081/demo-mvc/usuarios'

try {
    if (-not (Test-Path -LiteralPath $maven)) {
        throw "Maven no se encontro en: $maven"
    }
    if (-not (Test-Path -LiteralPath (Join-Path $projectRoot 'pom.xml'))) {
        throw "No se encontro pom.xml en la carpeta del proyecto: $projectRoot"
    }
    if (-not (Test-Path -LiteralPath $tomcatWebapps)) {
        throw "No se encontro la carpeta webapps de Tomcat: $tomcatWebapps"
    }

    Push-Location $projectRoot
    try {
        Write-Host 'Compilando el proyecto con Maven...'
        & $maven -B clean package
        if ($LASTEXITCODE -ne 0) {
            throw "Maven termino con codigo $LASTEXITCODE."
        }
    }
    finally {
        Pop-Location
    }

    if (-not (Test-Path -LiteralPath $war)) {
        throw "No se genero el archivo WAR: $war"
    }

    Write-Host 'Copiando el WAR a Tomcat...'
    Copy-Item -LiteralPath $war -Destination (Join-Path $tomcatWebapps 'demo-mvc.war') -Force

    Write-Host 'Esperando a que Tomcat actualice la aplicacion...'
    Start-Sleep -Seconds 12
    $response = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 10
    if ([int]$response.StatusCode -ne 200) {
        throw "Tomcat respondio con HTTP $([int]$response.StatusCode)."
    }

    Write-Host "Actualizacion correcta. Abre o recarga: $url" -ForegroundColor Green
}
catch {
    Write-Error "No se pudo actualizar la aplicacion: $($_.Exception.Message)"
    Write-Host 'Verifica que Tomcat este iniciado en el puerto 8081.'
    exit 1
}
