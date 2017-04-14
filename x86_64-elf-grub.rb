class X8664ElfGrub < Formula
  desc "GNU GRUB is a Multiboot boot loader"
  homepage "https://www.gnu.org/software/grub/"
  head "git://git.savannah.gnu.org/grub.git"

  depends_on "autoconf"
  depends_on "automake"
  depends_on "objconv"
  depends_on "x86_64-elf-gcc"
  depends_on "x86_64-elf-binutils"

  def install
    args = [
      "-disable-werror",
      "--prefix=#{prefix}",
      "TARGET_CC=#{Formula["x86_64-elf-gcc"].opt_bin}/x86_64-elf-gcc",
      "TARGET_OBJCOPY=#{Formula["x86_64-elf-binutils"].opt_bin}/x86_64-elf-objcopy",
      "TARGET_STRIP=#{Formula["x86_64-elf-binutils"].opt_bin}/x86_64-elf-strip",
      "TARGET_NM=#{Formula["x86_64-elf-binutils"].opt_bin}/x86_64-elf-nm",
      "TARGET_RANLIB=#{Formula["x86_64-elf-binutils"].opt_bin}/x86_64-elf-ranlib",
      "--target=x86_64-elf",
    ]
    
    system "./autogen.sh"
    mkdir "build" do
      system "../configure", *args
      system "make"
      system "make", "install"
    end
  end
end
