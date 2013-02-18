require 'formula'

class IosWebkitDebugProxy < Formula
  homepage 'https://github.com/google/ios-webkit-debug-proxy'
  url 'https://github.com/google/ios-webkit-debug-proxy/archive/1.0.tar.gz'
  sha1 '2f05bdca351cb7730552a63b3825db858bf8fdd6'

  depends_on 'automake' => :build
  depends_on 'libimobiledevice'

  def install
    system "./autogen.sh"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
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

