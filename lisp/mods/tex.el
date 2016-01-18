;;
;; auctex setup
;;

(when (is-mac)
  (setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin"))
  (setq exec-path (append exec-path '("/Library/TeX/texbin"))))

(load "auctex.el" nil t t)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(provide 'mods/tex)
