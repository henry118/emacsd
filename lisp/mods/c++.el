;;
;; C/C++ Settings
;;

(require 'mods/utils)

;; Fix auto complete clang search path, obtain the include path list by:
;; $ echo | g++ -v -x c++ -E -
(defun hwang:g++-include-path ()
  "Return a list of include paths of g++"
  (let ((lines) (paths) (found))
    (setq lines (process-lines "sh" "-c" "echo | g++ -v -x c++ -E -"))
    (dolist (ln lines)
      (progn
        (setq ln (hwang:s-trim ln))
        (cond
         ((string= ln "#include <...> search starts here:")
          (setq found t))
         ((string= ln "End of search list.")
          (setq found nil))
         ((and found t)
          (setq paths (append paths (list ln))))
         )))
    paths)
  )

(when (not (is-win))
  (setq ac-clang-flags (mapcar (lambda (item)(concat "-I" item)) (hwang:g++-include-path))))

(defun hwang:include (path)
  "Append project local include directories to clang completion"
  (interactive (list (read-directory-name "Path: ")) )
  (setq ac-clang-flags (append ac-clang-flags (list (concat "-I" path)))))

(defun hwang:include-list (paths)
  "Append a list of project local include paths to clang completion"
  (setq ac-clang-flags
        (append ac-clang-flags
                (mapcar (lambda (item)(concat "-I" item)) paths))))


(defun hwang:cmode-hook()
  (hs-minor-mode t)
 ;(imenu-add-to-menubar "Imenu")
  (doxymacs-mode)
  (setq ac-sources (append '(ac-source-clang) ac-sources))
 ;(setq cursor-type 'bar)
  (local-set-key (kbd "C-c m") 'hwang:imenu)
  (local-set-key (kbd "C-<tab>") 'hs-toggle-hiding)
  (local-set-key (kbd "M-o")   'ff-find-other-file)
  (local-set-key (kbd "M-m")   'helm-semantic-or-imenu)
  (local-set-key (kbd "M-P")   'compile)
  (local-set-key (kbd "M-p")   'recompile)
  (local-set-key (kbd "M-.")   'helm-gtags-find-tag)
  (local-set-key (kbd "M-,")   'helm-gtags-pop-stack)
  (local-set-key (kbd "C-.")   'helm-gtags-find-rtag)
  (local-set-key (kbd "C-,")   'helm-gtags-find-pattern)
  (local-set-key (kbd "C-c i") 'helm-gtags-create-tags)
  (local-set-key (kbd "C-c u") 'helm-gtags-update-tags)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; CSCOPE Features
  ;;(require 'xcscope)
  ;;(setq cscope-do-not-update-database t)
  ;;(local-set-key (kbd "M-.")   'helm-cscope-find-global-definition)
  ;;(local-set-key (kbd "M-,")   'helm-cscope-pop-mark)
  ;;(local-set-key (kbd "C-.")   'helm-cscope-find-calling-this-funtcion)
  ;;(local-set-key (kbd "C-,")   'helm-cscope-find-this-symbol)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  )
(add-hook 'c-mode-common-hook 'hwang:cmode-hook)

(setq
 auto-mode-alist
 (append
  '(("\\.\\(h\\|ipp\\|tcc\\|tmh\\)\\'" . c++-mode))
  auto-mode-alist))

(provide 'mods/c++)
