;;
;; Org mode setup
;;

(setq org-directory "~/org")
(setq org-src-fontify-natively t)
(define-key global-map "\C-cc" 'org-capture)
(setq org-agenda-files '("~/org/"))

(defun hwang-journal-file-name ()
  (let ((day (format-time-string "%Y-%m")))
    (concat "~/org/journal-" day ".org")
    )
  )

(setq org-default-notes-file (hwang-journal-file-name))

(setq
 org-capture-templates
 '(
   ("t" "Todo" entry (file+headline "~/org/todo.org" "Tasks")
    "* TODO %?\n  %i\n  %a")
   ("g" "General" entry (file+headline (hwang-journal-file-name) "General")
    "* %?\nEntered on %U\n  %i\n  %a")
   ("d" "Diary" entry (file+headline (hwang-journal-file-name) "Diary")
    "* %?\nEntered on %U\n  %i\n  %a")
   ("p" "Programming" entry (file+headline (hwang-journal-file-name) "Programming")
    "* %?\nEntered on %U\n  %i\n  %a")
   ("x" "Linux" entry (file+headline (hwang-journal-file-name) "Linux")
    "* %?\nEntered on %U\n  %i\n  %a")
   ("k" "Networking" entry (file+headline (hwang-journal-file-name) "Network")
    "* %?\nEntered on %U\n  %i\n  %a")
   ("e" "Emacs" entry (file+headline (hwang-journal-file-name) "Emacs")
    "* %?\nEntered on %U\n  %i\n  %a")
   ("a" "Graphics" entry (file+headline (hwang-journal-file-name) "Graphics")
    "* %?\nEntered on %U\n  %i\n  %a")
   ("w" "Windows" entry (file+headline (hwang-journal-file-name) "Windows")
    "* %?\nEntered on %U\n  %i\n  %a")
   ("o" "Work" entry (file+headline (hwang-journal-file-name) "Work")
    "* %?\nEntered on %U\n  %i\n  %a")
   )
 )

(provide 'mods/org)
