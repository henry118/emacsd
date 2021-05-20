;;
;; My autocomplete setup
;;

(require 'auto-complete-config)
(require 'auto-complete-clang-async)
;;(require 'auto-complete-nxml)
;;(require 'auto-complete-auctex)

(ac-config-default)

;;(ac-set-trigger-key "TAB")
(setq ac-auto-start nil)

(setq ac-quick-help-delay 0.5)

(global-set-key "\M-/" 'auto-complete)

(provide 'mods/ac)
