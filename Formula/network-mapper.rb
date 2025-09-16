class NetworkMapper < Formula
  desc "Cross-platform network discovery and visualization tool"
  homepage "https://github.com/NickBorgers/util"
  version "2.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NickBorgers/util/releases/download/v#{version}/network-mapper-darwin-arm64.tar.gz"
      sha256 "0569a5b19f27b24fde7162e68c6189bef5a25d0f8b93f2ea220c1e274d76592b"
    else
      url "https://github.com/NickBorgers/util/releases/download/v#{version}/network-mapper-darwin-amd64.tar.gz"
      sha256 "1b36131267951f0617e380ab85fef24fb4b584dcb2e1124a4684cd361a54b9f0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NickBorgers/util/releases/download/v#{version}/network-mapper-linux-arm64.tar.gz"
      sha256 "baa57838ae6b3eae803217c8d5ffa3f3297450144d804776133c082273b86b1c"
    else
      url "https://github.com/NickBorgers/util/releases/download/v#{version}/network-mapper-linux-amd64.tar.gz"
      sha256 "f9c084f8b97a56b3184d1e274aea4ac5241a67c69fa9c5c09660a9e1ea4907d1"
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
