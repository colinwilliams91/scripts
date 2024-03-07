# This script contains a fn that will rebuild the buffer segments from `split-file.ps1`

# It searches the cwd for files matching filenames that are incrementing digits
# The output should resemble the original file before it was split (contents reassembled in correct order)

# Invoke like this:
# .\converge-files.ps1 -outFile "reassembled_file.zip" -buffSize 4MB

param(
    [string]$outFile,
    [int]$buffSize = 4MB
)

function converge {

  $files = Get-ChildItem | Where-Object { $_.Name -match '^\d+$' } | Sort-Object { [int]$_.Name }

  $outStream = [System.IO.File]::OpenWrite($outFile)

  foreach ($file in $files) {
      $inStream = [System.IO.File]::OpenRead($file.FullName)
      $buffer = New-Object byte[] $buffSize
      $bytesRead = $inStream.Read($buffer, 0, $buffSize)
      $outStream.Write($buffer, 0, $bytesRead)
      $inStream.Close()
  }

  $outStream.Close()
  Write-Output "Re-assembled file written to $outFile"
}

# splatting the $PSBoundParameters variable will pass all the parameter arguments
# that were originally passed to the script, to the `converge` function
converge @PSBoundParameters
