# Prefix Notation Calculator in Racket

## 📘 Overview

This is a prefix-notation calculator implemented in Racket. It supports four operators:

- `+` (binary addition)
- `*` (binary multiplication)
- `/` (binary division with integer quotient)
- `-` (unary negation only)

Each time the user enters a valid expression, the result is:

- Evaluated and printed as a floating-point number using `real->double-flonum`
- Added to a history list (most recent result is first)
- Displayed with a history ID in the format:  
  `1: 5.0`, `2: -3.0`, etc.

The program runs in interactive mode by default and supports an `"exit"` command to quit gracefully.

---

## ▶️ How to Run

### 🔧 Requirements

- [Racket](https://racket-lang.org/) installed (DrRacket or command-line)

### 🖥️ Interactive Mode (default)

From the terminal or inside DrRacket, run:

```bash
racket main.rkt
```

You will see:

```bash
Enter a prefix expression starting with +,*,/ (binary) or - (unary), or type 'exit' to quit:
>
```

You can now type expressions like:

```bash
- 3 4 ; Output: 1: 7.0

* 5 ; Output: 2: -5.0

- 2 6 ; Output: 3: 12.0
  exit ; Exits the program

```

---

### 📂 Batch Mode (optional)

If run with the -b or --batch command-line argument, the prompt is suppressed and only results or error messages are printed.

Example:

```bash
racket main.rkt -b

```

Then enter expressions directly or from redirected input.
##📦 Features
Prefix notation support

Integer-only operations

Unary negation (-) only (no binary subtraction)

Input validation with helpful error messages

Divide-by-zero detection

History tracking using a list and cons

History output with ID and float conversion

Graceful exit via "exit"

### 👨‍💻 Author

Developed by Ananth Ram Tekkalakota

For CS4337 Pradigms Elmer Salzar Spring Semster of 2025
