class NetworkMapper < Formula
  desc "Cross-platform network discovery and visualization tool"
  homepage "https://github.com/NickBorgers/util"
  version "2.7.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NickBorgers/util/releases/download/v#{version}/network-mapper-darwin-arm64.tar.gz"
      sha256 "966d7af9d6b6f8eaf19b5ab418b9b5a181c523dcd1c249158091f7f8031a02de"
    else
      url "https://github.com/NickBorgers/util/releases/download/v#{version}/network-mapper-darwin-amd64.tar.gz"
      sha256 "801b1d41ad859643ead8aa994d885d303d8eb39ea002a1deb15b608281b7d605"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NickBorgers/util/releases/download/v#{version}/network-mapper-linux-arm64.tar.gz"
      sha256 "56d94160a8308b2ac1aaa824fb3cd0588f2a202396b5e4ad12f292ccd0d40bfd"
    else
      url "https://github.com/NickBorgers/util/releases/download/v#{version}/network-mapper-linux-amd64.tar.gz"
      sha256 "f3be8b8dcda8f992005b4386114e2a818e29ec5debdf1036fa083acde98150d6"
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
