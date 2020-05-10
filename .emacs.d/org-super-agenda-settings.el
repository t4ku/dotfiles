;;(setq org-agenda-custom-commands
;;      '(("d" "deadlines" agenda ""
;;	 ((org-agenda-entry-types '(:deadline)))
;;	 (org-agenda-skip-function '(org-agenda-skip-entry-if 'notdeadline))
;;	 (org-deadline-warning-days 10)
;;	 (org-agenda-overriding-columns-format "%20ITEM %DEADLINE")
;;	 )
;;	("S" "Agenda by states"
;;	 (;;(agenda "" nil)
;;	  (tags-todo  "Ops/!-DONE"
;;		      ((org-agenda-overriding-header "Ops")
;;		       (org-agenda-block-separator nil)))
;;	  (tags-todo  "/NEXT"
;;		      ((org-agenda-overriding-header "Next")
;;		       (org-tags-match-list-sublevels t)
;;		       (org-agenda-block-separator nil)
;;		       (org-agenda-sorting-strategy '(todo-state-down effort-up category-keep)))
;;		      ))
;;	 )
;;        ("G" "Agenda by Goals"
;;         ((tags-todo "Ops")
;;          (tags-todo "G@2018_request")
;;	  (tags-todo "G@2018_ml")
;;	  (tags-todo "G@2018_product")	  
;;          (tags-todo "errands"))
;;         nil                      ;; i.e., no local settings
;;         ("~/next-actions.html")) ;; exports block to this file with C-c a e
;;       ;; ..other commands here
;;        ))

;;(setq org-agenda-span 1)

;; https://github.com/alphapapa/org-super-agenda/issues/20#issuecomment-333365815

(setq org-agenda-span 1)
(setq org-agenda-include-deadlines nil)
;; or, hit ! manually
;;(org-agenda-toggle-deadlines)


(setq org-agenda-custom-commands
      '(("c" "Super Agenda" agenda
	 (org-super-agenda-mode)
       ((org-super-agenda-groups
	 '(;; Each group has an implicit boolean OR operator between its selectors.
         (:name "Today"  ; Optionally specify section name
                ;;:time-grid t  ; Items that appear on the time grid
		:auto-outline-path t
                :todo "NEXT")  ; Items that have this TODO keyword
         )))
         (org-agenda nil "a"))))

