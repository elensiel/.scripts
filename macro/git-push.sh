set -euo pipefail

commit_msg="${1:-}"

[[ -z "$commit_msg" ]] && { echo "Error: Commit message required." >&2; exit 1; }

echo -e "\e[32mStarting Git automation process...\e[0m"

echo "Executing: git add ."
git add . || { echo "Failed to add changes." >&2; exit 1; }

echo "Executing: git commit -m \"$commit_msg\""
if ! git commit -m "$commit_msg"; then
    rc=$?
    [[ "$rc" -eq 1 ]] && { echo "No changes to commit."; exit 0; }
    echo "Failed to commit changes." >&2
    exit 1
fi

echo "Executing: git push"
git push || { echo "Failed to push changes." >&2; exit 1; }

echo -e "\e[32mGit automation process completed.\e[0m"
