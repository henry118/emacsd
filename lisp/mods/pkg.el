;;
;; My Packaging Setup
;;

(when (< emacs-major-version 24)
  (add-to-list 'load-path "~/.emacs.d/lisp/pm"))

(require 'package)

(add-to-list
 'package-archives
 '("melpa" . "http://melpa.org/packages/")
 t)

(when (< emacs-major-version 24)
  (add-to-list
   'package-archives
   '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

;; The following list contains the packages required for this setup
(defvar hwang-bootstrap-packages
  '(auto-complete
    auto-complete-clang-async
    auto-complete-nxml
    auto-complete-auctex
    switch-window
    clips-mode
    markdown-mode
    epc
    jedi
    ;;emms
    regex-tool
    magit
    iedit
    ;;idomenu
    ;;ido-vertical-mode
    ;;flx-ido
    ;;smex
    helm
    ;;helm-cscope
    helm-gtags
    helm-lsp
    undo-tree
    paredit
    rainbow-delimiters
    php-mode
    ;;malabar-mode
    ;;csharp-mode
    ;;omnisharp ;(requires OmniSharpServer - https://github.com/nosami/OmniSharpServer)
    ;;groovy-mode
    skewer-mode
    js2-mode
    ac-js2
    go-mode
    go-autocomplete
    s
    seq
    request
    ;;jabber
    pinentry
    ecb
    auctex
    yaml-mode
    powershell
    graphviz-dot-mode
    robe
    projectile
    helm-projectile
    plantuml-mode
    mediawiki
    protobuf-mode
    lua-mode
    tabbar
    minimap
    rust-mode
    cargo
    racer
    company
    lsp-mode
    lsp-ui
    which-key
    ))

(defun hwang:bootstrap ()
  (dolist (p hwang-bootstrap-packages)
    (if (not (package-installed-p p))
        (progn
          (package-refresh-contents)
          (package-install p))))
  )

(defun hwang:recompile-elpa ()
  "Delete *.elc in elpa and recompile all packages"
  (interactive)
  (require 'find-lisp)
  (dolist
      (file (find-lisp-find-files (expand-file-name "~/.emacs.d/elpa") "^.*\\.elc$"))
    (delete-file file)
    (message "Deleted %s..." file))
  (byte-recompile-directory (expand-file-name "~/.emacs.d/elpa") 0))

;; Now bootstrap Emacs
(hwang:bootstrap)

(provide 'mods/pkg)
