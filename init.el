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

;; set theme
(cond ((equal window-system 'nil)
       (load-theme 'monokai t))
      ((equal window-system 'ns)
       (load-theme 'atom-one-dark  t))
      ((equal window-system 'x)
       (load-theme 'atom-one-dark t)))

;; show directory tree
;;(bind-key "C-x C-b" 'neotree-toggle)
(bind-key "C-x C-b" 'dired-sidebar-toggle-sidebar)
(setq dired-sidebar-theme 'nerd)

;; editor config
(editorconfig-mode t)

;; company-mode
(global-company-mode)
(setq company-selection-wrap-around t)

;; eshell settings
;; load path
(exec-path-from-shell-initialize)
;; eshell prompt
(defun is-repository ()
  (vc-find-root (string-trim (shell-command-to-string "pwd")) ".git"))
(defun current-branch()
  (string-trim (shell-command-to-string "git symbolic-ref --short HEAD")))
(setq eshell-prompt-function
      (lambda nil
	(concat
	 (propertize (concat "\s" (user-login-name) "\s") 'face `(:foreground "black" :background "#3b83f7"))
	 (propertize (concat "\s" (eshell/pwd) "\s") 'face `(:foreground "black" :background "orange"))
	 (if (is-repository)
	     (propertize (concat "<" (current-branch) ">") 'face `(:foreground "orange")))
	 (propertize "\n\s$" 'face `(:foreground "green")) "\s")))
;;(setq eshell-highlight-prompt nil)

;; drag-stuff
;; metaキー+shiftキー+上or下で行の入れ替えができる
(drag-stuff-global-mode 1)
(drag-stuff-define-keys)
(setq drag-stuff-modifier '(meta shift))

;; delete whiltespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; smart parens
(smartparens-global-mode t)

;; projectile-mode enable
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;; helm
(helm-mode 1)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-s o") 'helm-occur)
(add-hook 'eshell-mode-hook
	  (lambda ()
	      (define-key eshell-mode-map
		(kbd "M-p")
		'helm-eshell-history)))
(setq helm-M-x-fuzzy-match t
      helm-recentf-fuzzy-match t
      helm-buffers-fuzzy-matching t)

;; yasnippet
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/plugins/snippets/personal/" ;; personal snippets
        "~/.emacs.d/plugins/snippets/yasnippet-snippets";; the yasmate collection
        ))
(yas-global-mode 1)

;; web-mode
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; xml-config
(add-to-list 'auto-mode-alist '("\\.launch\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.urdf\\'"  . xml-mode))
(add-to-list 'auto-mode-alist '("\\.xacro\\'" . web-mode))

;; org-mode
(setq open-junk-file-format "~/Documents/org/%Y-%m%d.org")
(global-set-key "\C-xj" 'open-junk-file)
(add-hook 'org-mode-hook
	  (lambda ()
	    (local-set-key "\C-caa" 'org-agenda-list)
	    (local-set-key "\C-ccat" 'org-todo-list)
	    (local-set-key "\M-n" 'outline-next-heading)
	    (local-set-key "\M-p" 'outline-previous-heading)))
(setq org-agenda-files '("~/Documents/org"))
(setq org-log-done 'time)
(setq org-enforce-todo-dependencies t)

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
(defun python-shell-parse-command ()
  "Return the string used to execute the inferior Python process."
  "python3 -i"
  )
