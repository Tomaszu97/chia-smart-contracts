;piggybank coin / piggybank smart contract
(mod (
    my_amount
    new_amount
    my_puzzlehash
  )

  (include condition_codes.clib)

  (defconstant TARGET_AMOUNT 500)
  (defconstant CASH_OUT_PUZZLE_HASH 0xdeadbeef ) ;payout wallet address

  (defun-inline cash_out (CASH_OUT_PUZZLE_HASH my_amount new_amount my_puzzlehash)
    (list
      (list CREATE_COIN CASH_OUT_PUZZLE_HASH new_amount)
      (list CREATE_COIN my_puzzlehash 0)
      (list ASSERT_MY_AMOUNT my_amount)
      (list ASSERT_MY_PUZZLEHASH my_puzzlehash)
      (list CREATE_COIN_ANNOUNCEMENT new_amount)
    )
  )

  (defun-inline recreate_self (my_amount new_amount my_puzzlehash)
    (list
      (list CREATE_COIN my_puzzlehash new_amount)
      (list ASSERT_MY_AMOUNT my_amount)
      (list ASSERT_MY_PUZZLEHASH my_puzzlehash)
      (list CREATE_COIN_ANNOUNCEMENT new_amount)
    )
  )

  ;main
  (if ( > new_amount my_amount)
    (if (> new_amount TARGET_AMOUNT)
      (cash_out CASH_OUT_PUZZLE_HASH my_amount new_amount my_puzzlehash)
      (recreate_self my_amount new_amount my_puzzlehash)
    )
    (x)
  )
)
