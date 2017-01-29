;; spacemacs

;;(setq spacemacs-start-directory "~/.emacs.d/spacemacs/")
;;(load-file (concat spacemacs-start-directory "init.el"))

;; -----


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Cask
(require 'cask "/usr/local/opt/cask/cask.el")
(cask-initialize)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; theme
(load-theme 'flatui t)

;; key bind
(global-set-key (kbd "M-x") 'helm-M-x)

(require 'helm-config)
(helm-mode 1)

;;Font設定
;;(set-face-attribute 'default nil :family "monaco" :height 110)
;;(set-face-attribute 'default nil :family "Source Han Code JP" :height 90)

(set-face-font 'default "Source Han Code JP")

;;(set-face-font 'default "Source Code Pro")
;;(set-fontset-font
;;  (frame-parameter nil 'font)
;;    'japanese-jisx0208
;;    '("Source Han Code JP" . "iso10646-*"))
;;(add-to-list 'face-font-rescale-alist
;;             '(".*Source Han Code JP.*" 2.0))
;;

;;(when (and (>= emacs-major-version 24) (not (null window-system)))
;;  (let* ((font-family "Menlo")
;;         (font-size 9)
;;         (font-height (* font-size 10))
;;         (jp-font-family "ヒラギノ角ゴ ProN"))
;;    (set-face-attribute 'default nil :family font-family :height font-height)
;;    (let ((name (frame-parameter nil 'font))
;;          (jp-font-spec (font-spec :family jp-font-family))
;;          (jp-characters '(katakana-jisx0201
;;                           cp932-2-byte
;;                           japanese-jisx0212
;;                           japanese-jisx0213-2
;;                           japanese-jisx0213.2004-1))
;;          (font-spec (font-spec :family font-family))
;;          (characters '((?\u00A0 . ?\u00FF)    ; Latin-1
;;                        (?\u0100 . ?\u017F)    ; Latin Extended-A
;;                        (?\u0180 . ?\u024F)    ; Latin Extended-B
;;                        (?\u0250 . ?\u02AF)    ; IPA Extensions
;;                        (?\u0370 . ?\u03FF)))) ; Greek and Coptic
;;      (dolist (jp-character jp-characters)
;;        (set-fontset-font name jp-character jp-font-spec))
;;      (dolist (character characters)
;;        (set-fontset-font name character font-spec))
;;      (add-to-list 'face-font-rescale-alist (cons jp-font-family 1.2)))))

;;(when (and (>= emacs-major-version 24) (not (null window-system)))
;;  (let* ((font-family "Source Code Pro")
;;         (font-size 11)
;;         (font-height (* font-size 10))
;;         (jp-font-family "Source Han Code JP"))
;;    (set-face-attribute 'default nil :family font-family :height font-height)
;;    (let ((name (frame-parameter nil 'font))
;;          (jp-font-spec (font-spec :family jp-font-family))
;;          (jp-characters '(katakana-jisx0201
;;                           cp932-2-byte
;;                           japanese-jisx0212
;;                           japanese-jisx0213-2
;;                           japanese-jisx0213.2004-1))
;;          (font-spec (font-spec :family font-family))
;;          (characters '((?\u00A0 . ?\u00FF)    ; Latin-1
;;                        (?\u0100 . ?\u017F)    ; Latin Extended-A
;;                        (?\u0180 . ?\u024F)    ; Latin Extended-B
;;                        (?\u0250 . ?\u02AF)    ; IPA Extensions
;;                        (?\u0370 . ?\u03FF)))) ; Greek and Coptic
;;      (dolist (jp-character jp-characters)
;;        (set-fontset-font name jp-character jp-font-spec))
;;      (dolist (character characters)
;;        (set-fontset-font name character font-spec))
;;      (add-to-list 'face-font-rescale-alist (cons jp-font-family 1.3)))))
