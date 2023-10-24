# haskell-ghcid-mode
Emacs major mode for navigating ghcid and ghciwatch errors.

## Installation

### straight.el

Add this to `init.el`:

```elisp
;;; init.el
(straight-use-package '(haskell-ghcid-mode :type git :host github :repo "ttuegel/haskell-ghcid-mode"))
```

Or, if using `straight-use-package-by-default`,

```elisp
;;; init.el
(use-package
  :straight (haskell-ghcid-mode :type git :host github :repo "ttuegel/haskell-ghcid-mode")
  )
```

### use-package

Clone this repository in a convenient location, then add this to `init.el`:

```elisp
;;; init.el
(use-package haskell-ghcid-mode :load "/path/to/repo")
```

## Use

1. Start `ghcid` or `ghciwatch` in the usual manner for your project.
   Direct output to `ghcid.txt`:

```sh
ghcid ... -o ghcid.txt
# or,
ghciwatch ... --errors ghcid.txt
```

2. Open `ghcid.txt` in Emacs. Use `next-error` and `previous-error` to navigate
   as any `compilation-mode` buffer.
3. The `ghcid.txt` buffer will automatically reload when changed.
