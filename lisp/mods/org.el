;;
;; Org mode setup
;;

(setq org-directory "~/org")
(setq org-src-fontify-natively t)
(define-key global-map "\C-cc" 'org-capture)
(setq org-agenda-files '("~/org/"))

(setq org-default-notes-file "~/org/journal.org")

(setq
 org-capture-templates
 '(
   ("t" "Todo" entry (file+headline "~/org/todo.org" "Tasks")
    "* TODO %?\n  %i\n  %a")
   ("g" "General" entry (file+headline "~/org/journal.org" "General")
    "* %?\n  Entered on %U\n  %i\n  %a")
   ("d" "Diary" entry (file+headline "~/org/journal.org" "Diary")
    "* %?\n  Entered on %U\n  %i\n  %a")
   ("p" "Programming" entry (file+headline "~/org/journal.org" "Programming")
    "* %?\n  Entered on %U\n  %i\n  %a")
   ("x" "Linux" entry (file+headline "~/org/journal.org" "Linux")
    "* %?\n  Entered on %U\n  %i\n  %a")
   ("k" "Networking" entry (file+headline "~/org/journal.org" "Network")
    "* %?\n  Entered on %U\n  %i\n  %a")
   ("b" "Database" entry (file+headline "~/org/journal.org" "Database")
    "* %?\n  Entered on %U\n  %i\n  %a")
   ("e" "Emacs" entry (file+headline "~/org/journal.org" "Emacs")
    "* %?\n  Entered on %U\n  %i\n  %a")
   ("a" "Graphics" entry (file+headline "~/org/journal.org" "Graphics")
    "* %?\n  Entered on %U\n  %i\n  %a")
   ("w" "Windows" entry (file+headline "~/org/journal.org" "Windows")
    "* %?\n  Entered on %U\n  %i\n  %a")
   ("m" "Mac" entry (file+headline "~/org/journal.org" "Mac")
    "* %?\n  Entered on %U\n  %i\n  %a")
   ("o" "Work" entry (file "~/org/work.org")
    "* %?\n  Entered on %U\n  %i\n  %a")
   )
 )

;; adding more file extensions to org-mode
(setq
 auto-mode-alist
 (append
  '(("\\.\\(todo\\|text\\)\\'" . org-mode))
  auto-mode-alist))

;; provide my own customization for org-mode
(defun hwang:org-mode-hook ()
  (flyspell-mode)
  )
(add-hook 'org-mode-hook 'hwang:org-mode-hook)

(provide 'mods/org)
