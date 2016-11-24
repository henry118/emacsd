;;
;; My color theme setup
;;

(require 'mods/utils)

(when (and (is-unix) (< emacs-major-version 24))
  (require 'color-theme)
  (color-theme-initialize))

(require 'rainbow-delimiters)
;; using stronger colors
(require 'cl-lib)
(require 'color)
(cl-loop
 for index from 1 to rainbow-delimiters-max-face-count
 do
 (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
   (cl-callf color-saturate-name (face-foreground face) 30)))


(provide 'mods/color)
