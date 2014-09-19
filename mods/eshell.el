;;
;; eshell setup
;;

(defun hwang:eshell-prompt()
  "Eshell prompt function"
  (format
   "%s@%s:%s%s "
   (user-login-name)
   (car (split-string (system-name) "\\."))
   (replace-regexp-in-string
    (format "^%s" (getenv "HOME")) "~"
    (if (= (length default-directory) 1) default-directory (substring default-directory 0 -1)))
   (if (= (user-uid) 0) "#" "$"))
  )

(setq eshell-prompt-function 'hwang:eshell-prompt)

(setq eshell-prompt-regexp "^[^#$]+[#$] ")

(provide 'mods/eshell)
