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

;; Main Loop

(define (main)
  (when prompt?
    (displayln "Enter a prefix expression starting with +,*,/ (binary) or - (unary):")
    (display "> ")
    (flush-output))
  
  (define input (read-line))
  (if (or (eof-object? input) (string=? input ""))
      (void)
      (with-handlers ([exn:fail?
                       (λ (e)
                         (displayln (string-append "Error: " (exn-message e)))
                         (main))])
        (define result (evaluate-prefix-expression input))
        (displayln (format "Result: ~a" result))
        (main))))


(main)
