(require 'helm-j-cheatsheet)

(defun insert-line (string)
  (insert string)
  (insert "\n"))

(defun j-dictionary-url (row)
  (let ((url (format "%s/%s.htm" (jc-valid-dictionary) (fourth row))))
    url))

(defun j-insert-flashcard (type row)
  (dolist (string `(,(format "*** %s               :drill:" type)
                    ":PROPERTIES:"
                    ":DRILL_CARD_TYPE: twosided"
                    ":END:"
                    "**** Symbol"
                    "#+begin_src j"
                    ,(first row)
                    "#+end_src"
                    "**** Name (monadic • dyadic)"))
    (insert-line string))
  (insert (if (second row)
              (second row)
            "N/A"))
  (insert " • ")
  (insert-line (if (third row)
                   (third row)
                 "N/A"))
  (insert-line "**** Dictionary entry")
  (insert-line (j-dictionary-url row)))

(defun j-insert-verb-flashcards ()
  "Iterate through the verbs defined in helm-j-cheatsheet and generate a
  flashcard for each one."
  (loop for row in jc-verbs do
        (j-insert-flashcard "Verb" row)))

(defun j-insert-adverb-flashcards ()
  "Iterate through the adverbs defined in helm-j-cheatsheet and generate a
  flashcard for each one."
  (loop for row in jc-adverbs do
        (j-insert-flashcard "Adverb" row)))

(defun j-insert-conjunction-flashcards ()
  "Iterate through the conjunctions defined in helm-j-cheatsheet and generate a
  flashcard for each one."
  (loop for row in jc-conjunctions do
        (j-insert-flashcard "Conjunction" row)))

(defun j-insert-other-flashcards ()
  "Iterate through the others defined in helm-j-cheatsheet and generate a
  flashcard for each one."
  (loop for row in jc-others do
        (j-insert-flashcard "Other" row)))

(defun j-flashcards ()
  "Generate J flashcards."
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
