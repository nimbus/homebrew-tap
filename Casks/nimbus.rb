cask "nimbus" do
  name "nimbus"
  desc "Self-hosted JavaScript backend runtime powered by V8"
  homepage "https://github.com/nimbus/nimbus"
  version "0.1.3"

  livecheck do
    skip "Auto-generated on release."
  end

  binary "nimbus"

  on_macos do
    on_intel do
      url "https://github.com/nimbus/nimbus/releases/download/v#{version}/nimbus_darwin_x86_64.tar.gz"
      sha256 ""
    end
    on_arm do
      url "https://github.com/nimbus/nimbus/releases/download/v#{version}/nimbus_darwin_arm64.tar.gz"
      sha256 "3db8fb237a6d71fe2cdbcd7813e11344861beef8544f380f7d5e7aa7f07f1c69"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nimbus/nimbus/releases/download/v#{version}/nimbus_linux_x86_64.tar.gz"
      sha256 "66a9a8c88e66c0dab873ab77897dd559c63703e989f2a464df74ee4f570b748b"
    end
    on_arm do
      url "https://github.com/nimbus/nimbus/releases/download/v#{version}/nimbus_linux_arm64.tar.gz"
      sha256 "5e025024b8233dbf3b93918d4ed2242c5eb51e64e9d4beae001714331ccedee9"
    end
  end

  postflight do
    if system_command("/usr/bin/xattr", args: ["-h"]).exit_status == 0
      system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{staged_path}/nimbus"], sudo: false
    end
  end

  caveats do
    "Nimbus has been installed!"
    ""
    "Quick start:"
    "  nimbus --help              # Show all commands"
    "  nimbus --port 8080         # Start server on port 8080"
    ""
    "Documentation: https://github.com/nimbus/nimbus"
  end
end
