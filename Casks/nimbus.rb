cask "nimbus" do
  name "nimbus"
  desc "Self-hosted JavaScript backend runtime powered by V8"
  homepage "https://github.com/nimbus/nimbus"
  version "0.1.45"

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
      sha256 "13906a2552a37cb1451da2dc701c61c8d221b1fca9a1f10d7f91a850e6b7ef7f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nimbus/nimbus/releases/download/v#{version}/nimbus_linux_x86_64.tar.gz"
      sha256 "cea217d812d8731b05d3a44ea5df1950fd5c5efec8ccef834f45068fd883d852"
    end
    on_arm do
      url "https://github.com/nimbus/nimbus/releases/download/v#{version}/nimbus_linux_arm64.tar.gz"
      sha256 "0cb49b9bde09e32773a35a2251bc5a53079b2603f04eeb1d0c4379097a86c742"
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

    A pinned vfkit (Apple Virtualization.framework) ships bundled in
    this cask as an opt-in machine backend; enable it with
    NIMBUS_MACHINE_PROVIDER=vfkit. The default backend stays krunkit.

    Documentation: https://github.com/nimbus/nimbus
  EOS
end

