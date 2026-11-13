class Agentcam < Formula
  desc "A dashcam for your coding agents: replay and search every Claude Code and Codex session on your machine"
  homepage "https://github.com/chauhanswapnil/agentcam"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/chauhanswapnil/agentcam/releases/download/v0.2.0/agentcam-aarch64-apple-darwin.tar.xz"
      sha256 "f4c43ec259a0f2ed5e80e1975918b8de3aaa2ddd39d5abdadab816e36633e87d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chauhanswapnil/agentcam/releases/download/v0.2.0/agentcam-x86_64-apple-darwin.tar.xz"
      sha256 "7296deafec80d5b2a1d6a23b88ff8d27b5bc1a242e466b0c7ae9c3c0762fdb52"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/chauhanswapnil/agentcam/releases/download/v0.2.0/agentcam-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "41b66f48ae9c5c3424afa0b9e68a343e7bb6c3663ebf37b0b582e0de87614927"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chauhanswapnil/agentcam/releases/download/v0.2.0/agentcam-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "63798dfe9f471e416efcb38cfbddf8286ca29e69550b1de017482b3438557db5"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "agentcam"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "agentcam"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "agentcam"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "agentcam"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
