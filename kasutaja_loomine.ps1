# 1. Kasutaja ees- ja perenime sisestamine
$firstName = Read-Host "Palun sisestage eesnimi"
$lastName = Read-Host "Palun sisestage perenimi"

# 2. Kasutajanime ja täisnime loomine
$username = "$($firstName).$($lastName)".ToLower()
$fullname = "$($firstName) $($lastName)"

# 3. Kasutaja loomine
try {
    # Kasutaja loomine
    New-LocalUser -Name $username -FullName $fullname -Password (ConvertTo-SecureString "Parool1!" -AsPlainText -Force) -AccountNeverExpires
    # Kontroll, kas kasutaja loomine õnnestus
    if ($?) {
        Write-Host "Kasutaja $fullname ($username) on edukalt loodud."
    } else {
        Write-Host "Kasutaja loomine ebaõnnestus."
    }
} catch {
    # 4. Veateate kuvamine, kui kasutaja loomine ebaõnnestus
    Write-Host "Kasutaja loomine ebaõnnestus: $_"
}

# Veateadete taseme muutmine (lisatakse pärast kontrolli või silumiseks)
# $ErrorActionPreference = "SilentlyContinue"
