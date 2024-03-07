# This script contains a fn that can split a file into chunks
# This is useful when you can't send a file over email because it is too large

# -inFile is the only argument that NEEDS to be passed in
# file will be split into segments by -buffSize and output into the cwd named by incrementing digits

# [SO Docs](https://stackoverflow.com/a/69467602/20575174)

# ######################################################## #
# ######################################################## #
# ######################################################## #

# To Use:
# split-file.ps1 -inFile "C:\path\to\your\file.zip" -buffSize 4MB

param(
  [string]$inFile,
  [int]$buffSize = 4MB
)

function split($inFile, [Int32] $buffSize){

  $stream = [System.IO.File]::OpenRead($inFile)
  $chunkNum = 1
  $barr = New-Object byte[] $buffSize

  while( $bytesRead = $stream.Read($barr,0,$buffsize)){
    $outFile = "$chunkNum"
    $outStream = [System.IO.File]::OpenWrite($outFile)
    $outStream.Write($barr,0,$bytesRead);
    $outStream.close();
    Write-Output "wrote chunk $outFile to file"
    $chunkNum += 1
  }
}

# splatting the $PSBoundParameters variable will pass all the parameter arguments
# that were originally passed to the script, to the `split` function
split @PSBoundParameters
