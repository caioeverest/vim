#!/bin/bash

# Check if there are any changes
if [[ -n $(git status --porcelain) ]]; then
  # There are changes
  git add .  # Add all changes to the staging area
  git commit -m "Sync new changes"  # Commit with a generic message
else
  echo "No changes detected"
fi
