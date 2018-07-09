;;; .emacs --- Initialization file for Emacs
;;; Commentary: Emacs Startup File --- initialization for Emacs

(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;;; Prevent Extraneous Tabs
(setq-default indent-tabs-mode nil)

(setq inhibit-startup-screen t)

; remove toolbar
(tool-bar-mode -1)

; paren highlighting
(show-paren-mode 1)
;(setq show-paren-delay 0)

; save cursor position
(save-place-mode 1)
;(setq save-place-forget-unreadable-files nil)

(setq column-number-mode t)

; (global-linum-mode 1)
;(setq linum-format "%d ")
;(setq linum-format 'dynamic)


; (use-package evil
;   :ensure t
;   :init
;   (setq evil-want-integration nil)
;   :config
;   (evil-mode 1))

; (use-package evil-commentary
;   :after evil
;   :ensure t
;   :config
;   (evil-commentary-mode))

; (use-package evil-surround
;   :after evil
;   :ensure t
;   :config
;   (global-evil-surround-mode 1))

; (use-package evil-collection
;   :after evil
;   :ensure t
;   :config
;   (evil-collection-init))

(use-package avy
  :ensure t
  :config
  (avy-setup-default)
  ; (global-set-key (kbd "C-c a c") 'avy-goto-char)
  ; (global-set-key (kbd "C-'") 'avy-goto-char-2)
  (global-set-key (kbd "C-c a") 'avy-goto-char-timer)
  ; (global-set-key (kbd "M-g f") 'avy-goto-line)
  ; (global-set-key (kbd "M-g w") 'avy-goto-word-1)
  ; (global-set-key (kbd "M-g e") 'avy-goto-word-0)
  (global-set-key (kbd "C-c C-j") 'avy-resume))

; (use-package flycheck
;   :ensure t
;   :config
;   (global-flycheck-mode)
;   (setq flycheck-highlighting-mode 'lines))

(use-package projectile
  :ensure t
  :config
  (projectile-global-mode))

(use-package ivy
  :ensure t
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  (minibuffer-depth-indicate-mode 1)

  ; Ivy-based interface to standard commands
  (global-set-key (kbd "C-s") 'swiper)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  
  ; Ivy-based interface to shell and system tools
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  
  ; Ivy-resume and other commands
  (global-set-key (kbd "C-c C-r") 'ivy-resume)

  (ivy-mode 1))

(use-package counsel-projectile
  :after projectile
  :after ivy
  :ensure t
  :config
  (setq counsel-find-file-ignore-regexp "\\(?:\\`[#.]\\)\\|\\(?:[#~]\\'\\)")
  (counsel-projectile-mode))

(use-package magit
  :ensure t
  :config
  (global-set-key (kbd "C-x g") 'magit-status))

; (evilem-default-keybindings "SPC")

(use-package rust-mode
  :ensure t
  :config
  (setq rust-format-on-save t))

; autopair
(electric-pair-mode 1)

; https://godoc.org/golang.org/x/tools/cmd/goimports
(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook #'go-guru-hl-identifier-mode)

; https://emacs.stackexchange.com/questions/5981/how-to-make-electric-pair-mode-buffer-local/5990#5990
; https://emacs.stackexchange.com/questions/13603/auctex-disable-electric-pair-mode-in-minibuffer-during-macro-definition
(defvar my-electic-pair-modes '(go-mode js-mode json-mode emacs-lisp-mode python-mode org-mode))

(defun my-inhibit-electric-pair-mode (char)
  (not (member major-mode my-electic-pair-modes)))

(setq electric-pair-inhibit-predicate #'my-inhibit-electric-pair-mode)

; (setq ivy-re-builders-alist
;       '((read-file-name-internal . ivy--regex-fuzzy)
;         (t . ivy--regex-plus)))

; https://www.emacswiki.org/emacs/WholeLineOrRegion
(put 'kill-region 'interactive-form      
     '(interactive
        (if (use-region-p)
          (list (region-beginning) (region-end))
          (list (line-beginning-position) (line-beginning-position 2)))))
(defun my-kill-ring-save (beg end flash)
  (interactive (if (use-region-p)
                 (list (region-beginning) (region-end) nil)
                 (list (line-beginning-position)
                       (line-beginning-position 2) 'flash)))
  (kill-ring-save beg end)
  (when flash
    (save-excursion
      (if (equal (current-column) 0)
        (goto-char end)
        (goto-char beg))
      (sit-for blink-matching-delay))))
(global-set-key [remap kill-ring-save] 'my-kill-ring-save)

;(require 'linum-off)

;(require 'nlinum-relative)
;(nlinum-relative-setup-evil)
;(add-hook 'prog-mode-hook 'nlinum-relative-mode)
;(setq nlinum-relative-redisplay-delay 0)

(if (display-graphic-p)
  (load-theme 'solarized-light t))

;(setq company-idle-delay 1)
;(setq company-minimum-prefix-length 2)
;;(global-set-key "\t" 'company-complete-common)
(add-hook 'after-init-hook 'global-company-mode)

(with-eval-after-load 'org
                      (setq org-startup-indented 1))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (cargo rust-mode flx avy protobuf-mode go-guru go-mode company-anaconda company yaml-mode racket-mode json-mode flycheck magit ag counsel-projectile))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(when (eq system-type 'darwin)

  ;; default Latin font (e.g. Consolas)
  (set-face-attribute 'default nil :family "Courier")

  ;; default font size (point * 10)
  ;;
  ;; WARNING!  Depending on the default font,
  ;; if the size is not supported very well, the frame will be clipped
  ;; so that the beginning of the buffer may not be visible correctly.
  (set-face-attribute 'default nil :height 180)

  ;; you may want to add different for other charset in this way.
  )

;(put 'upcase-region 'disabled nil)
;(put 'downcase-region 'disabled nil)

; (profiler-start 'cpu+mem)
