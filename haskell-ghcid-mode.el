;;; haskell-ghci-mode.el --- Emacs major mode for navigating ghcid and ghciwatch errors  -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Thomas Tuegel

;; Author: Thomas Tuegel <ttuegel@mailbox.org>
;; Version: 0.1
;; Package-Requires: ((emacs "25.1") (haskell-mode "17.4"))
;; Keywords: languages, haskell
;; URL: https://github.com/ttuegel/haskell-ghcid-mode

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

(require 'haskell-compile)

(defun haskell-ghcid-mode--after-revert nil
  "Default `after-revert-hook' for `haskell-ghcid-mode'."
  (goto-char (point-min))
  ;; `compilation-next-error' fails if the first error is at `point-min', so
  ;; insert an empty line at the beginning of the buffer.
  (when (looking-at-p "[^[:space:]]")
    (let ((inhibit-read-only t)) (insert "\n"))
    (set-buffer-modified-p nil)
    )
  ;; Reset `next-error-last-buffer' to restore focus to `haskell-ghcid-mode'
  ;; when the buffer is refreshed.
  (setq next-error-last-buffer (current-buffer))
  )

;;;###autoload
(define-derived-mode haskell-ghcid-mode haskell-compilation-mode "haskell-ghcid"
  "Major mode for navigating messages in a \"ghcid.txt\" file.

`haskell-ghcid-mode' does not manage the ghcid or ghciwatch process because
different projects have a myriad of different requirements. Instead, start ghcid
or ghciwatch in the manner of your choosing and direct errors to \"ghcid.txt\"."
  (auto-revert-mode)
  (add-hook 'after-revert-hook #'haskell-ghcid-mode--after-revert nil t)
  (haskell-ghcid-mode--after-revert)
  )

;;;###autoload
(add-to-list 'auto-mode-alist '("ghcid\\.txt\\'" . haskell-ghcid-mode))

(provide 'haskell-ghcid-mode)
;;; haskell-ghcid-mode.el ends here
