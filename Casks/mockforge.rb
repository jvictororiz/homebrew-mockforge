cask "mockforge" do
  arch arm: "arm64", intel: "x64"

  version "0.7.15"
  sha256 arm:   "e992e5d3313ef251b8333c90b476c6091754bad11428ac732d135d46f697724e",
         intel: "4edd6e322aa5d3637da6c9fc318781c2a22b99b72700d3e36d454cda6abf7fcf"

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
