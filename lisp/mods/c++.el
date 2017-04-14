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

(defun hwang:cpp-header-template ()
  "Populate an empty c/c++ header file with my template"
  (interactive)
  (let* ((cpp-header '("h" "hpp"))
         (is-header (member-ignore-case (file-name-extension (buffer-file-name)) cpp-header)))
    (if (and is-header (= (buffer-size) 0))
        (let* ((header-file-name (upcase (file-relative-name (buffer-file-name))))
               (hashdef (format "__%s__" (replace-regexp-in-string "\\." "_" header-file-name))))
          (save-excursion
            (goto-char (point-min))
            (insert (format "#ifndef %s\n" hashdef))
            (insert (format "#define %s\n" hashdef))
            (insert "\n")
            (insert "#ifdef __cplusplus\n")
            (insert "extern \"C\" {\n")
            (insert "#endif\n")
            (insert "\n\n")
            (insert "#ifdef __cplusplus\n")
            (insert "}\n")
            (insert "#endif\n")
            (insert "\n")
            (insert (format "#endif // %s\n" hashdef))))))
  )

(defun hwang:cmode-hook()
  (hs-minor-mode t)
  (rainbow-delimiters-mode)
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
  (hwang:cpp-header-template)
  )
(add-hook 'c-mode-common-hook 'hwang:cmode-hook)

(defun hwang:cmode-before-save-hook()
  (helm-gtags-update-tags)
)
(add-hook 'before-save-hook 'hwang:cmode-before-save-hook)

(setq
 auto-mode-alist
 (append
  '(("\\.\\(h\\|ipp\\|tcc\\|tmh\\)\\'" . c++-mode))
  auto-mode-alist))

(provide 'mods/c++)
