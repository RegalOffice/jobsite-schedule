# Builds index.html from the board (src/app.html) and the standalone platform layer (src/platform.html).
# Run from this folder:  powershell -ExecutionPolicy Bypass -File build.ps1
$ErrorActionPreference = "Stop"
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$app = [IO.File]::ReadAllText("$here\src\app.html")
$platform = [IO.File]::ReadAllText("$here\src\platform.html")

# Wording that only made sense inside claude.ai. (Windows PowerShell reads this script as ANSI, so the
# curly apostrophe is written as [char]0x2019 rather than typed.)
$q = [char]0x2019
$app = $app.Replace("Open this page on claude.ai while signed in to view and edit the shared job schedules.", "Couldn${q}t reach the schedule database. Check your connection and reload the page.")
$app = $app.Replace("Schedule storage isn${q}t available here", "The schedule database isn${q}t responding")
$app = $app.Replace("Saving files isn${q}t available in this view. Open the board on claude.ai.", "Couldn${q}t start the download.")
$app = $app.Replace("Open the board on claude.ai.", "")

$head = @"
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">
<meta name="robots" content="noindex">
<title>Jobsite Schedule Board</title>
<style>:root{color-scheme:light;padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0;font:14px system-ui,sans-serif}img{max-width:100%}[hidden]{display:none!important}</style>
</head>
<body>
"@
$out = $head + "`n" + $platform + "`n" + $app + "`n</body>`n</html>`n"
[IO.File]::WriteAllText("$here\index.html", $out, (New-Object Text.UTF8Encoding $false))
Write-Output ("Built index.html (" + [math]::Round($out.Length / 1024) + " KB)")
