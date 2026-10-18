class Loadman < Formula
  desc "Load testing for Postman collections, from your terminal or CI"
  homepage "https://github.com/tranhuuhuy297/loadman"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tranhuuhuy297/loadman/releases/download/v0.2.0/loadman-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "265320ebf1dbda86d4b85759efb64b67852ea21c99527a2445ec6f0d0eeb51e5"
    else
      url "https://github.com/tranhuuhuy297/loadman/releases/download/v0.2.0/loadman-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "e629bdefc3e7668df222279bd46a2f13729ae041e8651ccb3afb9d9f6c388dcf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tranhuuhuy297/loadman/releases/download/v0.2.0/loadman-v0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6fd99a0869c2748fe3793d4bf08de80203420511d950bf877a126f4ae7d3e93e"
    else
      url "https://github.com/tranhuuhuy297/loadman/releases/download/v0.2.0/loadman-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "91d2f02feb04da8c631760a9b108d475c29e2dc4fa445c995d8b7f702df3e544"
    end
  end

  def install
    bin.install "loadman"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/loadman --version")
    (testpath/"c.json").write <<~JSON
      {"info":{"name":"t"},"item":[{"name":"r","request":{"method":"GET","url":"http://127.0.0.1:9/"}}]}
    JSON
    assert_match "requests", shell_output("#{bin}/loadman inspect #{testpath}/c.json")
  end
end
