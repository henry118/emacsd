;;
;; Rust mode setup
;;
;; Instruction
;; ===========
;; 1. curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
;; 2. export PATH="$PATH:$HOME/.cargo/bin"
;;

(require 'rust-mode)

(when (is-mac)
  (setenv "PATH" (concat (getenv "PATH") (expand-file-name "~/.cargo/bin")))
  (setenv "RUST_SRC_PATH" (expand-file-name "~/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"))
  (add-to-list 'exec-path (expand-file-name "~/.cargo/bin")))

(setq rust-format-on-save t)

(defun hwang:rust-mode-hook ()
  (cargo-minor-mode)
  (lsp-deferred)
  (local-set-key (kbd "C-c <tab>") 'rust-format-buffer)
  (define-key rust-mode-map (kbd "TAB") 'company-indent-or-complete-common)
  (hwang:imenu)
  (setq lsp-enable-file-watchers 't)
  (setq lsp-file-watch-threshold 10000)
  (setq company-tooltip-align-annotations t)
  (lsp-enable-which-key-integration)

  (local-set-key (kbd "M-.")   'lsp-find-definition)
  (local-set-key (kbd "M-,")   'pop-tag-mark)
  (local-set-key (kbd "C-,")   'lsp-find-references)
  (local-set-key (kbd "C-.")   'lsp-goto-implementation)
  (local-set-key (kbd "M-m")   'helm-semantic-or-imenu)
)

(add-hook 'rust-mode-hook 'hwang:rust-mode-hook)

(provide 'mods/rust)
