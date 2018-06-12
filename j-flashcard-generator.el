(require 'helm-j-cheatsheet)  ; Used for jc-valid-dictionary, jc-verbs, jc-adverbs, jc-conjunctions, jc-others
(require 'w3m)                ; Used to get rendered dictionary entry

(defun insert-line (string)
  (insert string)
  (insert "\n"))

(defun j-dictionary-entry (url)
  "Return rendered text of dictionary entry excluding links at
top and bottom."
  (save-excursion
    (w3m-browse-url url)
    ;; 2 seconds is enough to access a local copy of the dictionary using w3m on
    ;; my machine. If you download the docs using JQT package manager they'll
    ;; install locally. Then as part of your helm-j-cheatsheet setup you'll
    ;; customize the jc-local-dictionary-url. E.g.,
    ;; "file:///Applications/j64-806/addons/docs/help/dictionary"
    (sleep-for 2)
    (org-w3m-copy-for-org-mode)
    (with-temp-buffer
      (yank)
      (beginning-of-buffer)
      (re-search-forward "-------------------------------------------------------")
      (forward-line 1)
      (beginning-of-line)
      (let ((beg (point))
            (end))
        (re-search-forward "-------------------------------------------------------")
        (forward-line -1)
        (beginning-of-line)
        (setq end (point))
        (narrow-to-region beg end)
        ;; Indent one space to avoid any asterisks in column one rendering as an
        ;; org headline.
        (beginning-of-buffer)
        (while (re-search-forward "^" nil t)
          (goto-char (match-beginning 0))
          (when (looking-at "^")
            (replace-match " ")))
        (buffer-string)))))

(defun j-dictionary-url (row)
  "Get the dictionary URL for the given entry."
  (let ((url (format "%s/%s.htm" (jc-valid-dictionary) (fourth row))))
    url))

(defun j-insert-flashcard (type row)
  "Generate a flashcard of the given TYPE."
  (dolist (string `(,(format "*** %s               :drill:" type)
                    ":PROPERTIES:"
                    ":DRILL_CARD_TYPE: twosided"
                    ":END:"
                    "**** Symbol"
                    "#+begin_src j"
                    ;; Insert a space before so that asterisk at column one
                    ;; doesn't render as org headline, e.g., symbol 'times'.
                    ,(format " %s" (first row))
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
  (let ((url (j-dictionary-url row)))
    (insert-line url)
    (when (featurep 'w3m)
      (insert-line "#+begin_example")
      (insert-line (j-dictionary-entry url))
      (insert-line "#+end_example"))))

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
  (j-insert-other-flashcards)
  (w3m-close-window))
