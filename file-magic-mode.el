;;; file-magic-mode.el --- Major mode for Unix file(1) magic patterns -*- lexical-binding: t -*-

;; Copyright 2022 Lassi Kortela
;; SPDX-License-Identifier: ISC

;; Author: Lassi Kortela <lassi@lassi.io>
;; URL: https://github.com/lassik/emacs-file-magic-mode
;; Version: 0.1.0
;; Package-Requires: ((emacs "24.5"))
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Provides the following commands:

;;; Code:

(defconst file-magic-mode-font-lock-keywords
  `(("^#.*\n"
     (0 'font-lock-comment-face))

    ("^>+"
     (0 'font-lock-keyword-face))

    ("\\(:mime\\)[ \t]+\\(.*/.*\\)"
     (1 'font-lock-keyword-face)
     (2 'font-lock-preprocessor-face))

    ("\\<0x[0-9a-f]+\\>"
     (0 'font-lock-builtin-face))

    ("\\<[0-9]+\\>"
     (0 'font-lock-builtin-face))

    ("u?\\(be\\|le\\)?\\(byte\\|short\\|long\\|double\\)"
     (0 'font-lock-type-face)))
  "Font lock keywords for `file-magic-mode'.")

;;;###autoload
(define-derived-mode file-magic-mode prog-mode "File-Magic"
  "Major mode for writing file(1) magic patterns.

The syntax is usually described on the magic(5) manual page."
  (set (make-local-variable 'font-lock-defaults)
       '(file-magic-mode-font-lock-keywords nil t)))

;; Add the file-magic pattern last in `auto-mode-alist', which means it
;; has lower priority than other filename patterns.  File-Magic files
;; don't have a filename extension; it's better to first match files
;; that have an extension since that's a better clue of the file type.

;;;###autoload
(add-to-list 'auto-mode-alist
             '("/[Mm]ag\\(ic\\|dir\\)/" . file-magic-mode)
             t)

(provide 'file-magic-mode)

;;; file-magic-mode.el ends here
