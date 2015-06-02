;;
;; Incremental completion and selection narrowing
;;

;;
;; == Option (1) ==
;;
;; ido + ido-vertical-mode + flx-ido + semx
;;
;(setq ido-enable-flex-matching t)
;(setq ido-everywhere t)
;(ido-mode 1)
;(ido-vertical-mode 1)
;(setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)
;(flx-ido-mode 1)
;(require 'smex)
;(smex-initialize)
;(global-set-key (kbd "M-x") 'smex)
;(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;;
;; == Option (2) ==
;;
;; emacs-helm
;;
(require 'helm-config)
(helm-mode 1)
(helm-autoresize-mode 1)

(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-selection-action)
(define-key helm-map (kbd "C-z") 'helm-select-action)

(setq
 helm-recentf-fuzzy-match t
 helm-buffers-fuzzy-matching t
 helm-locate-fuzzy-match t
 helm-M-x-fuzzy-match t
 helm-semantic-fuzzy-match t
 helm-imenu-fuzzy-match t
 helm-apropos-fuzzy-match t
 helm-lisp-fuzzy-completion t
 )

(provide 'mods/completion)
