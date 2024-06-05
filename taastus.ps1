# Funktsioon kuupäeva formaadis PP.MM.YYYY hankimiseks
function Get-DateFormatted {
    return (Get-Date).ToString("dd.MM.yyyy")
}

# Loome Backup kausta, kui seda pole olemas
$backupDir = "C:\Backup"
if (-Not (Test-Path -Path $backupDir)) {
    New-Item -ItemType Directory -Path $backupDir
}

# Hankime kõik kasutajad
$users = Get-LocalUser

foreach ($user in $users) {
    # Kontrollime, kas kasutaja kodukataloog on olemas
    $userProfilePath = "C:\Users\$($user.Name)"
    if (Test-Path -Path $userProfilePath) {
        # Loome varukoopia failinime formaadis kasutajanimi-PP.MM.YYYY.zip
