;;
;; MediaWiki mode setup
;;
(require 'mediawiki)

;; (setq mediawiki-site-alist
;;       (append '(("WikiName" "https://url.com/" "" "" ""))
;;               mediawiki-site-alist))

(add-to-list 'auto-mode-alist '("\\.wiki\\'" . mediawiki-mode))

(provide 'mods/mediawiki)
