(require 'helm-j-cheatsheet)

(defun insert-line (string)
  (insert string)
  (insert "\n"))

(defun j-insert-verb-flashcard (row)
  "Insert one verb flashcard."
  (insert-line "*** Verb               :drill:")
  (insert-line ":PROPERTIES:")
  (insert-line ":DRILL_CARD_TYPE: twosided")
  (insert-line ":END:")
  (insert-line "**** Symbol")
  (insert-line "#+begin_src j")
  (insert-line (first row))
  (insert-line "#+end_src")
  (insert-line "**** Name (monadic • dyadic)")
  (insert (if (second row)
              (second row)
            "N/A"))
  (insert " • ")
  (insert-line (if (third row)
                   (third row)
                 "N/A"))
  (insert-line "**** Dictionary entry")
  (let ((url (format "%s/%s.htm" (jc-valid-dictionary) (fourth row))))
    (insert-line url)))

(defun j-insert-adverb-flashcard (row)
  "Insert one adverb flashcard."
  (insert-line "*** Adverb               :drill:")
  (insert-line ":PROPERTIES:")
  (insert-line ":DRILL_CARD_TYPE: twosided")
  (insert-line ":END:")
  (insert-line "**** Symbol")
  (insert-line "#+begin_src j")
  (insert-line (first row))
  (insert-line "#+end_src")
  (insert-line "**** Name (monadic • dyadic)")
  (insert (if (second row)
              (second row)
            "N/A"))
  (insert " • ")
  (insert-line (if (third row)
                   (third row)
                 "N/A"))
  (insert-line "**** Dictionary entry")
  (let ((url (format "%s/%s.htm" (jc-valid-dictionary) (fourth row))))
    (insert-line url)))

(defun j-insert-conjunction-flashcard (row)
  "Insert one adverb flashcard."
  (insert-line "*** Conjunction          :drill:")
  (insert-line ":PROPERTIES:")
  (insert-line ":DRILL_CARD_TYPE: twosided")
  (insert-line ":END:")
  (insert-line "**** Symbol")
  (insert-line "#+begin_src j")
  (insert-line (first row))
  (insert-line "#+end_src")
  (insert-line "**** Name (monadic • dyadic)")
  (insert (if (second row)
              (second row)
            "N/A"))
  (insert " • ")
  (insert-line (if (third row)
                   (third row)
                 "N/A"))
  (insert-line "**** Dictionary entry")
  (let ((url (format "%s/%s.htm" (jc-valid-dictionary) (fourth row))))
    (insert-line url)))

(defun j-insert-other-flashcard (row)
  "Insert one other flashcard."
  (insert-line "*** Other          :drill:")
  (insert-line ":PROPERTIES:")
  (insert-line ":DRILL_CARD_TYPE: twosided")
  (insert-line ":END:")
  (insert-line "**** Symbol")
  (insert-line "#+begin_src j")
  (insert-line (first row))
  (insert-line "#+end_src")
  (insert-line "**** Name (monadic • dyadic)")
  (insert (if (second row)
              (second row)
            "N/A"))
  (insert " • ")
  (insert-line (if (third row)
                   (third row)
                 "N/A"))
  (insert-line "**** Dictionary entry")
  (let ((url (format "%s/%s.htm" (jc-valid-dictionary) (fourth row))))
    (insert-line url)))

(defun j-insert-verb-flashcards ()
  "Iterate through the verbs defined in helm-j-cheatsheet and generate a
  flashcard for each one."
  (loop for row in jc-verbs do
        (j-insert-verb-flashcard row)))

(defun j-insert-adverb-flashcards ()
  "Iterate through the adverbs defined in helm-j-cheatsheet and generate a
  flashcard for each one."
  (loop for row in jc-adverbs do
        (j-insert-adverb-flashcard row)))

(defun j-insert-conjunction-flashcards ()
  "Iterate through the conjunctions defined in helm-j-cheatsheet and generate a
  flashcard for each one."
  (loop for row in jc-conjunctions do
        (j-insert-conjunction-flashcard row)))

(defun j-insert-other-flashcards ()
  "Iterate through the others defined in helm-j-cheatsheet and generate a
  flashcard for each one."
  (loop for row in jc-others do
        (j-insert-other-flashcard row)))

(defun j-flashcards ()
  "Generate J flashcards."
  ;; * Flashcards
  ;; ** Verbs
  ;; ** Adverbs
  ;; ** Conjunctions
  ;; ** Others
  (interactive)
  (insert-line "* J flashcards")
  (insert-line "** Verbs")
  (j-insert-verb-flashcards)
  (insert-line "** Adverbs")
  (j-insert-adverb-flashcards)
  (insert-line "** Conjunctions")
  (j-insert-conjunction-flashcards)
  (insert-line "** Others")
  (j-insert-other-flashcards))
