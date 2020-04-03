<p align="center">
  <img src="https://raw.githubusercontent.com/qaraluch/qdots/master/.pictures/qdots-logo.jpg" alt="qdots logo" width="880" />
</p>

<h1 align="center">:package: QDOTS</h1>

<p align="center">
 <b>Qaraluch's Arch Linux Dotfiles</b>
</p>

<p align="center">
   <a href="https://opensource.org/licenses/mit-license.php">
    <img alt="MIT Licence" src="https://badges.frapsoft.com/os/mit/mit.svg?v=103" />
  </a>
</p>

<br />

- Easy to manage, thanks to [chezmoi.io](https://www.chezmoi.io/).
- Version control via **GIT**.
- Based on **ZSH** shell.
- Zsh **completions**.
- Goodness of command-line fuzzy finder (**fzf**) for git, zsh and locate.
- Navigate directories via **fzf-makrs**.
- Shell **autosuggestions**.
- Command line **syntax highlighting**.
- Zsh **global aliases** expansion (via zsh-abbrev-alias).
- **Vim keybindings** in terminal.
- follow **XDG Base Directory Specification** if possible.
- Custom **prompt**.
- Custom **aliases**.
- And much more...

:warning: Disclaimer:
This repo is published in good faith and for learning purpose only. Any usage of the dotfiles is strictly at your own risk :see_no_evil:.

## :white_circle: Installation

Make sure the following requirements are installed:

- Chezmoi

For installation of the dotfiles you need to use chezmoi CLI commands:

```sh
chezmoi init https://github.com/qaraluch/qdots.git
chezmoi apply -v --remove
```

## License

MIT © [qaraluch](https://github.com/qaraluch)
