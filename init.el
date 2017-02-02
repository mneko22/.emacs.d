;;; package --- Summary
;;; Commentary:
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;; Code:
(package-initialize)

(setq inhibit-startup-screen t)
(global-linum-mode t)

(cond ((equal system-type 'darwin)
       (require 'cask "/usr/local/Cellar/cask/0.7.4/cask.el"))
      ((equal system-type 'gnu/linux)
       (require 'cask "~/.cask/cask.el")))
;;(require 'cask "~/.cask/cask.el")
;;(require 'cask "/usr/local/Cellar/cask/0.7.4/cask.el")
(cask-initialize)

(load-theme 'monokai t)

(require 'auto-complete)
(ac-config-default)

(require 'flycheck)
(global-flycheck-mode)

(require 'magit)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))


(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/plugins/snippets" ;; personal snippets
        "~/.emacs.d/plugins/yasnippet-snippets/" ;; the yasmate collection
        ))
(yas-global-mode 1)

;; helm
(require 'helm-config)
(helm-mode 1)
;;(define-key global-map (kbd "C-l") 'helm-mini)

;; font-settings
(set-face-attribute 'default nil
		    :family "Ricty Discord"
                    :height 120)
	     (set-fontset-font (frame-parameter nil 'font)
			       'japanese-jisx0208
			       (cons "Ricty Discord" "iso10646-1"))
	     (set-fontset-font (frame-parameter nil 'font)
			       'japanese-jisx0212
			       (cons "Ricty Discord" "iso10646-1"))
	     (set-fontset-font (frame-parameter nil 'font)
			       'katakana-jisx0201
			       (cons "Ricty Discord" "iso10646-1"))

(require 'twittering-mode)
(setq twittering-use-master-password t)
(setq twitterring-use-sssl t)
(setq twittering-icon-mode t)
(setq twittering-icon-timeline-spec-string
      '(":replies"
	":favorites"
	":retweets_of_me"
	":home"
	))

(require 'markdown-mode)
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(require 'powerline)
(powerline-default-theme)

(add-to-list 'exec-path (expand-file-name "/opt/go/bin/"))
(add-to-list 'exec-path (expand-file-name "~/.go/bin/"))

(require 'go-mode)
(require 'go-autocomplete)
(add-hook 'go-mode-hook 'flycheck-mode)
(global-set-key "\C-h" 'delete-backward-char)
(provide 'init)
;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (trr yasnippet web-mode use-package twittering-mode smex smartparens projectile prodigy powerline popwin php-mode pallet nyan-mode multiple-cursors monokai-theme markdown-mode magit idle-highlight-mode htmlize helm go-mode go-autocomplete flycheck-cask expand-region exec-path-from-shell drag-stuff))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
