cask "nimbus" do
  name "nimbus"
  desc "Self-hosted JavaScript backend runtime powered by V8"
  homepage "https://github.com/nimbus/nimbus"
  version "0.1.42"

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
      sha256 "f9a4bf5b011ddc8c656e21299d70048c2ff9c3d07b2924e9ef92993a46c44fa0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nimbus/nimbus/releases/download/v#{version}/nimbus_linux_x86_64.tar.gz"
      sha256 "5c9dbb1d584c7dbfe2356f183a9d494e7fc14c520dd600c2c3344dded8802233"
    end
    on_arm do
      url "https://github.com/nimbus/nimbus/releases/download/v#{version}/nimbus_linux_arm64.tar.gz"
      sha256 "9fd1f7d67a478a666c7a4c5f8bfd9c52e3d927df893c6f80c180ead887bd369f"
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

