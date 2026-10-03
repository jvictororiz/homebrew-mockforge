cask "mockforge" do
  arch arm: "arm64", intel: "x64"

  version "0.7.25"
  sha256 arm:   "5c0c71fd0acdd3a07a7c6b964fc055d35177d690746b88a7a9c25df1088c7741",
         intel: "9f9de04937387e3c397b5650eb2b27be7e5b3f21aed27afd160897e1c766d7b2"

  url "https://github.com/jvictororiz/Mock-Forge/releases/download/v#{version}/MockForge-mac-#{arch}.dmg"
  name "MockForge"
  desc "Visual mock server manager for MockServer"
  homepage "https://github.com/jvictororiz/Mock-Forge"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :big_sur

  app "MockForge.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/MockForge.app"],
                   must_succeed: false
  end

  uninstall quit: "com.mockforge.app"

  zap trash: [
    "~/.mockforge",
    "~/Library/Application Support/MockForge",
    "~/Library/Logs/MockForge",
    "~/Library/Preferences/com.mockforge.app.plist",
    "~/Library/Saved Application State/com.mockforge.app.savedState",
  ]
end
