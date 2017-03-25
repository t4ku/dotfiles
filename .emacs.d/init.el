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
;;(load-theme 'flatui t)
;;(load-theme 'leuven t)
(load-theme 'material-light t)

;; key bind
(global-set-key (kbd "M-x") 'helm-M-x)

;;;;;;;;;;;;;;;;;;;;;
;; emacs
;;;;;;;;;;;;;;;;;;;;

;; mouse scroll
(global-set-key [wheel-right] 'scroll-left)
(global-set-key [wheel-left] 'scroll-right)

(global-set-key [tripple-wheel-right] 'scroll-left)
(global-set-key [tripple-wheel-left] 'scroll-right)
(put 'scroll-left 'disabled nil)

;; appearance
(tool-bar-mode -1)

;; backup
;; http://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;;;;;;;;;;;;;;;;;;;;;
;; plugins
;;;;;;;;;;;;;;;;;;;;;

(require 'helm-config)
(helm-mode 1)
;; helm
(global-set-key (kbd "C-x b") 'helm-for-files)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
;; helmショートカット
(global-set-key (kbd "C-x C-h h") 'helm-mini)
(global-set-key (kbd "C-x C-h r") 'helm-recentf)
(global-set-key (kbd "C-x C-h i") 'helm-imenu)
(global-set-key (kbd "C-x C-h k") 'helm-show-kill-ring)
;; helmコマンド内のキーバインド
(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-read-file-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
;;(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
;;(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

;; set correct path in emacs shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; set python path in pyenv
(pyenv-mode)

;; reload inline imge
;; http://emacs.stackexchange.com/questions/13107/replace-plantuml-source-with-generated-image-in-org-mode
(add-hook 'org-babel-after-execute-hook
          (lambda ()
            (when org-inline-image-overlays
              (org-redisplay-inline-images))))

(org-babel-do-load-languages
'org-babel-load-languages
'((emacs-lisp . t)
  (ipython . t)
  (org . t)
  (sql . t)
  (latex . t)
  (sh . t)))

;;org-agenda
(define-key org-mode-map (kbd "C-c C-a") 'org-agenda-execute)
(define-key org-mode-map (kbd "C-c s") 'org-schedule)
(define-key org-mode-map (kbd "C-c d") 'org-deadlinxe)

(setq org-agenda-custom-commands '(
  ("1" "Events" agenda "display deadlines and exclude scheduled" (
    (org-agenda-span 'month)
    (org-agenda-time-grid nil)
    (org-agenda-show-all-dates nil)
    (org-agenda-entry-types '(:deadline :scheduled)) ;; this entry excludes :scheduled
    (org-agenda-skip-scheduled-delay-if-deadline nil)
    (org-scheduled-delay-days 0)
    (org-scheduled-past-days 2)
    (org-deadline-warning-days 0) ))
    ))


;;org-goto
(setq org-goto-interface 'outline-path-completion
      org-goto-max-level 10)
(setq org-outline-path-complete-in-steps nil)

(setq org-agenda-files (list "~/Dropbox/Docs/org"))

;;org-todo
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)"))))

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



;; auto-complete
(ac-config-default)
