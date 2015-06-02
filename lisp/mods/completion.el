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

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x c o") 'helm-occur)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-selection-action)
(define-key helm-map (kbd "C-z") 'helm-select-action)

;; use ack-grep to replace grep
(defvar ack-grep-cmd nil)
(cond
 ((executable-find "ack-grep")(setq ack-grep-cmd "ack-grep"))
 ((executable-find "ack")(setq ack-grep-cmd "ack"))
 )
(when (stringp ack-grep-cmd)
  (setq
   helm-grep-default-command (format "%s -Hn --no-group --no-color %%e %%p %%f" ack-grep-cmd)
   helm-grep-default-recurse-command (format "%s -H --no-group --no-color %%e %%p %%f" ack-grep-cmd)))

;; Fuzzy matchings
(setq
 helm-recentf-fuzzy-match t
 helm-buffers-fuzzy-matching t
 helm-locate-fuzzy-match t
 helm-M-x-fuzzy-match t
 helm-semantic-fuzzy-match nil
 helm-imenu-fuzzy-match nil
 helm-apropos-fuzzy-match t
 helm-lisp-fuzzy-completion t
 )

(provide 'mods/completion)
