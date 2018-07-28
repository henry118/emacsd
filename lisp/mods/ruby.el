;;
;; Ruby mode setup
;;


(require 'robe)

(defun hwang:ruby-mode-hook()
  (robe-mode)
  (ac-robe-setup)
  (setq tab-width 2)
)

(add-hook 'ruby-mode-hook 'hwang:ruby-mode-hook)

(provide 'mods/ruby)