## Summary

The coding-theory separation template has a serious model mismatch in its most direct form. For deterministic received words, strong **improper** agnostic learning of the codeword class does not solve nearest-codeword decoding: the learner is allowed to output the received word, or any predictor close to it, rather than a codeword.

The template becomes meaningful only in an RCN/sample model: if labels are fresh noisy evaluations of a planted codeword, then a strong agnostic improper learner at error `eta + epsilon` recovers the planted codeword as a predictor. That gives a plausible hardness route, but it is no longer classical nearest-codeword decoding; it is noisy sample-based codeword prediction, closer to LPN-style learning.

## Concrete Progress

A clean obstruction emerged:

**Explicit block-code obstruction.** If the coordinate domain has size `n = poly(s)`, then every concept class over that domain is efficiently strong agnostic improperly learnable. Ignore the code. Run ERM over all Boolean functions on the `n` coordinates, equivalently coordinate-wise empirical majority, and output a table. Since the class of all labelings has VC dimension `n`, this achieves Bayes risk plus `epsilon`, hence at most `OPT_C + epsilon`.

So NP-hardness of maximum-likelihood decoding for explicit codes cannot separate this atlas edge in the improper model.

For a code family to remain viable, its coordinate domain must be succinct or exponentially large, so tabulating the received word is impossible. But then the “decoder below radius `gamma`” required by the weak source must be a **sample-access, distribution-free, weighted low-noise learner**, not merely a classical full-word bounded-distance decoder.

## Claims Or Lemmas

**Lemma 1: Proper code learning equals weighted nearest-codeword; improper does not.**  
Let `C = {Enc(m): m in M}` over coordinates `X`, with distribution `mu` and deterministic labels `r(x)`. Then
`OPT_C = min_m Pr_mu[Enc(m)(X) != r(X)]`,
the weighted nearest-codeword distance. A proper strong learner would solve approximate weighted nearest-codeword. An improper learner may output any `h` close to `r`, so it need not reveal a message or codeword.

**Lemma 2: Strong improper RCN learning implies codeword prediction.**  
If `Y = c(X)N`, where `Pr[N=-1]=eta<1/2`, then for any `h`,
`err(h,Y) = eta + (1-2 eta) err(h,c)`.
Thus a strong agnostic learner returning `err(h,Y) <= eta + epsilon` gives
`err(h,c) <= epsilon/(1-2 eta)`.

**Lemma 3: Classical bounded-distance decoding is insufficient for the source.**  
A decoder that only promises “return some codeword within radius `gamma` when one exists” satisfies `OPT + beta`, with `beta=1/2-gamma`, only automatically when `gamma <= beta`, i.e. `gamma <= 1/4`. Otherwise it must return something near the weighted optimum, not merely below the threshold.

## Proof Attempts

I tested the standard nearest-codeword route against the atlas target. It fails: on a deterministic received word, the target learner can fit the received labels directly. Estimating the returned hypothesis’s error against the received word gives no lower bound on `OPT_C`, because an improper `h` may beat every codeword.

I then tested the RCN route. This one is structurally sound: a strong learner would recover the planted codeword predictor by Lemma 2. To turn that into decoding a message, one additionally needs either polynomial blocklength so we can evaluate `h` everywhere, or a local/global reconstruction procedure that converts oracle access to an approximate codeword into the message. But polynomial blocklength reintroduces the generic table-learning obstruction, so the useful case needs succinct huge-domain codes plus reconstruction.

I also checked known coding candidates. General linear codes and Reed-Solomon codes have relevant hardness results for maximum-likelihood/nearest-codeword decoding, but these are proper/full-word decoding hardness results. They do not directly constrain improper PAC prediction. Parity/Hadamard-style codes fit the huge-domain noisy-sample model, but then the low-noise weak source is already LPN-like hard.

## Gaps And Risks

The main missing object is very specific: a succinct code family with efficient distribution-free weak learning below `gamma`, but hard noisy prediction at some `eta > gamma`.

Classical coding thresholds do not provide this by themselves. Full-word unique decoding, list decoding, and soft-decision decoding assume access to the received block or reliabilities. PAC learning only has random labeled examples.

Weighted distribution-free decoding is also much stronger than uniform Hamming decoding. An arbitrary `mu` can focus on bad coordinate sets where usual code distance guarantees are irrelevant.

## Counterexamples Or Obstructions

The strongest obstruction is universal finite-domain improper learning: if `|X|` is polynomial, strong agnostic improper learning is trivial for every class.

A second obstruction is deterministic-label fitting. A received word is a deterministic labeling of coordinates. The improper learner’s best comparator is not restricted to codewords, so “hard nearest codeword” can coexist with “easy fit the labels.”

A third obstruction is fixed-word versus fresh-noise mismatch. Classical decoding fixes one corrupted block. RCN learning uses fresh label noise conditional on `X`. Lemma 2 applies to the latter, not automatically to a fixed corrupted word.

## Sources Consulted

Local run notes: `problem.md`, `canonical_summary.md`, `claim_ledger.md`, `lemma_bank.md`, `failed_attempts.md`, `counterexamples.md`, `literature_map.md`, `promising_directions.md`, `iteration_summaries.md`, and `iterations/iter_004/idea_03/idea.md`.

External sources: Berlekamp-McEliece-van Tilborg 1978 on NP-completeness of general decoding, https://authors.library.caltech.edu/records/aw9vs-ann16; Dumer-Micciancio-Sudan 2003 on hardness of minimum distance and nearest codeword, https://cseweb.ucsd.edu/~daniele/papers/DMS.html; Guruswami-Sudan 1999 list decoding, https://www.itsoc.org/publications/papers/improved-decoding-of-reed-solomon-and-algebraic-geometry-codes; Guruswami-Vardy 2005 RS maximum-likelihood decoding hardness, https://arxiv.org/abs/cs/0405005; Blum-Kalai-Wasserman 2003 on noisy parity/LPN and coding interpretation, https://www.microsoft.com/en-us/research/publication/noise-tolerant-learning-parity-problem-statistical-query-model/.

## Recommended Next Steps

Do not pursue explicit block-code nearest-codeword hardness as a separation for the improper atlas edge.

Refocus the coding route on succinct huge-domain codes and formulate the hard problem as RCN codeword prediction from random examples. The next useful test is: can any known code family be weakly learned at low constant noise in polynomial time while moderate-noise prediction remains conditionally hard? If not, record the coding template as a sharpened obstruction rather than a live separation path.