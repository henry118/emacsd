;;
;; My color theme setup
;;

(require 'mods/utils)


(when (and (is-unix) (< emacs-major-version 24))
  (require 'color-theme)
  (color-theme-initialize))


(provide 'mods/color)
