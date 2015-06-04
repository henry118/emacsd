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
    "* %?\nEntered on %U\n  %i\n  %a")
   ("d" "Diary" entry (file+headline "~/org/journal.org" "Diary")
    "* %?\nEntered on %U\n  %i\n  %a")
   ("p" "Programming" entry (file+headline "~/org/journal.org" "Programming")
    "* %?\nEntered on %U\n  %i\n  %a")
   ("x" "Linux" entry (file+headline "~/org/journal.org" "Linux")
    "* %?\nEntered on %U\n  %i\n  %a")
   ("k" "Networking" entry (file+headline "~/org/journal.org" "Network")
    "* %?\nEntered on %U\n  %i\n  %a")
   ("b" "Database" entry (file+headline "~/org/journal.org" "Database")
    "* %?\nEntered on %U\n  %i\n  %a")
   ("e" "Emacs" entry (file+headline "~/org/journal.org" "Emacs")
    "* %?\nEntered on %U\n  %i\n  %a")
   ("a" "Graphics" entry (file+headline "~/org/journal.org" "Graphics")
    "* %?\nEntered on %U\n  %i\n  %a")
   ("w" "Windows" entry (file+headline "~/org/journal.org" "Windows")
    "* %?\nEntered on %U\n  %i\n  %a")
   ("m" "Mac" entry (file+headline "~/org/journal.org" "Mac")
    "* %?\nEntered on %U\n  %i\n  %a")
   ("o" "Work" entry (file+headline "~/org/journal.org" "Work")
    "* %?\nEntered on %U\n  %i\n  %a")
   )
 )

(provide 'mods/org)
