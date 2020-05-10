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


(setq org-agenda-block-separator nil)
(setq org-agenda-compact-blocks t)
;; doesn't take effect

(setq org-agenda-custom-commands
      '(
	("c" "Super Agenda"
	 ((agenda "" (
             ;;(org-agenda-overriding-header "THIS WEEK")
             (org-agenda-span 'day)
             ;;(org-agenda-scheduled-leaders '("   " "%2dx"))
	     (org-agenda-block-separator nil)
	     ;; this doesn't take effect either
	     (org-super-agenda-mode)
             )))
       ((org-super-agenda-groups
	 '(;; Each group has an implicit boolean OR operator between its selectors.
         (:name "Today"  ; Optionally specify section name
                ;;:time-grid t  ; Items that appear on the time grid
	 	:auto-outline-path t
                :todo "NEXT")  ; Items that have this TODO keyword
         ;;(:name "Important"
         ;;       ;; Single arguments given alone
         ;;       :tag "bills"
         ;;       :priority "A")
	 ;;(:name "Projects"
	 ;;	:todo "PROJ")
         ;; Set order of multiple groups at once
         (:order-multi (2 (:name "Shopping in town"
                                 ;; Boolean AND group matches items that match all subgroups
                                 :and (:tag "shopping" :tag "@town"))
                          (:name "Food-related"
                                 ;; Multiple args given in list with implicit OR
                                 :tag ("food" "dinner"))
                          (:name "Personal"
                                 :habit t
                                 :tag "personal")
                          (:name "Space-related (non-moon-or-planet-related)"
                                 ;; Regexps match case-insensitively on the entire entry
                                 :and (:regexp ("space" "NASA")
                                               ;; Boolean NOT also has implicit OR between selectors
                                               :not (:regexp "moon" :tag "planet")))))
         ;; Groups supply their own section names when none are given
         (:todo "WAITING" :order 8)  ; Set order of this section
         (:todo ("SOMEDAY" "TO-READ" "CHECK" "TO-WATCH" "WATCHING")
                ;; Show this group at the end of the agenda (since it has the
                ;; highest number). If you specified this group last, items
                ;; with these todo keywords that e.g. have priority A would be
                ;; displayed in that group instead, because items are grouped
                ;; out in the order the groups are listed.
                :order 9)
         (:priority<= "B"
                      ;; Show this section after "Today" and "Important", because
                      ;; their order is unspecified, defaulting to 0. Sections
                      ;; are displayed lowest-number-first.
                      :order 1)
         ;; After the last group, the agenda will display items that didn't
         ;; match any of these groups, with the default order position of 99
         )))
         (org-agenda nil "a"))))


