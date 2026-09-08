cask "nimbus" do
  name "nimbus"
  desc "Self-hosted JavaScript backend runtime powered by V8"
  homepage "https://github.com/nimbus/nimbus"
  version "0.1.47"

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
      sha256 "9aae21cdd452e7c91d942eb8d4f1f86d5e0db0e6c80f1b90891c8c2d4f981b3d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nimbus/nimbus/releases/download/v#{version}/nimbus_linux_x86_64.tar.gz"
      sha256 "38bf16d1dbf9d591ba0a1c2490efed45d9fffa822eac136ab6c7104c4f82147f"
    end
    on_arm do
      url "https://github.com/nimbus/nimbus/releases/download/v#{version}/nimbus_linux_arm64.tar.gz"
      sha256 "24040e7a44531dc025ec924b5f0ec76517022271785c18086fe1b30d739d768b"
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
    libkrun/krun tap. Homebrew 6.0 requires you to trust a third-party
    tap before installing from it (trust is per-tap, so this cask cannot
    do it for you):

      brew tap libkrun/krun
      brew trust --tap libkrun/krun
      brew install libkrun/krun/krunkit

    The 'nimbus' server itself runs fine without this chain.

    A pinned vfkit (Apple Virtualization.framework) ships bundled in
    this cask as an opt-in machine backend; enable it with
    NIMBUS_MACHINE_PROVIDER=vfkit. The default backend stays krunkit.

    Documentation: https://github.com/nimbus/nimbus
  EOS
end
