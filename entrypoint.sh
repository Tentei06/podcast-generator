#!/bin/sh
set -e

cd /github/workspace

echo "Running feed generator..."
python3 /app/feed.py

echo "Configuring git..."
git config --global user.name "${INPUT_NAME:-github-actions}"
git config --global user.email "${INPUT_EMAIL:-github-actions@github.com}"
git config --global --add safe.directory /github/workspace

echo "Committing output if changed..."
git add -A

if git diff --cached --quiet; then
  echo "No changes to commit."
  exit 0
fi

git commit -m "Update feed output"
git push

echo "Done."