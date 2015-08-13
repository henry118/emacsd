;;
;; Golang mode setup
;;


(require 'go-autocomplete)
(setq exec-path (append exec-path '("~/.golang/bin")))

(defun hwang:go-mode-hook()
  (hwang:imenu)
  (add-hook 'before-save-hook 'gofmt-before-save)
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-m") 'helm-semantic-or-imenu)
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go generate && go build -v && go test -v && go vet")
    )
  )

(add-hook 'go-mode-hook 'hwang:go-mode-hook)

(provide 'mods/go)
