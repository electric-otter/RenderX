function Show-LoadingAnimation {
    param(
        [string]$Message = "Loading...",
        [int]$Duration = 5
    )

    $chars = "-/|\"
    $i = 0
    $startTime = Get-Date

    while ((Get-Date) - $startTime).TotalSeconds -lt $Duration {
        Write-Host "$Message [$($chars[$i])]`r" -NoNewline
        $i = ($i + 1) % $chars.Length
        Start-Sleep -Milliseconds 100
    }
    Write-Host " "  # Clear the line
}
