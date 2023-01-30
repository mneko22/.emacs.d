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
            (indent-tabs-mode . nil))
  :config
  (defalias 'yes-or-no-p 'y-or-n-p)
  (keyboard-translate ?\C-h ?\C-?)
  (setq-default tab-width 2)
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
    :config
    (defvar doom-themes-enable-bold t)
    (defvar doom-themes-enable-italic t)
    (load-theme 'doom-one t))
  (leaf doom-modeline
    :ensure t
    :config
    (add-hook 'after-init-hook #'doom-modeline-mode)
    (defvar doom-modeline-height 1)
    (defvar doom-modeline-icon nil)))


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
    :config
    (global-set-key (kbd "C-c g") 'magit-status)
    )
  (leaf fido
    :init
    (fido-mode t)
    :config
    )
  (leaf ace-window
    :ensure t
    :config
    (global-set-key (kbd "C-x o") 'ace-window)
    (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
    )
  (leaf zoom
    :ensure t
    :config
    (zoom-mode t)
    (custom-set-variables
     '(zoom-size '(0.618 . 0.618)))
    )
  (leaf avy
    :ensure t
    :config
    (global-set-key (kbd "C-c j c") 'avy-goto-char)
    (global-set-key (kbd "C-c j w") 'avy-goto-char-2)
    (global-set-key (kbd "C-c j l") 'avy-goto-line)
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
  (leaf company
    :ensure t
    :config
    (add-hook 'after-init-hook 'global-company-mode)
    ))


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
    (setq org-agenda-files '("~/Org" "~/Org/todo"))
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
        (setq go-indent-offset 2)
        (setq tab-width 2)
        (setq standard-indent 2)
        (setq indent-tabs-mode nil)
        (eglot-ensure)
      )
    )
  )
)


;;end of editor setting
(provide 'init)
