;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(add-to-list 'load-path "~/.emacs.d/lisp")

;; Theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/vendor/zenburn-emacs/")
(load-theme 'zenburn t)

;; Bootstrap 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package smex
 :ensure t)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Get Vim keybindings
(use-package evil
  :ensure t)
(evil-mode 1)

;; Intero itself
(use-package intero
 :ensure t)
(add-hook 'haskell-mode-hook 'intero-mode)

(require 'haskell-mode)
(define-key haskell-mode-map [f5] (lambda () (interactive) (compile "stack build --fast")))
(define-key haskell-mode-map [f12] 'intero-devel-reload)

(setq inhibit-startup-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(blink-cursor-mode 0)
(global-linum-mode t)
(column-number-mode t)
(setq-default indent-tabs-mode nil)
(setq-default show-trailing-whitespace t)
(setq evil-insert-state-cursor 'box)
(ido-mode 1)
(set-default-font "Tlwg Mono-11")
