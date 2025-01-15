Emacsd
======

This repository is my ~/.emacs.d directory. It is meant to be platform neutral.


Usage
-----

Simply put the following line into your .emacs file.

```
(load "~/.emacs.d/lisp/hwang")
```

Note that my implementation doesn't enforce the visual components such as the
color themes or fonts. You have to make the changes in your .emacs to suite
your own needs.

For pastbin module to work properly, you'll have to configure your own pastbin
API key like this:

```
(setenv "PASTEBIN_KEY" "pastebin-api-dev-key-here")
```

Tips
----

* On Windows systems, Cygwin must be installed
* For C/C++ completions, clang is a must
* For Python completions, epc & jedi python packages are required
* The emacstts requires pyttsx python package
* EMMS module might require mplayer to be functional
