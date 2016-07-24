(setq inhibit-startup-screen t)
(global-linum-mode t)
(require 'cask "~/.cask/cask.el")
(cask-initialize)

(require 'auto-complete)
(ac-config-default)

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
      '("~/.emacs.d/snippets" ;; personal snippets
        "~/.emacs.d/yasnippet-snipetts/" ;; the yasmate collection
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
