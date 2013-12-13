;;================================================================================
;;
;; My personal Emacs configuration
;;
;; Author: Henry Wang <henry118@gmail.com>
;;
;; * I am using the trunk version of CEDET:
;;   $ bzr co bzr://cedet.bzr.sourceforge.net/bzrroot/cedet/code/trunk/ cedet
;; * Most other packages can be found in Emacs packages (M-x list-packages)
;;
;;=================================================================================

;;---------------------------------------------------------------------------------
;; load paths
;;---------------------------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/cedet")
(add-to-list 'load-path "~/.emacs.d/cedet/contrib")
(add-to-list 'load-path "~/.emacs.d/distel/elisp")

;; load path for specific platforms
(cond
 ((string-equal system-type "darwin")
  (progn
    (add-to-list 'load-path "~/.emacs.d/macintosh")
    (add-to-list 'load-path "~/.emacs.d/erlmode")
    (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
    (setq exec-path (append exec-path '("/usr/local/bin")))))
 ((string-equal system-type "windows-nt")
  (progn
    (add-to-list 'load-path "~/.emacs.d/windows")
    (add-to-list 'load-path "~/.emacs.d/windows/erlmode")))
 ((string-equal system-type "cygwin")
  (progn
    (add-to-list 'load-path "~/.emacs.d/windows")
    (add-to-list 'load-path "~/.emacs.d/erlmode"))))

;;---------------------------------------------------------------------------------
;; setup cygwin for windows
;;---------------------------------------------------------------------------------
(if (string-equal system-type "windows-nt")
    (progn
      (require 'cygwin-mount)
      (setq cygwin-mount-cygwin-bin-directory "C:/cygwin/bin")
      (cygwin-mount-activate)
      (require 'setup-cygwin)))

;;---------------------------------------------------------------------------------
;; setup emacs package system
;;---------------------------------------------------------------------------------
(when (< emacs-major-version 24)
  (add-to-list 'load-path "~/.emacs.d/pm"))
(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

;;---------------------------------------------------------------------------------
;; color theme
;; note that since v24 the built-in deftheme in emacs is pretty good.
;; so we only need this in old versions
;;---------------------------------------------------------------------------------
(if (and (string-equal system-type "gnu/linux") (< emacs-major-version 24))
    (progn
      (require 'color-theme)
      (color-theme-initialize)))

;;---------------------------------------------------------------------------------
;; cedet
;;---------------------------------------------------------------------------------
(load-file "~/.emacs.d/cedet/cedet-devel-load.el")
(require 'semantic/bovine/c)
(require 'semantic/bovine/clang)
(require 'semantic/bovine/gcc)
(require 'semantic/ia)
(require 'semantic/analyze/debug)
(require 'semantic/decorate/include)
(require 'eassist)

(add-to-list 'load-path "~/.emacs.d/cedet/contrib/")
(add-to-list 'Info-directory-list "~/.emacs.d/cedet/doc/info")
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-local-symbol-highlight-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-show-unmatched-syntax-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-show-parser-state-mode)

;; Add header directories of 3rd party libraries
(cond
 ((or (string-equal system-type "darwin") (string-equal system-type "gnu/linux"))
  (progn
    (semantic-add-system-include "/usr/local/include" 'c++-mode)))
 ((string-equal system-type "windows-nt")
  (progn
    (add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
    (add-to-list 'semantic-default-submodes 'global-semantic-highlight-edits-mode)
    (semantic-add-system-include "/usr/lib/gcc/i686-pc-cygwin/4.7.3/include" 'c++-mode)
    (semantic-add-system-include "/usr/lib/gcc/i686-pc-cygwin/4.7.3/include/c++" 'c++-mode)
    (semantic-add-system-include "/usr/lib/gcc/i686-pc-cygwin/4.7.3/include/c++/i686-pc-cygwin" 'c++-mode)))
 ((string-equal system-type "cygwin")
  (progn
    (semantic-add-system-include "/usr/lib/gcc/i686-pc-cygwin/4.7.3/include" 'c++-mode)
    (semantic-add-system-include "/usr/lib/gcc/i686-pc-cygwin/4.7.3/include/c++" 'c++-mode)
    (semantic-add-system-include "/usr/lib/gcc/i686-pc-cygwin/4.7.3/include/c++/i686-pc-cygwin" 'c++-mode)))
)

;; Now turn on semantic
(semantic-mode 1)

;;---------------------------------------------------------------------------------
;; yasnippnet
;;---------------------------------------------------------------------------------
(require 'yasnippet)
(yas/global-mode 1)

;;---------------------------------------------------------------------------------
;; anything/helm
;;---------------------------------------------------------------------------------
;(require 'anything-config)
;(require 'anything-match-plugin)

;;----------------------------------------------------------------------------------
;; auto-complete
;;----------------------------------------------------------------------------------
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'cmake-mode)
(setq ac-auto-start nil)
(global-set-key "\M-/" 'auto-complete)

;;----------------------------------------------------------------------------------
;; cscope
;;----------------------------------------------------------------------------------
(require 'xcscope)
(setq cscope-do-not-update-database t)
(require 'semantic/db-cscope)
(semanticdb-enable-cscope-databases nil)

;;----------------------------------------------------------------------------------
;; ido everywhere
;;----------------------------------------------------------------------------------
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;;----------------------------------------------------------------------------------
;; ECB settings
;;----------------------------------------------------------------------------------
(setq ecb-minor-mode-text "ECB")
(setq ecb-options-version "2.40")
(setq ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
(setq ecb-tip-of-the-day nil)

;;----------------------------------------------------------------------------------
;; Other packages
;;----------------------------------------------------------------------------------
(require 'dired+)
(require 'buff-menu+)
(require 'gnus)
(require 'diff-mode-)
(require 'pastebin)
(require 'clips-mode)
(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)

;;----------------------------------------------------------------------------------
;; Emacs-Lisp Mode setup
;;----------------------------------------------------------------------------------
(defun hwang/elisp-hook()
  (local-set-key (kbd "M-m")   'eassist-list-methods)
)
(add-hook 'emacs-lisp-mode-hook 'hwang/elisp-hook)

;;----------------------------------------------------------------------------------
;; C Mode setup
;;----------------------------------------------------------------------------------
(defun hwang/cmode-hook()
  (hs-minor-mode t)
  (setq ac-sources (append '(ac-source-semantic) ac-sources))
  (local-set-key [s-mouse-1]   'semantic-ia-fast-mouse-jump)
  (local-set-key [s-mouse-3]   'semantic-mrub-switch-tags)
  ;;(local-set-key (kbd ".")     'semantic-complete-self-insert)
  ;;(local-set-key (kbd ">")     'semantic-complete-self-insert)
  (local-set-key (kbd "C-c l") 'semantic-ia-complete-symbol-menu)
  (local-set-key (kbd "C-c ?") 'semantic-ia-complete-symbol)
  (local-set-key (kbd "C-c >") 'semantic-complete-analyze-inline)
  (local-set-key (kbd "C-c =") 'semantic-decoration-include-visit)
  (local-set-key (kbd "C-c j") 'semantic-ia-fast-jump)
  (local-set-key (kbd "C-c J") 'semantic-complete-jump)
  (local-set-key (kbd "C-c q") 'semantic-ia-show-doc)
  (local-set-key (kbd "C-c s") 'semantic-ia-show-summary)
  (local-set-key (kbd "C-c p") 'semantic-analyze-proto-impl-toggle)
  (local-set-key (kbd "C-c f") 'semantic-symref)
  (local-set-key (kbd "C-c v") 'semantic-symref-symbol)
  (local-set-key (kbd "<f4>")  'semantic-complete-jump)
  (local-set-key (kbd "M-o")   'eassist-switch-h-cpp)
  (local-set-key (kbd "M-m")   'eassist-list-methods)
  (local-set-key (kbd "M-P")   'compile)
  (local-set-key (kbd "M-p")   'recompile)
  (local-set-key (kbd "M-.")   'cscope-find-global-definition)
  (local-set-key (kbd "M-,")   'cscope-pop-mark)
  (local-set-key (kbd "C-.")   'cscope-find-functions-calling-this-function)
  (local-set-key (kbd "C-,")   'cscope-find-this-symbol)
  )
(add-hook 'c-mode-common-hook 'hwang/cmode-hook)

;;----------------------------------------------------------------------------------
;; Java mode setup
;;----------------------------------------------------------------------------------
;;(defun hwang/jde-mode-hook()
;;  (local-set-key (kbd "M-.")   'jde-complete-menu)
;;  (local-set-key (kbd "<f3>")  'jde-find)
;;  (local-set-key (kbd "<f4>")  'jde-find-class-source)
;;  (local-set-key (kbd "<f5>")  'eassist-switch-h-cpp)
;;  (local-set-key (kbd "<f6>")  'eassist-list-methods)
;;  (local-set-key (kbd "<f7>")  'jde-set-global-classpath)
;;  (local-set-key (kbd "<f8>")  'jde-compile)
;;)
;;(add-hook 'jde-mode-hook 'hwang/jde-mode-hook)

;;----------------------------------------------------------------------------------
;; Python mode setup
;;----------------------------------------------------------------------------------
(if (or (string-equal system-type "windows-nt") (string-equal system-type "cygwin"))
  (require 'python-mode))

(defun hwang/python-mode-hook()
  (jedi:setup)
  (setq jedi:setup-keys t)
  (setq jedi:complete-on-dot t)
  (hs-minor-mode t)
  (local-set-key (kbd "M-m") 'eassist-list-methods)
  (local-set-key (kbd "M-.") 'jedi:goto-definition)
  (local-set-key (kbd "M-,") 'jedi:goto-definition-pop-marker)
  (local-set-key (kbd "C-c d") 'jedi:show-doc)
  )
(add-hook 'python-mode-hook 'hwang/python-mode-hook)

;;----------------------------------------------------------------------------------
;; Perl mode setup
;;----------------------------------------------------------------------------------
(add-hook 'cperl-mode-hook
          (lambda()
            (require 'perl-completion)
            (perl-completion-mode t)
            (local-set-key (kbd "M-m")  'eassist-list-methods)
	    ))

;;----------------------------------------------------------------------------------
;; Makefile mode setup
;;----------------------------------------------------------------------------------
(add-hook 'GNUmakefile-mode-hook
          (lambda()
            (setq indent-tabs-mode t)
            ))
(add-hook 'conf-mode-hook
          (lambda()
            (setq indent-tabs-mode t)
            ))

;;----------------------------------------------------------------------------------
;; Erlang mode setup
;; Disable it for now, it causes CPerlMode misbehave
;;----------------------------------------------------------------------------------
;; (cond
;;  ((string-equal system-type "windows-nt")
;;   (progn
;;     (setq erlang-root-dir "C:/Program Files (x86)/erl5.9.2")
;;     (setq exec-path (cons "C:/Program Files (x86)/erl5.9.2/bin" exec-path))
;;     (require 'erlang-start)))
;;  ((string-equal system-type "darwin")
;;   (require 'erlmode-start))
;;  ((string-equal system-type "gnu/linux")
;;   (require 'erlang-start))
;;  ((string-equal system-type "cygwin")
;;   (require 'erlmode-start)))
;; (require 'distel)
;; (distel-setup)

;; (defun hwang/erlang-hook()
;;   (setq inferior-erlang-machine-options '("-sname" "emacs"))
;;   (imenu-add-to-menubar "Imenu")
;;   )
;; (add-hook 'erlang-mode-hook 'hwang/erlang-hook)

;;----------------------------------------------------------------------------------
;; CMake mode setup
;;----------------------------------------------------------------------------------
(require 'cmake-mode)
(defun hwang/cmake-hook()
  (local-set-key (kbd "C-c l") 'cmake-help-list-commands)
  (local-set-key (kbd "C-c h") 'cmake-help-command)
)
(add-hook 'cmake-mode-hook 'hwang/cmake-hook)

;;----------------------------------------------------------------------------------
;; Before Save Hook
;;----------------------------------------------------------------------------------
(defun hwang/before-save-hook()
  (if (not (string-equal mode-name "Markdown"))
      (delete-trailing-whitespace))
)
(add-hook 'before-save-hook 'hwang/before-save-hook)

;;----------------------------------------------------------------------------------
;; Set up auto modes
;;----------------------------------------------------------------------------------
(setq auto-mode-alist
      (append
       '(("CMakeLists\\.txt\\'" . cmake-mode)
         ("\\.cmake\\'" . cmake-mode)
         ("\\.\\(h\\|ipp\\|tcc\\|tmh\\)\\'" . c++-mode)
         ("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode)
         ("\\.lua\\'" . lua-mode)
         ("\\.clp\\'" . clips-mode)
         ("\\.\\(xml\\|xsl\\|rng\\|xhtml\\|xsd\\)\\'" . nxml-mode)
         ("\\.\\(text\\|markdown\\|md\\)\\'" . markdown-mode)
         ) auto-mode-alist))
(setq interpreter-mode-alist
      (append
       '(("perl" . cperl-mode)
         ("perl5" . cperl-mode)
         ("miniperl" . cperl-mode)
         ("lua" . lua-mode)
         ) interpreter-mode-alist))

;;----------------------------------------------------------------------------------
;; general variables
;;----------------------------------------------------------------------------------
(custom-set-variables
 '(browse-url-browser-function (quote w3m-browse-url))
 '(c-basic-offset 4)
 '(c-offsets-alist (quote ((substatement-open . 0) (case-label . +) (innamespace . 0) (arglist-intro . +) (arglist-close . 0))))
 '(cua-mode t nil (cua-base))
 '(display-time-day-and-date t)
 '(display-time-mode t)
 '(gdb-find-source-frame t)
 '(gdb-many-windows t)
 '(gdb-show-main t)
 '(gdb-speedbar-auto-raise t)
 '(gdb-use-separate-io-buffer t)
 '(global-linum-mode t)
 '(indent-tabs-mode nil)
 '(make-backup-files nil)
 '(show-paren-mode t)
 '(which-function-mode t)
 '(pastebin-api-dev-key (getenv "PASTEBIN_KEY"))
 )

;;----------------------------------------------------------------------------------
;; Minor tweaks
;;----------------------------------------------------------------------------------
;; Quick window switch
(windmove-default-keybindings 'meta)
