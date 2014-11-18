;;
;; Markdown setup
;;

(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)

(setq
 auto-mode-alist
 (append
  '(("\\.\\(text\\|markdown\\|md\\)\\'" . markdown-mode))
  auto-mode-alist))


(provide 'mods/markdown)
