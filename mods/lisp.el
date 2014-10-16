;;
;; ELisp mode setup
;;

(require 'mods/utils)

(defun hwang:elisp-hook()
  (setq cursor-type 'bar)
  (hs-minor-mode t)
  (hwang:imenu)
  (local-set-key (kbd "M-m")   'idomenu)
  (local-set-key (kbd "C-<tab>") 'hs-toggle-hiding)
)

(add-hook 'emacs-lisp-mode-hook 'hwang:elisp-hook)

(provide 'mods/lisp)
