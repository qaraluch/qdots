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

<p align="center">
  <img src="https://raw.githubusercontent.com/qaraluch/qdots/master/.pictures/qdots-screenshot-desktop.png" alt="qdots logo" width="880" />
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/qaraluch/qdots/master/.pictures/qdots-screenshot-code.png" alt="qdots logo" width="880" />
</p>

<br />

- Easy to manage, thanks to [[chezmoi.io](https://www.chezmoi.io/)].
- Version control via **Git**.
- Based on **Zsh** shell.
- **Tmux** terminal multiplexer and **tmuxinator** as session manager.
- Zsh **completions**.
- **Neovim** as IDE [[neovim.io](https://neovim.io/)]:
  - integrated with fzf
  - intellisense engine: **coc** [[github.com/neoclide/coc.nvim](https://github.com/neoclide/coc.nvim)]
  - use **prettier** as code formatter
  - use **eslint** as JS linter
  - use **UltiSnips** for snippets
- Goodness of command-line fuzzy finder (**fzf**) for git, zsh and locate.
- Navigate directories via **fzf-makrs**.
- Shell **autosuggestions**.
- Command line **syntax highlighting**.
- Zsh **global aliases** expansion (via zsh-abbrev-alias).
- **Vim keybindings** in terminal.
- Follow **XDG Base Directory Specification** if possible.
- Custom **prompt**.
- Custom **aliases**.
- The silver searcher (**ag**) as 'grep' replacement
- X window configuration:
  - windows manager: **dwm** [[suckless.org](https://suckless.org/)]
  - status bar: **dwmblocks**
  - terminal emulator: **st**
  - program launcher: **dmenu**
  - display manager: **sddm** [[github.com/sddm](https://github.com/sddm/sddm)]
    - theme: sddm-chili [[github.com/MarianArlt/sddm-chili](https://github.com/MarianArlt/sddm-chili)]
  - lockscreen: **betterlockscreen** [[github.com/pavanjadhaw/betterlockscreen](https://github.com/pavanjadhaw/betterlockscreen)]
  - notification daemon: **dunst** [[dunst-project.org](https://dunst-project.org/)]
  - audio control via **pamixer** and **pulseaudio**
  - default theme: bloodtrees (generated by **pywal**)
  - integration of Xresources
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
