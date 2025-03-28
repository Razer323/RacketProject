#lang racket

;; Prompt Setup 

(define prompt?
  (let [(args (current-command-line-arguments))]
    (cond
      [(= (vector-length args) 0) #t]
      [(string=? (vector-ref args 0) "-b") #f]
      [(string=? (vector-ref args 0) "--batch") #f]
      [else #t])))

;; Evaluate simple prefix expression  

(define (evaluate-prefix-expression input)
  (define tokens (string-split input))
  (cond
    [(null? tokens)
     (error "Empty input")]

    ;; "+" operator (binary)
    [(string=? (first tokens) "+")
     (if (< (length tokens) 3)
         (error "Not enough arguments for +")
         (let* ([arg1 (string->number (second tokens))]
                [arg2 (string->number (third tokens))])
           (if (and arg1 arg2)
               (+ arg1 arg2)
               (error "Invalid numbers for +"))))]

    ;; "*" operator (binary)
    [(string=? (first tokens) "*")
     (if (< (length tokens) 3)
         (error "Not enough arguments for *")
         (let* ([arg1 (string->number (second tokens))]
                [arg2 (string->number (third tokens))])
           (if (and arg1 arg2)
               (* arg1 arg2)
               (error "Invalid numbers for *"))))]

    ;; "/" operator (binary)
    [(string=? (first tokens) "/")
     (if (< (length tokens) 3)
         (error "Not enough arguments for /")
         (let* ([arg1 (string->number (second tokens))]
                [arg2 (string->number (third tokens))])
           (cond
             [(not (and arg1 arg2)) (error "Invalid numbers for /")]
             [(= arg2 0) (error "Divide by zero")]
             [else (quotient arg1 arg2)])))]

    ;; "-" operator (unary)
    [(string=? (first tokens) "-")
     (if (< (length tokens) 2)
         (error "Not enough arguments for -")
         (let ([arg (string->number (second tokens))])
           (if arg
               (- arg)
               (error "Invalid number for -"))))]

    [else
     (error "Unsupported operator (only +, -, *, / allowed)")]))

;; Main Loop With History

(define (main-loop history)
  (when prompt?
    (displayln "Enter a prefix expression starting with +,*,/ (binary) or - (unary), or type 'exit' to quit:")
    (display "> ")
    (flush-output))
  
  (define input (read-line))

  (cond
    [(or (eof-object? input) (string-ci=? input "exit"))
     (when prompt? (displayln "Exiting calculator...")) (void)]

    [else
     (with-handlers ([exn:fail?
                      (λ (e)
                        (displayln (string-append "Error: " (exn-message e)))
                        (main-loop history))])
       (define result (evaluate-prefix-expression input))
       (define new-history (cons result history))
       (define id (length new-history))
       ;; Convert to float and print with id
       (display id)
       (display ": ")
       (display (real->double-flonum result))
       (newline)
       (main-loop new-history))]))

;; Start with empty history
(define (main)
  (main-loop '()))

(main)
