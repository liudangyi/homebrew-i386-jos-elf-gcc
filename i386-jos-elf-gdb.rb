class I386JosElfGdb < Formula
  homepage "http://pdos.csail.mit.edu/6.828/2014/tools.html"
  url "http://ftpmirror.gnu.org/gdb/gdb-7.3.1.tar.bz2"
  sha256 "cdecfa69f02aa7b05fbcdf678e33137151f361313b2f3e48aba925f64eabf654"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--target=i386-jos-elf",
                          "--program-prefix=i386-jos-elf-",
                          "--disable-nls",
                          "--disable-werror"
    system "make", "all"
    system "make", "install"
    # avoid conflict with binutil
    if Formula["i386-jos-elf-binutils"].installed?
      rm_r share/"info"
      rm_r lib
    end
  end

  test do
    system "#{bin}/i386-jos-elf-gdb -v"
  end
end
