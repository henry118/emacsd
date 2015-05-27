;;
;; C# mode setup
;;

(require 'mods/utils)


(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)

(when (is-win)
  (setq omnisharp--windows-curl-tmp-file-path (concat (getenv "HOME") "\\omnisharp-tmp-file.cs")))

(defun hwang:csharp-hook()
 ;(setq cursor-type 'bar)
  (doxymacs-mode)
  (omnisharp-mode)
  (local-set-key (kbd "M-/") 'omnisharp-auto-complete)
  (local-set-key (kbd ".") 'omnisharp-add-dot-and-auto-complete)
  (local-set-key (kbd "M-.") 'omnisharp-go-to-definition)
  (local-set-key (kbd "C-.") 'omnisharp-find-usages)
  (local-set-key (kbd "M-p") 'omnisharp-build-in-emacs)
  (local-set-key (kbd "C-c f") 'omnisharp-code-format)
  )

(add-hook 'csharp-mode-hook 'hwang:csharp-hook)

(setq
 auto-mode-alist
 (append
  '(("\\.cs\\'" . csharp-mode))
  auto-mode-alist))


(provide 'mods/csharp)
