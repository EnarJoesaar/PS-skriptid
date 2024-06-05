# 1. Küsime kasutaja ees- ja perenime
$firstName = Read-Host "Palun sisestage kasutaja eesnimi"
$lastName = Read-Host "Palun sisestage kasutaja perenimi"

# 2. Loome kasutajanime, teisendades sümbolid ladina tähtedeks
function Transliterate {
    param(
        [string]$input
    )
    $transliterations = @{
        "ä" = "a"; "Ä" = "A";
        "ö" = "o"; "Ö" = "O";
        "ü" = "u"; "Ü" = "U";
        "õ" = "o"; "Õ" = "O";
        "š" = "s"; "Š" = "S";
        "ž" = "z"; "Ž" = "Z";
        "š" = "s"; "Š" = "S";
        "ø" = "o"; "Ø" = "O";
        "æ" = "ae"; "Æ" = "AE";
    }
    $input.ToCharArray() | ForEach-Object {
        if ($transliterations.ContainsKey($_)) {
            $transliterations[$_]
        } else {
            $_
        }
    } -join ''
}
$username = (Transliterate "$firstName.$lastName").ToLower()

# 3. Kustutame kasutaja
try {
    # Kustutame kasutaja
    Remove-ADUser -Identity $username -ErrorAction Stop
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
