cask "nimbus-desktop" do
  name "Nimbus Desktop"
  desc "Native desktop shell for the Nimbus operator console"
  homepage "https://github.com/nimbus/desktop"
  version "0.1.0"

  livecheck do
    skip "Auto-generated on release."
  end

  auto_updates true
  depends_on macos: ">= :sonoma"

  url "https://github.com/nimbus/desktop/releases/download/v#{version}/nimbus-desktop-#{version}-universal.dmg"
  sha256 "1a263bd0fd0a9ed8ded9bea2a3f6e24c660688a7f9a10d2ed03482b851b60fa4"

  app "nimbus-desktop.app"

  zap trash: [
    "~/Library/Application Support/nimbus-desktop",
    "~/Library/Caches/com.nimbus.desktop",
    "~/Library/Caches/com.nimbus.desktop.ShipIt",
    "~/Library/Logs/nimbus-desktop",
    "~/Library/Preferences/com.nimbus.desktop.plist",
    "~/Library/Saved Application State/com.nimbus.desktop.savedState",
  ]
end
