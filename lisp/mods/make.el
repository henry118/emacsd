;;
;; GNUmake file setup
;;

(defun hwang:makefile-mode-hook()
  (setq indent-tabs-mode t)
  )

(add-hook 'GNUmakefile-mode-hook 'hwang:makefile-mode-hook)

(defun hwang:conf-mode-hook()
  (setq indent-tabs-mode t)
  (setq cursor-type 'bar)
  )

(add-hook 'conf-mode-hook 'hwang:conf-mode-hook)


(provide 'mods/make)
