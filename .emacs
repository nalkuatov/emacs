(package-initialize)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'load-path "~/.emacs.d/lisp")

;; Theme
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/vendor/zenburn-emacs/")
;; (load-theme 'zenburn t)

;; Bootstrap 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package solarized-theme
  :ensure t)
;; Don't change the font for some headings and titles
(setq solarized-use-variable-pitch nil)
;; Change the size of markdown-mode headlines (off by default)
(setq solarized-scale-markdown-headlines t)
;; Avoid all font-size changes
(setq solarized-height-minus-1 1.0)
(setq solarized-height-plus-1 1.0)
(setq solarized-height-plus-2 1.0)
(setq solarized-height-plus-3 1.0)
(setq solarized-height-plus-4 1.0)
;; Use less bolding
(setq solarized-use-less-bold t)
(load-theme 'solarized-light t)

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

(use-package haskell-mode
  :ensure t)

;; Intero itself
;; (use-package intero
;; :ensure t)
;; (add-hook 'haskell-mode-hook
;; (lambda ()
;;    (intero-mode)))

;; Trying to use ghcide instead of intero
;; (use-package flycheck
;;  :ensure t
;;  :init
;;  (global-flycheck-mode t))
;; (use-package yasnippet
;   :ensure t)
;; (use-package lsp-mode
;;  :ensure t
;;  :hook (haskell-mode . lsp)
;;  :commands lsp)
;; (use-package lsp-ui
;;  :ensure t
;;  :commands lsp-ui-mode)
;; (use-package lsp-haskell
; :ensure t
; :config
; (setq lsp-haskell-process-path-hie "ghcide")
; (setq lsp-haskell-process-args-hie '())
 ;; Comment/uncomment this line to see interactions between lsp client/server.
 ;;(setq lsp-log-io t)
;;)

;; (require 'haskell-mode)
;; (define-key haskell-mode-map [f5] (lambda () (interactive) (compile "stack build --fast")))
;; (define-key haskell-mode-map [f12] 'intero-devel-reload)
;; (global-set-key (kbd "C-0") 'haskell-mode-stylish-buffer)

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
  :ensure t
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
                       (setq sr-speedbar-right-side nil)
                       (setq speedbar-show-unknown-files t)
                       (setq speedbar-use-images nil))

(setq require-final-newline t)

;; easily switch between windows
(use-package ace-window :ensure t)
(global-set-key (kbd "M-o") 'ace-window)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(auto-save-visited-mode t)

(defun full-auto-save ()
  (interactive)
  (save-excursion
    (dolist (buf (buffer-list))
      (set-buffer buf)
      (if (and (buffer-file-name) (buffer-modified-p))
          (basic-save-buffer)))))
(add-hook 'auto-save-hook 'full-auto-save)

(defun save-all ()
  (interactive)
  (save-some-buffers t))

(add-hook 'focus-out-hook 'save-all)

;; (use-package hasklig-mode
;; :ensure t
;; :hook (haskell-mode)
;; :commands (hasklig-mode)
;; :delight "hl")

(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 2
                                  tab-width 2
                                  indent-tabs-mode nil)))

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
(set-frame-font "-outline-Tlwg Mono-normal-normal-normal-mono-18-*-*-*-c-*-iso8859-1")

;; make the scroll smooth
(setq mouse-wheel-progressive-speed nil)
