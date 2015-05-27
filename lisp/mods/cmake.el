;;
;; CMake mode setup
;;

(require 'cmake-mode)

(add-to-list 'ac-modes 'cmake-mode)

(defun hwang:cmake-hook()
 ;(setq cursor-type 'bar)
  (local-set-key (kbd "C-c l") 'cmake-help-list-commands)
  (local-set-key (kbd "C-c h") 'cmake-help-command)
)

(add-hook 'cmake-mode-hook 'hwang:cmake-hook)

(setq
 auto-mode-alist
 (append
  '(("CMakeLists\\.txt\\'" . cmake-mode)
    ("\\.cmake\\'" . cmake-mode))
  auto-mode-alist))


(provide 'mods/cmake)
