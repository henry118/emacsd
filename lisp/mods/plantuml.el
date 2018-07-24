;;
;; PlantUML mode config
;;
(require 'mods/utils)

(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))

;(setq plantuml-output-type "utxt")

(provide 'mods/plantuml)
