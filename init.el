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

;; cask initalize
(cond ((equal system-type 'darwin)
       (require 'cask "/usr/local/Cellar/cask/0.8.1/cask.el"))
      ((equal system-type 'gnu/linux)
       (require 'cask "~/.cask/cask.el")))
(cask-initialize)

;; thme settings
(load-theme 'monokai t)
;; power line
(require 'powerline)
(powerline-default-theme)


;; input support config
;; autocomplete
(require 'auto-complete)
(ac-config-default)

;; flycheck
(require 'flycheck)
(global-flycheck-mode)

;; yasnippet
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/plugins/snippets/personal/" ;; personal snippets
        "~/.emacs.d/plugins/snippets/yasnippet-snippets";; the yasmate collection
        ))
(yas-global-mode 1)

;; helm
(require 'helm-config)
(helm-mode 1)

;; git config
(require 'magit)

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; smarty-mode
(require 'smarty-mode)
(add-to-list 'auto-mode-alist '("\\.smarty\\'" . smarty-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . smarty-mode))


;; markdown-modepp
(require 'markdown-mode)
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
(require 'go-mode)
(require 'go-autocomplete)
(add-hook 'go-mode-hook 'flycheck-mode)

;; python mode config
(require 'python)
(defun python-shell-parse-command ()
  "Return the string used to execute the inferior Python process."
  "python3 -i"
  )

(keyboard-translate ?\C-h ?\C-?)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (mastodon smarty-mode 0xc yasnippet web-mode use-package twittering-mode trr smex smartparens projectile prodigy powerline popwin php-mode pallet nyan-mode multiple-cursors monokai-theme markdown-mode magit idle-highlight-mode htmlize helm go-mode go-autocomplete flycheck-cask expand-region exec-path-from-shell drag-stuff))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;; init.el ends here
