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
(setq helm-recentf-fuzzy-match t)
(setq helm-buffers-fuzzy-matching t)
(setq helm-locate-fuzzy-match t)
(setq helm-M-x-fuzzy-match t)
(setq helm-semantic-fuzzy-match t)
(setq helm-imenu-fuzzy-match t)
(setq helm-apropos-fuzzy-match t)
(setq helm-lisp-fuzzy-completion t)

(provide 'mods/completion)
