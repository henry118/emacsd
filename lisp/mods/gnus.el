;;
;; Gnus newsgroup setup
;;
(require 'gnus)
(require 'nnir)

(setq gnus-select-method '(nnnil))

(setq
 user-full-name "Henry Wang"
 user-mail-address "henry118@gmail.com"
 )

(setq
 gnus-posting-styles
 '((".*"
    (signature "Regards,\nHenry Wang\n\nSent from Emacs Gnus.")
    )
   ))

;;== the following uses /maildir/ backend, but we can't do splitting
;; (add-to-list
;;  'gnus-secondary-select-methods
;;  '(nnmaildir ""
;;              (directory "~/.maildir/")
;;              (directory-files nnheader-directory-files-safe)
;;              (get-new-mail nil))
;;  )
;;
;;== the following uses /maildir/ mail source, so we can do splitting now
(add-to-list
 'gnus-secondary-select-methods
 '(nnml "")
 )

(add-to-list
 'mail-sources
 '(maildir :path "~/.maildir/inbox/")
 )

(setq
 nnmail-split-methods 'nnmail-split-fancy
 nnmail-split-fancy
 `(| (to "henry118@gmail.com" "mail.gmail")
     (to "wh_henry@hotmail.com" "mail.outlook")
     (to "wh_henry@outlook.com" "mail.outlook")
     "mail.spam")
 )
;;===

(setq
 message-send-mail-function 'message-send-mail-with-sendmail
 )

(cond
 ((executable-find "esmtp")
  (setq sendmail-program (executable-find "esmtp")))
 ((executable-find "msmtp")
  (progn
    (setq sendmail-program (executable-find "msmtp"))
    (setq message-sendmail-f-is-evil 't)
    (setq message-sendmail-extra-arguments '("--read-envelope-from"))
    ))
 )

(setq-default
 gnus-summary-line-format "%U%R%z %(%&user-date;  %-15,15f  %B%s%)\n"
 gnus-user-date-format-alist '((t . "%Y-%m-%d %H:%M"))
 gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references
 gnus-sum-thread-tree-false-root ""
 gnus-sum-thread-tree-indent ""
 gnus-sum-thread-tree-leaf-with-other "-> "
 gnus-sum-thread-tree-root ""
 gnus-sum-thread-tree-single-leaf "|_ "
 gnus-sum-thread-tree-vertical "|")

(setq
 gnus-thread-sort-functions
 '(
   (not gnus-thread-sort-by-date)
   (not gnus-thread-sort-by-number)
   ))

(setq gnus-use-correct-string-widths nil)

(defun hwang:gnus-group-list-subscribd-groups()
  "List all subscribed groups with or without un-read messages."
  (interactive)
  (gnus-group-list-all-groups 5)
)

(defun hwang:gnus-group-mode-hook()
  (local-set-key (kbd "o") 'hwang:gnus-group-list-subscribd-groups)
)

(add-hook 'gnus-group-mode-hook 'hwang:gnus-group-mode-hook)

(provide 'mods/gnus)
