class NetworkMapper < Formula
  desc "Cross-platform network discovery and visualization tool"
  homepage "https://github.com/NickBorgers/util"
  version "2.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NickBorgers/util/releases/download/v#{version}/network-mapper-darwin-arm64.tar.gz"
      sha256 "ff04475efdbdf90119760da0a82bce351422dfb35932d5848b0cc94be64de522"
    else
      url "https://github.com/NickBorgers/util/releases/download/v#{version}/network-mapper-darwin-amd64.tar.gz"
      sha256 "30b23f120b3e4f84c8c6013669f2046d7e74b68950e245c269a478316a72d041"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NickBorgers/util/releases/download/v#{version}/network-mapper-linux-arm64.tar.gz"
      sha256 "0086152a617f9d11669132a4004a93f5e093dac1a087864871fd8d33185c60ea"
    else
      url "https://github.com/NickBorgers/util/releases/download/v#{version}/network-mapper-linux-amd64.tar.gz"
      sha256 "13ad2150fc62d8ca9f8819fa6acc6018d12050bf60829e9d0515522d25b07424"
    end
  end

  def install
    bin.install "network-mapper-#{OS.kernel_name.downcase}-#{Hardware::CPU.arch}"
    mv bin/"network-mapper-#{OS.kernel_name.downcase}-#{Hardware::CPU.arch}", bin/"network-mapper"
  end

  def caveats
    <<~EOS
      Network Mapper may require elevated privileges for some operations:
      - On macOS/Linux: Run with 'sudo' if needed for network interface access
      - Some features like ARP scanning require root access

      To run a quick scan:
        network-mapper --scan-mode quick

      To use intelligent discovery with different thoroughness:
        network-mapper --thoroughness 1  # Minimal
        network-mapper --thoroughness 5  # Exhaustive

      For help:
        network-mapper --help
    EOS
  end

  test do
    assert_match "Network Mapper", shell_output("#{bin}/network-mapper --version")
  end
end