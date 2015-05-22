;;
;; My utilies
;;

(require 'mods/os)

(add-to-list 'load-path "~/.emacs.d/lisp/emacstts")
(add-to-list 'load-path "~/.emacs.d/lisp/cedet")

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

(defun hwang:delete-spaces-after-point ()
  "Delete spaces (including new lines) after cursor"
  (interactive)
  (let ((x (char-after (point))))
    (while (or (char-equal x ?\s) (char-equal x ?\n) (char-equal x ?\t))
      (delete-char 1)
      (setq x (char-after (point)))
    ))
)

(provide 'mods/utils)
