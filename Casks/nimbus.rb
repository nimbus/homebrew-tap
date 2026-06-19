cask "nimbus" do
  name "nimbus"
  desc "Self-hosted JavaScript backend runtime powered by V8"
  homepage "https://github.com/nimbus/nimbus"
  version "0.1.38"

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
      sha256 "e6b0df3e04911c965191b1f84e42daad1bf2bc4aa4e832ee402f8326d1fa0274"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nimbus/nimbus/releases/download/v#{version}/nimbus_linux_x86_64.tar.gz"
      sha256 "31d0ef252f1ac695a4ff979b83102630799c176c0a2da5dd3fe5de8963b233ff"
    end
    on_arm do
      url "https://github.com/nimbus/nimbus/releases/download/v#{version}/nimbus_linux_arm64.tar.gz"
      sha256 "1cf8479652cd2aeefb3565fbcbdada2bfb78174239648edaf121ed4467c620cd"
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

