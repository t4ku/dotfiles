;; spacemacs

;;(setq spacemacs-start-directory "~/.emacs.d/spacemacs/")
;;(load-file (concat spacemacs-start-directory "init.el"))

;; -----


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;(setq package-enable-at-startup nil)

(setq warning-suppress-log-types '((package reinitialization)))
(package-initialize)



;; Cask
(require 'cask "~/.cask/cask.el")
(cask-initialize)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; theme
;;(load-theme 'flatui t)
(load-theme 'leuven t)
;;(load-theme 'material-light t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; key bind
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; helm
(global-set-key (kbd "M-x") 'helm-M-x)
;; map Cmd-f1 to change gui window(emacs frames)
(global-set-key (kbd "<s-f1>") 'other-frame)


;; like vim's C-o
(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(global-set-key (kbd "C-c b") 'switch-to-previous-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; emacs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; mouse scroll
(global-set-key [wheel-right] 'scroll-left)
(global-set-key [wheel-left] 'scroll-right)

(global-set-key [tripple-wheel-right] 'scroll-left)
(global-set-key [tripple-wheel-left] 'scroll-right)
(put 'scroll-left 'disabled nil)

;; appearance
(tool-bar-mode -1)

;;
(transient-mark-mode 0)

;; backup
;; http://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; appearence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;Font設定
;;(set-face-attribute 'default nil :family "monaco" :height 110)
;;(set-face-attribute 'default nil :family "Source Han Code JP" :height 90)

;;(set-face-font 'default "Source Han Code JP")
(set-face-font 'default "Noto Sans Mono CJK JP")

;; 結局1:2の等幅フォントを使ったほうが良さげ
;; http://extra-vision.blogspot.com/2016/07/emacs.html
;; -- 
;; まあサイズ的なバンランスを調整(または無視)したとしても、
;; そもそもデザイン的に統一感がありません。そこまで気にする人は
;; 少ないかもしれませんが、フォント環境をつきつめていくと、
;; こういった所まで気になるものです。
;; --

;;---------------------------------------------------
;; https://qiita.com/kaz-yos/items/0f23d53256c2a3bd6b8d
;; macOS font settings
(when (and (eq system-type 'darwin)
           (display-graphic-p))
  ;; Best one so far. Good rescaling, and working with Greek letters φ phi
  ;; http://d.hatena.ne.jp/setoryohei/20110117
  ;; Good overview of how to configure a multi-language environment
  ;; http://qiita.com/melito/items/238bdf72237290bc6e42
  ;; Overview of an alternative method
  ;; http://lioon.net/emacs-change-font-size-quickly
  ;; Detailed explanation with Japanese font-only config
  ;; http://extra-vision.blogspot.com/2016/07/emacs.html?m=1
  ;; 37.12.11 Fontsets (Emacs Lisp Manual)
  ;; A fontset is a list of fonts, each assigned to a range of character codes.
  ;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Fontsets.html#Fontsets
  ;;
  ;; Strategy
  ;; 1. Create a fontset specifying Latin and Japanese letter separately
  ;; 2. Set default-frame fontset via default-frame-alist
  ;; 3. Set face-font-rescale-alist to match width of different fonts
  ;;
  ;;;  Step 1. Create a fontset specifying different fonts for Latin and Japanese letters
  ;; This creates a new fontset rather than overwriting the default fontset.
  (let* ((my-fontset-name "myfonts")
      ;; Font size one of [9/10/12/14/15/17/19/20/...]
      (my-default-font-size 14)
      ;;
      ;; Ascii font name (pick from (font-family-list))
      (my-ascii-font "Menlo")
      ;; (my-ascii-font "Source Han Code JP")
      ;; Japanese font name (pick from (font-family-list))
      (my-jp-font    "Hiragino Maru Gothic ProN")
      ;;
      ;; Create a FONT string for create-fontset-from-ascii-font
      ;; "Menlo-14:weight=normal:slant=normal"
      (my-default-font-string (format "%s-%d:weight=normal:slant=normal" my-ascii-font my-default-font-size))
      (my-jp-font-string (format "%s-%d:weight=normal:slant=normal" my-jp-font my-default-font-size))
      ;;
      ;; Create a fontset from an ASCII font FONT.
      ;; Name as "fontset-" added to my-fontset-name
      ;; "-*-menlo-normal-normal-normal-*-*-140-*-*-m-0-fontset-myfonts"
      (my-font-set (create-fontset-from-ascii-font my-default-font-string nil my-fontset-name))
      ;;
      ;; Create :family-only font specifications (use later)
      ;; #<font-spec nil nil Menlo nil nil nil nil nil nil nil nil nil nil>
      (my-ascii-fontspec (font-spec :family my-ascii-font))
      ;; #<font-spec nil nil Hiragino\ Maru\ Gothic\ ProN nil nil nil nil nil nil nil nil nil nil>
      (my-jp-fontspec    (font-spec :family my-jp-font)))
      ;;
      ;; set-fontset-font function
      ;; Modify fontset NAME to use FONT-SPEC for TARGET characters.
      ;; (set-fontset-font NAME TARGET FONT-SPEC &optional FRAME ADD)
      ;; NAME is a fontset name string, nil for the fontset of FRAME, or t for the default fontset.
      ;; TARGET may be a cons (FROM . TO) or a charset or others.
      ;;  To list all possible choices, use M-x list-character-sets
      ;; FONT-SPEC may one of these:
      ;; * A font-spec object made by the function ‘font-spec’ (which see).
      ;; * A cons (FAMILY . REGISTRY), where FAMILY is a font family name and
      ;;   REGISTRY is a font registry name.  FAMILY may contain foundry
      ;;   name, and REGISTRY may contain encoding name.
      ;; * A font name string.
      ;; * nil, which explicitly specifies that there’s no font for TARGET.
      ;; FRAME is a frame or nil for the selected frame
      ;; ADD, if non-nil, specifies how to add FONT-SPEC to the font specifications for TARGET previously set
      ;; Use 'append if specifying overlapping
      ;;
      ;; For these Japanese character sets, use my-jp-fontspec
      (set-fontset-font my-font-set 'japanese-jisx0213.2004-1 my-jp-fontspec    nil 'append)
      (set-fontset-font my-font-set 'japanese-jisx0213-2      my-jp-fontspec    nil 'append)
      ;; For Half-sized katakana characters, use my-jp-fontspec
      (set-fontset-font my-font-set 'katakana-jisx0201        my-jp-fontspec    nil 'append)
      ;;
      ;; For the characters in the range #x0080 - #x024F, use my-ascii-fontspec
      ;; Latin with pronounciation annotations
      (set-fontset-font my-font-set '(#x0080 . #x024F)        my-ascii-fontspec nil 'append)
      ;; For the characters in the range #x0370 - #x03FF, use my-ascii-fontspec
      ;; Greek characters
      (set-fontset-font my-font-set '(#x0370 . #x03FF)        my-ascii-fontspec nil 'append))
      ;;
      ;;;  Step 2. Set default-frame fontset via default-frame-alist
      ;; Set the font set for the default frame (Used at frame creation)
      ;; Alist of default values for frame creation.
      ;; To check for the current frame, use M-x describe-fontset
      ;; To examine a specific character under cursor, use M-x describe-font
      ;; ----------- ここでデフォルトにセットしない
      ;;(add-to-list 'default-frame-alist '(font . "fontset-myfonts"))
      ;;
      ;;;  Step 3. Set face-font-rescale-alist to match width of different fonts
      ;; Rescaling parameters to adjust font sizes to match each other
      (dolist (elt '(("Hiragino Maru Gothic ProN"        . 1.2)
                     ;; Below not relevant, but kept for historical reasons
                     ;; ("^-apple-hiragino.*"               . 1.2)
                     ;; (".*osaka-bold.*"                   . 1.2)
                     ;; (".*osaka-medium.*"                 . 1.2)
                     ;; (".*courier-bold-.*-mac-roman"      . 1.0)
                     ;; (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
                     ;; (".*monaco-bold-.*-mac-roman"       . 0.9)
                     ))
      ;; Alist of fonts vs the rescaling factors.
      ;; Each element is a cons (FONT-PATTERN . RESCALE-RATIO)
      (add-to-list 'face-font-rescale-alist elt)))
;;;---------------------------------------------------


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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; plugins
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

;; -------------
;; smartparens
;; -------------

;; example
;; https://github.com/Fuco1/.emacs.d/blob/master/files/smartparens.el

(smartparens-global-mode t)
(add-to-list 'sp-ignore-modes-list 'emacs-lisp-mode)
(add-hook 'minibuffer-setup-hook 'turn-on-smartparens-strict-mode)

;; guide - navigation-functions / manupulation-functions
;; https://github.com/Fuco1/smartparens/wiki/Working-with-expressions#navigation-functions
;; https://github.com/Fuco1/smartparens/wiki/Working-with-expressions#manipulation-functions

(define-key smartparens-mode-map (kbd "C-M-f") 'sp-forward-sexp)
(define-key smartparens-mode-map (kbd "C-M-b") 'sp-backward-sexp)

(define-key smartparens-mode-map (kbd "C-M-d") 'sp-down-sexp)
(define-key smartparens-mode-map (kbd "C-M-a") 'sp-backward-down-sexp)
(define-key smartparens-mode-map (kbd "C-S-d") 'sp-beginning-of-sexp)
(define-key smartparens-mode-map (kbd "C-S-a") 'sp-end-of-sexp)

(define-key smartparens-mode-map (kbd "C-M-e") 'sp-up-sexp)
(define-key smartparens-mode-map (kbd "C-M-u") 'sp-backward-up-sexp)
(define-key smartparens-mode-map (kbd "C-M-t") 'sp-transpose-sexp)

(define-key smartparens-mode-map (kbd "C-M-n") 'sp-forward-hybrid-sexp)
(define-key smartparens-mode-map (kbd "C-M-p") 'sp-backward-hybrid-sexp)

(define-key smartparens-mode-map (kbd "C-M-k") 'sp-kill-sexp)
(define-key smartparens-mode-map (kbd "C-M-w") 'sp-copy-sexp)

(define-key smartparens-mode-map (kbd "M-<delete>") 'sp-unwrap-sexp)
(define-key smartparens-mode-map (kbd "M-<backspace>") 'sp-backward-unwrap-sexp)

(define-key smartparens-mode-map (kbd "C-<right>") 'sp-forward-slurp-sexp)
(define-key smartparens-mode-map (kbd "C-<left>") 'sp-forward-barf-sexp)
(define-key smartparens-mode-map (kbd "C-M-<left>") 'sp-backward-slurp-sexp)
(define-key smartparens-mode-map (kbd "C-M-<right>") 'sp-backward-barf-sexp)

(define-key smartparens-mode-map (kbd "M-D") 'sp-splice-sexp)
(define-key smartparens-mode-map (kbd "C-M-<delete>") 'sp-splice-sexp-killing-forward)
(define-key smartparens-mode-map (kbd "C-M-<backspace>") 'sp-splice-sexp-killing-backward)
(define-key smartparens-mode-map (kbd "C-S-<backspace>") 'sp-splice-sexp-killing-around)

(define-key smartparens-mode-map (kbd "C-]") 'sp-select-next-thing-exchange)
(define-key smartparens-mode-map (kbd "C-<left_bracket>") 'sp-select-previous-thing)
(define-key smartparens-mode-map (kbd "C-M-]") 'sp-select-next-thing)

(define-key smartparens-mode-map (kbd "M-F") 'sp-forward-symbol)
(define-key smartparens-mode-map (kbd "M-B") 'sp-backward-symbol)

(define-key smartparens-mode-map (kbd "C-\"") 'sp-change-inner)


;; -------------
;; pyenv
;; -------------

;; set python path in pyenv
(pyenv-mode)

;; -------------
;;neotree
;; -------------
(global-set-key [f8] 'neotree-toggle)

;; -------------
;; auto-complete
;; -------------
(ac-config-default)

;; -------------
;; auto-complete
;; -------------

(require 'rg)
(rg-enable-default-bindings)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; archive subtree as it is
;; https://fuco1.github.io/2017-04-20-Archive-subtrees-under-the-same-hierarchy-as-original-in-the-archive-files.html
;;(load-file "~/dotfiles/.emacs.d/org-archive-subtree.el")

;; reload inline imge
;; http://emacs.stackexchange.com/questions/13107/replace-plantuml-source-with-generated-image-in-org-mode
(add-hook 'org-babel-after-execute-hook
          (lambda ()
            (when org-inline-image-overlays
              (org-redisplay-inline-images))))

(pyenv-mode-set "3.6.5")

;; org language
(org-babel-do-load-languages
'org-babel-load-languages
'((emacs-lisp . t)
  ;;(ipython . t)
    (http . t)
    (org . t)
    (sql . t)
    (latex . t)
    (shell . t)
    (ruby . t)
    (jupyter . t)))

;;org-protocol
(require 'org-protocol)
;; start emacs server so that emacsclient can connect
;; when using org-protocol
(server-start)

;;org-capture
(define-key global-map "\C-cc" 'org-capture)

;;capture-template
;;(setq org-capture-templates
;;      '(("t" "Todo" entry (file+headline "~/Dropbox/org/Agenda/work.org" "Capture")
;;             "* TODO %?n %in %a")
;;        ("l" "Logbook" entry (file+datetree "~/Dropbox/org/Journal/logbook-work.org")
;;             "* %?n %Un %in %a")
;;        ("n" "Note" entry (file+headline "~/Dropbox/org/notes.org" "Notes")
;;             "* %?n %Un %i")
;;
;;org-agenda
(define-key org-mode-map (kbd "C-c C-a") 'org-agenda-execute)
(define-key org-mode-map (kbd "C-c s") 'org-schedule)
(define-key org-mode-map (kbd "C-c d") 'org-deadline)

;;org-clock
(setq org-log-into-drawer t)  ; Save state changes into LOGBOOK drawer instead of in the body

;; org link
;; https://emacs.stackexchange.com/questions/19598/org-mode-link-to-heading-in-other-org-file
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c C-l") 'org-insert-link)

;; key mapping
;;(add-hook 'org-mode-hook
;;	  (lambda ()
;;	    (local-set-key (kbd "C-c C-u") #'outline-up-heading)))
;;
;; C-c C-u (original keymap) was overritten by pymode-env set
;; add similar keymap
(global-set-key (kbd "C-c u") 'outline-up-heading)
(define-key org-mode-map (kbd "M-s-<up>") 'org-previous-block)
(define-key org-mode-map (kbd "M-s-<down>") 'org-next-block)

;; open link

(require 'org)

(defun my-find-file-fn (file)
"If the filename extension of FILE ends in `.txt' or `.el' or `.png', then use
`find-file-other-frame'; otherwise, use `find-file-other-window'.  The three file
extensions txt/el/png are hard-coded into the let-bound variable `regex'."
  (let* (
      ;; regexp-matchp-fn from:  https://github.com/kentaro/auto-save-buffers-enhanced
      ;; regexp-matchp-fn modified by @sds:  http://stackoverflow.com/a/20343715/2112489
      (regexp-matchp-fn
        (lambda (regexps string)
          (and string
             (catch 'matched
               (let ((inhibit-changing-match-data t))
                 (dolist (regexp regexps)
                   (when (string-match regexp string)
                     (throw 'matched t))))))))
      (ext (file-name-extension file))
      (regex '("txt" "el" "png")))
    (if (funcall regexp-matchp-fn regex ext)
      (find-file-other-frame file)
      ;;(find-file-other-window file))))
      (find-file file))))

(setq org-link-frame-setup '(
  (vm . vm-visit-folder-other-frame)
  (vm-imap . vm-visit-imap-folder-other-frame)
  (gnus . org-gnus-no-new-news)
  (file . my-find-file-fn)
  (wl . wl-other-frame)))

;; capture template
(setq capture-template-load-file "~/Dropbox/Docs/org/Templates/capture_template.el")
(load capture-template-load-file)

;; custome agenda view

;; ------------------
;; org-super-agenda
;; ------------------

(load "~/.emacs.d/org-super-agenda-settings.el")


;;org-goto
(setq org-goto-interface 'outline-path-completion
      org-goto-max-level 10)
(setq org-outline-path-complete-in-steps nil)

(setq org-agenda-files (list "~/Dropbox/Docs/org/Agenda"))

;;org-todo
;;(setq org-todo-keywords
;;      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
;;              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)"))))


(setq org-src-fontify-natively t)

(defface org-block-begin-line
  '((t (:underline "#A7A6AA" :foreground "#008ED1" :background "#EAEAFF")))
  "Face used for the line delimiting the begin of source blocks.")

(defface org-block-background
  '((t (:background "#FFFFEA")))
  "Face used for the source block background.")

(defface org-block-end-line
  '((t (:overline "#A7A6AA" :foreground "#008ED1" :background "#EAEAFF")))
  "Face used for the line delimiting the end of source blocks.")


;;org-sync
;;(add-to-list 'load-path "~/.emacs.d/src/org-sync")
;;(mapc 'load
;;      '("org-sync" "org-sync-bb" "org-sync-github" "org-sync-redmine"))

;; riary
(setq diary-file "~/Dropbox/Docs/org/Inbox/diary.txt")
(setq org-agenda-include-diary t)
;;(setq org-agenda-diary-file  "~/Dropbox/Docs/org/Inbox/test.org")

;; refile
(setq org-refile-targets '((nil :maxlevel . 9)
                                (org-agenda-files :maxlevel . 9)))
(setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
(setq org-refile-use-outline-path t)                  ; Show full paths for refiling

;; org-select
;; https://emacs.stackexchange.com/questions/40571/how-to-set-a-short-cut-for-begin-src-end-src/47370#47370

(add-to-list 'org-structure-template-alist '("j" . "src jupyter-python :session py :display plain
"))

;; --------------
;; ox-hugo
;; --------------

(use-package ox-hugo
  :after ox)

;; --------------
;; ox-ipynb
;; https://github.com/jkitchin/ox-ipynb
;; --------------

(add-to-list 'load-path "~/.emacs.d/src/ox-ipynb")

;; ---------------
;; company-mode
;; ---------------

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0)

(defun text-mode-hook-setup ()
  ;; make `company-backends' local is critcal
  ;; or else, you will have completion in every major mode, that's very annoying!
  (make-local-variable 'company-backends)

  ;; company-ispell is the plugin to complete words
  (add-to-list 'company-backends 'company-ispell)

  ;; OPTIONAL, if `company-ispell-dictionary' is nil, `ispell-complete-word-dict' is used
  ;;  but I prefer hard code the dictionary path. That's more portable.
  (setq company-ispell-dictionary (file-truename "~/.emacs.d/misc/english-words.txt")))

(add-hook 'text-mode-hook 'text-mode-hook-setup)

;; -------------
;; pngpaste
;; -------------

(defun my-org-screenshot ()
  "Save a clipboard's screenshot into a time stamped unique-named file
   in a specified directory and insert a link to this file."
  (interactive)
  (setq filename
        (concat
         (make-temp-name
          (concat "/Users/takuokawa/Dropbox/Docs/org/Attachments/images/"
                  (buffer-name)
                  "_"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (call-process "pngpaste" nil nil nil filename)
  (insert (concat "[[" filename "]]"))
  (org-display-inline-images))

