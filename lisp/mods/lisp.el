;;
;; ELisp mode setup
;;

(require 'mods/utils)

(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)

;; Hooks
(defun hwang:elisp-hook()
 ;(setq cursor-type 'bar)
  (hs-minor-mode t)
  (hwang:imenu)
  (enable-paredit-mode)
  (rainbow-delimiters-mode)
  (local-set-key (kbd "M-m") 'helm-semantic-or-imenu)
  (local-set-key (kbd "C-<tab>") 'hs-toggle-hiding)
)

(add-hook 'emacs-lisp-mode-hook 'hwang:elisp-hook)
(add-hook 'lisp-mode-hook 'hwang:elisp-hook)
(add-hook 'eval-expression-minibuffer-setup-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'scheme-mode-hook 'enable-paredit-mode)

(provide 'mods/lisp)
