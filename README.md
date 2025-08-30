# Table of Contents

- [Quick Start](#quick-start)
	- [Install (Linux/macOS)](#install-linuxmacos)
	- [Install (Windows)](#install-windows)
	- [Uninstall (Linux/macOS)](#uninstall-linuxmacos)
	- [Uninstall (Windows)](#uninstall-windows)
- [Requirements](#requirements)
	- [General](#general)
	- [Language Runtimes/Toolchains](#language-runtimestoolchains)
	- [Formatters & Linters](#formatters--linters-installed-via-masonnvim-or-system-package-manager)
	- [Optional/Recommended](#optionalrecommended)
- [Full System Dependency List & Install Commands](#full-system-dependency-list--install-commands)
	- [Required system dependencies](#required-system-dependencies)
	- [Example install commands (Debian/Ubuntu)](#example-install-commands-debianubuntu)

---

# Neovim Config Installation & Removal Guide

## Quick Start

### Install (Linux/macOS)
1. Backup your current Neovim config:
	```sh
	mv ~/.config/nvim ~/.config/nvim.backup
	```
2. Clone this repo:
	```sh
	git clone https://github.com/argon-chat/nvim.git ~/.config/nvim
	```
3. Install the required dependencies (see below).
4. Open Neovim and plugins will install automatically:
	```sh
	nvim
	```

### Install (Windows)
1. Backup your current Neovim config:
	- Move `%LOCALAPPDATA%\nvim` to a backup location.
2. Clone this repo:
	- Use Git Bash or PowerShell:
	  ```sh
	  git clone https://github.com/argon-chat/nvim.git "$env:LOCALAPPDATA\nvim"
	  ```
3. Install the required dependencies (see below).
4. Open Neovim (`nvim.exe`) and plugins will install automatically.

### Uninstall (Linux/macOS)
```sh
rm -rf ~/.config/nvim
```
Restore your backup if needed:
```sh
mv ~/.config/nvim.backup ~/.config/nvim
```

### Uninstall (Windows)
Delete the folder:
```
%LOCALAPPDATA%\nvim
```
Restore your backup if needed.

# Requirements

This Neovim configuration requires the following external tools to be installed on your system:

## General
- Git
- Python (for some plugins and LSPs)
- Node.js (for JavaScript/TypeScript LSPs and formatters)

## Language Runtimes/Toolchains
- Go (for Go LSP and formatters)
- Ruby (for Ruby LSP and formatters)
- Rust (for Rust LSP and formatters)
- Zig (for Zig LSP and formatters)
- C/C++ compiler (for C/C++ LSP and formatters)

## Formatters & Linters (installed via Mason.nvim or system package manager)
- prettier
- eslint_d
- gofmt
- goimports
- rufo
- clang_format
- csharpier
- rustfmt
- zigfmt
- stylua

## Optional/Recommended
- k9s (for Kubernetes management, if using kube-utils-nvim)

Most language servers and formatters can be installed using Mason.nvim from within Neovim. System dependencies (Node.js, Go, etc.) must be installed manually.

# Full System Dependency List & Install Commands

Below is a complete list of all required dependencies outside of Neovim, and example install commands for Debian/Ubuntu systems:

## Required system dependencies
- Git
- Python 3 and pip (plus pynvim: `pip install --user pynvim`)
- Node.js and npm
- k9s (for kube-utils-nvim)
- Ruby (for Ruby LSP/formatter)
- Ruby gems: solargraph, rufo (install with `gem install solargraph rufo`)
- Go, Rust, Zig, C/C++ compiler (for language servers/formatters)
- libgit2 (for plugins or tools that require native git bindings)
- gpgme (for plugins or tools that require GPG support)
- npm global packages: prettier, eslint_d, yarn (optional)

## Example install commands (Debian/Ubuntu):

```sh
sudo apt update
sudo apt install -y git python3 python3-pip nodejs npm ruby-full build-essential libgit2-dev libgpgme-dev
pip3 install --user pynvim
sudo npm install -g prettier eslint_d yarn
gem install solargraph rufo
# k9s install
if ! command -v k9s &> /dev/null; then
  curl -sSLo k9s.tar.gz https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz
  tar -xzf k9s.tar.gz k9s
  sudo mv k9s /usr/local/bin/
  rm k9s.tar.gz
fi
```

You must also install Go, Rust, Zig, and a C/C++ compiler using your OS package manager or their official installers.

# Credits

1) Lazyvim starter https://github.com/LazyVim/starter as nvchad's starter was inspired by Lazyvim's . It made a lot of things easier!