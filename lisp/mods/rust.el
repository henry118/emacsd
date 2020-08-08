;;
;; Rust mode setup
;;
;; Instruction
;; ===========
;; 1. curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
;; 2. export PATH="$PATH:$HOME/.cargo/bin"
;; 3. rustup toolchain add nightly
;; 4. cargo +nightly install racer
;; 5. rustup component add rust-src
;; 6. export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
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
