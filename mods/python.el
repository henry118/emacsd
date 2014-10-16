;;
;; Python mode setup
;;

(require 'mods/utils)

(defun hwang:python-mode-hook()
  (hwang:imenu)
  (doxymacs-mode)
  (jedi:setup)
  (setq jedi:setup-keys t)
  (setq jedi:complete-on-dot t)
  (setq cursor-type 'bar)
  (define-key jedi-mode-map (kbd "<C-tab>") nil)
  (hs-minor-mode t)
  (local-set-key (kbd "M-m") 'idomenu)
  (local-set-key (kbd "C-<tab>") 'hs-toggle-hiding)
  (local-set-key (kbd "M-.") 'jedi:goto-definition)
  (local-set-key (kbd "M-,") 'jedi:goto-definition-pop-marker)
  (local-set-key (kbd "C-.") 'jedi:complete)
)

(add-hook 'python-mode-hook 'hwang:python-mode-hook)

(provide 'mods/python)
