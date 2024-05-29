;; initialize package manger
(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("org"   . "https://orgmode.org/elpa/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))
  
  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))


;; editor settings
(leaf cus-edit
  :doc "tools for customizing Emacs and Lisp packages"
  :tag "builtin" "faces" "help"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))


(leaf cus-start
  :doc "define customization properties of builtins"
  :tag "builtin" "internal"
  :preface
  (defun c/redraw-frame nil
    (interactive)
    (redraw-frame))

  :bind (("M-ESC ESC" . c/redraw-frame))
  :custom '((create-lockfiles . nil)
            (debug-on-error . nil)
            (init-file-debug . t)
            (frame-resize-pixelwise . t)
            (enable-recursive-minibuffers . t)
            (history-length . 1000)
            (history-delete-duplicates . t)
            (scroll-preserve-screen-position . t)
            (scroll-conservatively . 100)            
            (ring-bell-function . 'ignore)
            (text-quoting-style . 'straight)
            (truncate-lines . t)
            (menu-bar-mode . nil)
            (tool-bar-mode . nil)
            (scroll-bar-mode . nil)
            (global-display-line-numbers-mode . t)
            (inhibit-startup-screen . t)
            (indent-tabs-mode . nil)
            (warning-minimum-level . :emergency))
  :config
  (defalias 'yes-or-no-p 'y-or-n-p)
  (keyboard-translate ?\C-h ?\C-?)
  (setq tab-width 2)
  (setq c-basic-offset 2)
  (setq indent-line-function 'insert-tab))



(leaf files
  :doc "file input and output commands for Emacs"
  :tag "builtin"
  :custom `((auto-save-timeout . 15)
            (auto-save-interval . 60)
            (auto-save-file-name-transforms . '((".*" ,(locate-user-emacs-file "backup/") t)))
            (backup-directory-alist . '((".*" . ,(locate-user-emacs-file "backup"))
                                        (,tramp-file-name-regexp . nil)))
            (version-control . t)
            (delete-old-versions . t)))

(leaf startup
  :doc "process Emacs shell arguments"
  :tag "builtin" "internal"
  :custom `((auto-save-list-file-prefix . ,(locate-user-emacs-file "backup/.saves-"))))


(leaf theme
  :config
  (leaf doom-themes
    :ensure t
    :custom
    (doom-themes-enable-bold . t)
    (doom-themes-enable-italic . t)
    :config
    (load-theme 'doom-one t))
  (leaf doom-modeline
    :ensure t
    :custom
    (doom-modeline-height . 1)
    (doom-modeline-icon . nil)
    :config
    (add-hook 'after-init-hook #'doom-modeline-mode))
  (leaf font
    :config
    (add-to-list 'default-frame-alist
                 '(font . "HackGen"))
    (set-face-attribute 'default t :font "HackGen")))

(leaf tools
  :config
  (leaf drag-stuff
    :doc "drag stuff (words, region, lines) around"
    :ensure t
    :config
    (drag-stuff-global-mode)
    (drag-stuff-define-keys)
    (setq drag-stuff-modifier '(meta shift)))
  (leaf magit
    :doc "git client"
    :ensure t
    :bind
    ("C-c g" . magit-status)
    :config
  )
    )
  (leaf exec-path-from-shell
    :ensure t
    :config
    (when (memq window-system '(mac ns x))
      (exec-path-from-shell-initialize)))
;;  (leaf fido
;;    :init
;;    (fido-mode t)
;;    :config
;;    )
  (leaf vertico
    :ensure t
    :init
    (vertico-mode)
    :config
    (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
    (advice-add #'completing-read-multiple :filter-args #'crm-indicator)
    (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
    (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)
    (setq enable-recursive-minibuffers t)
    (leaf consult
      :ensure t
      :bind
      ("C-x b" . consult-buffer)
      ("C-x r b" . consult-bookmark)
      ("M-y" . consult-yank-pop)
      ("M-g l" . consult-line))
    (leaf orderless
      :ensure t
      :config
      (setq completion-styles '(orderless)))
  )
  (leaf projectile
    :ensure t
    :init
    (projectile-mode t)
    :config
    (setq projectile-completion-system 'default)
  )
  (leaf ace-window
    :ensure t
    :bind
    ("C-x o" . ace-window)
    :config
    (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))
  (leaf zoom
    :ensure t
    :config
    (zoom-mode t)
    (custom-set-variables
     '(zoom-size '(0.618 . 0.618)))
    )
  (leaf avy
    :custom
      (avy-timeout-seconds . 10)
    :ensure t
    :bind
      ("C-:" . avy-goto-char-timer)
    :config
    )
  (leaf which-key
    :ensure t
    :config
    (which-key-mode t)
    (which-key-setup-side-window-bottom)
    )
  (leaf eglot
    :ensure t
    )
  (leaf yasnippet
    :ensure t
    :config
    (setq yas-snippet-dirs '("~/.emacs.d/plugins/snippets/yasnippet-snippets/snippets/"
                             "~/.emacs.d/plugins/snippets/personal/"
                             ))
    (yas-global-mode t))
  (leaf company
    :ensure t
    :config
    (add-hook 'after-init-hook 'global-company-mode))
  (leaf vterm
    :ensure t
    :custom
      (vterm-keymap-exceptions . '("C-c" "C-x" "C-u" "C-g" "C-l" "M-x" "M-o" "C-v" "M-v" "C-y" "M-y"))
    :config)

(defun list-directories (dir)
  (let ((result '()))
    (dolist (file (directory-files dir t))
      (when (and (file-directory-p file)
                 (not (member (file-name-nondirectory file) '("." ".."))))
        (push file result)))
    result))

(leaf lang
  :config
  (leaf org
    :doc "documentation"
    :ensure t
    :config
    (add-hook 'org-mode-hook
      (lambda () (setq tab-width 2))
      )
    (setq org-startup-truncated nil)
    (setq org-directory "~/Org")
    (setq org-default-notes-file "~/Org/notes.org")
    (define-key global-map "\C-cc" 'org-capture)
    ;;(setq org-agenda-files (append '("~/Org") (list-directories "~/Org")))
    (setq org-agenda-files (directory-files-recursively "~/Org" "org$"))
    (setq org-todo-keywords
          '((sequence "TODO" "DOING" "|" "DONE" "CANCEL")))
    (setq org-log-done 'time)
    (setq org-refile-targets '((org-agenda-files :maxlevel . 3)))
    (setq org-capture-templates
      '(("n" "Note" entry (file+headline "~/Org/notes.org" "Notes")
         "* %?\nEntered on %U\n %i\n %a")
        ))
    (defun show-org-buffer (file)
      "Show an org-file FILE on the current buffer."
      (interactive)
      (if (get-buffer file)
          (let ((buffer (get-buffer file)))
            (switch-to-buffer buffer)
            (message "%s" file))
        (find-file (concat "~/Org/" file))))
    (global-set-key (kbd "C-c o n") '(lambda () (interactive)
                                       (show-org-buffer "notes.org")))
    (leaf org-superstar
      :ensure t
      :config
      (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1))))
    (leaf org-journal
      :ensure t
      :bind
      ("C-c j" . org-journal-new-entry)
      :config
      (setq org-journal-dir "~/Org/journal")
      (setq org-journal-date-format "%Y-%m-%d, %A")
      (setq org-journal-file-format "%Y%m%d.org"))
  )
  (leaf text
    :config
    (add-hook 'text-mode-hook
      (lambda () (setq tab-width 2))
    )
  )
  (leaf elisp
    :config
    (add-hook 'emacs-lisp-mode-hook
      (lambda ()
        (setq indent-tabs-mode nil)
        (setq tab-width 2)
        (setq standard-indent 2)
      )
    )
  )
  (leaf markdown-mode
    :ensure t
    :config
    (add-hook 'markdown-mode-hook
      (lambda ()
        (setq indent-tabs-mode nil)
        (setq tab-width 2)
        (setq standard-indent 2)
      )
    )
  )
  (leaf go-mode
    :ensure t
    :config
    (add-hook 'go-mode-hook
       (lambda ()
        (setq tab-width 2)
        (eglot-ensure))))
  (leaf sh-mode
    :config
    (add-hook 'sh-mode-hook
              (lambda ()
                (setq tab-width 2)
                (setq standard-indent 2)
                (setq indent-tabs-mode nil)
                (eglot-ensure))))
  (leaf terraform-mode
    :ensure t
    :config
    (add-hook 'terraform-mode-hook #'outline-minor-mode)
    (custom-set-variables '(terraform-indent-level 4))
  ))


;;end of editor setting
(provide 'init)
