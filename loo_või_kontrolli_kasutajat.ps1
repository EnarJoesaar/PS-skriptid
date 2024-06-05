# 1. Küsime kasutaja ees- ja perenime
$firstName = Read-Host "Palun sisestage kasutaja eesnimi"
$lastName = Read-Host "Palun sisestage kasutaja perenimi"

# 2. Loome kasutajanime
$username = "$($firstName).$($lastName)".ToLower()

# 3. Kontrollime, kas kasutaja juba eksisteerib AD-s
if (Get-LocalUser -Name $username -ErrorAction SilentlyContinue) {
    Write-Host "Kasutaja $username on juba olemas AD-s."
} else {
    # 4. Lisame kasutaja AD-sse
    try {
        New-LocalUser -Name $username -FullName "$firstName $lastName" -Password (ConvertTo-SecureString "Parool1!" -AsPlainText -Force) -AccountNeverExpires
        # Kontrollime, kas kasutaja loomine õnnestus
        if ($?) {
            Write-Host "Kasutaja $username on edukalt loodud."
        } else {
            Write-Host "Kasutaja loomine ebaõnnestus."
        }
    } catch {
        # 5. Veateate kuvamine, kui kasutaja loomine ebaõnnestus
        Write-Host "Kasutaja loomine ebaõnnestus: $_"
    }
}

# Veateadete taseme muutmine (lisatakse pärast kontrolli või silumiseks)
# $ErrorActionPreference = "SilentlyContinue"
