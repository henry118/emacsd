;;
;; Org mode setup
;;

;(require 'ox-latex)

;(add-to-list 'org-latex-packages-alist '("" "minted"))

;(setq org-latex-listings 'minted)

(setq org-directory "~/org")
(setq org-src-fontify-natively t)
(setq org-default-notes-file (concat org-directory "/notes.org"))

;(setq org-latex-pdf-process
;      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(provide 'mods/org)