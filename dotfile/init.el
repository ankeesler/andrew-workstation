;; default thingys

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq-default indent-tabs-mode nil)
(setq-default column-number-mode t)
(setq-default tab-width 2)
(setq-default next-screen-context-lines 10)

;; turn that stupid bell off
(setq ring-bell-function 'ignore)

;; use M-r for recompile
(global-set-key (kbd "M-r") 'recompile)

;; use C-c C-f for open other file
(global-set-key (kbd "C-c o") 'ff-find-other-file)

;; don't show the menu
(menu-bar-mode -1)

;; bring in the package manager
(require 'package)
(add-to-list
 'package-archives
 '("melpa" . "https://melpa.org/packages/")
 t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fill-column 80)
 '(package-selected-packages
   '(fill-column-indicator gotest flycheck flymake-shell flymake-shellcheck flymake-go flymake lsp-ui use-package company-lsp lsp-mode clang-format clang-format+ rubocop yaml-mode dockerfile-mode elpy go-guru fzf go-rename go-autocomplete go-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

; tie fzf-git-files to keyboard shortcut
(global-set-key (kbd "C-x C-o") 'fzf-git-files)

(load-theme 'tango-dark) ;; agkeesle change!

; add line numbers
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

; flycheck?
(add-hook 'after-init-hook #'global-flycheck-mode)

; global delete-selection-mode
(add-hook 'after-init-hook 'delete-selection-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; go

(with-eval-after-load 'go-mode
  (add-hook 'go-mode-hook 'subword-mode))

(use-package lsp-mode
  :ensure t
  :config (setq lsp-file-watch-threshold 100000) ; k/k is ~55,000 files
  :commands (lsp lsp-deferred)
  :init
  :hook (go-mode . lsp-deferred))

;; Set up before-save hooks to format buffer and add/delete imports.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

; hit C-c SPC to suggest completions
(global-set-key (kbd "C-c SPC") 'company-complete)

; call gofmt + goimports before save
;(add-hook 'before-save-hook #'gofmt-before-save)
;(setq gofmt-command "goimports")

; go guru package
;(require 'go-guru)

; testing shortcuts
(global-set-key (kbd "C-c t") 'go-test-current-test)
(global-set-key (kbd "C-c T") 'go-test-current-project)

; enable visible column
; set fill column at 100 characters
(add-hook 'go-mode-hook
          (lambda() (fci-mode) (setq fci-rule-column 100)))

; enable yas-minor-mode for snippets
(add-hook 'go-mode-hook 'yas-minor-mode)

; enable auto filling at 100 colums
(add-hook 'go-mode-hook
          (lambda() (auto-fill-mode) (setq fill-column 100)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ruby

(add-hook 'ruby-mode-hook #'rubocop-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; c/c++

; does clang-format+ do this for us?
(add-hook 'before-save-hook
          (lambda() (when (or
                           (eq major-mode 'c-mode)
                           (eq major-mode 'c++-mode))
                      (clang-format-buffer))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; sh

;(require 'flymake-shellcheck)
;(add-hook 'sh-mode-hook 'flymake-shellcheck-load)
;(require 'flymake-shell)
;(add-hook 'sh-set-shell-hook 'flymake-shell-load)

(defun setup-sh-mode ()
  "My own personal preferences for `sh-mode'.

This is a custom function that sets up the parameters I usually
prefer for `sh-mode'.  It is automatically added to
`sh-mode-hook', but is can also be called interactively."
  (interactive)
  (setq sh-basic-offset 2
        sh-indentation 2))
(add-hook 'sh-mode-hook 'setup-sh-mode)
; '(smie-indent-basic 2) what?

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; markdown

(add-hook 'markdown-mode-hook 'flyspell-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; latex

(add-hook 'latex-mode-hook 'flyspell-mode)
(add-hook 'latex-mode-hook 'auto-fill-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'init)
;;; init.el ends here
