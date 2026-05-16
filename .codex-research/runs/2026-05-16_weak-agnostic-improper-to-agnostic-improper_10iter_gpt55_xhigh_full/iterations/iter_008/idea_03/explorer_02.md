## Summary

Selector-hard generated bags look plausible in a **black-box obstruction** sense. I found a clean way to make a semantically valid fixed-slack weak learner whose DCHP-style generated bag contains a Set-Cover-hard sparse-majority subbag. The mechanism is rare-slice programming: the learner is always equal to a trivial valid comparator except on a randomly chosen key slice, where it can implement arbitrary selector columns.

This does **not** give an atlas separation. The class can be the singleton constant class, hence strongly learnable by ignoring the weak learner. It does, however, seriously weakens any claim that “DCHP-generated bags” are automatically structured enough for a generic polynomial selector.

## Concrete Progress

The construction has three moving parts.

1. Use the existing Set-Cover sparse-majority gadget with a public `+1` constant column and `T=2k-1`. Set columns output `-1` on a dummy negative row and encode coverage on positive element rows. A zero-error `T`-wise vote exists iff there is a size-`k` set cover.

2. Build a keyed domain. For key `r` and selector column `j`, define
   $$
   h_{r,j}(x)=+1
   $$
   off slice `r`, and on slice `r` let it equal the desired hard column `j`.

3. Let the concept class be `C={+1}`. A weak learner chooses a random key `R`, chooses/programs a column index `j` from its input tuple, and outputs `h_{R,j}`. For any query distribution `Q`,
   $$
   \operatorname{err}_Q(h_{R,j})\le \operatorname{err}_Q(+1)+Q[X\text{ has key }R].
   $$
   Since `R` is uniform over `K` keys,
   $$
   \Pr_R[Q[\text{key }R]>\tau]\le \frac{1}{K\tau}.
   $$
   Choosing `K >= 1/(tau delta_0)` and `tau <= beta` makes this a valid `OPT_C+beta` weak learner with failure probability `delta_0`, uniformly over all distributions.

DCHP’s enumeration over all training subsequences can then be used to program many different `j`s. Put tagged programming examples in `S_1`; for each desired selector column, many enumerated tuples map to that column. With enough duplicates, one of the random seeds hits the special validation key `R*`, so the generated bag contains `h_{R*,j}` for every hard column with high probability. All columns with `R != R*` are just `+1` on the validation hard block, so they are harmless constant duplicates.

## Claims Or Lemmas

**Lemma 1: Rare-Slice Programmable Weak Learner.**  
For `C={+1}`, the learner above is semantically `OPT+beta` valid for any fixed `beta>0`, provided the random key space is large enough. The programmed column can depend arbitrarily on the sample tuple because validity is protected by rare slice mass, not by tuple rarity.

**Lemma 2: Generated-Bag Realization.**  
For any finite binary bag matrix `A` and labels `y`, there is a valid weak learner and a DCHP-style first-half sample `S_1` such that the generated bag contains a copy of `A` on a chosen validation slice, up to harmless `+1` duplicates, with high probability over learner seeds.

**Lemma 3: One-Sided Selector Hardness.**  
Even a selector that is only required to find a zero empirical-loss vote when one exists over generated bags would solve Set Cover, because the plus-constant gadget’s output can be verified. This avoids needing a two-sided approximation guarantee.

## Proof Attempts

The main proof attempt succeeds as a black-box construction. The key point is that this is stronger than mere “large range” junk: the bad columns are not only in `Range(A)`; they are actually inserted into the realized DCHP bag because the algorithm enumerates all sample subsequences.

The proof is not yet a complete lower bound for the exact DCHP algorithm because `T` must be aligned with the algorithm’s computed
`T = ceil(min{log n/theta^2, O(d*/theta^2)})`. For a standalone final selector primitive with `T` as input, the reduction is clean. For the literal DCHP parameter formula, one still needs a padding/tuning argument.

## Gaps And Risks

The construction is artificial and white-box removable. Since `C={+1}`, a strong learner can ignore the weak learner and output `+1`.

The sample arrangement is currently worst-case over `S_1,S_2`. Turning it into an iid distribution where the hard generated bag appears with high probability is plausible but not written.

The reduction attacks proper selection over `sign(B^(T))`. It says nothing against an unconstrained improper empirical learner, which could memorize validation labels.

The DCHP-generated bag may satisfy additional hidden promises in natural executions. This construction shows those promises do not follow from semantic weak correctness alone.

## Counterexamples Or Obstructions

A canonical or class-aware wrapper could strip rare-slice junk immediately in this singleton-class example.

A selector exploiting DCHP’s hidden clean-margin structure might avoid worst-case full-bag hardness, but that structure must be an explicit promise; it is not guaranteed for every generated bag of every valid weak learner.

If the final selector is allowed to output outside `sign(B^(T))`, the Set-Cover obstruction disappears.

## Sources Consulted

- Local run files: `problem.md`, all listed `working_notes/*.md`, and `iterations/iter_008/idea_03/idea.md`.
- Arthur da Cunha, Mikael Møller Høgsgaard, Andrea Paudice, “Sample-Near-Optimal Agnostic Boosting with Improved Running Time,” arXiv:2601.11265: https://arxiv.org/abs/2601.11265

## Recommended Next Steps

Formalize Lemmas 1-3 with exact parameters `K,tau,delta_0,m_0,M,L`.

Then resolve the `T`-alignment issue for the literal DCHP formula, or state the obstruction only for a standalone generated-bag selector primitive.

Finally, try an iid version where programming tags and hard validation rows appear with high probability, not just in a chosen sample.