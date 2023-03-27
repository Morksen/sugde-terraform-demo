Write-Host "Getting environment variables from .env"
$file = Get-Content "$PSScriptRoot/../.env"
 foreach($line in $file) {
  try {
    if ([string]::IsNullOrWhiteSpace($line)) {
      continue
    }

    if ($line.StartsWith('#')) {
      Write-Host $line
      continue
    }

    $name, $value = $line.split('=')

    if ([string]::IsNullOrWhiteSpace($name) -or $name.Contains('#')) { continue }

    if (-not [string]::IsNullOrWhiteSpace($value) -and $value.Contains('#')) {
      $value, $comment = $value.split('#')
      Write-Host $comment
    }

    $name = $name.Trim()
    Write-Host "Set env:$($name)"
    Set-Content env:\$name $value.Trim()
  } catch {
    Write-Error $_
  }
}

Write-Host "az login"
az login --tenant="$($env:TENANT_ID)"

Write-Host "az account set"
az account set --subscription="$($env:SUBSCRIPTION_ID)"
