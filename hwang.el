;;================================================================================
;;
;; My personal Emacs configuration
;;
;; Author: Henry Wang <henry118@gmail.com>
;;
;; Comment:
;;
;;   * Most packages can be found in Emacs packages (M-x list-packages)
;;   * For CXX completion, Clang must be installed. I dont use CEDET anymore
;;     since my computer is slow.
;;   * For Python completion, py-epc & jedi python eggs must be installed
;;
;; Used packages:
;;   yasnippet
;;   auto-complete
;;   auto-complete-clang
;;   dired+
;;   clips-mode
;;   markdown-mode
;;   epc
;;   jedi
;;   emms
;;   w3m
;;
;;=================================================================================

;;---------------------------------------------------------------------------------
;; load paths
;;---------------------------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/distel/elisp")
(add-to-list 'load-path "~/.emacs.d/emacstts")

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
(require 'auto-complete-clang)
(ac-config-default)
(setq ac-auto-start nil)
(setq ac-quick-help-delay 0.5)
(global-set-key "\M-/" 'auto-complete)
(add-to-list 'ac-modes 'cmake-mode)

;;----------------------------------------------------------------------------------
;; Fix auto complete clang search path, obtain the include path list by:
;; $ echo | g++ -v -x c++ -E -
;;----------------------------------------------------------------------------------
(defun s-trim-left (s)
  "Remove whitespace at the beginning of S."
  (if (string-match "\\`[ \t\n\r]+" s)
      (replace-match "" t t s)
    s))
(defun s-trim-right (s)
  "Remove whitespace at the end of S."
  (if (string-match "[ \t\n\r]+\\'" s)
      (replace-match "" t t s)
    s))
(defun s-trim (s)
  "Remove whitespace at the beginning and end of S."
  (s-trim-left (s-trim-right s)))

(defun g++-include-path ()
  "Return a list of include paths of g++"
  (let ((lines) (paths) (found))
    (setq lines (process-lines "sh" "-c" "echo | g++ -v -x c++ -E -"))
    (dolist (ln lines)
      (progn
        (setq ln (s-trim ln))
        (cond
         ((string= ln "#include <...> search starts here:")
          (setq found t))
         ((string= ln "End of search list.")
          (setq found nil))
         ((and found t)
          (setq paths (append paths (list ln))))
         )))
    paths)
)

(when (not (string= system-type "darwin"))
  (setq ac-clang-flags
      (mapcar (lambda (item)(concat "-I" item)) (g++-include-path))))

;;----------------------------------------------------------------------------------
;; cscope
;;----------------------------------------------------------------------------------
(require 'xcscope)
(setq cscope-do-not-update-database t)

;;----------------------------------------------------------------------------------
;; ido everywhere
;;----------------------------------------------------------------------------------
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;;----------------------------------------------------------------------------------
;; EmacsTTS
;;----------------------------------------------------------------------------------
(defun my-emacstts-start ()
  "Load emacstts module"
  (interactive)
  (require 'emacstts)
)

;;----------------------------------------------------------------------------------
;; EMMS
;;----------------------------------------------------------------------------------
(defun my-emms-start ()
  "Load EMMS module"
  (interactive)
  (require 'emms-setup)
  (emms-standard)
  (emms-default-players)
)

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
  (setq ac-sources (append '(ac-source-clang) ac-sources))
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
;; Language environmenet to UTF-8
(set-language-environment 'UTF-8)
