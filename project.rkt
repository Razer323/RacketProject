#lang racket


(define prompt?
  (let [(args (current-command-line-arguments))]
    (cond
      [(= (vector-length args) 0) #t]
      [(string=? (vector-ref args 0) "-b") #f]
      [(string=? (vector-ref args 0) "--batch") #f]
      [else #t])))




(define (evaluate-plus-expression input)
  (define tokens (string-split input))
  (cond
    [(< (length tokens) 3)
     (error "Not enough arguments")]
    [(not (string=? (first tokens) "+"))
     (error "Operator must be +")]
    [else
     (define arg1 (string->number (second tokens)))
     (define arg2 (string->number (third tokens)))
     (if (and arg1 arg2)
         (+ arg1 arg2)
         (error "Invalid numbers"))]))



(define (main)
  (when prompt?
    (displayln "Enter a prefix expression followed by two numbers (e.g., + 1 2):")
    (display "> ")
    (flush-output))
  
  (define input (read-line))
  (if (or (eof-object? input) (string=? input ""))
      (void)
      (with-handlers ([exn:fail?
                       (λ (e)
                         (displayln (string-append "Error: " (exn-message e)))
                         (main))])
        (define result (evaluate-plus-expression input))
        (displayln (format "Result: ~a" result))
        (main))))



(main) ;