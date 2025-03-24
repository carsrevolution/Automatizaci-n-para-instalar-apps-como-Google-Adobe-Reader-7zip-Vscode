# Instalar Google Chrome
Write-Host "Descargando e Instalando Google Chrome..."
$chromeUrl = "http://dl.google.com/chrome/install/375.126/chrome_installer.exe"
$descargasPath = "C:\Users\$env:USERNAME\Downloads"
$chromePath = Join-Path -Path $descargasPath -ChildPath "chrome_installer.exe"

Invoke-WebRequest -Uri $chromeUrl -OutFile $chromePath
Start-Process -FilePath $chromePath -ArgumentList "/silent /install" -Wait

# Establecer Chrome como navegador predeterminado
# Script para establecer Google Chrome como navegador predeterminado en Windows 10
# Guardar este archivo con extensión .ps1 y ejecutarlo como administrador

# Ruta del ejecutable de Chrome
$ChromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$ChromePathx86 = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"

# Verificar si Chrome está instalado
if (Test-Path $ChromePath) {
    $ChromeExe = $ChromePath
} elseif (Test-Path $ChromePathx86) {
    $ChromeExe = $ChromePathx86
} else {
    Write-Host "Google Chrome no está instalado en las rutas predeterminadas." -ForegroundColor Red
    Write-Host "Por favor, instala Chrome o verifica su ubicación." -ForegroundColor Red
    exit
}

# Función para establecer Chrome como navegador predeterminado
function Set-ChromeAsDefaultBrowser {
    # Abrir el panel de Control de aplicaciones predeterminadas
    Start-Process "ms-settings:defaultapps"
    
    Write-Host "El panel de Control de aplicaciones predeterminadas se ha abierto." -ForegroundColor Green
    Write-Host "Por favor, sigue estos pasos:" -ForegroundColor Yellow
    Write-Host "1. En la sección 'Navegador web', haz clic en el navegador actual" -ForegroundColor Yellow
    Write-Host "2. Selecciona 'Google Chrome' de la lista" -ForegroundColor Yellow
    Write-Host "3. Cierra la ventana de configuración" -ForegroundColor Yellow
}

# Función para comprobar si Chrome está registrado como navegador
function Register-ChromeBrowser {
    try {
        Write-Host "Registrando Chrome como navegador..." -ForegroundColor Cyan
        Start-Process $ChromeExe -ArgumentList "--make-default-browser" -Wait
        Write-Host "Chrome ha sido registrado como navegador." -ForegroundColor Green
    } catch {
        Write-Host "Error al registrar Chrome: $_" -ForegroundColor Red
    }
}

# Ejecutar las funciones
Write-Host "Configurando Google Chrome como navegador predeterminado..." -ForegroundColor Cyan
Register-ChromeBrowser
Set-ChromeAsDefaultBrowser

Write-Host "`nProceso completado. Si Chrome no se estableció como predeterminado automáticamente, sigue las instrucciones mostradas." -ForegroundColor Green

# Instalar Visual Studio Code
Write-Host "Instalando Visual Studio Code..."
$vscodeUrl = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64"
$vscodePath = Join-Path -Path $descargasPath -ChildPath "VSCodeSetup.exe"

Invoke-WebRequest -Uri $vscodeUrl -OutFile $vscodePath
Start-Process -FilePath $vscodePath -ArgumentList "/silent /install" -Wait

# Descargando e instalando adobe reader lite
$adobeReaderUrl = "https://d1uclk7mkn1jje.cloudfront.net/gSfcwnVDrhro.exe"
$descargasPath = "C:\Users\$env:USERNAME\Downloads"
$adobeReaderPath = Join-Path -Path $descargasPath -ChildPath "AdobeReaderInstaller.exe"


Invoke-WebRequest -Uri $adobeReaderUrl -OutFile $adobeReaderPath
$filteredFile = Get-ChildItem -Path $descargasPath -Filter "*adobe*.exe" | Select-Object -First 1

if ($filteredFile) {
    # Instalar Adobe Acrobat Reader
    Start-Process -FilePath $filteredFile.FullName -ArgumentList "/sAll /rs /r /l /msi" -Wait
} else {
    Write-Host "No se encontró un archivo .exe que contenga 'adobe' en su nombre."
}

# Instalar otras aplicaciones
Write-Host "Instalando otras aplicaciones..."
$aplicaciones = @(
    @{
        Nombre = "7z1900.exe"
        Url = "https://www.7-zip.org/a/7z1900.exe"
        Argumentos = "/S"
    },
    @{
        Nombre = "LibreOffice.msi"
        Url = "https://www.libreoffice.org/donate/dl/win-x86_64/25.2.1/es/LibreOffice_25.2.1_Win_x86-64.msi"
        Argumentos = "/quiet /install"
    }
)

foreach ($aplicacion in $aplicaciones) {
    Write-Host "Instalando $($aplicacion.Nombre)..."
    $descargasPath = "C:\Users\$env:USERNAME\Downloads"
    $vscodePath = Join-Path -Path $descargasPath -ChildPath "$($aplicacion.Nombre)"
    
    Invoke-WebRequest -Uri $aplicacion.Url -OutFile $vscodePath
    Start-Process -FilePath $vscodePath -ArgumentList $aplicacion.Argumentos -Wait
}