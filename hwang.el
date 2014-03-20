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
;;   auto-complete-nxml
;;   dired+
;;   clips-mode
;;   markdown-mode
;;   epc
;;   jedi
;;   emms
;;   w3m
;;   regex-tool
;;   magit
;;   iedit
;;   idomenu
;;   flyspell
;;   emacs-eclim
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
;; Eclim
;;----------------------------------------------------------------------------------
;; (require 'eclim)
;; (global-eclim-mode)
;; (setq help-at-pt-display-when-idle t)
;; (setq help-at-pt-timer-delay 0.1)
;; (help-at-pt-set-timer)
;; (cond
;;  ((string= system-type "windows-nt")
;;   (setq eclim-executable "c:/Tools/eclipse/eclim.bat"))
;;  ((string= system-type "darwin")
;;   (setq eclim-eclipse-dirs '("/Application/eclipse")))
;; )

;;----------------------------------------------------------------------------------
;; auto-complete
;;----------------------------------------------------------------------------------
(require 'auto-complete-config)
(require 'auto-complete-clang)
(require 'ac-emacs-eclim-source)
(require 'auto-complete-nxml)
(ac-config-default)
(ac-emacs-eclim-config)
(setq ac-auto-start nil)
(setq ac-quick-help-delay 0.5)
(global-set-key "\M-/" 'auto-complete)
(add-to-list 'ac-modes 'cmake-mode)

;;----------------------------------------------------------------------------------
;; Fix auto complete clang search path, obtain the include path list by:
;; $ echo | g++ -v -x c++ -E -
;;----------------------------------------------------------------------------------
(defun hwang:s-trim-left (s)
  "Remove whitespace at the beginning of S."
  (if (string-match "\\`[ \t\n\r]+" s)
      (replace-match "" t t s)
    s))

(defun hwang:s-trim-right (s)
  "Remove whitespace at the end of S."
  (if (string-match "[ \t\n\r]+\\'" s)
      (replace-match "" t t s)
    s))

(defun hwang:s-trim (s)
  "Remove whitespace at the beginning and end of S."
  (hwang:s-trim-left (hwang:s-trim-right s)))

(defun hwang:g++-include-path ()
  "Return a list of include paths of g++"
  (let ((lines) (paths) (found))
    (setq lines (process-lines "sh" "-c" "echo | g++ -v -x c++ -E -"))
    (dolist (ln lines)
      (progn
        (setq ln (hwang:s-trim ln))
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
      (mapcar (lambda (item)(concat "-I" item)) (hwang:g++-include-path))))

(defun hwang:include (path)
  "Append project local include directories to clang completion"
  (interactive (list (read-directory-name "Path: ")) )
  (setq ac-clang-flags (append ac-clang-flags (list (concat "-I" path)))))

(defun hwang:include-list (paths)
  "Append a list of project local include paths to clang completion"
  (setq ac-clang-flags
      (append ac-clang-flags
      (mapcar (lambda (item)(concat "-I" item)) paths))))

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
(defun hwang:emacstts-start ()
  "Load emacstts module"
  (interactive)
  (require 'emacstts)
)

;;----------------------------------------------------------------------------------
;; EMMS
;;----------------------------------------------------------------------------------
(defun hwang:emms-start ()
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
;(require 'buff-menu+)
(require 'gnus)
(require 'diff-mode-)
(require 'pastebin)
(require 'clips-mode)
(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)

;;----------------------------------------------------------------------------------
;; Emacs-Lisp Mode setup
;;----------------------------------------------------------------------------------
(defun hwang:elisp-hook()
  (imenu-add-to-menubar "Imenu")
  (local-set-key (kbd "M-m")   'idomenu)
)
(add-hook 'emacs-lisp-mode-hook 'hwang:elisp-hook)

;;----------------------------------------------------------------------------------
;; C Mode setup
;;----------------------------------------------------------------------------------
(defun hwang:cmode-hook()
  (hs-minor-mode t)
  (imenu-add-to-menubar "Imenu")
  (setq ac-sources (append '(ac-source-clang) ac-sources))
  (local-set-key (kbd "M-o")   'ff-find-other-file)
  (local-set-key (kbd "M-m")   'idomenu)
  (local-set-key (kbd "M-P")   'compile)
  (local-set-key (kbd "M-p")   'recompile)
  (local-set-key (kbd "M-.")   'cscope-find-global-definition)
  (local-set-key (kbd "M-,")   'cscope-pop-mark)
  (local-set-key (kbd "C-.")   'cscope-find-functions-calling-this-function)
  (local-set-key (kbd "C-,")   'cscope-find-this-symbol)
  )
(add-hook 'c-mode-common-hook 'hwang:cmode-hook)

;;----------------------------------------------------------------------------------
;; Python mode setup
;;----------------------------------------------------------------------------------
(defun hwang:python-mode-hook()
  (imenu-add-to-menubar "Imenu")
  (jedi:setup)
  (setq jedi:setup-keys t)
  (setq jedi:complete-on-dot t)
  (hs-minor-mode t)
  (local-set-key (kbd "M-m") 'idomenu)
  (local-set-key (kbd "M-.") 'jedi:goto-definition)
  (local-set-key (kbd "M-,") 'jedi:goto-definition-pop-marker)
  (local-set-key (kbd "C-c d") 'jedi:show-doc)
  )
(add-hook 'python-mode-hook 'hwang:python-mode-hook)

;;----------------------------------------------------------------------------------
;; Perl mode setup
;;----------------------------------------------------------------------------------
(defun hwang:cperl-mode-hook()
  (imenu-add-to-menubar "Imenu")
  (require 'perl-completion)
  (perl-completion-mode t)
  (local-set-key (kbd "M-m")  'idomenu)
  )
(add-hook 'cperl-mode-hook 'hwang:cperl-mode-hook)

;;----------------------------------------------------------------------------------
;; Makefile mode setup
;;----------------------------------------------------------------------------------
(defun hwang:makefile-mode-hook()
  (setq indent-tabs-mode t)
  )
(add-hook 'GNUmakefile-mode-hook 'hwang:makefile-mode-hook)

(defun hwang:conf-mode-hook()
  (setq indent-tabs-mode t)
  )
(add-hook 'conf-mode-hook 'hwang:conf-mode-hook)

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

;; (defun hwang:erlang-hook()
;;   (setq inferior-erlang-machine-options '("-sname" "emacs"))
;;   (imenu-add-to-menubar "Imenu")
;;   )
;; (add-hook 'erlang-mode-hook 'hwang:erlang-hook)

;;----------------------------------------------------------------------------------
;; CMake mode setup
;;----------------------------------------------------------------------------------
(require 'cmake-mode)
(defun hwang:cmake-hook()
  (local-set-key (kbd "C-c l") 'cmake-help-list-commands)
  (local-set-key (kbd "C-c h") 'cmake-help-command)
)
(add-hook 'cmake-mode-hook 'hwang:cmake-hook)

;;----------------------------------------------------------------------------------
;; Java mode setup
;;----------------------------------------------------------------------------------
;; (defun hwang:java-hook()
;;   (local-set-key (kbd "M-.") 'eclim-java-find-declaration)
;;   (local-set-key (kbd "M-,") 'pop-global-mark)
;;   (local-set-key (kbd "C-.") 'eclim-java-find-references)
;;   (local-set-key (kbd "M-p") 'eclim-project-build)
;; )
;; (add-hook 'java-mode-hook 'hwang:java-hook)

;;----------------------------------------------------------------------------------
;; Before Save Hook
;;----------------------------------------------------------------------------------
(defun hwang:before-save-hook()
  (if (not (string-equal mode-name "Markdown"))
      (delete-trailing-whitespace))
)
(add-hook 'before-save-hook 'hwang:before-save-hook)

;;----------------------------------------------------------------------------------
;; Eshell settings
;;----------------------------------------------------------------------------------
(defun hwang:eshell-prompt()
  "Eshell prompt function"
  (format
   "%s@%s:%s%s "
   (user-login-name)
   (car (split-string (system-name) "\\."))
   (replace-regexp-in-string
    (format "^%s" (getenv "HOME")) "~"
    (if (= (length default-directory) 1) default-directory (substring default-directory 0 -1)))
   (if (= (user-uid) 0) "#" "$"))
  )
(setq eshell-prompt-function 'hwang:eshell-prompt)
(setq eshell-prompt-regexp "^[^#$]+[#$] ")

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
;; Global key bindings
;;----------------------------------------------------------------------------------
(global-set-key (kbd "C-;") 'iedit-mode)
(global-set-key (kbd "C-'") 'magit-status)

;;----------------------------------------------------------------------------------
;; Minor tweaks
;;----------------------------------------------------------------------------------
;; Quick window switch
(windmove-default-keybindings 'meta)
;; Language environmenet to UTF-8
(set-language-environment 'UTF-8)
;; Turn on mouse support when running in terminal
(when (not (display-graphic-p))
  (xterm-mouse-mode t))
;; I don't use tool bar at all!
(tool-bar-mode 0)
;; Who use the bar to scroll?
(scroll-bar-mode 0)
;; Keep quiet
;(setq visible-bell t)
