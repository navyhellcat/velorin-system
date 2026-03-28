# Neuron: Git Credentials

Git credential helper set globally: `osxkeychain`
On first push after setup, enter username `navyhellcat` + PAT as password.
Keychain stores it for future pushes.

If push fails with auth error:
1. Try push normally (keychain may have it)
2. If not: temporarily embed PAT in remote URL, push, then reset URL
3. `git remote set-url origin "https://navyhellcat:PAT@github.com/navyhellcat/REPO.git"`
4. After push: `git remote set-url origin "https://github.com/navyhellcat/REPO.git"`

## Pointers
- [1] `./github-pat.md` — where to find the PAT
- [2] `../../Architecture/neurons/github-repos.md` — repos that need auth
