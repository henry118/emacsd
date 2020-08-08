;;
;; Rust mode setup
;;

(require 'rust-mode)

(setq rust-format-on-save t)

(add-hook 'racer-mode-hook 'eldoc-mode)
(add-hook 'racer-mode-hook 'company-mode)

(defun hwang:rust-mode-hook ()
  (cargo-minor-mode)
  (racer-mode)
  (local-set-key (kbd "C-c <tab>") 'rust-format-buffer)
  (define-key rust-mode-map (kbd "TAB") 'company-indent-or-complete-common)
  (setq company-tooltip-align-annotations t)
)

(add-hook 'rust-mode-hook 'hwang:rust-mode-hook)

(provide 'mods/rust)
