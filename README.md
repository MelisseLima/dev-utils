# 🛠 DevUtils

A collection of handy CLI scripts to speed up your dev workflow. Stop, clean, build, debug — all from short memorable commands.

## Installation

```bash
git clone https://github.com/melisselima/devutils.git
cd devutils
./install.sh
```

Then reload your shell:

```bash
source ~/.zshrc   # or ~/.bashrc / ~/.bash_profile
```

That's it. All commands are now available globally.

> **Re-run `./install.sh`** anytime you add new scripts — it will pick them up automatically.

---

## Scripts

### Docker & Infrastructure

| Command | Description |
|---------|-------------|
| `good-morning` | Stop **all** Docker containers, remove images, volumes, networks, and run a full system prune. A clean slate. |
| `dockerup [dir ...]` | Find `docker-compose.yml` files and spin up services. Pass project directories as arguments or run in the current directory. |
| `port-who <port>` | Show which process is using a specific port. |
| `killport <port> [...]` | Kill whatever is running on one or more ports. |

#### Examples

```bash
good-morning                     # nuke all Docker resources
dockerup ~/projects/api          # spin up a specific project
port-who 3000                    # who's on port 3000?
killport 3000 8080               # free up ports 3000 and 8080
```

---

### Git

| Command | Description |
|---------|-------------|
| `git-nuke` | Delete local branches already merged into main/master, prune remote tracking branches, and run `git gc`. |
| `git-fresh <branch-name>` | Checkout the default branch, pull latest, and create a new branch. |
| `git-oops` | Undo the last commit with a soft reset — your changes stay staged. |

#### Examples

```bash
git-nuke                         # clean up old branches
git-fresh feature/new-login      # start fresh from main
git-oops                         # undo last commit, keep changes
```

---

### Project

| Command | Description |
|---------|-------------|
| `nuke-modules [dir]` | Recursively remove `node_modules`, `.next`, `dist`, `build`, `__pycache__`, and other build artifacts. |
| `dev-up [dir]` | Auto-detect project type (Node.js, Python, Go, Rust, Docker Compose) and run install + start. |
| `env-check [dir]` | Compare `.env.example` (or `.env.sample` / `.env.template`) with `.env` and flag missing or empty variables. |

#### Examples

```bash
nuke-modules ~/projects          # free up disk space across all projects
dev-up                           # detect and start the current project
env-check                        # check for missing env vars
```

---

### System

| Command | Description |
|---------|-------------|
| `ram-hog [n]` | Display the top *n* processes by memory usage (default: 10). |
| `cleanup` | Purge caches from Homebrew, npm, yarn, pnpm, pip, Docker, and macOS system caches. Optionally empties the Trash. |

#### Examples

```bash
ram-hog                          # top 10 memory hogs
ram-hog 20                       # top 20
cleanup                          # reclaim disk space from all caches
```

---

### Productivity

| Command | Description |
|---------|-------------|
| `wtf` | Show recent error logs for the current project. Auto-detects Docker Compose, Next.js, npm/yarn/pnpm logs, Python, Laravel, and Rails. |
| `note "text"` | Save a quick timestamped note to `~/dev-notes/YYYY-MM-DD.md`. |
| `note` | View today's notes. |
| `note --list` | List all note files. |
| `note --search <term>` | Search across all notes. |

#### Examples

```bash
wtf                              # what broke? show me the logs
note "fixed the auth bug"        # jot it down
note --search auth               # find past notes about auth
```

---

## Uninstall

Remove the following line from your shell config (`~/.zshrc`, `~/.bashrc`, etc.):

```bash
# devutils
export PATH="/path/to/devutils/scripts:$PATH"
```

Then delete the repo folder.

---

## Adding Your Own Scripts

1. Create a new file in the `scripts/` directory (no file extension needed).
2. Add `#!/usr/bin/env bash` as the first line.
3. Run `./install.sh` to make it executable and available.

---

## Requirements

- **bash** 4+ (macOS ships with zsh by default — all scripts use `#!/usr/bin/env bash`)
- **Docker** (for Docker-related scripts)
- **Git** (for git-related scripts)
- **lsof** (pre-installed on macOS/Linux — used by `port-who` and `killport`)

## License

MIT
