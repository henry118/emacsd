;;
;; Clips mode setup
;;

(setq
 auto-mode-alist
 (append
  '(("\\.clp\\'" . clips-mode))
  auto-mode-alist))


(provide 'mods/clips)
