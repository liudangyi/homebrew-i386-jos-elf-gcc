class I386JosElfGcc < Formula
  homepage "http://pdos.csail.mit.edu/6.828/2014/tools.html"
  url "http://ftpmirror.gnu.org/gcc/gcc-4.6.1/gcc-core-4.6.1.tar.bz2"
  sha256 "0bbb8f754a31f29013f6e9ad4c755d92bb0f154a665c4b623e86ae7174d98e33"

  depends_on 'gmp'
  depends_on 'libmpc'
  depends_on 'mpfr'
  depends_on 'i386-jos-elf-binutils'

  patch :DATA

  def install
    mkdir 'build' do
      system "../configure", "--prefix=#{prefix}",
                             "--target=i386-jos-elf",
                             "--disable-werror",
                             "--disable-libssp",
                             "--disable-libmudflap",
                             "--disable-nls",
                             "--with-newlib",
                             "--with-as=#{Formula["i386-jos-elf-binutils"].opt_prefix}/bin/i386-jos-elf-as",
                             "--with-ld=#{Formula["i386-jos-elf-binutils"].opt_prefix}/bin/i386-jos-elf-ld",
                             "--without-headers",
                             "--enable-languages=c"
      system "make", "all-gcc"
      system "make", "install-gcc"
      system "make", "all-target-libgcc"
      system "make", "install-target-libgcc"
    end
  end

  test do
    system "#{bin}/i386-jos-elf-gcc -v"
  end
end

__END__
diff --git a/gcc/gengtype.c b/gcc/gengtype.c
index abf17f8..550d3bb 100644
--- a/gcc/gengtype.c
+++ b/gcc/gengtype.c
@@ -3594,13 +3594,13 @@ write_field_root (outf_p f, pair_p v, type_p type, const char *name,
                  int has_length, struct fileloc *line, const char *if_marked,
                  bool emit_pch, type_p field_type, const char *field_name)
 {
+  struct pair newv;
   /* If the field reference is relative to V, rather than to some
      subcomponent of V, we can mark any subarrays with a single stride.
      We're effectively treating the field as a global variable in its
      own right.  */
   if (v && type == v->type)
     {
-      struct pair newv;
 
       newv = *v;
       newv.type = field_type;
