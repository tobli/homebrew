require 'formula'

class Libpqxx < Formula
  homepage 'http://pqxx.org/development/libpqxx/'
  url 'http://pqxx.org/download/software/libpqxx/libpqxx-4.0.1.tar.gz'
  sha1 '4748835bd1a90fb34e6e577788006a416c2acb60'

  depends_on 'pkg-config' => :build
  depends_on :postgresql

  def install
    system "./configure", "--prefix=#{prefix}", "--enable-shared"
    system "make install"
  end
end
