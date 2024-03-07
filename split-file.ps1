# This script contains a fn that can split a file into chunks
# This is useful when you can't send a file over email because it is too large

# -inFile is the only argument that NEEDS to be passed in
# file will be split into segments by -buffSize and output into the current working dir

# [SO Docs](https://stackoverflow.com/a/69467602/20575174)

# ######################################################## #
# ######################################################## #
# ######################################################## #

# To Use:
# split-file.ps1 -inFile "C:\path\to\your\file.zip" -outPrefix "" -buffSize 4MB

param(
  [string]$inFile,
  [string]$outPrefix = "",
  [int]$buffSize = 4MB
)

function split($inFile,  $outPrefix, [Int32] $buffSize){

  $stream = [System.IO.File]::OpenRead($inFile)
  $chunkNum = 1
  $barr = New-Object byte[] $buffSize

  while( $bytesRead = $stream.Read($barr,0,$buffsize)){
    $outFile = "$outPrefix$chunkNum"
    $ostream = [System.IO.File]::OpenWrite($outFile)
    $ostream.Write($barr,0,$bytesRead);
    $ostream.close();
    Write-Output "wrote $outFile"
    $chunkNum += 1
  }
}

# splatting the $PSBoundParameters variable will pass all the parameter arguments that were originally passed to the script, to the `split` function
split @PSBoundParameters

# ######################################################## #
# ######################################################## #
# ######################################################## #

# param(
#   [string]$inFile,
#   [string]$outPrefix = "",
#   [int]$buffSize = 4MB
# )

# function Split-File {
#   param(
#     [string]$inFile,
#     [string]$outPrefix,
#     [int]$buffSize
#   )

#   $stream = [System.IO.File]::OpenRead($inFile)
#   $chunkNum = 1
#   $barr = New-Object byte[] $buffSize

#   while( $bytesRead = $stream.Read($barr,0,$buffsize)){
#     $outFile = "$outPrefix$chunkNum"
#     $ostream = [System.IO.File]::OpenWrite($outFile)
#     $ostream.Write($barr,0,$bytesRead);
#     $ostream.close();
#     Write-Output "wrote $outFile"
#     $chunkNum += 1
#   }
# }

# # Call the function with the parameters passed to the script
# Split-File @PSBoundParameters
