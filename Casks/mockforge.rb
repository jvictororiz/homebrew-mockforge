cask "mockforge" do
  arch arm: "arm64", intel: "x64"

  version "0.7.30"
  sha256 arm:   "1cbfce07e248a844422cc603a3a85d2823854a4368e8c609499a2fb7e81c22e2",
         intel: "3ab6568c66fd8082f6f724dfcfea6729a4128d5cab6f0def9a4348e8cec39a73"

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
