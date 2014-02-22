(require 'f)

(defvar evm-test/test-path
  (f-dirname (f-this-file)))

(defvar evm-test/root-path
  (f-parent evm-test/test-path))

(defvar evm-sandbox-path
  (f-expand "sandbox" evm-test/test-path))

(defmacro with-sandbox (&rest body)
  `(let ((evm-path evm-sandbox-path)
         (default-directory evm-sandbox-path))
     (when (f-dir? evm-sandbox-path)
       (f-delete evm-sandbox-path 'force))
     (f-mkdir evm-sandbox-path)
     (f-mkdir evm-sandbox-path "bin")
     (let ((emacs-test-path (f-expand "emacs-test" evm-sandbox-path)))
       (f-mkdir emacs-test-path)
       (f-symlink emacs-test-path (f-join evm-sandbox-path "bin" "emacs"))
       (let ((default-directory emacs-test-path))
         ,@body))))

(require 'evm (f-expand "evm" evm-test/root-path))
