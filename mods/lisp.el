;;
;; ELisp mode setup
;;

(require 'mods/utils)


(defun hwang:elisp-hook()
  (hwang:imenu)
  (local-set-key (kbd "M-m")   'idomenu)
)

(add-hook 'emacs-lisp-mode-hook 'hwang:elisp-hook)


(provide 'mods/lisp)
