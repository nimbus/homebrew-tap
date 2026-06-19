cask "nimbus" do
  name "nimbus"
  desc "Self-hosted JavaScript backend runtime powered by V8"
  homepage "https://github.com/nimbus/nimbus"
  version "0.1.36"

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
      sha256 "cc936897ac983b9dd81bf152de24f073300ed80b7454c409605eabc96d0f2ea3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nimbus/nimbus/releases/download/v#{version}/nimbus_linux_x86_64.tar.gz"
      sha256 "7042bdeafcecffa8ab7637405081149cb0b949a913e87f14de2025c3bf1deadc"
    end
    on_arm do
      url "https://github.com/nimbus/nimbus/releases/download/v#{version}/nimbus_linux_arm64.tar.gz"
      sha256 "bbdb5bae5038fee88792d90e27ecb75651a9d4d87663b8c0360a7e3950d69358"
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

