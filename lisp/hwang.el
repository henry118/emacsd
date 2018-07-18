;;================================================================================
;;
;; My personal Emacs configuration
;;
;; Author: Henry Wang <henry118@gmail.com>
;;
;; Comment:
;;
;;   * Most packages can be found in Emacs packages (M-x list-packages)
;;
;;   * For CXX completion, Clang must be installed. I don't use CEDET any more
;;     because my computer is slow. Also note that CXX completion does not work
;;     under windows, use emacs-w32 under Cygwin instead.
;;
;;   * For Python completion, py-epc & jedi python eggs must be installed
;;
;;   * Java completion requireds package *emacs-eclim*, and Eclim Eclipse plugin
;;
;;   * C# completion requires package *omnisharp*, and OmniSharpServer. Note that
;;     on windows, omnisharp requires windows native *curl* to work properly.
;;
;;=================================================================================

(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'mods/os)
(require 'mods/utils)
(require 'mods/pkg)
(require 'mods/color)
(require 'mods/misc)

(require 'mods/ac)
(require 'cedet)
(require 'semantic)
(load "semantic/loaddefs.el")
(semantic-mode 1)

(require 'mods/completion)

(require 'undo-tree)
(global-undo-tree-mode)

;;(require 'dired+)
(require 'diff-mode-)
(require 'pastebin)
;;(require 'clips-mode)
(require 'doxymacs)
(require 'mods/markdown)
(require 'mods/lisp)
(require 'mods/c++)
;;(require 'mods/python)
;;(require 'mods/perl)
(require 'mods/make)
;;(require 'mods/erlang)
(require 'mods/cmake)
;;(require 'mods/java)
;;(require 'mods/csharp)
;;(require 'mods/js)
;;(require 'mods/go)
(require 'mods/eshell)
;;(require 'mods/lua)
;;(require 'mods/clips)
;;(require 'mods/xml)
(require 'mods/org)
;;(require 'mods/gnus)
;;(require 'mods/bbdb)
;;(require 'mods/hipchat)
;;(require 'mods/ecb)
(require 'mods/tex)
(require 'mods/ruby)
