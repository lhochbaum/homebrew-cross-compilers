class GccI686Elf < Formula
  desc "GNU Compiler Collection for i686-elf target"
  homepage "https://www.gnu.org/software/gcc/gcc.html"
  url "https://ftpmirror.gnu.org/gcc/gcc-6.3.0/gcc-6.3.0.tar.bz2"
  sha256 "f06ae7f3f790fbf0f018f6d40e844451e6bc3b7bc96e128e63b09825c1f8b29f"

  option "without-cxx", "Don't build the g++ compiler"

  depends_on "gmp"
  depends_on "libmpc"
  depends_on "mpfr"
  depends_on "isl"
  depends_on "binutils-i686-elf"

  def install
    # The C compiler is always built, C++ can be disabled
    languages = %w[c]
    languages << "c++" if build.with? "cxx"

    args = [
      "--target=i686-elf",
      "--prefix=#{prefix}",

      "--enable-languages=#{languages.join(",")}",
      "--with-gnu-as",
      "--with-gnu-ld",
      "--with-ld=#{Formula["binutils-i686-elf"].opt_bin/"i686-elf-ld"}",
      "--with-as=#{Formula["binutils-i686-elf"].opt_bin/"i686-elf-as"}",
      "--disable-nls",
      "--without-headers",
      "--with-gmp=#{Formula["gmp"].opt_prefix}",
      "--with-mpfr=#{Formula["mpfr"].opt_prefix}",
      "--with-mpc=#{Formula["libmpc"].opt_prefix}",
      "--with-isl=#{Formula["isl"].opt_prefix}",
      "--with-system-zlib",
    ]

    mkdir "build" do
      system "../configure", *args
      system "make", "all-gcc"
      system "make", "all-target-libgcc"
      system "make", "install-gcc"
      system "make", "install-target-libgcc"
    end

    # info and man7 files conflict with native gcc
    info.rmtree
    man7.rmtree
  end
end
