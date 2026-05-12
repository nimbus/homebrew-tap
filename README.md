# Nimbus Homebrew Tap

This is the official [Homebrew](https://brew.sh) tap for [Nimbus](https://github.com/nimbus/nimbus).

## Installation

```bash
brew tap nimbus/tap
```

## Available Casks

### nimbus

Self-hosted JavaScript backend runtime powered by V8.

```bash
brew install nimbus/tap/nimbus
```

## Development

To add a new formula or cask:

1. Create a new `.rb` file in `Formula/` (for source builds) or `Casks/` (for pre-built binaries)
2. Follow the [Homebrew formula cookbook](https://docs.brew.sh/Formula-Cookbook) or [cask cookbook](https://docs.brew.sh/Cask-Cookbook)
3. Test locally: `brew install --build-from-source ./Formula/<name>.rb` or `brew install --cask ./Casks/<name>.rb`
4. Submit a PR

## License

All formulas and casks in this repository are licensed under the MIT License.
