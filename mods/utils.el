;;
;; My utilies
;;

(add-to-list 'load-path "~/.emacs.d/emacstts")
(add-to-list 'load-path "~/.emacs.d/cedet")

(defmacro is-unix ()
  (cond
   ((equal system-type 'gnu/linux) t)
   ((equal system-type 'gnu/kfreebsd) t)
   ((equal system-type 'berkeley-unix) t)))

(defmacro is-mac ()
  (equal system-type 'darwin))

(defmacro is-win ()
  (equal system-type 'windows-nt))

(defmacro is-cygwin ()
  (equal system-type 'cygwin))


(defun hwang:s-trim-left (s)
  "Remove whitespace at the beginning of S."
  (if (string-match "\\`[ \t\n\r]+" s)
      (replace-match "" t t s)
    s))

(defun hwang:s-trim-right (s)
  "Remove whitespace at the end of S."
  (if (string-match "[ \t\n\r]+\\'" s)
      (replace-match "" t t s)
    s))

(defun hwang:s-trim (s)
  "Remove whitespace at the beginning and end of S."
  (hwang:s-trim-left (hwang:s-trim-right s)))

(defun hwang:imenu ()
  "Add imenu to menubar"
  (interactive)
  (imenu-add-to-menubar "Imenu"))

(defun hwang:emacstts-start ()
  "Load emacstts module"
  (interactive)
  (require 'emacstts)
)

(defun hwang:emms-start ()
  "Load EMMS module"
  (interactive)
  (require 'emms-setup)
  (emms-standard)
  (emms-default-players)
)

(defun hwang:before-save-hook()
  (if (not (string-equal mode-name "Markdown"))
      (delete-trailing-whitespace))
)

(add-hook 'before-save-hook 'hwang:before-save-hook)


(provide 'mods/utils)
