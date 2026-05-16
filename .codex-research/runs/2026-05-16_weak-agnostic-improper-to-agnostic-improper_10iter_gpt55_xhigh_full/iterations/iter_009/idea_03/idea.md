# DCHP Generated-Bag Pollution

ID: idea_03

## Summary
Try to make rare-slice generated-bag pollution fully compatible with a DCHP-style bag generator. Specify key slices, stateful or stateless column scheduling, iid realization of hard rows, constants/offset columns, and show whether Set-Cover-hard sparse-majority bags can actually appear while each weak output remains OPT+beta valid.

## Why Promising
Generic sparse-majority ERM is hard only for arbitrary bags. This direction tests whether semantic weak correctness alone can also make generated bags selector-hard in black-box reductions.

## Risks
Actual DCHP query distributions may put too much mass on the programmed slices. Coupon/key accounting, confidence parameters, constants or offsets, extra generated columns, and T alignment may break the construction.

## Suggested Lenses
- black-box obstruction
- selector hardness
- construction audit
