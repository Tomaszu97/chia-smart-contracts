(
  (defun digit_to_char (d) (+ 48 d))

  ;2 digits max
  (defun int_to_str (n)
    (concat "number: "
      (concat
        (digit_to_char ( f (divmod n 10)))
        (digit_to_char ( r (divmod n 10)))
      )
    )
  )
)
