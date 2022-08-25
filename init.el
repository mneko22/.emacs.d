;; common settings
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode 0)
(global-linum-mode t)
(prefer-coding-system 'utf-8)
(set-default 'buffer-file-coding-system 'utf-8)

;; shortcut settings
(keyboard-translate ?\C-h ?\C-?)

;; package manager settings
(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))


(use-package doom-themes
  :ensure t
  :init
  (defvar doom-themes-enable-bold t)    ; if nil, bold is universally disabled
  (defvar doom-themes-enable-italic t) ; if nil, italics is universally disabled
  :config
  (load-theme 'doom-one t)
  (use-package doom-modeline
    :ensure t
    :hook (after-init . doom-modeline-mode)
    :config
    (defvar doom-modeline-height 1)
    (defvar doom-modeline-icon nil)))

(use-package which-key
  :ensure t
  :init
  (defvar which-key-side-window-max-width 0.20)
  :config
  (which-key-setup-side-window-right)
  (which-key-mode))

(use-package company
  :ensure t
  :hook (after-init . global-company-mode))

(use-package helm
  :ensure t
  :init
  (defvar helm-M-x-fuzzy-match t)
  (defvar helm-buffers-fuzzy-matching t)
  (defvar helm-recentf-fuzzy-match t)
  :bind
  (("M-x" . helm-M-x)
   ("C-x b" . helm-mini)
   ("C-x C-f" . helm-find-files))
  :config
  (helm-mode 1))
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))
  
(use-package org
  :ensure t)
(use-package go-mode
  :ensure t
  :config)

(use-package ace-jump-mode
  :init
  (eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
  :bind
  (("C-c SPC" . ace-jump-mode)
   ("C-x SPC" . ace-jump-mode-pop-mark)))
