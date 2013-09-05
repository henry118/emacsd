;; load paths
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/cedet")
(add-to-list 'load-path "~/.emacs.d/cedet/contrib")
;;(add-to-list 'load-path "~/.emacs.d/elib")
;;(add-to-list 'load-path "~/.emacs.d/jdee/lisp")
(add-to-list 'load-path "~/.emacs.d/distel/elisp")

;; load path for Mac
(if (string-equal system-type "darwin")
    (progn
      (add-to-list 'load-path "~/.emacs.d/macintosh")
      (add-to-list 'load-path "~/.emacs.d/yasnippet")
      (add-to-list 'load-path "~/.emacs.d/helm")
      (add-to-list 'load-path "~/.emacs.d/erlmode")
      (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
      (setq exec-path (append exec-path '("/usr/local/bin")))))

;; color theme
(if (string-equal system-type "gnu/linux")
    (progn
      (require 'color-theme)
      (color-theme-initialize)
      (color-theme-clarity)))

;; cedet
(load-file "~/.emacs.d/cedet/cedet-devel-load.el")
(semantic-mode 1)
(require 'semantic/bovine/c)
(require 'semantic/bovine/clang)
(require 'semantic/bovine/gcc)
(require 'semantic/ia)
(require 'eassist)
;;(require 'semantic/decorate/include)
;;(require 'semantic/lex-spp)
(add-to-list 'load-path "~/.emacs.d/cedet/contrib/")
(add-to-list 'Info-directory-list "~/.emacs.d/cedet/doc/info")
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
;;(add-to-list 'semantic-default-submodes 'global-semantic-show-unmatched-syntax-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-edits-mode)
;;(add-to-list 'semantic-default-submodes 'global-semantic-show-parser-state-mode)

;; yasnippnet
(require 'yasnippet)
(yas/global-mode 1)

;; anything
(cond
 ((string-equal system-type "gnu/linux")
  (progn
    (require 'anything-config)
    (require 'anything-match-plugin)))
 ((string-equal system-type "darwin")
  (progn
    (require 'helm-mode)
    (helm-mode 1)))
 ((string-equal system-type "windows-nt")
  (progn
    (require 'helm-mode)
    (helm-mode 1))))

;; auto-complete
(require 'auto-complete-config)
(ac-config-default)
;; stop complete automatically for windows
(if (string-equal system-type "windows-nt")
    (progn
      (setq ac-auto-start nil)
      (global-set-key "\M-/" 'auto-complete)))

;; enhanced dired
(require 'dired+)
;;(toggle-dired-find-file-reuse-dir 1)

;; enhanced buffer menu
(require 'buff-menu+)

;; nXML
(load "~/.emacs.d/nxml-mode/rng-auto.el")

;; required packages
;;(require 'jde)
(require 'cmake-mode)
(require 'gnus)
(require 'diff-mode-)
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")
(require 'pastebin)

;; cscope
(require 'xcscope)
(setq cscope-do-not-update-database t)

;; turn on cscope semanticdb backend
(require 'semantic/db-cscope)
(semanticdb-enable-cscope-databases nil)

;; variables
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
 '(pastebin-api-dev-key "Your-Pastebin-Dev-Key-Here")
 )

;; auto c++ mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.ipp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.tcc\\'" . c++-mode))

;; CMake
(setq auto-mode-alist (append '(("CMakeLists\\.txt\\'" . cmake-mode) ("\\.cmake\\'" . cmake-mode)) auto-mode-alist))

;; XML mode
(setq auto-mode-alist (cons '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\|xsd\\)\\'" . nxml-mode) auto-mode-alist))

;; CLIPS mode
(require 'clips-mode)
(add-to-list 'auto-mode-alist '("\\.clp\\'" . clips-mode))

;; erlang mode
(cond
 ((string-equal system-type "windows-nt")
  (progn
    (setq erlang-root-dir "C:/Program Files (x86)/erl5.9.2")
    (setq exec-path (cons "C:/Program Files (x86)/erl5.9.2/bin" exec-path))
    (require 'erlmode-start)))
 ((string-equal system-type "darwin")
  (require 'erlmode-start))
 ((string-equal system-type "gnu/linux")
  (require 'erlang-start)))
(require 'distel)
(distel-setup)

;; Templates
;;(template-initialize)

;; Automatically remove trailing spaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Quick window switch
(windmove-default-keybindings 'meta)

;; my c-mode hook
(defun hwang/cmode-hook()
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
  (local-set-key (kbd "C-c r") 'semantic-tag-folding-fold-all)
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

;; my Java hook
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

;; python mode hook
(defun hwang/python-mode-hook()
  (local-set-key (kbd "<f6>")  'eassist-list-methods)
  ;;(add-to-list 'ac-sources 'ac-source-ropemacs)
  )
(add-hook 'python-mode-hook 'hwang/python-mode-hook)

;; Use cperl-mode instead of the default perl-mode
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))
(add-hook 'cperl-mode-hook
          (lambda()
            (require 'perl-completion)
            (perl-completion-mode t)
            (local-set-key (kbd "<f6>")  'eassist-list-methods)
	    ))

;; Makefile hook
(add-hook 'GNUmakefile-mode-hook
          (lambda()
            (setq indent-tabs-mode t)
            ))

;; Makefile.config hook
(add-hook 'conf-mode-hook
          (lambda()
            (setq indent-tabs-mode t)
            ))

;; Erlang hook
(add-hook
 'erlang-mode-hook
 (lambda ()
   ;; when starting an Erlang shell in Emacs, default in the node name
   (setq inferior-erlang-machine-options '("-sname" "emacs"))
   ;; add Erlang functions to an imenu menu
   (imenu-add-to-menubar "Imenu")))

;; Font
;;(custom-set-faces '(default ((t (:height 110 :family "monospace")))))

;; project
;;(ede-cpp-root-project "test" :file "~/work/test/CMakeLists.txt")
