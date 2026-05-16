## Summary

The weighted-decoding idea gives a clean **conditional separation schema**, but I do not see a concrete represented class yet. The key refinement is that classical nearest-codeword or ML-decoding hardness is not enough for this PAC edge, because the target learner is **improper** and because finite explicit code domains are trivially agnostically learnable by memorization.

A real separation needs a succinct code family with:

1. efficient distribution-free **weighted low-radius decoding** below some radius;
2. hardness of **RCN prediction**, not merely proper nearest-codeword recovery, at a larger noise rate.

## Concrete Progress

For a binary code family `C_s subset {+-1}^{X_s}`, any distribution `D` induces weights `mu=D_X` and soft labels `a(x)=E[Y|X=x]`. For codeword `c`,

$$
err_D(c,Y)=\frac{1-\mathbb E_\mu[c(X)a(X)]}{2}.
$$

So the weak source is a weighted/soft nearest-codeword primitive over arbitrary coordinate distributions, not ordinary uniform Hamming decoding.

A useful conditional template is:

- pick constants `0 < gamma_w < r < eta < 1/2`;
- set `beta = 1/2 - gamma_w`;
- assume a polynomial weighted decoder that, whenever `OPT_C(D) < r`, returns a codeword or hypothesis with error at most `OPT_C(D)+tau`, with `tau <= beta`;
- otherwise use a majority constant.

Then if `OPT_C(D) >= gamma_w`, the majority constant has error at most `1/2 <= OPT_C(D)+beta`. If `OPT_C(D)<r`, the decoder handles it. This gives the fixed-slack weak learner, modulo sampling/certification details.

Conversely, if a strong agnostic learner existed and examples came from random classification noise

$$
Y=c^\star(X)N,\qquad Pr[N=-1]=\eta,
$$

then

$$
err_D(h,Y)=\eta+(1-2\eta)err_\mu(h,c^\star).
$$

Since `OPT_C(D) <= eta`, an `OPT+epsilon` learner would output `h` with

$$
err_\mu(h,c^\star)\le \frac{\epsilon}{1-2\eta}.
$$

Thus strong improper learning directly breaks RCN **prediction hardness** for the code family.

## Claims Or Lemmas

**Lemma 1: Low-Radius Weighted Decoder Implies Fixed Weak Learner.**  
With the margin/certification assumptions above, weighted decoding below `r > gamma_w` gives an `OPT + beta` weak learner for `beta=1/2-gamma_w`.

**Lemma 2: Strong Agnostic Learning Implies RCN Prediction.**  
For any code family, under RCN at rate `eta<1/2`, an `OPT+epsilon` improper learner outputs a hypothesis close to the transmitted codeword under the coordinate marginal, with error at most `epsilon/(1-2eta)`.

**Lemma 3: Explicit Finite Codes Cannot Separate.**  
If `|X|=N` is polynomial in the representation size and arbitrary table hypotheses are allowed, distribution-free agnostic improper learning is trivial in `poly(N,1/epsilon)`: ERM over all functions on `X` learns to Bayes error, hence to `OPT_C+epsilon`. Therefore classical length-`N` code hardness does not by itself give an atlas separation.

## Proof Attempts

General linear codes fail the source side: nearest-codeword/general decoding hardness is already present for ordinary linear codes, so there is no efficient distribution-free low-radius weighted decoder.

Reed-Solomon codes are the most tempting structured candidate because low-radius algebraic decoding is efficient and maximum-likelihood decoding is NP-hard. But this does not yet instantiate the PAC edge: known hardness is q-ary, proper/ML, worst-case received-word hardness, while the atlas target is binary, sample-based, and improper. Weighted distribution-free low-radius decoding is also stronger than standard unweighted unique decoding.

Hadamard/parity codes fail in the opposite way. They have strong list-decoding structure with query access, but random-example noisy parity is the LPN barrier; even low constant noise would already violate the required weak source.

## Gaps And Risks

The hard problem must be improper prediction under RCN, or else include a reduction from a close improper predictor `h` back to the transmitted codeword/message.

Uniform Hamming bounded-distance decoding is insufficient; the weak learner must work for arbitrary coordinate distributions and stochastic labels.

Classical NP-hard decoding inputs usually have code length as input size; then improper PAC learning can memorize the domain. A separation needs succinct/exponential coordinate domains or a cryptographic sample-access hardness assumption.

The decoder-to-weak-learner step needs a margin or certificate near the threshold `OPT = gamma_w`.

## Counterexamples Or Obstructions

A deterministic received word is not enough: an improper learner that approximates the received word need not identify the nearest codeword.

Finite explicit domains kill the separation by table learning.

Public handles or polynomial list decoding can also kill the separation: if the hard code family admits a polynomial candidate list at noise `eta`, validation selects the right candidate.

## Sources Consulted

Local: all requested `working_notes/*.md`, `problem.md`, and `iterations/iter_004/idea_03/idea.md`.

External:
- Berlekamp, McEliece, van Tilborg, “On the inherent intractability of certain coding problems” — https://authors.library.caltech.edu/records/aw9vs-ann16
- Arora, Babai, Stern, Sweedyk, “The Hardness of Approximate Optima in Lattices, Codes, and Systems of Linear Equations” — https://doi.org/10.1006/jcss.1997.1472
- Dumer, Micciancio, Sudan, “Hardness of approximating the minimum distance of a linear code” — https://cseweb.ucsd.edu/~daniele/papers/DMS.html
- Guruswami, Vardy, “Maximum-likelihood decoding of Reed-Solomon Codes is NP-hard” — https://arxiv.org/abs/cs/0405005
- Blum, Kalai, Wasserman, “Noise-Tolerant Learning, the Parity Problem, and the Statistical Query Model” — https://arxiv.org/abs/cs/0010022

## Recommended Next Steps

Formalize the conditional separation theorem with `gamma_w,r,eta,epsilon` and an explicit RCN prediction-hardness assumption.

Then audit Reed-Solomon or another algebraic code only against the strengthened checklist: binary encoding, arbitrary weighted low-radius decoding, succinct domain, and improper RCN prediction hardness.