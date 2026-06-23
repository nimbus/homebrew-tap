cask "nimbus" do
  name "nimbus"
  desc "Self-hosted JavaScript backend runtime powered by V8"
  homepage "https://github.com/nimbus/nimbus"
  version "0.1.44"

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
      sha256 "e9b3341870a180335f256d02f8c0cab5cc4f0f4899f1fca95c8cd0f70c04cd60"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nimbus/nimbus/releases/download/v#{version}/nimbus_linux_x86_64.tar.gz"
      sha256 "a036fe10bcc12d70723b4a72df790ac4ff5419082947c6fcf17342552f67678c"
    end
    on_arm do
      url "https://github.com/nimbus/nimbus/releases/download/v#{version}/nimbus_linux_arm64.tar.gz"
      sha256 "e6f50c59864dfb4a4070a137be4aa5bb782719e70f66e8cb007328897b0c85e9"
    end
  end

  postflight do
    if system_command("/usr/bin/xattr", args: ["-h"]).exit_status == 0
      system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", staged_path.to_s], sudo: false
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

    Documentation: https://github.com/nimbus/nimbus
  EOS
end
