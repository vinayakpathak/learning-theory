# Prove a polynomially stable filter-gap invariant

ID: idea_01

## Summary
Define a concrete residual-forcing filter family (e.g., adaptive rejection based on empirical residual sign + clipping) and prove a theorem: after each round t, every accepted distribution D_t satisfies explicit OPT_C(D_t) ≤ 1/2 - γ_t with γ_t ≥ 1/poly(n,1/ε), and acceptance mass(D_t) ≥ 1/poly(n,1/ε). If proved, instantiate a standard agnostic-boosting framework to obtain ε-accuracy from fixed β.

## Why Promising
This directly isolates the only blocked step in prior attempts and would turn the current conditional route into a complete theorem under a clearly stated wrapper family.

## Risks
May fail because the needed gap-preservation condition could be false for standard residual-based filters; proving a polynomial lower bound on mass may require assumptions absent from the target oracle model.

## Suggested Lenses
- conditional positive proof
- explicit invariant synthesis
- oracle semantics translation
