# Define the URL of the latest version information (replace with your GitHub API endpoint)
$latestVersionUrl = "https://github.com/electric-otter/RenderX/releases/latest" 

# Function to check for updates
function Check-ForUpdates {
    try {
        # Fetch the latest release information from GitHub API
        $latestRelease = Invoke-WebRequest -Uri $latestVersionUrl -UseBasicParsing
        if ($latestRelease.StatusCode -ne 200) {
            Write-Warning "Failed to fetch latest release from GitHub: $($latestRelease.StatusCode)"
            return $false
        }

        # Extract the latest version tag from the response (adjust based on your API response structure)
        $latestVersion = ($latestRelease.Content | ConvertFrom-Json).tag_name

        # Get the current installed version (replace with your logic)
        $currentVersion = Get-ItemProperty -Path "C:\Program Files\YourRenderingEngine\version.txt" -Name Version

        # Compare versions
        if ([version]::Parse($latestVersion) -gt [version]::Parse($currentVersion)) {
            # Notify the user
            [System.Windows.Forms.MessageBox]::Show("A new version of the renderX engine is available! Please update.", "Update Available", [System.Windows.Forms.MessageBoxButtons]::OK)
            return $true
        } else {
            Write-Host "You are running the latest version."
            return $false
        }
    } catch {
        Write-Warning "Failed to check for updates: $($_.Exception.Message)"
        return $false
    }
}

# Check for updates
if (Check-ForUpdates) {
    # Optionally, provide a link to the release page on GitHub
    [System.Windows.Forms.MessageBox]::Show("Click here to download the update.", "Download Link", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information, 0, 0, 0, "https://github.com/electric-otter/RenderX/releases/latest") 
}

# Schedule the script to run periodically (e.g., daily)
Register-ScheduledTask -TaskName "CheckForRenderingEngineUpdates" -Trigger (New-ScheduledTaskTrigger -Daily) -Action (New-ScheduledTaskAction -Execute @('powershell.exe', '-File', "$($MyInvocation.MyCommand.Definition)") )
