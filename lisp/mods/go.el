;;
;; Golang mode setup
;;
;; Setup:
;;
;; export GOPATH = $HOME/.golang/
;; go get -u github.com/nsf/gocode
;; go get -u github.com/rogpeppe/godef

(require 'go-autocomplete)
(setq exec-path (append exec-path '("~/.golang/bin")))

(defun hwang:go-mode-hook()
  (hwang:imenu)
  (setq tab-width 4)
  (add-hook 'before-save-hook 'gofmt-before-save)

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
