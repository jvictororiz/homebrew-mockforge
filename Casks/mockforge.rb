cask "mockforge" do
  arch arm: "arm64", intel: "x64"

  version "0.7.14"
  sha256 arm:   "c1bbc7926a436abab6c0eacd55ffb17290cff916044ae0d8e5964c9eb78d5564",
         intel: "69e561aae6b412e2c54903593409311e29732d1bfccf0bb1b68161f1f0a91889"

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
