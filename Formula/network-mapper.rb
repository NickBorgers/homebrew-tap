class NetworkMapper < Formula
  desc "Cross-platform network discovery and visualization tool"
  homepage "https://github.com/NickBorgers/util"
  version "2.4.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NickBorgers/util/releases/download/v#{version}/network-mapper-darwin-arm64.tar.gz"
      sha256 "653f9cae69c11d9b30d4f9a96003708b58c60c244736cd7b497440e467c76775"
    else
      url "https://github.com/NickBorgers/util/releases/download/v#{version}/network-mapper-darwin-amd64.tar.gz"
      sha256 "77eacdb3e6d7319695e17696427497e89789f2c1167dc5d905c78af75bc9892d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NickBorgers/util/releases/download/v#{version}/network-mapper-linux-arm64.tar.gz"
      sha256 "700bcd4a08de54bb0559c51bab748b0ca0a443beef81b90a14e42899d72c7bba"
    else
      url "https://github.com/NickBorgers/util/releases/download/v#{version}/network-mapper-linux-amd64.tar.gz"
      sha256 "0da2737257c8623e5bfb0db72a1ec6f05093a271e4242a74c8e3f094aebb6900"
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
