class Libpointing < Formula
  desc "Provides direct access to HID pointing devices"
  homepage "http://libpointing.org"
  url "https://github.com/INRIA/libpointing/releases/download/v1.0.1/libpointing-mac-1.0.1.tar.gz"
  sha256 "46e2cefa7eb41b9f0c4e5e9b9307ce50e5a36b7a986606e1f759ec6b4efb1204"

  bottle do
    cellar :any
    sha256 "b01b5ecd5414895be0800699356bf90744fcd2b312c814fd1be3c5975f991d79" => :el_capitan
    sha256 "04e722aad17ff31cea60ed6da8564294a8a8ec9fbea674c638922642becc85c3" => :yosemite
    sha256 "8bc1371ef1ba9b2339594a3cb963680df280500e27cba265d8f5f9ec8ec8b139" => :mavericks
  end

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <pointing/pointing.h>
      #include <iostream>
      int main() {
        std::cout << LIBPOINTING_VER_STRING << " |" ;
        std::list<std::string> schemes = pointing::TransferFunction::schemes() ;
        for (std::list<std::string>::iterator i=schemes.begin(); i!=schemes.end(); ++i) {
          std::cout << " " << (*i) ;
        }
        std::cout << std::endl ;
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-lpointing", "-o", "test"
    system "./test"
  end
end
