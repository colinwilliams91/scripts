# Load the JSON file
$emojiData = Get-Content -Raw -Path "E:\Dev\profiles\gitmoji.json" | ConvertFrom-Json

# Get the commit type/intention from the command line argument
$commitType = $args[0]

# Get the corresponding emoji short-code
$emoji = $emojiData.$commitType

# If emoji exists, copy to clipboard
if ($emoji) {
    $emoji | Set-Clipboard
    Write-Host "$emoji copied to clipboard!"
} else {
    Write-Host "No emoji found matching commit type: $commitType"
}
