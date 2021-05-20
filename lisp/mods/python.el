;;
;; Python mode setup
;;

(require 'mods/utils)

(defun hwang:python-mode-hook()
  (hwang:imenu)
  (doxymacs-mode)
  ;;(jedi:setup)
  ;;(setq jedi:setup-keys t)
  ;;(setq jedi:complete-on-dot t)
  ;;(setq cursor-type 'bar)
  ;;(define-key jedi-mode-map (kbd "<C-tab>") nil)
  (hs-minor-mode t)
  (local-set-key (kbd "M-m") 'helm-semantic-or-imenu)
  (local-set-key (kbd "C-<tab>") 'hs-toggle-hiding)
  ;;(local-set-key (kbd "M-.") 'jedi:goto-definition)
  ;;(local-set-key (kbd "M-,") 'jedi:goto-definition-pop-marker)
  ;;(local-set-key (kbd "C-.") 'jedi:complete)
  (local-set-key (kbd "M-.")   'helm-gtags-find-tag)
  (local-set-key (kbd "M-,")   'helm-gtags-pop-stack)
  (local-set-key (kbd "C-.")   'helm-gtags-find-rtag)
  (local-set-key (kbd "C-,")   'helm-gtags-find-pattern)
  (local-set-key (kbd "C-c i") 'helm-gtags-create-tags)
  (local-set-key (kbd "C-c u") 'helm-gtags-update-tags)
)

(add-hook 'python-mode-hook 'hwang:python-mode-hook)

(provide 'mods/python)
