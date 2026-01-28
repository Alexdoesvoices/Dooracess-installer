    $basePath = Join-Path -Path $HOME -ChildPath "scripts"
    $doorPath = Join-Path -Path $basePath -ChildPath "Dooraccess"
    $scriptFolder = Join-Path -Path $doorPath -ChildPath "HS"

    # 2. Create the full folder structure if it's missing
    if (-not (Test-Path $scriptFolder)) {
        New-Item -Path $scriptFolder -ItemType Directory -Force | Out-Null
        Write-Host "Created target folder: $scriptFolder" -ForegroundColor Green
    }

    # 3. Setup URL and temporary Zip location
    $url = "https://alexdoesvoices.com/school/test2.zip"
    $zipPath = Join-Path -Path $env:TEMP -ChildPath "test2.zip" # Save zip in Temp folder

    Write-Host "Downloading from alexdoesvoices.com..." -ForegroundColor Cyan

    try {
        # 4. Download
        Invoke-WebRequest -Uri $url -OutFile $zipPath -ErrorAction Stop

        # 5. Extract files directly into the Elem folder
        Write-Host "Placing files into HS folder..." -ForegroundColor Yellow
        Expand-Archive -Path $zipPath -DestinationPath $scriptFolder -Force
        
        # 6. Cleanup the zip from the Temp folder
        Remove-Item -Path $zipPath
        
        # 7. Unblock the scripts
        Get-ChildItem -Path $scriptFolder -Filter *.ps1 -Recurse | Unblock-File
        
        Write-Host "Done! Files are now located in: $scriptFolder" -ForegroundColor Green
    }
    catch {
        Write-Host "Failed to download or extract. Check your URL or permissions." -ForegroundColor Red
    }


    # Now Ask for the api key and store it to a varible in .env that is called by the files in the folder

    $spacer = '-------------------------------------------'

    Write-Host ""
    Write-Host ""
    Write-Host ""
    Write-Host $spacer -ForegroundColor Green
    Write-Host "This system requires a API key to operate:"
    $APIKEY = Read-Host "Please enter your key here: "
    New-Item -Path $scriptFolder -Name ".env.ps1" -Value "`$APIKEY = '$APIKEY'" -Force

