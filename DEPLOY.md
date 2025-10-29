# boostr Deployment Guide

## Quick Publish to GitHub

1. **Create GitHub repo:**
   ```bash
   # Go to github.com and create a new repo named "boostr"
   # Keep it public, don't initialize with README (we already have one)
   ```

2. **Push to GitHub:**
   ```bash
   cd ~/boostr
   git branch -M main
   git commit -m "Initial commit: boostr v1.0"
   git remote add origin https://github.com/YOUR_USERNAME/boostr.git
   git push -u origin main
   ```

3. **Update README:**
   - Edit `README.md` and replace `YOUR_USERNAME` with your actual GitHub username
   - Commit and push:
   ```bash
   git add README.md
   git commit -m "Update installation URL"
   git push
   ```

## Testing Installation

Test the installer on a fresh system (or VM):
```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/boostr/main/install.sh | bash
```

## Creating a Release

1. **Tag a version:**
   ```bash
   git tag -a v1.0.0 -m "Release v1.0.0"
   git push origin v1.0.0
   ```

2. **Create release on GitHub:**
   - Go to your repo → Releases → Draft a new release
   - Choose tag v1.0.0
   - Title: "boostr v1.0.0"
   - Description: Copy key features from README

## Optional: Homebrew Formula

For easier macOS installation, create a Homebrew tap:

```bash
# Create tap repo
gh repo create homebrew-boostr --public

# Create Formula/boostr.rb
# See: https://docs.brew.sh/Formula-Cookbook
```

## Marketing

Share on:
- [x] GitHub (create repo)
- [ ] Reddit: /r/commandline, /r/unixporn
- [ ] Hacker News: Show HN
- [ ] Twitter/X with demo GIF
- [ ] Dev.to blog post

## Demo Content Ideas

Create screenshots/GIFs showing:
1. Installation process
2. AI command generation (`doo "..."`)
3. Split panes with different themes
4. Greeting screen
5. Before/after comparison

## Roadmap for v1.1

- [ ] Fish shell support
- [ ] Alternative LLM backends
- [ ] Theme marketplace
- [ ] Windows/WSL support
- [ ] Config migration tool

---

**Current Status:** ✅ Ready to deploy!
