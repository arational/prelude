(with-eval-after-load 'helm
  (defun my-helm-rdictcc ()
    (interactive)
    (helm :sources 'my-helm-rdictcc-source
          :buffer "*helm rdictcc*"))

  (defvar my-helm-rdictcc-source
    (helm-build-async-source "rdictcc"
      :candidates-process 'my-helm-rdictcc-process
      :candidate-number-limit 99
      :filtered-candidate-transformer 'my-helm-rdictcc-transformer
      :requires-pattern 3))

  (defun my-helm-rdictcc-process ()
    (let ((proc (start-process "rdictcc" helm-buffer "rdictcc" "-c" helm-pattern)))
      (set-process-sentinel
       proc
       (lambda (process event)
         (helm-process-deferred-sentinel-hook process event default-directory)))
      proc))

  (defun my-helm-rdictcc-transformer (candidates _source)
    (let (result)
      (dolist (candidate candidates)
        (when (string-match-p "=\\{20\\}\\[ [AB] => [AB] \\]=\\{20\\}" candidate)
          (add-face-text-property 0 (length candidate) 'font-lock-comment-face
                                  nil candidate))
        (push candidate result))
      (nreverse result))))
