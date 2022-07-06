(mod ()
  (defun decr (n) (- n 1))

  (defun countdown (n) 
    (if (= n 0)
      ()
      (c n (countdown (decr n)))
    )
  )

  ;(defun join_two (a b) (c a (c b ())))
  ;(join_two (q . ("b" . "c") ) "a")

  (countdown 5)
)
