#!/bin/bash

committer_email=$PERSONAL_GIT_EMAIL
ssh_key_path=$PERSONAL_GIT_SSH_KEY
api_key=$OPENAI_API_KEY
endpoint='https://api.openai.com/v1/chat/completions'

# Check if there are any changes
if [[ -n $(git status --porcelain) ]]; then
  # There are changes
  git add .  # Add all changes to the staging area

  # Get the staged changes as a diff
  staged_diff=$(git diff --staged | jq -sR '.' | sed 's/^"\(.*\)"$/\1/')

  # Create the prompt with the staged_diff
  template=$(cat <<EOF
{
  "model": "gpt-3.5-turbo",
  "messages": [
    {
      "role": "system",
      "content": "You are a helpful assistant that generates commit messages."
    },
    {
      "role": "user",
      "content": "Generate a commit message and details for the following changes:\n\n$staged_diff\n\nSuggestion:"
    }
  ]
}
EOF)

  echo "$template" > openai_req.json  # Use echo to write to the file

  # Execute request!
  response=$(curl -s -H "Content-Type: application/json" -H "Authorization: Bearer $api_key" -d @openai_req.json "$endpoint")
  # echo "$response" | jq
 
  # Extract the suggested commit message from the response
  commit_message=$(echo "$response" | jq -r '.choices[0].message.content')
  echo "Committing with message: $commit_message"

  # Configure the committer email for this commit
  git config user.email "$committer_email"
  
  # Commit with a generic message
  git commit -m "$commit_message"
  rm openai_req.json

  # Set the SSH key for this push and push the commit to upstream
  GIT_SSH_COMMAND="ssh -i $ssh_key_path" git push 
else
  echo "No changes detected"
fi
