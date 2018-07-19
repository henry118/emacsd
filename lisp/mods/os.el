;;
;; Platform Specific Utils
;;

(defmacro is-unix ()
  (cond
   ((equal system-type 'gnu/linux) t)
   ((equal system-type 'gnu/kfreebsd) t)
   ((equal system-type 'berkeley-unix) t)))

(defmacro is-mac ()
  (equal system-type 'darwin))

(defmacro is-win ()
  (equal system-type 'windows-nt))

(defmacro is-cygwin ()
  (equal system-type 'cygwin))

(when (is-mac)
  (add-to-list 'load-path "~/.emacs.d/lisp/macintosh")
  (add-to-list 'load-path "~/.emacs.d/lisp/erlmode")
  (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin:/usr/texbin"))
  (setq exec-path (append '("/usr/local/bin") exec-path)))

(when (is-win)
  (add-to-list 'load-path "~/.emacs.d/lisp/windows")
  (add-to-list 'load-path "~/.emacs.d/lisp/windows/erlmode")
  (add-to-list 'exec-path (expand-file-name "~/.emacs.d/lisp/windows/bin"))
  (add-to-list 'exec-path (expand-file-name "~/.emacs.d/lisp/windows/global/bin"))
  (setenv "PATH" (concat (expand-file-name "~/.emacs.d/lisp/windows/bin;") (getenv "PATH")))
)

(when (is-cygwin)
  (add-to-list 'load-path "~/.emacs.d/lisp/windows")
  (add-to-list 'load-path "~/.emacs.d/lisp/erlmode"))

(provide 'mods/os)
