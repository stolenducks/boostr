# boostr

> AI-powered terminal built on Ghostty with local LLM integration

**boostr** combines the speed of [Ghostty](https://ghostty.org) with the power of local AI ([Ollama](https://ollama.com)) to create an intelligent terminal experience that respects your privacy.

```
    ██████   ██████   ██████  ███████ ████████ ██████  
    ██   ██ ██    ██ ██    ██ ██         ██    ██   ██ 
    ██████  ██    ██ ██    ██ ███████    ██    ██████  
    ██   ██ ██    ██ ██    ██      ██    ██    ██   ██ 
    ██████   ██████   ██████  ███████    ██    ██   ██ 
```

## Features

### 🤖 AI Integration
- **Conversational AI** - Ask questions, get contextual answers
- **Command Generation** - Describe what you want, AI generates the command
- **Context Aware** - Remembers conversation history
- **100% Local** - No cloud, no tracking, no API keys

### ⚡ Modern Terminal
- **GPU Accelerated** - Buttery smooth rendering via Ghostty
- **Cross-Platform** - macOS & Linux (works identically)
- **Split Panes** - Efficient workspace management
- **Minimal UI** - Clean prompt, simple icons, no clutter

### 🎨 Aesthetic
- Auto-switching themes (dark/light with system)
- Catppuccin color palette
- JetBrains Mono font with readability enhancements
- Transparent background (95% opacity)

### 🔒 Security
- Auto-secure input for password prompts
- Command safety checks before execution
- Confirmation dialogs for destructive operations
- Local AI (no data leaves your machine)

## Quick Start

### One-Line Install
```bash
curl -fsSL https://raw.githubusercontent.com/stolenducks/boostr/main/install.sh | bash
```

### Manual Install
```bash
git clone https://github.com/stolenducks/boostr.git
cd boostr
chmod +x install.sh
./install.sh
```

### Supported Systems
- ✅ macOS (Intel & Apple Silicon)
- ✅ Linux (Debian, Ubuntu, Arch, Void)
- ✅ Requires: zsh, git

## Usage

### AI Commands

**Ask questions:**
```bash
ai "how do I find large files?"
ai "what's the difference between grep and find?"
ai clear  # Reset conversation
```

**Generate & execute commands:**
```bash
doo "show disk usage"
doo "find files modified today"
doo "compress this directory"
```

### Keyboard Shortcuts

| Action | Shortcut |
|--------|----------|
| Quick Terminal (global) | `Cmd+Shift+Space` |
| Command Palette | `Cmd+Shift+P` |
| Split Right | `Cmd+D` |
| Split Down | `Cmd+Shift+D` |
| Navigate Splits | `Cmd+Shift+Arrow Keys` |
| Close Split | `Cmd+W` |
| Jump to Prompts | `Ctrl+Shift+Up/Down` |
| Reload Config | `Ctrl+Shift+R` |
| Font Zoom | `Ctrl+Shift+Plus/Minus/Zero` |

## Customization

### Change Theme
```bash
ghostty +list-themes  # Browse available themes
# Edit ~/.config/ghostty/config
theme = dark:Dracula,light:Solarized Light
```

### Change Font
```bash
ghostty +list-fonts  # Browse available fonts
# Edit ~/.config/ghostty/config
font-family = "Your Font Name"
```

### Modify AI Behavior
Edit `~/bin/ai` to adjust:
- Context window size
- LLM model (default: llama3.1:8b)
- System prompts

### Custom Keybindings
Edit `~/.config/ghostty/config`:
```
keybind = your+shortcut=action
```
See [Ghostty docs](https://ghostty.org/docs/config/keybind) for available actions.

## Architecture

```
boostr/
├── install.sh              # Cross-platform installer
├── configs/
│   ├── ghostty/config      # Terminal configuration
│   └── zsh/.zshrc         # Shell configuration
├── bin/
│   ├── ai                  # Conversational AI assistant
│   ├── ai-exec            # Command generator (aliased as 'doo')
│   └── greeting           # Startup ASCII art
└── docs/                   # Additional documentation
```

## How It Works

1. **Ghostty** provides the terminal emulator (GPU-accelerated, cross-platform)
2. **Ollama** runs LLMs locally (llama3.1:8b by default)
3. **Shell scripts** bridge the two with conversational context and safety checks
4. **zsh integration** provides the minimal `>` prompt and helper functions

## Why boostr?

**vs. Warp:**
- ✅ 100% local AI (no cloud, no tracking)
- ✅ Works on Linux
- ✅ Open source, infinitely customizable
- ✅ No account required

**vs. Plain Ghostty:**
- ✅ Pre-configured aesthetics
- ✅ AI integration out of the box
- ✅ Productivity shortcuts
- ✅ Curated experience

**vs. Other AI terminals:**
- ✅ Cross-platform (same config everywhere)
- ✅ No subscription, no API keys
- ✅ Your data stays local
- ✅ Built on modern, fast foundation (Ghostty)

## Requirements

- **Ghostty** - Installed automatically by `install.sh`
- **Ollama** - Installed automatically by `install.sh`
- **zsh** - Usually pre-installed on macOS/Linux
- **git** - For cloning the repo
- **~5GB disk space** - For Ollama + LLM model

## Uninstall

```bash
./uninstall.sh
```

Or manually:
```bash
rm -rf ~/.config/ghostty
rm ~/bin/{ai,ai-exec,greeting}
# Remove boostr section from ~/.zshrc
```

## Contributing

Contributions welcome! Areas of interest:
- Additional LLM backends (llama.cpp, koboldcpp)
- More themes and fonts
- Fish/Bash shell support
- Windows support (via WSL)

## License

MIT - See [LICENSE](LICENSE) for details.

## Credits

- [Ghostty](https://ghostty.org) - Mitchell Hashimoto
- [Ollama](https://ollama.com) - Ollama team
- [Catppuccin](https://github.com/catppuccin) - Theme
- Inspired by Warp, but with local-first principles

## Star History

If you find **boostr** useful, please consider giving it a ⭐ on GitHub!

---

**Made with ❤️ for developers who want AI without compromising privacy**
