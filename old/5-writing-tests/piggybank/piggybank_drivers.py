from pathlib                                    import Path
from typing                                     import List
from chia.types.blockchain_format.coin          import Coin
from chia.types.blockchain_format.sized_bytes   import bytes32
from chia.types.blockchain_format.program       import Program
from chia.types.condition_opcodes               import ConditionOpcode
from chia.util.ints                             import uint64
from chia.util.hash                             import std_hash
from clvm.casts                                 import int_to_bytes
import cdv.clibs                                as std_lib
from cdv.util.load_clvm                         import load_clvm

PIGGYBANK_MOD = load_clvm("piggybank.clsp","piggybank")

# create a piggybank
def create_piggybank_puzzle(amount, cash_out_puzzle):
    return PIGGYBANK_MOD.curry(amount, cash_out_puzzle)

# generate solution to contribute to a piggybank
def solution_for_piggybank(pb_coin, contribution_amount):
    return Program.to([pb_coin.amount, (pb_coin.amount + contribution_amount), pb_coin.puzzle_hash])

# return condition to assert the announcement
def piggybank_announcement_assertion(pb_coin, contribution_amount):
    return [ConditionOpcode.ASSERT_COIN_ANNOUNCEMENT, std_hash(pb_coin.name() + int_to_bytes(pb_coin.amount + contribution_amount))]
