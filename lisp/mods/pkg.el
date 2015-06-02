;;
;; My Packaging Setup
;;

(when (< emacs-major-version 24)
  (add-to-list 'load-path "~/.emacs.d/lisp/pm"))

(require 'package)

(package-initialize)

(add-to-list
 'package-archives
 '("melpa" . "http://melpa.milkbox.net/packages/")
 t)

(when (< emacs-major-version 24)
  (add-to-list
   'package-archives
   '("gnu" . "http://elpa.gnu.org/packages/")))

(defun hwang:bootstrap ()
  (list-packages)
  (package-install 'auto-complete)
  (package-install 'auto-complete-clang)
  (package-install 'auto-complete-nxml)
  (package-install 'dired+)
  (package-install 'clips-mode)
  (package-install 'markdown-mode)
  (package-install 'epc)
  (package-install 'jedi)
 ;(package-install 'emms)
  (package-install 'regex-tool)
  (package-install 'magit)
  (package-install 'iedit)
 ;(package-install 'idomenu)
 ;(package-install 'ido-vertical-mode)
 ;(package-install 'flx-ido)
 ;(package-install 'smex)
  (package-install 'helm)
  (package-install 'undo-tree)
  (package-install 'php-mode)
 ;(package-install 'malabar-mode)
 ;(package-install 'csharp-mode)
 ;(package-install 'omnisharp) ;(requires OmniSharpServer - https://github.com/nosami/OmniSharpServer)
 ;(package-install 'groovy-mode)
  (package-install 'skewer-mode)
  (package-install 'js2-mode)
  (package-install 'ac-js2)
  )

(defun hwang:recompile-elpa ()
  "Delete *.elc in elpa and recompile all packages"
  (interactive)
  (require 'find-lisp)
  (dolist
      (file (find-lisp-find-files (expand-file-name "~/.emacs.d/elpa") "^.*\\.elc$"))
    (delete-file file)
    (message "Deleted %s..." file))
  (byte-recompile-directory (expand-file-name "~/.emacs.d/elpa") 0))

(when (not (file-exists-p "~/.emacs.d/elpa"))
  (hwang:bootstrap))


(provide 'mods/pkg)
