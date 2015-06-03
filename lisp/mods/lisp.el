;;
;; ELisp mode setup
;;

(require 'mods/utils)
(require 'rainbow-delimiters)

(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)

;; using stronger colors
(require 'cl-lib)
(require 'color)
(cl-loop
 for index from 1 to rainbow-delimiters-max-face-count
 do
 (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
   (cl-callf color-saturate-name (face-foreground face) 30)))

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
