;;
;; My path setup
;;

(require 'mods/utils)


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

(when (is-win)
  ;; Prevent issues with the Windows null device (NUL) when using cygwin find with rgrep.
  (defadvice grep-compute-defaults (around grep-compute-defaults-advice-null-device)
    "Use cygwin's /dev/null as the null-device."
    (let ((null-device "/dev/null")) ad-do-it))
  (ad-activate 'grep-compute-defaults)
  ;(require 'cygwin-mount)
  ;(setq cygwin-mount-cygwin-bin-directory "C:/cygwin/bin")
  ;(cygwin-mount-activate)
  ;(require 'setup-cygwin)
)


(provide 'mods/os)
