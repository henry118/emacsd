;;================================================================================
;;
;; My personal Emacs configuration
;;
;; Author: Henry Wang <henry118@gmail.com>
;;
;;=================================================================================

(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'mods/os)
(require 'mods/utils)
(require 'mods/pkg)
(require 'mods/color)
(require 'mods/misc)

;;(require 'mods/ac)
;;(require 'cedet)
;;(require 'semantic)
;;(load "semantic/loaddefs.el")
;;(semantic-mode 1)

(require 'mods/completion)

(require 'undo-tree)
(global-undo-tree-mode)

;;(require 'dired+)
(require 'diff-mode-)
;;(require 'pastebin)
;;(require 'clips-mode)
(require 'doxymacs)
(require 'mods/markdown)
(require 'mods/lisp)
(require 'mods/c++)
;;(require 'mods/python)
;;(require 'mods/perl)
(require 'mods/make)
;;(require 'mods/erlang)
;;(require 'mods/cmake)
;;(require 'mods/java)
;;(require 'mods/csharp)
;;(require 'mods/js)
(require 'mods/go)
(require 'mods/eshell)
;;(require 'mods/lua)
;;(require 'mods/clips)
;;(require 'mods/xml)
;;(require 'mods/org)
;;(require 'mods/gnus)
;;(require 'mods/bbdb)
;;(require 'mods/hipchat)
;;(require 'mods/ecb)
;;(require 'mods/tex)
(require 'mods/ruby)
(require 'mods/plantuml)
;;(require 'mods/mediawiki)
(require 'mods/rust)
