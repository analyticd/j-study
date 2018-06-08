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
            ""))
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
  ;; TODO insert adverbs
  ;; TODO insert conjunctions
  ;; TODO insert others
  (j-insert-verb-flashcards))
