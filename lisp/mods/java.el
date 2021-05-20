;;
;; Java mode setup
;;

;;(require 'malabar-mode)

(defun hwang:java-hook()
  (hs-minor-mode t)
  (doxymacs-mode)
  (setq ac-sources (append '(ac-source-semantic) ac-sources))
 ;(setq cursor-type 'bar)
  (local-set-key (kbd "C-<tab>") 'hs-toggle-hiding)
  (local-set-key (kbd "M-.")   'helm-gtags-find-tag)
  (local-set-key (kbd "M-,")   'helm-gtags-pop-stack)
  (local-set-key (kbd "C-.")   'helm-gtags-find-rtag)
  (local-set-key (kbd "C-,")   'helm-gtags-find-pattern)
  (local-set-key (kbd "C-c i") 'helm-gtags-create-tags)
  (local-set-key (kbd "C-c u") 'helm-gtags-update-tags)
  ;(local-set-key (kbd "M-.") 'malabar-jump-to-thing)
  ;(local-set-key (kbd "M-,") 'pop-global-mark)
  ;(local-set-key (kbd "C-,") 'semantic-symref)
  ;(local-set-key (kbd "M-p") 'malabar-package-project)
  ;(local-set-key (kbd "M-n") 'malabar-run-maven-command)
  ;(local-set-key (kbd "C-c c") 'malabar-compile-file)
  ;(local-set-key (kbd "C-c h") 'malabar-show-javadoc)
  ;(local-set-key (kbd "C-c g") 'malabar-insert-getset)
  ;(local-set-key (kbd "C-c f") 'malabar-find-file-in-project)
  ;(local-set-key (kbd "C-c p") 'malabar-visit-project-file)
  ;(local-set-key (kbd "C-c a") 'malabar-fully-qualified-class-name-kill-ring-save)
  (local-set-key (kbd "C-c ?") 'semantic-ia-complete-symbol-menu)
  (local-set-key (kbd "M-m") 'helm-semantic-or-imenu)
  )

(add-hook 'java-mode-hook 'hwang:java-hook)

;(setq
; auto-mode-alist
; (append
;  '(("\\.java\\'" . malabar-mode))
;  auto-mode-alist))

(provide 'mods/java)
