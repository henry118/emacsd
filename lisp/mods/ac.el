;;
;; My autocomplete setup
;;

(require 'auto-complete-config)
(require 'auto-complete-clang)
(require 'auto-complete-nxml)

(ac-config-default)

(setq ac-auto-start nil)

(setq ac-quick-help-delay 0.5)

(global-set-key "\M-/" 'auto-complete)

(provide 'mods/ac)
