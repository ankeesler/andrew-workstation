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

;; use M-l for goto-line
(global-set-key (kbd "M-l") 'goto-line)

;; use M-r for recompile
(global-set-key (kbd "M-r") 'recompile)

;; don't show the menu
(menu-bar-mode -1)

;; bring in the package manager
(require 'package)
(add-to-list
 'package-archives
 '("melpa" . "http://melpa.milkbox.net/packages/")
 t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (rubocop yaml-mode eclim dockerfile-mode elpy go-guru fzf go-rename go-autocomplete go-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; call go fmt before save
(add-hook 'before-save-hook #'gofmt-before-save)

;; eclim???
(add-hook 'java-mode-hook 'eclim-mode)

;; When I add this stuff, the go autocomplete starts working...
;;(require 'go-autocomplete)
;;(require 'auto-complete-config) i wonder if we are getting multiple autocomplete lists...
;;(ac-config-default) i wonder if this is what is bringing up the list automatically...

;; go guru package
(require 'go-guru)

;; set the fill-paragraph column to 101
(set-fill-column 101)

(load-theme 'leuven) ;; agkeesle change!

(with-eval-after-load 'go-mode
  (add-hook 'go-mode-hook 'subword-mode))

(setq gofmt-command "goimports")

(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

; tie fzf-git-files to keyboard shortcut
(global-set-key (kbd "C-x C-o") 'fzf-git-files)

(add-hook 'ruby-mode-hook #'rubocop-mode)
