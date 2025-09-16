class NetworkMapper < Formula
  desc "Cross-platform network discovery and visualization tool"
  homepage "https://github.com/NickBorgers/util"
  version "2.6.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NickBorgers/util/releases/download/v#{version}/network-mapper-darwin-arm64.tar.gz"
      sha256 "3959928a152e4b0538317907d51d48c92350a602709ec1025175b7f75e17b6b4"
    else
      url "https://github.com/NickBorgers/util/releases/download/v#{version}/network-mapper-darwin-amd64.tar.gz"
      sha256 "24ee398e41d0b8baacff4ecb14b43aaea4ea98ad2909eeccd1228ea11e984f75"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NickBorgers/util/releases/download/v#{version}/network-mapper-linux-arm64.tar.gz"
      sha256 "cf62d2375fd44aa69fcbf6235c9e884405c4fb39b98112c1b154355d51f07360"
    else
      url "https://github.com/NickBorgers/util/releases/download/v#{version}/network-mapper-linux-amd64.tar.gz"
      sha256 "89714067354aac418a657fd999f61289000ed345a6732c10f961dd5d99995333"
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

      To start with intelligent discovery (default, recommended):
        network-mapper

      To adjust thoroughness for intelligent discovery:
        network-mapper --thoroughness 1  # Minimal, faster
        network-mapper --thoroughness 5  # Exhaustive, thorough

      To run a quick brute-force scan (interface subnets only):
        network-mapper --scan-mode quick

      For help:
        network-mapper --help
    EOS
  end

  test do
    assert_match "Network Mapper", shell_output("#{bin}/network-mapper --version")
  end
end
