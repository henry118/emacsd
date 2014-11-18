;;
;; Setup Cygwin on Windows Platform
;;

(require 'cygwin-mount)

(setq cygwin-mount-cygwin-bin-directory "C:/cygwin/bin")

(cygwin-mount-activate)

(require 'setup-cygwin)

;; Prevent issues with the Windows null device (NUL)
;; when using cygwin find with rgrep.
(defadvice grep-compute-defaults (around grep-compute-defaults-advice-null-device)
  "Use cygwin's /dev/null as the null-device."
  (let ((null-device "/dev/null")) ad-do-it))
(ad-activate 'grep-compute-defaults)

(provide 'mods/cygwin)
