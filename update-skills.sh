#!/bin/bash
# update-skills.sh
# Pull latest skills from GitHub and confirm what changed.

set -e

SKILLS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Pulling latest from GitHub..."
cd "$SKILLS_DIR"
git pull origin main

echo ""
echo "Skills up to date at: $SKILLS_DIR"
echo ""
echo "Active skills:"
for d in "$SKILLS_DIR"/*/; do
  name=$(basename "$d")
  if [ -f "$d/SKILL.md" ]; then
    echo "  ✓ $name"
  fi
done
