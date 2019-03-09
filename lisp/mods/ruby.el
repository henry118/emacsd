;;
;; Ruby mode setup
;;


(require 'robe)

(defun hwang:ruby-mode-hook()
  (robe-mode)
  (ac-robe-setup)
  ;;(add-to-list 'ac-sources 'ac-source-robe)
  (setq tab-width 2)
  (local-set-key (kbd "M-m") 'helm-semantic-or-imenu)
)

(add-hook 'ruby-mode-hook 'hwang:ruby-mode-hook)

(provide 'mods/ruby)
