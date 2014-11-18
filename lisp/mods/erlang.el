;;
;; Erlang mode setup
;;


(cond
 ((string-equal system-type "windows-nt")
  (progn
    (setq erlang-root-dir "C:/Program Files (x86)/erl5.9.2")
    (setq exec-path (cons "C:/Program Files (x86)/erl5.9.2/bin" exec-path))
    (require 'erlang-start)))
 ((string-equal system-type "darwin")
  (require 'erlmode-start))
 ((string-equal system-type "gnu/linux")
  (require 'erlang-start))
 ((string-equal system-type "cygwin")
  (require 'erlmode-start)))

(require 'distel)

(distel-setup)

(defun hwang:erlang-hook()
  (setq inferior-erlang-machine-options '("-sname" "emacs"))
  (imenu-add-to-menubar "Imenu")
  )

(add-hook 'erlang-mode-hook 'hwang:erlang-hook)

(provide 'mods/erlang)
