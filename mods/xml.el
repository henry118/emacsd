;;
;; XML setup
;;


(setq
 auto-mode-alist
 (append
  '(("\\.\\(xml\\|xsl\\|rng\\|xhtml\\|xsd\\)\\'" . nxml-mode))
  auto-mode-alist))


(provide 'mods/xml)
