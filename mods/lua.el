;;
;; Lua mode setup
;;


(setq
 auto-mode-alist
 (append
  '(("\\.lua\\'" . lua-mode))
  auto-mode-alist))


(setq
 interpreter-mode-alist
 (append
  '(("lua" . lua-mode))
  interpreter-mode-alist))


(provide 'mods/lua)
