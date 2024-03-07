# Summary:
These are helpful scripts I have developed. Mostly Powershell but some Bash.

## `split-file` & `converge-files` Use:
If you have a file, such as a `.zip` that exceeds the max size of your mode of transfer (such as email @ 25mb or something...):

### To Use:
1. Make sure the directory you clone these scripts into is in your PATH, else, you will need to invoke with full path to file
2. Sender Runs:
  - `split-file.ps1 -inFile "C:\path\to\your\file.zip" -buffSize 4MB`
  - the out files will be named "1", "2", "3", ... to the current working directory
  - you can pass whatever `-buffSize` you need for your file (e.g. `-buffSize 100KB`)
3. Recipient Runs:
  - `.\converge-files.ps1 -outFile "reassembled_file.zip" -buffSize 4MB`
  - this will search the current working directory, matching filenames that are incrementing digits
  - you should pass the same `-buffSize` arg as you did to `split-file` for best results (resembling orig file)
