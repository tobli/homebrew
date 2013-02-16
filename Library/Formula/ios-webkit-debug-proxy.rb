require 'formula'

class IosWebkitDebugProxy < Formula
  homepage 'https://github.com/google/ios-webkit-debug-proxy'
  head 'https://github.com/google/ios-webkit-debug-proxy.git'

  depends_on 'automake' => :build
  depends_on 'libimobiledevice'

  def install
    system "./autogen.sh"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make install"
  end

  def test
    system "ios_webkit_debug_proxy -h"
  end

  def patches
    # Fix compilation with clang
    DATA
  end

end

__END__
diff --git a/src/ios_webkit_debug_proxy_main.c b/src/ios_webkit_debug_proxy_main.c
index e2f8f3c..c65180c 100644
--- a/src/ios_webkit_debug_proxy_main.c
+++ b/src/ios_webkit_debug_proxy_main.c
@@ -52,7 +52,7 @@ int main(int argc, char** argv) {
   int ret = iwdpm_configure(self, argc, argv);
   if (ret) {
     exit(ret > 0 ? ret : 0);
-    return;
+    return ret;
   }
 
   iwdpm_create_bridge(self);

