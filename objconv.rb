class Objconv < Formula
  desc "Utility used for converting object files between COFF/PE, OMF, ELF and Mach-O formats for all 32-bit and 64-bit x86 platforms"
  homepage "http://www.agner.org/optimize/"
  url "http://www.agner.org/optimize/objconv.zip"
  version "2016-Nov-27"
  sha256 ""

  def install
    system "unzip", "source.zip"
    system "sh", "./build.sh"
    system "mkdir", "#{prefix}/bin"
    system "cp", "objconv", "#{prefix}/bin"
  end
end
