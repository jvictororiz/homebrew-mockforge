cask "mockforge" do
  arch arm: "arm64", intel: "x64"

  version "0.7.24"
  sha256 arm:   "ab3d722dfd6028b68670cafeffceee6061afbea4a4df7d65fd2e1432cd41cdf0",
         intel: "92d94ec7f9ce4845b67c604490281f71ffdcf7e4ec7ba1417df5bbd3f703983b"

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
