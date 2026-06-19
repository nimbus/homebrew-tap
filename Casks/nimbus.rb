cask "nimbus" do
  name "nimbus"
  desc "Self-hosted JavaScript backend runtime powered by V8"
  homepage "https://github.com/nimbus/nimbus"
  version "0.1.39"

  livecheck do
    skip "Auto-generated on release."
  end

  binary "nimbus"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: ">= :sonoma"
    depends_on formula: "slp/krunkit/krunkit"

    on_arm do
      url "https://github.com/nimbus/nimbus/releases/download/v#{version}/nimbus_darwin_arm64.tar.gz"
      sha256 "6f773ece88e25ee4e3676d802c0ae8f6cfa492546aedb73321a6796d62670e05"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nimbus/nimbus/releases/download/v#{version}/nimbus_linux_x86_64.tar.gz"
      sha256 "e11de6c88caffbda8aa06186e786272c99c76c9406dc0dd1633e5e264545a9dd"
    end
    on_arm do
      url "https://github.com/nimbus/nimbus/releases/download/v#{version}/nimbus_linux_arm64.tar.gz"
      sha256 "3a4adf9f194acf833c8a4bf8b34d670534878098f67667572403be0be9b37dc6"
    end
  end

  postflight do
    if system_command("/usr/bin/xattr", args: ["-h"]).exit_status == 0
      system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", staged_path.to_s], sudo: false
    end
  end

  caveats do
    "Nimbus has been installed!"
    ""
    "Quick start:"
    "  nimbus --help              # Show all commands"
    "  nimbus machine init        # Record the default macOS machine contract"
    "  nimbus start               # Start the server"
    ""
    "Documentation: https://github.com/nimbus/nimbus"
  end
end

