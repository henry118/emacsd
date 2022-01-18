;;
;; Golang mode setup
;;
;; Setup:
;;
;; export GOPATH = $HOME/.golang/
;; GO111MODULE=on go get golang.org/x/tools/gopls@latest

(require 'lsp-mode)

(setq exec-path (append exec-path '("~/go/bin")))
(when (is-mac)
  (setenv "PATH" (concat (getenv "PATH") ":/usr/local/go/bin")))

(add-hook 'go-mode-hook #'lsp-deferred)

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(defun hwang:go-mode-hook()
  (hwang:imenu)
  (setq tab-width 2)
  (lsp-enable-which-key-integration)

  (local-set-key (kbd "M-.")   'lsp-find-definition)
  (local-set-key (kbd "M-,")   'pop-tag-mark)
  (local-set-key (kbd "C-,")   'lsp-find-references)
  (local-set-key (kbd "C-.")   'lsp-goto-implementation)
  (local-set-key (kbd "M-m")   'lsp-ui-imenu)

  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go generate && go build -v && go test -v && go vet")
    )
  )

(add-hook 'go-mode-hook 'hwang:go-mode-hook)

(provide 'mods/go)
