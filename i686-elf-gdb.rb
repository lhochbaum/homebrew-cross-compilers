class I686ElfGdb < Formula
  desc "GNU Project Debugger for i686-elf target"
  homepage "https://www.gnu.org/software/gdb/"
  url "https://ftpmirror.gnu.org/gdb/gdb-7.12.tar.xz"
  sha256 "834ff3c5948b30718343ea57b11cbc3235d7995c6a4f3a5cecec8c8114164f94"

  depends_on "i686-elf-binutils"
  depends_on "i686-elf-gcc"

  def install
    args = [
      "--prefix=#{prefix}",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--target=i686-elf",
    ]

    mkdir "build" do
      ENV.prepend_path("PATH", Formula["i686-elf-binutils"].opt_bin)
      ENV.prepend_path("PATH", Formula["i686-elf-gcc"].opt_bin)

      system "../configure", *args

      system "make"
      system "make", "install"
    end
    
    info.rmtree
    (share+"gdb").rmtree
    (share+"locale").rmtree
    (include+"gdb").rmtree
  end
end
