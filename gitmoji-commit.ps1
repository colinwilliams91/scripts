# Script takes 2 arguments (args[0] defaults to ":computer::") for gitmoji commit standard and makes git commit -m ":computer:: your message..."

if (-not $args[0]) {
    $commitType = "chore"
} else {
    $commitType = $args[0]
}

if (-not $args[1]) {
    Write-Host "Please provide a commit message after your commit type argument..."
    exit 1
} else {
    $commitMessage  = $args[1]
}

$emojiData = Get-Content -Raw -Path "E:\Dev\profiles\gitmoji.json" | ConvertFrom-Json

$emoji = $emojiData.$commitType

$output = ""

if ($emoji) {
    $output = "$emoji $commitMessage"
    git commit -m $output
} else {
    Write-Host "No emoji found matching commit type: $commitType"
    exit 1
}
