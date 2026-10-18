class Loadman < Formula
  desc "Load testing for Postman collections, from your terminal or CI"
  homepage "https://github.com/tranhuuhuy297/loadman"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tranhuuhuy297/loadman/releases/download/v0.3.0/loadman-v0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "564b016aca2b7de974b163dcb01dd727a63964633e63b82cf6ec48e88c0ade3d"
    else
      url "https://github.com/tranhuuhuy297/loadman/releases/download/v0.3.0/loadman-v0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "7e726ac291cbc9c1fabe6dd20395bd3c8d7b6b7e94525c31021e51d765487b3a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/tranhuuhuy297/loadman/releases/download/v0.3.0/loadman-v0.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d657bbd72211c6d0bf44ae7b73b5fe3a64d2dc2e1ccd8f38c9c40fd51d0f9ab2"
    else
      url "https://github.com/tranhuuhuy297/loadman/releases/download/v0.3.0/loadman-v0.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "061d23ac49cc45047dbd9db6bf64c128e2fff8f269c02c2a762c5a95600afc95"
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
