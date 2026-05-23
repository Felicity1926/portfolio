param(
    [string]$Branch = "agents/portfolio-website-setup",
    [string]$CommitMessage = "Add GitHub Pages deploy workflow"
)

function Exit-WithMessage($msg, $code=1) {
    Write-Host $msg -ForegroundColor Yellow
    exit $code
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Exit-WithMessage "git not found in PATH. Install Git and retry." 2
}

$cwd = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Set-Location $cwd

# Ensure we're in repo root
Write-Host "Using branch: $Branch"

$status = git status --porcelain
if ($status) {
    git add .
    git commit -m "$CommitMessage"
} else {
    Write-Host "No changes to commit."
}

Write-Host "Pushing branch $Branch to origin..."
git push -u origin $Branch

if (Get-Command gh -ErrorAction SilentlyContinue) {
    Write-Host "Creating Pull Request with gh..."
    gh pr create --base main --head $Branch --title "Deploy: Add GitHub Pages workflow" --body "Adds deploy workflow and .nojekyll"
    Write-Host "You can merge the PR on GitHub or run: gh pr merge --auto --merge"
} else {
    Write-Host "'gh' CLI not found. Open a PR on GitHub: https://github.com/Felicity1926/portfolio/pulls"
}

Write-Host "Done - after merging to 'main' the workflow will publish to 'gh-pages'."
Write-Host "The site will be available at: https://Felicity1926.github.io/portfolio/"
