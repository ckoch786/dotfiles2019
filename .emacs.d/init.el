;;; from https://www.emacswiki.org/emacs/LoadingLispFiles

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(defun load-directory (dir)
      (let ((load-it (lambda (f)
		       (load-file (concat (file-name-as-directory dir) f)))
		     ))
	(mapc load-it (directory-files dir nil "\\.el$"))))
(load-directory "~/.emacs.d/lisp/")

(require 'powershell)

(autoload 'PowerShell "powershell" "Run powershell as a shell within emacs." t) 

(column-number-mode 1)
(tool-bar-mode -1)

;;; TODO permission issues with savehist?????
;;; From http://pages.sachachua.com/.emacs.d/Sacha.html#org0477c97
;; (setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; (setq savehist-file "~/.emacs.d/savehist")
;; (savehist-mode 1)
;; (setq history-length t)
;; (setq history-delete-duplicates t)
;; (setq savehist-save-minibuffer-history 1)
;; (setq savehist-additional-variables
;;       '(kill-ring
;;         search-ring
;;         regexp-search-ring))
(display-time-mode 1)
