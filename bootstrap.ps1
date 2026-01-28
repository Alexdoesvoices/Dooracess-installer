Clear-Host
Write-Host "--- NSD Selector Menue ---" -ForegroundColor Cyan
Write-Host "Select your building"
Write-Host "1) Elementary"
Write-Host "2) Junior High"
Write-Host "3) High School"
Write-Host "Q) Quit"
Write-Host "-------------------"


# Define the path



$choice = Read-Host "Please select an option"
switch ($choice) {
    '1' {
        Echo "Starting Elementary setup process:"
        iex (curl alexdoesvoices.github.io/Dooracess-installer/school/elem/setup.ps1)
        
    }
    '2' {
        Echo "Starting Junior High setup process:"
        iex (curl alexdoesvoices.github.io/Dooracess-installer/school/jh/setup.ps1)
    }
    '3' {
        Echo "Starting HighSchool setup process:"
        iex (curl alexdoesvoices.github.io/Dooracess-installer/school/hs/setup.ps1)
    }
    'Q' {
        Write-Host "Exiting..." -ForegroundColor Gray
        exit
    }
    Default {
        Write-Host "Invalid selection. Please try again." -ForegroundColor Red
    }
}