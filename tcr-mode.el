;;; package --- summary:
; Copyright: Manfred Bergmann

;;; Commentary:

;;; Code:

(make-variable-buffer-local
 (defvar tcr-mode))

(defvar git-commit-cmd "git commit -am 'TCR: test OK'")
(defvar git-reset-cmd "git reset --hard")

(defun execute-elixir-test ()
  "Call Elixir test."
  (let* ((test-cmd-args (list "mix" "test"))
         (call-args
          (append (list (car test-cmd-args) nil "TCR out" t)
                  (cdr test-cmd-args))))
    (message "calling: %s" call-args)
    (let* ((default-directory (locate-dominating-file default-directory "mix.exs"))
           (call-result (apply 'call-process call-args)))
      (message "test call result: %s" call-result)
      call-result)))

(defun execute-ocaml-test ()
  "Call OCaml test via 'dune'."
  (let* ((test-cmd-args (list "dune" "test"))
         (call-args
          (append (list (car test-cmd-args) nil "TCR out" t)
                  (cdr test-cmd-args))))
    (message "calling: %s" call-args)
    (let* ((default-directory (locate-dominating-file default-directory "dune-project"))
           (call-result (apply 'call-process call-args)))
      (message "test call result: %s" call-result)
      call-result)))

(defun execute-git-cmd (git-cmd)
  "Call the given GIT-CMD with 'shell-command."
  (message "calling: %s" git-cmd)
  (shell-command git-cmd))

(defun tcr-after-save-action ()
  "Here we call test and commit || revert."
  (message "after save action from TCR in: %s" major-mode)

  (let ((test-result (cond
                      ((string-equal "elixir-mode" major-mode)
                       (execute-elixir-test))
                      ((string-equal "tuareg-mode" major-mode)
                       (execute-ocaml-test))
                      (t (progn (message "Unknown mode!")
                                nil)))))

    (unless (eq test-result nil)
      (if (= test-result 0)
          (execute-git-cmd git-commit-cmd)
        (execute-git-cmd git-reset-cmd)))))

(defun tcr-execute ()
  (interactive)
  (save-buffer)
  (save-some-buffers)
  (tcr-after-save-action))

(define-minor-mode tcr-mode
  "TCR - Test && commit || Revert"
  :lighter " TCR"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-t c") 'tcr-execute)
            map))

(provide 'tcr-mode)

;;; tcr-mode ends here
