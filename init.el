;; global settings
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode 0)
(global-linum-mode t)
(prefer-coding-system 'utf-8)
(set-default 'buffer-file-coding-system 'utf-8)

;; global shortcut settings
(keyboard-translate ?\C-h ?\C-?)

;; initialize el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))


(el-get-bundle which-key
  (which-key-mode)
  (which-key-setup-side-window-right)
  (defvar which-key-side-window-max-width 0.20))
(el-get-bundle magit)
(el-get-bundle trr)
(el-get-bundle company
  (add-hook 'after-init-hook 'global-company-mode))
(el-get-bundle lsp-mode
  (add-hook 'go-mode-hook #'lsp-deferred))
(el-get-bundle projectile
  (projectile-mode +1)
  (defvar projectile-completion-system 'helm))
(el-get-bundle markdown-mode)
(el-get-bundle editorconfig)
(el-get-bundle org-mode)
(el-get-bundle smartparens
  (smartparens-global-mode))
(el-get-bundle doom-themes
  (defvar doom-themes-enable-bold t)    ; if nil, bold is universally disabled
  (defvar doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t))
(el-get-bundle doom-modeline
  (add-hook 'after-init-hook #'doom-modeline-mode)
  (defvar doom-modeline-height 1)
  (defvar doom-modeline-icon nil))
(el-get-bundle go-mode)
(el-get-bundle helm
  (global-set-key (kbd "M-x") 'helm-M-x)
  (defvar helm-M-x-fuzzy-match t)
  (global-set-key (kbd "C-x b") 'helm-mini)
  (defvar helm-buffers-fuzzy-matching t)
  (defvar helm-recentf-fuzzy-match t)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (helm-mode 1))

(el-get 'sync)
