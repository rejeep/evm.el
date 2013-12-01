(require 'f)

(defvar evm-test/test-path
  (f-dirname (f-this-file)))

(defvar evm-test/vendor-path
  (f-expand "vendor" evm-test/test-path))

(unless (require 'ert nil 'noerror)
  (require 'ert (f-expand "ert" evm-test/vendor-path)))
