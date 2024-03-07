# This script contains a fn that will rebuild the buffer segments from `split-file.ps1`

# It searches the cwd for files matching the `$inFilePattern` which defaults to filenames that are just digits
# The output should resemble the original file before it was split (contents reassembled in correct order)

# Invoke like this:
# .\converge-files.ps1 -inFilePattern "" -outFile "reassembled_file.zip" -buffSize 4MB

param(
    [string]$inFilePattern,
    [string]$outFile,
    [int]$buffSize = 4MB
)

function converge {
  param(
      [string]$inFilePattern,
      [string]$outFile
  )

  $files = Get-ChildItem $inFilePattern | Where-Object { $_.Name -match '^\d+$' } | Sort-Object { [int]$_.Name }

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

# Calls the converge function with the provided parameters
converge -inFilePattern $inFilePattern -outFile $outFile -buffSize $buffSize
