# Funktsioon juhusliku parooli genereerimiseks
function Generate-Password {
    param(
        [int]$length = 10
    )
    $characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()'
    $password = ''
    for ($i = 0; $i -lt $length; $i++) {
        $password += $characters[(Get-Random -Minimum 0 -Maximum $characters.Length)]
    }
    return $password
}

# 1. Küsime kasutaja ees- ja perenime
$firstName = Read-Host "Palun sisestage kasutaja eesnimi"
$lastName = Read-Host "Palun sisestage kasutaja perenimi"

# 2. Loome kasutajanime
$username = "$($firstName).$($lastName)".ToLower()

# 3. Genereerime parooli
$password = Generate-Password

# 4. Loome kasutaja ja salvestame info CSV-faili
try {
    New-LocalUser -Name $username -FullName "$firstName $lastName" -Password (ConvertTo-SecureString $password -AsPlainText -Force) -AccountNeverExpires
    # Kontrollime, kas kasutaja loomine õnnestus
    if ($?) {
        Write-Host "Kasutaja $username on edukalt loodud."
        # Salvestame info CSV-faili
        $userDetails = [PSCustomObject]@{
            Username = $username
            Password = $password
        }
        $userDetails | Export-Csv -Path "$username.csv" -NoTypeInformation
    } else {
        Write-Host "Kasutaja loomine ebaõnnestus."
    }
} catch {
    Write-Host "Kasutaja loomine ebaõnnestus: $_"
}

# Veateadete taseme muutmine (lisatakse pärast kontrolli või silumiseks)
# $ErrorActionPreference = "SilentlyContinue"
