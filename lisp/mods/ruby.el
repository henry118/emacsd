;;
;; Ruby mode setup
;;


;;(require 'robe)

(defun hwang:ruby-mode-hook()
  ;;(robe-mode)
  ;;(ac-robe-setup)
  ;;(add-to-list 'ac-sources 'ac-source-robe)
  (setq tab-width 2)
  (local-set-key (kbd "M-m") 'helm-semantic-or-imenu)
  (local-set-key (kbd "C-<tab>") 'hs-toggle-hiding)
  (local-set-key (kbd "M-.")   'helm-gtags-find-tag)
  (local-set-key (kbd "M-,")   'helm-gtags-pop-stack)
  (local-set-key (kbd "C-.")   'helm-gtags-find-rtag)
  (local-set-key (kbd "C-,")   'helm-gtags-find-pattern)
  (local-set-key (kbd "C-c i") 'helm-gtags-create-tags)
  (local-set-key (kbd "C-c u") 'helm-gtags-update-tags)
)

(add-hook 'ruby-mode-hook 'hwang:ruby-mode-hook)

(provide 'mods/ruby)
