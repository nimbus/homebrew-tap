cask "nimbus" do
  name "nimbus"
  desc "Self-hosted JavaScript backend runtime powered by V8"
  homepage "https://github.com/nimbus/nimbus"
  version "0.1.48"

  livecheck do
    skip "Auto-generated on release."
  end

  binary "nimbus"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma
    # No depends_on formula here: krunkit lives in a third-party tap,
    # and Homebrew 6.0 tap-trust is non-transitive, so a nimbus/tap cask
    # can never pre-trust libkrun/krun. The krunkit microVM chain is
    # optional and documented in caveats instead.

    on_arm do
      url "https://github.com/nimbus/nimbus/releases/download/v#{version}/nimbus_darwin_arm64.tar.gz"
      sha256 "76f0b3d87cac5d453dc34fd9f5b65b1f8c6410d0f3d533fdf7fb5150e1b4bd47"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nimbus/nimbus/releases/download/v#{version}/nimbus_linux_x86_64.tar.gz"
      sha256 "8db21f98e19fc29f0a84c815add8830761876a3576c7d75739be6d93b848158b"
    end
    on_arm do
      url "https://github.com/nimbus/nimbus/releases/download/v#{version}/nimbus_linux_arm64.tar.gz"
      sha256 "2e287475b68aa87475053dd8f3ea4f4d0be1fb760cf78f17c0781d310bbe2e82"
    end
  end

  postflight_steps do
    on_macos do
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{staged_path}}"], sudo: false, must_succeed: true
    end
  end

  caveats <<~EOS
    Nimbus is installed. Quick start:
      nimbus --help              # Show all commands
      nimbus start               # Start the server

    Optional macOS microVM dev flow ('nimbus machine'):
    it needs the krunkit chain (krunkit + gvproxy + libkrun) from the
    libkrun/krun tap. Trust the krunkit formula before installation:

      brew tap libkrun/krun
      brew trust --formula libkrun/krun/krunkit
      brew install libkrun/krun/krunkit

    The 'nimbus' server itself runs fine without this chain.

    A pinned vfkit (Apple Virtualization.framework) ships bundled in
    this cask as an opt-in machine backend; enable it with
    NIMBUS_MACHINE_PROVIDER=vfkit. The default backend stays krunkit.

    Documentation: https://github.com/nimbus/nimbus
  EOS
end

