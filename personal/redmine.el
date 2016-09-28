;;; effort-export.el --- Export Org clocking entries for Redmine

;; Copyright (C) 2016 Vasilij Schneidermann <v.schneidermann@gmail.com>

;; Author: Vasilij Schneidermann <v.schneidermann@gmail.com>
;; URL: https://dev.bevuta.com/wasa/effort-export
;; Version: 0.0.1
;; Keywords: org

;; This file is NOT part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING. If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; An exporter for Org clocking entries in a particular format.
;; Intended to be used with a corresponding CSV time entry importer
;; for Redmine, but can be adjusted for other uses.

;;; Code:

(require 'org-table)
(require 'org-element)

(defgroup effort-export nil
  "Org clocking entry exporter"
  :group 'org
  :prefix "ee-")

(defun ee-insert-org-table (headers rows)
  "Insert an Org table with given data.
HEADERS is a list of strings while ROWS is a list of lists of
strings."
  (insert "|")
  (dolist (header headers)
    (insert header "|"))

  (insert "\n|-\n")

  (dolist (row rows)
    (insert "|")
    (dolist (col row)
      (insert col "|"))
    (insert "\n"))

  (org-table-align))

(defun ee-export-as-csv (file headers rows)
  "Export given data to FILE as CSV.
See `ee-insert-org-table' for the types of HEADERS and ROWS."
  (with-temp-buffer
    (ee-insert-org-table headers rows)
    (goto-char (point-min)) ; HACK export requires point in table
    (org-table-export file "orgtbl-to-csv")))

(defvar ee-ticket-re (rx bos "#" (group (+ digit)))
  "Regular expression matching a ticket ID.")

(defcustom ee-time-entry-headers
  '("Issue" "Comments" "Activity" "spent_on" "Hours" "User")
  "CSV headers to use for export."
  :type '(repeat string)
  :group 'effort-export)

(defcustom ee-subtree-tag "redmine"
  "Tag to identify subtrees to be scanned."
  :type 'string
  :group 'effort-export)

(defun ee-find-tagged-subtrees (elements)
  "Finds tagged subtrees in ELEMENTS.
ELEMENTS is a tree as produced by `org-element-parse-buffer'."
  (org-element-map elements 'headline
    (lambda (element)
      (when (member ee-subtree-tag (org-element-property :tags element))
        element))
    nil t))

(defcustom ee-activities '("Other" "Research" "Design" "Development" "Review")
  "Known Redmine activities.  Can be used in tags."
  :type '(repeat string)
  :group 'effort-export)

(defcustom ee-default-activity "Development"
  "Default activity to pick if none specified."
  :type 'string
  :group 'effort-export)

(defcustom ee-user "liquid"
  "Redmine user name."
  :type 'string
  :group 'effort-export)

(defun ee-date-to-components (date)
  "Splits the string DATE into its number components."
  (mapcar 'string-to-number (split-string date "-")))

(defun ee-approximate-hours (time)
  "Round TIME in minutes to quarter hours."
  (/ (ceiling (* (/ time 60.0) 4)) 4.0))

(defun ee-extract-ticket-id (title)
  "Extracts the ticket ID from TITLE."
  (when (string-match ee-ticket-re title)
    (match-string 1 title)))

(defun ee-subtrees-to-ticket-headlines (subtrees)
  "Convert SUBTREES to ticket headlines."
  (org-element-map subtrees 'headline
    (lambda (headline)
      (let* ((title (org-element-property :raw-value headline))
             (id (ee-extract-ticket-id title)))
        (when id
          (org-element-put-property headline :ticket-id id))))))

(defun ee-clocks-to-times (clocks date-components)
  "Convert CLOCKS to durations matching DATE-COMPONENTS."
  (org-element-map clocks 'clock ; HACK we actually want filter-map
    (lambda (clock)
      (let* ((duration (org-element-property :duration clock))
             (value (cadr (org-element-property :value clock)))
             (year (plist-get value :year-start))
             (month (plist-get value :month-start))
             (day (plist-get value :day-start)))
        (when (equal (list year month day) date-components)
          (org-duration-string-to-minutes duration))))))

(defun ee-headline-activity (headline)
  "Extract specified or default activity for HEADLINE.
See also `ee-default-activity' and `ee-activities'."
  (let ((tag (car (org-element-property :tags headline))))
    (if (and tag (member (capitalize tag) ee-activities))
        (capitalize tag)
      ee-default-activity)))

(defun ee-flatten-1 (args)
  "Flattens ARGS once."
  (apply 'append args))

(defun ee-ticket-headlines-to-time-entries (headlines date)
  "Converts ticket HEADLINES to time entry headlines.
Results are limited to the string argument DATE."
  (ee-flatten-1
   (let ((date-components (ee-date-to-components date)))
     (org-element-map headlines 'headline
       (lambda (ticket-headline)
         (let ((id (org-element-property :ticket-id ticket-headline)))
           (org-element-map (org-element-contents ticket-headline) 'headline
             (lambda (headline)
               (let ((clocks (org-element-map (org-element-contents headline)
                                 'clock 'identity nil nil 'headline)))
                 (when (and id clocks)
                   (let* ((comment (org-element-property :raw-value headline))
                          (activity (ee-headline-activity headline))
                          (times (ee-clocks-to-times clocks date-components))
                          (minutes (apply '+ times))
                          (time (format "%.2f" (ee-approximate-hours minutes))))
                     (when times
                       (list id comment activity date time ee-user)))))))))))))

;;;###autoload
(defun ee-export-time-entries (file date)
  "Export time clocking entries from current buffer to FILE.
Results are limited to DATE."
  (interactive (list (read-file-name "Export to: ")
                     (org-read-date)))
  (let* ((elements (org-element-parse-buffer))
         (subtrees (ee-find-tagged-subtrees elements))
         (headlines (ee-subtrees-to-ticket-headlines subtrees))
         (time-entries (ee-ticket-headlines-to-time-entries headlines date)))
    (when (not subtrees)
      (user-error "No subtrees tagged with %s found" ee-subtree-tag))
    (ee-export-as-csv file ee-time-entry-headers time-entries)))

(provide 'effort-export)
;;; effort-export.el ends here
