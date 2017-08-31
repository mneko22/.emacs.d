;;; package -- Smarray
;;; Commentary:
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;; Code:

;; common settings
(package-initialize)
(tool-bar-mode 0)
(setq inhibit-startup-screen t)
(global-linum-mode t)

;; shortcut settings
(keyboard-translate ?\C-h ?\C-?)

;; cask initalize
(cond ((equal system-type 'darwin)
       (require 'cask "/usr/local/Cellar/cask/0.8.1/cask.el"))
      ((equal system-type 'gnu/linux)
       (require 'cask "~/.cask/cask.el")))
(cask-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (mastodon smarty-mode yasnippet web-mode use-package twittering-mode trr  smartparens projectile powerline popwin php-mode pallet multiple-cursors monokai-theme markdown-mode magit htmlize helm go-mode go-autocomplete flycheck-cask expand-region drag-stuff))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; thme settings
(load-theme 'monokai t)
;; power line
(powerline-default-theme)

;; drag-stuff
;; metaキー+shiftキー+上or下で行の入れ替えができる
(drag-stuff-global-mode 1)
(drag-stuff-define-keys)
(setq drag-stuff-modifier '(meta shift))

;; 選択範囲を広げる
(global-set-key (kbd "C-=") 'er/expand-region)

;;カッコがいいかんじになる
(smartparens-global-mode t)

;; input support config
;; autocomplete
(ac-config-default)

;; flycheck
(global-flycheck-mode)

;; yasnippet
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/plugins/snippets/personal/" ;; personal snippets
        "~/.emacs.d/plugins/snippets/yasnippet-snippets";; the yasmate collection
        ))
(yas-global-mode 1)

;; helm
(helm-mode 1)

;; git config


;; web-mode
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; smarty-mode
(add-to-list 'auto-mode-alist '("\\.smarty\\'" . smarty-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . smarty-mode))


;; markdown-modepp
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))


;; go-mode
(add-to-list 'exec-path (expand-file-name "/opt/go/bin/"))
(add-to-list 'exec-path (expand-file-name "~/.go/bin/"))
(add-hook 'go-mode-hook 'flycheck-mode)

;; python mode config
(require 'python)
(defun python-shell-parse-command ()
  "Return the string used to execute the inferior Python process."
  "python3 -i"
  )

;;; init.el ends here
