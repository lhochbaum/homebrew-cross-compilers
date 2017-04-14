class I686ElfBinutils < Formula
  desc "Binutils for i686-elf target"
  homepage "https://www.gnu.org/software/binutils/"
  url "https://ftpmirror.gnu.org/binutils/binutils-2.28.tar.bz2"
  sha256 "6297433ee120b11b4b0a1c8f3512d7d73501753142ab9e2daa13c5a3edd32a72"

  def install
    args = [
      "--disable-debug",
      "--disable-dependency-tracking",
      "--prefix=#{prefix}",
      "--infodir=#{info}",
      "--mandir=#{man}",
      "--target=i686-elf",
      "--disable-nls",
      "--disable-werror",
      "--with-sysroot",
    ]

    mkdir "build" do
      system "../configure", *args

      system "make"
      system "make", "install"
    end

    info.rmtree # info files conflict with native binutils
  end
end
