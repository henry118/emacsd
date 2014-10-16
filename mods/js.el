;;
;; Javascript setup
;;

(defun hwang:js-hook()
  (skewer-mode)
  (setq cursor-type 'bar)
  (setq js2-highlight-level 3)
  (ac-js2-mode)
  (setq ac-js2-evaluate-calls t)
  (setq ac-js2-external-libraries '("/usr/share/javascript/jquery/jquery.js"))
  )

(add-hook 'js2-mode-hook 'hwang:js-hook)

(setq
 auto-mode-alist
 (append
  '(("\\.\\(js\\|json\\)\\'" . js2-mode))
  auto-mode-alist))


(provide 'mods/js)
