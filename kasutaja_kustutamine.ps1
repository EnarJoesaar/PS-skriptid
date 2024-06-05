# 1. Küsime kasutaja ees- ja perenime
$firstName = Read-Host "Palun sisestage kasutaja eesnimi"
$lastName = Read-Host "Palun sisestage kasutaja perenimi"

# 2. Loome kasutajanime
$username = "$($firstName).$($lastName)".ToLower()

# 3. Kustutame kasutaja
try {
    # Kustutame kasutaja
    Remove-LocalUser -Name $username -ErrorAction Stop
    # Kontrollime, kas kasutaja kustutamine õnnestus
    if ($?) {
        Write-Host "Kasutaja $username on edukalt kustutatud."
    } else {
        Write-Host "Kasutaja kustutamine ebaõnnestus."
    }
} catch {
    # 4. Veateate kuvamine, kui kasutaja kustutamine ebaõnnestus
    Write-Host "Kasutaja kustutamine ebaõnnestus: $_"
}

# Veateadete taseme muutmine (lisatakse pärast kontrolli või silumiseks)
# $ErrorActionPreference = "SilentlyContinue"
