;;
;; Golang mode setup
;;
;; Setup:
;;
;; export GOPATH = $HOME/.golang/
;; GO111MODULE=on go get golang.org/x/tools/gopls@latest

(require 'lsp-mode)

(setq exec-path (append exec-path '("~/.golang/bin")))
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
  (setq tab-width 4)

  (local-set-key (kbd "M-.")   'helm-gtags-find-tag)
  (local-set-key (kbd "M-,")   'helm-gtags-pop-stack)
  (local-set-key (kbd "C-.")   'helm-gtags-find-rtag)
  (local-set-key (kbd "C-,")   'helm-gtags-find-pattern)
  (local-set-key (kbd "C-c i") 'helm-gtags-create-tags)
  (local-set-key (kbd "C-c u") 'helm-gtags-update-tags)

  ;(local-set-key (kbd "M-.") 'godef-jump)
  ;(local-set-key (kbd "M-,") 'pop-tag-mark)

  (local-set-key (kbd "M-m") 'helm-semantic-or-imenu)
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go generate && go build -v && go test -v && go vet")
    )
  )

(add-hook 'go-mode-hook 'hwang:go-mode-hook)

(provide 'mods/go)
