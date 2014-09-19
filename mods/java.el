;;
;; Java mode setup
;;


(require 'malabar-mode)


(defun hwang:java-hook()
  (doxymacs-mode)
  (setq ac-sources (append '(ac-source-semantic) ac-sources))
  (local-set-key (kbd "M-.") 'malabar-jump-to-thing)
  (local-set-key (kbd "M-,") 'pop-global-mark)
  (local-set-key (kbd "C-,") 'semantic-symref)
  (local-set-key (kbd "M-p") 'malabar-package-project)
  (local-set-key (kbd "M-n") 'malabar-run-maven-command)
  (local-set-key (kbd "C-c c") 'malabar-compile-file)
  (local-set-key (kbd "C-c h") 'malabar-show-javadoc)
  (local-set-key (kbd "C-c g") 'malabar-insert-getset)
  (local-set-key (kbd "C-c f") 'malabar-find-file-in-project)
  (local-set-key (kbd "C-c p") 'malabar-visit-project-file)
  (local-set-key (kbd "C-c a") 'malabar-fully-qualified-class-name-kill-ring-save)
  (local-set-key (kbd "C-c ?") 'semantic-ia-complete-symbol-menu)
  (local-set-key (kbd "M-m") 'eassist-list-methods)
  )

(add-hook 'malabar-mode-hook 'hwang:java-hook)

(setq
 auto-mode-alist
 (append
  '(("\\.java\\'" . malabar-mode))
  auto-mode-alist))


(provide 'mods/java)
