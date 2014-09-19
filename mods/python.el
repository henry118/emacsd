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
  (hs-minor-mode t)
  (local-set-key (kbd "M-m") 'idomenu)
  (local-set-key (kbd "M-.") 'jedi:goto-definition)
  (local-set-key (kbd "M-,") 'jedi:goto-definition-pop-marker)
  (local-set-key (kbd "C-c h") 'jedi:show-doc)
  )

(add-hook 'python-mode-hook 'hwang:python-mode-hook)


(provide 'mods/python)
