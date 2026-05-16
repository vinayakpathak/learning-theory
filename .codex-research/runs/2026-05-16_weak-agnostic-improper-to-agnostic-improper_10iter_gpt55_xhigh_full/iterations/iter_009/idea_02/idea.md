# Realized-Call DCHP Extraction

ID: idea_02

## Summary
Re-audit the da Cunha-Hogsgaard-Paudice proof with a strict separation between realized adaptive weak calls, hidden-clean population transfer, and final validation. Try to replace global Range(A)/dual-VC assumptions wherever possible using only realized-call union bounds and validation-independent finite lists of complete classifiers.

## Why Promising
Some capacity assumptions may be proof artifacts for final selection or PAC-call validity. Removing even one global range assumption would sharpen the best positive conditional theorem.

## Risks
The DCHP proof may genuinely need uniform control over exponentially many hidden-clean tuples, not just realized calls. The final selector and clean-population transfer bottlenecks may remain unchanged.

## Suggested Lenses
- proof extraction
- capacity audit
- positive reduction
