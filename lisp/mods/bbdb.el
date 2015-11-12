(add-to-list 'load-path "~/.emacs.d/lisp/bbdb")

(require 'bbdb)

(bbdb-initialize 'gnus 'message)
(bbdb-insinuate-message)

(setq
 bbdb-file "~/.bbdb"
 bbdb-offer-save 1
 bbdb-use-pop-up t
 bbdb-popup-target-lines 1
 bbdb-complete-name-allow-cyling t
 )

(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)

(provide 'mods/bbdb)
