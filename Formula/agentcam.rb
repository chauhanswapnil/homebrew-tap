class Agentcam < Formula
  desc "A dashcam for your coding agents: replay and search every Claude Code and Codex session on your machine"
  homepage "https://github.com/chauhanswapnil/agentcam"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/chauhanswapnil/agentcam/releases/download/v0.1.0/agentcam-aarch64-apple-darwin.tar.xz"
      sha256 "17bcdbe9bca3947851c6c2a1127a96653ef2998679730963f259d70920e9d09a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chauhanswapnil/agentcam/releases/download/v0.1.0/agentcam-x86_64-apple-darwin.tar.xz"
      sha256 "46b779617bc9f8c677509e8d05231741d0a7ee856e24ea87bbb921c85c4516a2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/chauhanswapnil/agentcam/releases/download/v0.1.0/agentcam-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "076c749c22d05e9c52894a278125fb98bcde965ab925fc9be717995d3cd8fb76"
    end
    if Hardware::CPU.intel?
      url "https://github.com/chauhanswapnil/agentcam/releases/download/v0.1.0/agentcam-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1fd65401e7d2bac9beef6b29c9b4f8473a7ed8a0235a4fa29bfec243c668816d"
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
