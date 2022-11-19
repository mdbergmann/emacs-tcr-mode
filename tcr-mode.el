;;; package --- summary:
; Copyright: Manfred Bergmann

;;; Commentary:

;;; Code:

(make-variable-buffer-local
 (defvar tcr-mode))

(defvar-local git-commit-cmd "git commit -am 'TCR: test OK'")
(defvar-local git-reset-cmd "git reset --hard")

(defun tcr--execute-git-cmd (git-cmd)
  "Call the given GIT-CMD with 'shell-command."
  (message "calling: %s" git-cmd)
  (shell-command git-cmd))

(defun tcr-run-vcr-revert ()
  "Run a revert operation."
  (save-buffer)
  (message "TCR: running revert!")
  (tcr--execute-git-cmd git-reset-cmd))

(defun tcr-run-vcr-commit ()
  "Run a commit operation."
  (save-buffer)
  (message "TCR: running commit!")
  (tcr--execute-git-cmd git-commit-cmd))

(provide 'tcr-mode)
;;; tcr-mode.el ends here
