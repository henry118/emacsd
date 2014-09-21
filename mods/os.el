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
  (add-to-list 'load-path "~/.emacs.d/macintosh")
  (add-to-list 'load-path "~/.emacs.d/erlmode")
  (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
  (setq exec-path (append exec-path '("/usr/local/bin"))))

(when (is-win)
  (add-to-list 'load-path "~/.emacs.d/windows")
  (add-to-list 'load-path "~/.emacs.d/windows/erlmode")
  (setenv "PATH" (concat "c:\\cygwin\\bin;" (getenv "PATH")))
  (setq exec-path (append exec-path '("~/.emacs.d/windows/bin" "c:/cygwin/bin"))))

(when (is-cygwin)
  (add-to-list 'load-path "~/.emacs.d/windows")
  (add-to-list 'load-path "~/.emacs.d/erlmode"))

(provide 'mods/os)
