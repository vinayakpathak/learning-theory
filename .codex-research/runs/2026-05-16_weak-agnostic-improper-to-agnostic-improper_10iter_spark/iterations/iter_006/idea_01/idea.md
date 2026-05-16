# Oracle-semantics compatibility audit for existing boosters

ID: idea_01

## Summary
Do a strict crosswalk from the atlas oracle (distribution-free, binary output, fixed excess `β`) to each candidate boosting theorem (KMV08, Feldman, potential-based): state theorem numbers, required weak condition, whether confidence/weights are returned, and whether final excess remains `OPT+α+ε` or can hit `OPT+ε`. End with a binary yes/no compatibility matrix.

## Why Promising
This can quickly convert the current uncertainty into a definitive blocker/proxy theorem and may either certify a near-complete positive route or force a precise negative frontier.

## Risks
Could stall if KMV08/Feldman/potential-based papers already give weaker assumptions that still fail exact conversion; extracting exact constants may show incompatibility rather than opportunity.

## Suggested Lenses
- theorem-by-theorem audit
- parameter translation
- complexity matching
