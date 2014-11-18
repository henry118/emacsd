;;
;; Org mode setup
;;

;(require 'ox-latex)

;(add-to-list 'org-latex-packages-alist '("" "minted"))

;(setq org-latex-listings 'minted)

(setq org-src-fontify-natively t)

;(setq org-latex-pdf-process
;      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(provide 'mods/org)
