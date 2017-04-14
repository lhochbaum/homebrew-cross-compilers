class I686ElfGrub < Formula
  desc "GNU GRUB is a Multiboot boot loader"
  homepage "https://www.gnu.org/software/grub/"
  head "git://git.savannah.gnu.org/grub.git"

  depends_on "autoconf"
  depends_on "automake"
  depends_on "objconv"
  depends_on "i686-elf-gcc"
  depends_on "i686-elf-binutils"

  def install
    args = [
      "-disable-werror",
      "--prefix=#{prefix}",
      "TARGET_CC=#{Formula["i686-elf-gcc"].opt_bin}/i686-elf-gcc",
      "TARGET_OBJCOPY=#{Formula["i686-elf-binutils"].opt_bin}/i686-elf-objcopy",
      "TARGET_STRIP=#{Formula["i686-elf-binutils"].opt_bin}/i686-elf-strip",
      "TARGET_NM=#{Formula["i686-elf-binutils"].opt_bin}/i686-elf-nm",
      "TARGET_RANLIB=#{Formula["i686-elf-binutils"].opt_bin}/i686-elf-ranlib",
      "--target=i686-elf",
    ]
    
    system "./autogen.sh"
    mkdir "build" do
      system "../configure", *args
      system "make"
      system "make", "install"
    end
  end
end
