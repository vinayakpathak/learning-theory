#!/bin/zsh

set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "usage: $0 /absolute/path/to/file.pdf" >&2
  exit 2
fi

pdf_path="$1"

if [ ! -f "$pdf_path" ]; then
  exit 0
fi

pdf_path="$(cd "$(dirname "$pdf_path")" && pwd)/$(basename "$pdf_path")"

# Make Skim opt into checking and reloading updated files on disk.
defaults write net.sourceforge.skim-app.skim SKAutoCheckFileUpdate -bool true
defaults write net.sourceforge.skim-app.skim SKAutoReloadFileUpdate -bool true

if ! osascript -e 'id of app "Skim"' >/dev/null 2>&1; then
  exit 0
fi

if pgrep -x Skim >/dev/null 2>&1; then
  osascript >/dev/null <<APPLESCRIPT
tell application "Skim"
  set matchingDocs to (documents whose path is "$pdf_path")
  if (count of matchingDocs) > 0 then
    tell item 1 of matchingDocs to revert
  else
    open POSIX file "$pdf_path"
  end if
end tell
APPLESCRIPT
else
  open -g -a Skim "$pdf_path"
fi
