(ert-deftest evm-find-test ()
  (with-sandbox
   (f-mkdir "foo" "bar")
   (f-mkdir "baz")
   (f-touch (f-join "foo" "FOO"))
   (f-touch (f-join "foo" "bar" "BAR"))
   (f-touch (f-join "baz" "BAZ"))
   (should (equal (f-join default-directory "foo" "FOO") (evm-find "FOO")))
   (should (equal (f-join default-directory "foo" "bar" "BAR") (evm-find "BAR")))
   (should (equal (f-join default-directory "baz" "BAZ") (evm-find "BAZ")))
   (should-not (evm-find "qux"))))

(ert-deftest evm-emacs-test/osx ()
  (with-sandbox
   (f-mkdir "Emacs.app" "Contents" "MacOS")
   (f-touch (f-join "Emacs.app" "Contents" "MacOS" "Emacs"))
   (let ((system-type 'darwin))
     (should (string= (evm-emacs) (f-expand (f-join "Emacs.app" "Contents" "MacOS" "Emacs")))))))

(ert-deftest evm-emacs-test/non-osx ()
  (with-sandbox
   (f-mkdir "bin")
   (f-touch (f-join "bin" "emacs"))
   (let ((system-type 'msdos))
     (should (string= (evm-emacs) (f-expand (f-join "bin" "emacs")))))))

(ert-deftest evm-emacsclient-test/osx ()
  (with-sandbox
   (f-mkdir "Emacs.app" "Contents" "MacOS")
   (f-touch (f-join "Emacs.app" "Contents" "MacOS" "Emacs"))
   (let ((system-type 'darwin))
     (should (string= (evm-emacsclient) (f-expand (f-join "Emacs.app" "Contents" "MacOS" "bin" "emacsclient")))))))

(ert-deftest evm-emacsclient-test/non-osx ()
  (with-sandbox
   (f-mkdir "bin")
   (f-touch (f-join "bin" "emacs"))
   (let ((system-type 'msdos))
     (should (string= (evm-emacsclient) (f-expand (f-join "bin" "emacsclient")))))))
