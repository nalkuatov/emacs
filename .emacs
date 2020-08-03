;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))
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
(add-hook 'haskell-mode-hook
  (lambda ()
    (intero-mode)
    (turn-on-haskell-unicode-input-method)))

(require 'haskell-mode)
(define-key haskell-mode-map [f5] (lambda () (interactive) (compile "stack build --fast")))
(define-key haskell-mode-map [f12] 'intero-devel-reload)

;; purescript
(use-package purescript-mode :ensure t)

(use-package psc-ide
  :ensure t)
(add-hook 'purescript-mode-hook
  (lambda ()
    (psc-ide-mode)
    (company-mode)
    (flycheck-mode)
    (turn-on-purescript-unicode-input-method)
    (haskell-indentation-mode)))
;; use the psc-ide server that is relative to your npm bin directory, e.g. ./node_modules/.bin/purs
(setq psc-ide-use-npm-bin t)

;; Enable scala-mode for highlighting, indentation and motion commands
(use-package scala-mode
  :mode "\\.s\\(cala\\|bt\\)$")

;; Enable sbt mode for executing sbt commands
(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
   ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
   (setq sbt:program-options '("-Dsbt.supershell=false"))
)

(use-package eglot
  :pin melpa-stable
  :config
  (add-to-list 'eglot-server-programs '(scala-mode . ("metals-emacs")))
  ;; (optional) Automatically start metals for Scala files.
  :hook (scala-mode . eglot-ensure))

(use-package sr-speedbar
               :ensure t
                 :bind ("C-k" . sr-speedbar-toggle)
                   :init
                     (setq sr-speedbar-auto-refresh nil)
                       (setq speedbar-show-unknown-files t)
                       (setq speedbar-use-images nil))

(setq require-final-newline t)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

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
