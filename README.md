
# Dotfiles

A simple, clean setup to quickly bootstrap your development environment using GNU Stow.

### 🛠️ Install Required Tools
Make sure the essentials are installed:

```bash
sudo apt install zsh git tmux
```
### 📦 Apply the Dotfiles with Stow
```bash 
stow zsh tmux git
```
This creates the appropriate symlinks in your home directory.

## 🚀 Start Using Your Shell

Load your new Zsh configuration:
```bash
zsh
```
## 🔧 (Optional) Set Zsh as Your Default Shell

If you'd like Zsh to start automatically:
```bash
chsh -s "$(which zsh)"
```
Feel free to explore, customize, and extend these dotfiles to fit your workflow!

