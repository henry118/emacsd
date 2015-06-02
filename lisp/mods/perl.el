;;
;; Perl mode setup
;;

(require 'mods/utils)


(defun hwang:cperl-mode-hook()
  (hwang:imenu)
 ;(setq cursor-type 'bar)
  (require 'perl-completion)
  (perl-completion-mode t)
  (local-set-key (kbd "M-m") 'helm-semantic-or-imenu)
  )

(add-hook 'cperl-mode-hook 'hwang:cperl-mode-hook)

(setq
 auto-mode-alist
 (append
  '(("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
  auto-mode-alist))

(setq
 interpreter-mode-alist
 (append
  '(("perl" . cperl-mode)
    ("perl5" . cperl-mode)
    ("miniperl" . cperl-mode)
    ) interpreter-mode-alist))


(provide 'mods/perl)
