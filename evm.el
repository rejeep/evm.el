;;; evm.el --- Emacs Version Manager

;; Copyright (C) 2013 Johan Andersson

;; Author: Johan Andersson <johan.rejeep@gmail.com>
;; Maintainer: Johan Andersson <johan.rejeep@gmail.com>
;; Version: 0.4.0
;; URL: http://github.com/rejeep/evm
;; Package-Requires: ((dash "2.3.0") (f "0.13.0"))

;; This file is NOT part of GNU Emacs.

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

(require 'f)
(require 'dash)

(defvar evm-path
  (f-expand ".evm" "~")
  "Path to EVM installation.")

(defun evm--installation-path ()
  "Path to currently selected package."
  (f-canonical (f-join evm-path "bin" "emacs")))

(defun evm--osx? ()
  "Return true if OSX, false otherwise."
  (eq system-type 'darwin))

(defun evm-find (file)
  "Find FILE in the currently selected Emacs installation."
  (-first-item
   (f-files
    (evm--installation-path)
    (lambda (path)
      (equal (f-filename path) file))
    'recursive)))

(defun evm-emacs ()
  "Return absolute path to Emacs binary."
  (let ((default-directory (evm--installation-path)))
    (f-expand
     (if (and (evm--osx?) (f-dir? "Emacs.app"))
         (f-join "Emacs.app" "Contents" "MacOS" "Emacs")
       (f-join "bin" "emacs")))))

(defun evm-emacsclient ()
  "Return absolute path to Emacsclient binary."
  (let ((default-directory (evm--installation-path)))
    (f-expand
     (if (and (evm--osx?) (f-dir? "Emacs.app"))
         (f-join "Emacs.app" "Contents" "MacOS" "bin" "emacsclient")
       (f-join "bin" "emacsclient")))))

(provide 'evm)

;;; evm.el ends here
