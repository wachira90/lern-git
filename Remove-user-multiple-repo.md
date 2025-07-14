### ✅ **Easy Method: Use GitHub CLI**

You can use the [GitHub CLI (`gh`)](https://cli.github.com/) to loop through your repositories and remove a user.

#### 🔧 Step-by-step:

1. **Install GitHub CLI** (if you haven’t):

   ```bash
   brew install gh  # macOS
   sudo apt install gh  # Ubuntu/Debian
   ```

2. **Authenticate with GitHub:**

   ```bash
   gh auth login
   ```

3. **Create a list of your repositories (in a text file):**

   ```bash
   gh repo list YOUR_ORG_OR_USER --limit 1000 --json name -q '.[].name' > repos.txt
   ```

4. **Remove collaborator from each repo:**

   ```bash
   while read repo; do
     echo "Removing user@example.com from $repo"
     gh api -X DELETE /repos/YOUR_ORG_OR_USER/$repo/collaborators/USERNAME
   done < repos.txt
   ```

   Replace:

   * `YOUR_ORG_OR_USER` with your GitHub org or username
   * `USERNAME` with the collaborator’s GitHub username

---

### 🛑 Note:

* You must be an **admin** on the repos.
* This works for both **personal accounts** and **organizations**.

---

### 🧠 Alternative: Use GitHub API Directly (Python or cURL)

Great! Here's how you can **remove a collaborator from multiple GitHub repositories** using both:

---

## ✅ Option 1: **Python Script Using GitHub API**

This Python script uses GitHub's REST API to remove a user from a list of repos.

### 🔧 Requirements:

* Python 3.x
* GitHub [Personal Access Token (PAT)](https://github.com/settings/tokens) with `repo` scope
* List of repository names

### 🧾 Python Script:

```python
import requests

# Configuration
GITHUB_TOKEN = "ghp_your_token_here"
ORG = "your_org_or_username"
USERNAME_TO_REMOVE = "collaborator_username"
HEADERS = {"Authorization": f"token {GITHUB_TOKEN}"}

# List of repositories (can also load from a file)
repos = [
    "repo1",
    "repo2",
    "repo3"
]

for repo in repos:
    url = f"https://api.github.com/repos/{ORG}/{repo}/collaborators/{USERNAME_TO_REMOVE}"
    response = requests.delete(url, headers=HEADERS)
    if response.status_code == 204:
        print(f"✅ Removed from {repo}")
    elif response.status_code == 404:
        print(f"❌ Not found in {repo}")
    else:
        print(f"⚠️ Error in {repo}: {response.status_code} - {response.text}")
```

---

## ✅ Option 2: **cURL Script (Bash)**

You can do the same thing in a shell script with `curl`.

### 🧾 Bash Script:

```bash
#!/bin/bash

GITHUB_TOKEN="ghp_your_token_here"
ORG="your_org_or_username"
USERNAME="collaborator_username"

# List of repositories
repos=("repo1" "repo2" "repo3")

for repo in "${repos[@]}"; do
  echo "Removing $USERNAME from $repo..."
  curl -s -o /dev/null -w "%{http_code}" \
    -X DELETE \
    -H "Authorization: token $GITHUB_TOKEN" \
    https://api.github.com/repos/$ORG/$repo/collaborators/$USERNAME
  echo
done
```

---

## 🛑 Notes:

* The `DELETE` request will return:

  * `204` if successful
  * `404` if the user isn’t a collaborator or repo doesn’t exist
* Your **token must have proper scopes** (usually `repo` for private repos).

---

Would you like to provide a list of repos from a file instead? I can modify either script to load from a `.txt` file.
