;;
;; ido everywhere
;;

(setq ido-enable-flex-matching t)

(setq ido-everywhere t)

(ido-mode 1)

(ido-vertical-mode 1)

(setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)

(flx-ido-mode 1)

(provide 'mods/ido)
