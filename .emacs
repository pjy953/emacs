;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives '("marmalade"    . "https://marmalade-repo.org/packages") t)
(add-to-list 'package-archives '("melpa"        . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org"          . "http://orgmode.org/elpa/") t)

(add-to-list 'package-archive-priorities '("org" . 10) t)
(add-to-list 'package-archive-priorities '("melpa-stable" . 10) t)
(add-to-list 'package-archive-priorities '("melpa" . 5) t)
(add-to-list 'package-archive-priorities '("marmalade" . 1) t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    elpy
    flycheck
    material-theme
    py-autopep8
    projectile
    spaceline
    helm
    helm-ag
    helm-projectile
    move-dup
    yatemplate
    spacemacs-theme
    use-package
    spaceline
    etags
    company
    web-mode
    ;; scala-mode
    ensime
    sbt-mode
    scala-mode
    expand-region
    ))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

;; hide the startup message
(setq inhibit-startup-message t)

;; set username, address
(setq user-full-name "Jay-p")
(setq user-mail-address "jay.p@kakaocorp.com")

;; set korean language
(setenv "LANG" "ko_KR.UTF-8")
(set-locale-environment "ko_KR.UTF-8")

;; replace tab to 4 spaces
(setq indent-tabs-mode nil)
(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(setq-default c-basic-offset 4)

;; no auto-save, backup, lockfile
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq create-lockfiles nil)

;; no alarm
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

;; enable local variable
(setq enable-local-variables :all)

;; 편집하는 파일의 변경시 반영한다.
(global-auto-revert-mode t)

;; 문법에 따른 글꼴을 강조한다.
(global-font-lock-mode t)

;; 마킹위치를 강조한다.
(transient-mark-mode t)

;; 윈도우 시스템을 사용하는 경우 툴발, 스크롤바, 프린지를 제거한다.
(when (window-system)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (set-fringe-mode -1))

;; yes-or-no 질문을 y-or-n 로 변경한다.
(fset 'yes-or-no-p 'y-or-n-p)

(setq ns-use-native-fullscreen nil)

(defadvice yes-or-no-p (around prevent-dialog activate)
  "Prevent 'yes-or-no-p from activating a dialog."
  (let ((use-dialog-box nil))
    ad-do-it))

(defadvice y-or-n-p (around prevent-dialog activate)
  "Prevent 'y-or-n-p from activating a dialog."
  (let ((use-dialog-box nil))
    ad-do-it))

;; enable line numbers globally
(global-linum-mode t) 


(elpy-enable)

;;(when (require 'flycheck nil t)
;;  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;;  (add-hook 'elpy-mode-hook 'flycheck-mode))

;;(require 'py-autopep8)
;;(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ensime web-mode yatemplate move-dup helm-ag spaceline org-plus-contrib projectile helm-projectile py-autopep8 material-theme flycheck elpy better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package spacemacs-theme
  :defer t
  :init (load-theme 'spacemacs-dark t))

(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :config
  (setq flycheck-idle-change-delay 2.0)
  (setq flycheck-highlighting-mode 'lines))


(use-package helm
  :ensure t
  :diminish helm-mode
  :commands helm-mode
  :bind
  ("M-x"          . helm-M-x)
  ("C-x b"        . helm-mini)
  ("C-x C-b"      . helm-buffers-list)
  ("C-x C-f"      . helm-find-files)
  ("C-x r b"      . helm-filtered-bookmarks)
  ("C-c h"        . helm-command-prefix)
  :init
  (require 'helm-config)
  (setq helm-split-window-inside-p t)
  (setq helm-move-to-line-cycle-in-source t)
  (setq helm-scroll-amount 8)
  (setq helm-echo-input-in-header-line t)
  (setq helm-autoresize-mode t)
  (setq helm-autoresize-max-height 40))


(use-package helm-ag
  :ensure t
  :bind
  ("C-c C-h G" . helm-do-grep-ag))


(use-package helm-projectile
  :ensure t
  :config
  (helm-projectile-on))


(use-package etags
  :bind
  (("M-*" . pop-tag-mark)))


(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (setq powerline-default-separator 'arrow)
  (when (fboundp 'spaceline-emacs-theme)
    (spaceline-emacs-theme)))


(use-package company
  :diminish company-mode
  :commands company-mode
  :bind
  (:map company-active-map
    ("C-n" . company-select-next)
    ("C-p" . company-select-previous))
  :init
  ;; (setq company-dabbrev-ignore-case nil)
  ;; (setq company-dabbrev-code-ignore-case nil)
  ;; (setq company-dabbrev-downcase nil)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 4)
  (setq company-show-numbers t))


(use-package projectile
  :ensure t
  :init
  :config
  (projectile-global-mode))


(use-package move-dup
  :ensure t
  :bind
  (("M-<up>"     . md/move-lines-up)
   ("M-<down>"   . md/move-lines-down)
   ("C-M-<up>"   . md/duplicate-up)
   ("C-M-<down>" . md/duplicate-down)))


;;;
;;; python
;;;

;; 기본 virtualenv 는 python2 를 사용하며, 다음과 같이 설정한다.
;; python3 버전에서는 rope 를 rope_py3k 변경한다.
;;
;; $ virtualenv ~/.virtualenvs/python2
;; $ source ~/.virtualenvs/python2
;; $ pip install rope jedi flake8 importmagic autopep8 yapf
;;
;; 프로젝트별로 virtualenv 를 지정할 수 있으며, .dir-locals.el 에 아래와 같이 정의한다.
;; ((python-mode . ((pyvenv-workon . "python3"))))


(use-package elpy
  :ensure t
  :config
  (setq pyvenv-workon "python2")
  (setq elpy-rpc-backend "jedi")
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (setq elpy-modules (delq 'elpy-module-highlight-indentation elpy-modules))
  (elpy-enable))

(use-package python
  :config
  (add-hook 'python-mode-hook
        (lambda ()
          (company-mode)
          (flycheck-mode)
          (show-paren-mode)
          (smartparens-mode)
          (whitespace-cleanup-mode)
          (yas-minor-mode))))


;;;
;;; scala + ensime
;;;

(use-package ensime
  :ensure t
  :config
  (setq ensime-search-interface 'helm)
  (setq ensime-startup-notification nil))

(use-package sbt-mode
  :ensure t)

(use-package scala-mode
  :ensure t
  :interpreter
  ("scala" . scala-mode)
  :config
  (setq scala-indent:add-space-for-scaladoc-asterisk t)
  (add-hook 'scala-mode-hook
        (lambda ()
          (company-mode)
          (ensime-mode)
          (show-paren-mode)
          (smartparens-mode)
          (scala-mode:goto-start-of-code)
          (yas-minor-mode))))
