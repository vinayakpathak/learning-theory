# Adaptive Public-Filter Barrier

ID: idea_03

## Summary
Formalize the adaptive public-filter information lemma in the random classification noise toy model. Include the selected filter in the transcript, charge raw samples and oracle outputs as mutual information about the hidden target, use the corrected KL transfer, and explicitly route low-OPT queries into hidden-target, public-witness, empirical/spike, and other-witness cases.

## Why Promising
The solver attempt has a clean algebraic identity showing that target-preserving filters beat the weak threshold only by correlating with the hidden target. Turning this into a rigorous adaptive toy theorem would clarify which positive strategies must leak target information.

## Risks
The model may remain too artificial to imply an atlas separation. Public constants, spike queries, artificial relabelings, and other concepts can still evade a hidden-target-noise argument.

## Suggested Lenses
- oracle lower bound
- information theory
- counterexample search
