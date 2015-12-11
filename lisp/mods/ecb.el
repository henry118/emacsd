;;
;; ECB Configuration
;;

(require 'ecb)

(custom-set-variables '(ecb-options-version "2.40"))

(setq
 ;ecb-compile-window-height 6
 ;ecb-compile-window-width 'edit-window
 ;ecb-compile-window-temporally-enlarge 'both
 ;ecb-create-layout-file "~/.emacs.d/auto-save-list/.ecb-user-layouts.el"
 ;ecb-windows-width 30
 ;ecb-fix-window-size 'width
 ;ecb-history-make-buckets 'mode
 ;ecb-kill-buffer-clears-history 'auto
 ecb-tip-of-the-day nil
 ecb-primary-secondary-mouse-buttons 'mouse-1--mouse-2
 semantic-decoration-styles (list '("semantic-decoration-on-includes" . t)
                                  '("semantic-tag-boundary" . t))
 ;;ecb-create-layout-frame-height 40
 ;;ecb-create-layout-frame-width 110
 )

(provide 'mods/ecb)
