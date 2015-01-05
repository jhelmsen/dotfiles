;autoinstall packages that are good
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))
(defvar wanted-packages
  '(cider monokai-theme zenburn-theme smartparens evil company yasnippet undo-tree projectile
    rainbow-delimiters helm multiple-cursors flycheck go-mode helm-projectile))
(dolist (p wanted-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;basic appearance crap
(setq inhibit-splash-screen t)
(tool-bar-mode -1)
(set-default-font "Consolas-11")
(load-theme 'monokai t)
(global-linum-mode t)

;get backup files out of the way
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
      backup-directory-alist `((".*" . ,temporary-file-directory)))

;helm
(require 'helm-config)
(helm-mode 1)

;(require 'evil)
;(evil-mode 1)

;company
(add-hook 'after-init-hook 'global-company-mode)

;multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(require 'smartparens-config)
(require 'rainbow-delimiters)

;clojure
(dolist (h '(cider-mode-hook cider-repl-mode-hook))
  (add-hook h 'smartparens-strict-mode)
  (add-hook h 'show-paren-mode)
  (add-hook h 'rainbow-delimiters-mode)
  (add-hook h 'cider-turn-on-eldoc-mode))

;go
(require 'go-mode)

;elisp
(add-hook 'emacs-lisp-mode-hook 'smartparens-strict-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

;(require 'yasnippet)
;(yas-global-mode t)

;projectile - can't get it to only turn on in a project
;(require 'projectile)
;(require 'helm-projectile)
;(setq projectile-require-project-root t)
;(add-hook 'go-mode-hook 'projectile-mode)
;(setq projectile-indexing-method 'alien)

;recentf
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

;flycheck
(add-hook 'go-mode-hook 'flycheck-mode)
(add-hook 'cider-mode-hook 'flycheck-mode)
(setq flycheck-check-syntax-automatically '(save))
