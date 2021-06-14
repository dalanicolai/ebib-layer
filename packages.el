;;; packages.el --- ebib layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2020 Sylvain Benner & Contributors
;;
;; Author: dalanicolai <dalanicolai@daniel-fedora>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `ebib-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `ebib/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `ebib/pre-init-PACKAGE' and/or
;;   `ebib/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst ebib-packages
  '(ebib
    biblio)
  "The list of Lisp packages required by the ebib layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun ebib/init-ebib ()
  (use-package ebib
    :defer t
    :init
    (spacemacs/set-leader-keys "oe" 'ebib)
    :config
    (setq ebib-bibtex-dialect 'biblatex)

    (evilified-state-evilify-map ebib-index-mode-map
      :mode ebib-index-mode
      :bindings
      "j" 'ebib-next-entry
      "k" 'ebib-prev-entry
      "J" 'evil-scroll-page-down
      "K" 'evil-scroll-page-up

      "/" 'ebib-search
      "n" 'ebib-search-next)

    (spacemacs/set-leader-keys-for-major-mode 'ebib-index-mode
      "j" 'ebib-jump-to-entry
      "k" 'ebib-kill-entry
      "b" 'biblio-lookup)

    (evilified-state-evilify-map ebib-entry-mode-map
      :mode ebib-entry-mode)

    (evilified-state-evilify-map ebib-log-mode-map
      :mode ebib-log-mode)

    (use-package ebib-biblio
      :after (ebib biblio)
      :config
      (evilified-state-evilify-map biblio-selection-mode-map
        :mode biblio-selection-mode
        :bindings
        "e" 'ebib-biblio-selection-import
        (kbd "C-j") 'biblio--selection-next
        (kbd "C-k") 'biblio--selection-previous))
))

(defun ebib/init-biblio()
  (use-package biblio
    :defer t))


;;; packages.el ends here
