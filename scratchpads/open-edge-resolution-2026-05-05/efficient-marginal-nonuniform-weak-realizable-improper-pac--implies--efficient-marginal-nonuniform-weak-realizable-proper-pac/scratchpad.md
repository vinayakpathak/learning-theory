# Open Edge Resolution Scratchpad

Edge: `efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-marginal-nonuniform-weak-realizable-proper-pac`

- date: 2026-05-05
- pass: first-pass open-edge resolution for this dated scratchpad
- verdict: unresolved-open
- confidence: medium-high that the atlas edge should remain open; medium that the currently known counterexample templates are genuinely blocked rather than merely unfinished

## Bottom Line

I do not have an atlas-ready proof or counterexample. Keep the edge

```text
efficient-marginal-nonuniform-weak-realizable-improper-pac
->
efficient-marginal-nonuniform-weak-realizable-proper-pac
```

as `status: "open"` with `evidence: unknown`.

The source gives one uniform weak realizable learner whose output may lie outside $\mathcal C$. For every fixed marginal $P$, the learner has a $P$-dependent polynomial runtime/sample bound and achieves error at most

$$
\frac12-\gamma_P(s)
$$

for some inverse-polynomial advantage $\gamma_P$.

The target asks for the same marginal-nonuniform weak guarantee but requires output $h\in\mathcal C$. The target concept itself is a zero-error proper hypothesis, so the issue is not statistical existence. The issue is whether one can efficiently find any proper weak handle. I found no generic properization lemma that follows from the source, and the checked false witnesses still miss the exact quantifiers of this weak marginal-nonuniform edge.

## Sources Checked

Local atlas notes:

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/README.md`, especially the finite encoded transcript convention for computational nodes.

Scratchpads checked:

- `scratchpads/open-edge-resolution-2026-05-04/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-04/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

Primary or near-primary external checks:

- Hanneke, Moran, and Thiessen, *Marginal-Nonuniform PAC Learnability*, OpenReview: https://openreview.net/forum?id=aoVCFtox89. Used for the quantifier pattern: rates may depend on the marginal, while the guarantee remains uniform over concepts for that marginal.
- Hastad and Khot, *Query Efficient PCPs with Perfect Completeness*, Theory of Computing: https://theoryofcomputing.org/articles/v001a007/. Used for the logarithmic-randomness perfect-completeness PCP with soundness below $1/2$.
- Khot and Saket, *Hardness of Minimizing and Learning DNF Expressions*, PDF/DOI metadata: https://cs.nyu.edu/~khot/papers/minDNF.pdf and https://doi.org/10.1109/FOCS.2008.37. Used for constant-advantage proper weak-learning hardness for small DNF variants.
- Kearns and Valiant, *Cryptographic Limitations on Learning Boolean Formulae and Finite Automata*, DOI/metadata: https://doi.org/10.1145/174644.174647 and https://www.mendeley.com/catalogue/95721061-146c-3bee-bb3d-f0a1c1ffbd55/. Used as the learning-theoretic cryptographic-hardness anchor.
- Hastad, Impagliazzo, Levin, and Luby, *A Pseudorandom Generator from any One-way Function*, DOI: https://doi.org/10.1137/S0097539793244708. Used as the standard one-way-function/PRG background.
- Schapire, *The Strength of Weak Learnability*, DOI/PDF: https://doi.org/10.1023/A:1022648800760 and https://www.schapire.net/papers/strengthofweak.pdf. Used to check that generic boosting improves accuracy by improper aggregation rather than projecting into $\mathcal C$.
- Targeted web searches for fixed-distribution proper weak PAC hardness and improper-to-proper properization lemmas. I found class-specific proper learning results and representation-dependent hardness background, but no theorem matching this abstract edge.

## Positive Route: Properization

Goal: given the source learner $A$, build a proper weak learner $B$ for the same class.

The obvious plan is:

1. run $A$ on realizable samples to get an external predictor $g$ with nontrivial $P$-correlation with the target $c$;
2. use $g$ and/or fresh samples to find some $h\in\mathcal C$ with nontrivial $P$-correlation with $c$.

Step 2 is the missing theorem. The fact that $c$ itself has zero error proves only existence. It does not give a polynomial-time search procedure for a represented concept, even with the polynomial allowed to depend on $P$.

The marginal-nonuniform quantifier is

$$
\forall P\ \exists p_P,\gamma_P\ \forall c.
$$

It gives a $P$-dependent analysis of one uniform algorithm. It does not give the learner $P$-specific advice, an enumeration of the useful trace of $\mathcal C$, a proper ERM oracle, or a projection from arbitrary predictors into $\mathcal C$.

Boosting is not the missing operation. Schapire/Freund boosting can turn weak realizable prediction into a strong predictor, but the boosted hypothesis is a vote or composition of weak hypotheses and is generally improper. The present edge does not ask for more accuracy; it asks for representation search.

The sample-only analog is also not enough. Finite VC or marginal-nonuniform sample control can justify proper ERM with unbounded computation. This edge is computational, and the known proper-hardness examples exist exactly because efficient improper prediction need not come with efficient proper search.

Conditional positive statement that would be useful but is not implied by the source:

> If every source-positive class admitted, for each fixed marginal $P$, an efficient weak proper selector from samples and an optional external predictor, then the edge would be true.

No checked source supplies such a selector under the abstract source assumption.

## Counterexample Route 1: PCP Active Slice

The local PCP active-slice class is the strongest non-cryptographic near miss.

For a fixed NP instance $\varphi$, examples are verifier-randomness points on the active slice for $\varphi$. Proper hypotheses encode proofs. Perfect completeness gives a proof accepted on every random string for satisfiable $\varphi$, while soundness below $1/2$ means no proof is accepted on more than half the random strings for unsatisfiable $\varphi$. A weak proper learner under the marginal uniform on this slice would distinguish the cases.

The source side is easy: the active slice has polynomial size because the verifier uses $O(\log |\varphi|)$ randomness, so an improper learner can memorize positive sampled points and predict $0$ elsewhere. The local atlas notes even record an agnostic improper lookup-table route.

Why it does not refute this edge:

- The hard marginal $P_\varphi$ depends on the input instance. In the marginal-nonuniform target, the allowed polynomial $p_{P_\varphi}$ and advantage $\gamma_{P_\varphi}$ may depend on that whole marginal, hence may depend arbitrarily on $\varphi$. A reduction from SAT no longer gets a uniform polynomial-time algorithm in $|\varphi|$.
- Packing all formula slices into one fixed marginal $P^\star$ dilutes the gap. If the $\varphi$ slice has mass $w_\varphi$, then a local constant PCP gap contributes only $O(w_\varphi)$ to global error/correlation. A fixed distribution cannot give inverse-polynomial mass to exponentially many formula slices of the same length. Low-mass slices can be ignored by a global weak learner.
- Removing the slice identity creates wrong-instance handles: unrelated satisfiable instances can supply all-accepting or high-acceptance proper proofs on a shared verifier-randomness space.

So PCP active slices separate distribution-free weak improper from weak proper learning, but they do not resolve the marginal-nonuniform weak properization edge.

## Counterexample Route 2: One-Way Image-Coordinate Witnesses

The ordinary one-way image-coordinate class is source-positive in a very strong way. For a target seed $s\in\{0,1\}^n$, the concept exposes the $n$ bits of $f(s)$ on a length-$n$ coordinate block. An improper learner can memorize observed positive atoms, and a sparse lookup-table ERM gives agnostic improper learning for nearby stronger sources.

The strong proper lower bound uses one fixed marginal with block masses

$$
\mu_k=\frac{6}{\pi^2 k^2}.
$$

At accuracy $\varepsilon_n=\mu_n/(3n)$, any proper seed hypothesis close to a length-$n$ target must have the same length and the same image; otherwise one wrong coordinate already costs too much. Given $y=f(s)$, the reduction can simulate labels and use a strong proper learner to recover $t$ with $f(t)=y$.

Why it does not refute this weak target:

- The weak target has no $\varepsilon$ input. It asks only for some hidden inverse-polynomial advantage over $1/2$.
- A wrong-length proper concept can ignore the active block. Against a length-$n$ sparse coordinate target, its error is roughly $\mu_n/2+\mu_m/2$, which is far below $1/2$ for large $n$ if $m$ is chosen with small block mass.
- Adding constants and singleton concepts makes this explicit: the weak-handle variant is weakly properly learnable, while strong proper learning under the fixed coordinate marginal still inverts the one-way function.

Thus one-way image-coordinate witnesses settle neighboring strong-proper edges but not this weak-proper edge.

## Counterexample Route 3: Balanced Or Hadamard Image Repairs

The best false lead is to replace sparse image coordinates by a dense code of the one-way image.

At a single fixed length, the cleanest version is:

$$
c_s(r)=\langle f(s),r\rangle \pmod 2,\qquad r\in\{0,1\}^n.
$$

Under the uniform length-$n$ marginal, an improper learner can recover the external image vector $y=f(s)$ by Gaussian elimination over samples and output the parity $r\mapsto\langle y,r\rangle$. Any proper seed $t$ with $f(t)\ne f(s)$ has exactly error $1/2$, so any positive weak proper advantage would invert $f$.

This is the right one-length geometry, but it is not an atlas-ready all-length fixed-marginal witness.

If each length gets a disjoint block, the block mass $\mu_n$ tends to zero and wrong-length/default agreement becomes a weak handle. If one imagines a common infinite product marginal, exact Walsh/Hadamard orthogonality would work, but examples are no longer finite encoded sample transcripts in the atlas sense. If one approximates the product marginal by finite strings with a length tail, the event that carries $n$ fresh random bits again has tail mass, and short examples create off-tail agreement handles.

Polynomial-length dense codes also do not obviously work. To rule out every non-inverting proper weak handle, residual correlations would need to be smaller than every inverse polynomial, because the target's $\gamma_P(s)$ is hidden and may have an arbitrary marginal-dependent exponent. Standard coding bounds near distance $1/2$ allow exponentially many messages over polynomially many coordinates only with some inverse-polynomial residual correlations. Those residual correlations may be enough for the target's weak advantage.

The current obstruction is therefore not just "use a better code." A valid dense cryptographic witness would need all of:

1. one fixed finite-encoded marginal with high-mass balanced measurements for every representation size;
2. a uniform efficient weak improper learner for every marginal;
3. a proof that finding any proper hypothesis with inverse-polynomial correlation under the fixed marginal yields a preimage or otherwise solves a standard hard search problem.

I did not find such a construction or source.

## Properization Lemmas Checked

The checked positive results are class-specific or sample-only, not generic enough for this edge.

- VC/marginal-nonuniform sample theory can support proper ERM when computation is unbounded.
- Full-support marginal uniformization controls the resource polynomial of a single learner under the atlas's finite-transcript convention, but it does not turn an improper output into a proper one and does not create a weak proper selector.
- Distribution-specific or Gaussian halfspace proper learners use halfspace and marginal geometry. They are evidence that properization can happen with extra structure, not that it follows from arbitrary improper weak PAC learning.
- Boosting and distribution-specific boosting improve accuracy or convert oracle guarantees, but their natural outputs are improper aggregates unless the class has special closure/projection properties.

So there is no checked lemma of the form

$$
\text{efficient marginal-nonuniform weak realizable improper}
\Rightarrow
\text{efficient marginal-nonuniform weak realizable proper}.
$$

## Proposed Atlas Update

No atlas update is justified by this pass, and no atlas files were edited.

Keep the current metadata shape:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

Optional body refinement if atlas edits are later allowed:

```markdown
`open`.

This is the weak marginal-nonuniform properization edge. The source gives a uniform learner with marginal-dependent weak advantage, but its output may be outside $\mathcal C$. A positive proof would need an efficient fixed-marginal weak proper selector or projection theorem; the existence of the target concept itself is not a computational search procedure.

Known false witnesses are near misses. PCP active-slice hardness separates the distribution-free weak proper target, but its hard marginal varies with the input instance, and packing all slices into one fixed marginal dilutes the weak gap. One-way image-coordinate witnesses force proper recovery only at strong accuracy; at the weak threshold, wrong-length, low-support, constant, singleton, or residual-code proper hypotheses can beat random guessing without inverting the one-way function. Dense Hadamard image repairs work at one fixed length but do not yet fit the atlas's single finite-encoded fixed marginal convention across all representation sizes.

Thus the edge remains open pending either a generic efficient weak properization theorem or a fixed-marginal weak proper hardness construction with no weak handles.
```

## Follow-Up Directions

1. Formalize a conditional positive lemma for classes with efficient fixed-marginal weak proper selectors, computable $L_1(P)$ covers by valid concepts, or approximate proper ERM.
2. Try to prove a finite-encoding no-go lemma for all-length Hadamard image witnesses: any fixed countable marginal either has heavy atoms/residual correlations or exposes fresh $n$-bit randomness only on a tail event.
3. Search for fixed-marginal proper weak hardness where the hard information is in target labels rather than the marginal, and where every inverse-polynomially correlated proper output yields a hard witness.
4. If using cryptography, look for a standard assumption stronger than one-wayness but weaker than "no correlated range element": the needed statement is hardness of finding any proper seed whose codeword has inverse-polynomial correlation with the hidden image under one fixed marginal.
5. Keep PCP active-slice and one-way weak-handle classes marked as non-witnesses for this exact edge unless the marginal/nonuniformity or weak-handle obstruction is removed.

## Final Verdict

`unresolved-open`.

Confidence: medium-high for keeping the current atlas edge open; medium for the stronger claim that no standard PCP/one-way/properization route can be made to work without a new idea.

---

## Depth 2 Follow-Up - Fixed-Marginal Weak-Handle Search, 2026-05-05

- depth: 2
- date: 2026-05-05
- verdict: unresolved-open
- confidence: medium-high that the edge should remain `open`; medium that the packed-PCP and Khot-Saket/DNF routes cannot be repaired without a new hardness ingredient
- changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`

### Goal

Try to build a false witness for

```text
efficient-marginal-nonuniform-weak-realizable-improper-pac
->
efficient-marginal-nonuniform-weak-realizable-proper-pac
```

with one fixed hard marginal $P^\star$. The desired witness should have weak
improper handles, but no efficiently findable weak proper handles, under the
same fixed marginal. In particular, the hard information should not live in a
formula-dependent marginal $P_\varphi$, because marginal nonuniformity allows
the target's polynomial and weak advantage to depend on that marginal.

### Sources Rechecked

Local notes:

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`

External hooks:

- Håstad and Khot, *Query Efficient PCPs with Perfect Completeness*, Theory of Computing 2005, https://theoryofcomputing.org/articles/v001a007/. Used for perfect completeness, logarithmic randomness, and soundness below $1/2$.
- Khot and Saket, *Hardness of Minimizing and Learning DNF Expressions*, FOCS 2008, https://cs.nyu.edu/~khot/papers/minDNF.pdf and DOI metadata https://doi.org/10.1109/FOCS.2008.37. Used for the constant-advantage lower bound for learning two-term DNF by fixed-term DNF hypotheses.
- Pitt and Valiant, *Computational Limitations on Learning from Examples*, JACM 1988, https://doi.org/10.1145/48014.63140. Used as the representation-dependent proper/improper DNF background.
- Mahaney, *Sparse Complete Sets for NP*, JCSS 1982 / DOI pointer https://doi.org/10.1137/0208034. Used only as a warning sign for attempts to make only polynomially many PCP slices per length carry inverse-polynomial mass.

### Packed PCP Attempt

The direct fixed-marginal version would choose

$$
P^\star(\varphi,r)=w_\varphi U_\varphi(r),
$$

where $U_\varphi$ is uniform over the verifier randomness for the active slice
of $\varphi$. A proper concept $(\psi,\pi)$ behaves like the PCP verifier on
the $\psi$ slice and is inactive elsewhere.

This keeps the improper source plausible. For each target slice, the positive
region has polynomial size because the verifier has $O(\log |\varphi|)$
randomness, so a lookup-style improper learner can memorize sampled positive
points and predict $0$ elsewhere.

The lower bound still fails at the weak fixed-marginal level. If the local PCP
gap is a constant $\Delta>0$, then the contribution to global correlation is
only $w_\varphi\Delta$. To force a weak proper learner with hidden advantage
$\gamma_{P^\star}(s)\ge s^{-a}$ to solve the $\varphi$ slice, one needs roughly

$$
w_\varphi \gtrsim s^{-a}.
$$

But at a fixed formula length there are exponentially many possible formulas.
Only polynomially many slices can all have inverse-polynomial mass under one
probability distribution. Most slices are therefore too light, and a global
weak learner may ignore them.

There is also an explicit weak-handle leak. For a target active on a low-mass
slice $\varphi$, a wrong-slice proper hypothesis $(\psi,\pi')$ is almost zero
on the target slice and only creates false positives on the $\psi$ slice. If
$w_\varphi+w_\psi$ is small, its global error is far below $1/2$ without
revealing any proof for $\varphi$. Thus packing does not merely weaken the
reduction; it creates legal weak proper outputs.

Could one put inverse-polynomial mass only on a sparse hard subfamily? That
would require the reduction from arbitrary SAT instances to land in only
polynomially many heavy slices per length. This is the sparse-hard-set problem
in disguise. Mahaney's theorem is not a formal no-go for every randomized or
promise formulation, but it is a serious warning that the obvious NP-hard PCP
packing route is trying to make an NP-complete family sparse enough to carry
large fixed marginal mass.

Could one add a large common balancing slice so every target remains near
balanced globally? I do not see how to do this while preserving the source. If
the balancing labels encode proof- or instance-specific data on a large domain,
lookup/memorization no longer gives a uniform improper learner. If the
balancing labels are easy enough for the improper learner to learn for every
marginal, they tend to become weak handles for proper hypotheses as well.

### Khot-Saket / DNF Attempt

The Khot-Saket theorem has the right representation flavor. For any fixed
positive integer $t$ and any fixed constant $\varepsilon>0$, assuming
$\mathrm{NP}\nsubseteq\mathrm{RP}$, two-term DNF cannot be PAC learned by
$t$-term DNF hypotheses to accuracy $1/2+\varepsilon$. Setting $t=2$ gives a
proper-looking obstruction, while Pitt-Valiant-style improper hypotheses give a
stronger source-positive story for fixed-term DNF than this edge needs.

The mismatch is quantitative and distributional.

First, the atlas weak target only asks for inverse-polynomial advantage under
the fixed marginal:

$$
\operatorname{err}_{P^\star}(h,c)\le \frac12-\gamma_{P^\star}(s),
\qquad
\gamma_{P^\star}(s)\ge s^{-a(P^\star)}.
$$

Khot-Saket rules out constant advantage for fixed $t$; it does not rule out
all inverse-polynomial advantages. This is not a cosmetic gap. A theorem
excluding $1/\operatorname{poly}(s)$ proper advantage for two-term DNF under
the usual PAC model would already be much closer to resolving the broader weak
properization edges, and that is not what the checked statement supplies.

Second, the Khot-Saket hard distributions are reduction-instance dependent.
If the marginal is $P_I$ for a Label-Cover/SAT-derived instance $I$, the
marginal-nonuniform target may hide arbitrary dependence on $I$ inside
$p_{P_I}$ and $\gamma_{P_I}$. That gives no uniform polynomial-time
contradiction.

Packing the Khot-Saket distributions into one $P^\star$ reintroduces the same
slice-weight problem as PCPs: a local constant inapproximability gap is
multiplied by the packed instance weight. Encoding the instance only in labels,
as in the clause-satisfaction fixed-marginal agnostic witness, also does not
directly work for this realizable proper target. The known DNF reduction uses
instance-specific tests/distributions to make yes instances realizable by a
small DNF and no instances uncorrelated with every fixed-term DNF. I do not
see a single universal marginal on which arbitrary input instances can be
encoded in labels while preserving a small-DNF realizable yes case and a
fixed-term-DNF weak lower bound.

### Interim Diagnosis

The right false witness cannot simply make weak handles nonexistent. Under one
fixed finite-encoded marginal, pure geometric exclusion of all wrong proper
hypotheses either needs too much coordinate space or leaves residual
inverse-polynomial correlations, and those correlations may be enough for the
hidden weak target advantage.

The more plausible target is computational weak-handle hardness:

1. weak proper handles may exist under $P^\star$;
2. finding any inverse-polynomially correlated proper handle should decode an
   NP-hard or cryptographic witness;
3. an improper learner should still have an efficient external handle under
   every marginal.

None of the checked PCP, clause, DNF, one-way-coordinate, or Hadamard-code
templates currently satisfies all three items. PCP and DNF hardness put the
hard instance in the marginal or in too many packed slices. One-way coordinate
classes put the hard object in the target labels under one fixed marginal, but
their sparse geometry leaks easy weak proper outputs. Dense image codes remove
some weak handles at one length, but all-length fixed finite marginals bring
back dilution, wrong-length/default handles, or coding residuals.

### Depth-3 Directions

1. **Parameterized DNF hardness.** Check whether any Khot-Saket follow-up gives
   proper hardness for two-term DNF by two-term or fixed-term DNF at
   $1/2+1/\operatorname{poly}(n)$ accuracy, with polynomial-size reductions.
   If yes, re-evaluate fixed-term DNF as a witness. If no, record the constant
   advantage barrier explicitly.

2. **Universal-marginal DNF tests.** Try to express the DNF hardness reduction
   over one fixed test distribution, with the input instance encoded only in
   labels, while keeping yes labels realizable by a two-term DNF. The key test
   is whether no-instances still rule out every fixed-term DNF weak handle at
   inverse-polynomial scale.

3. **Sparse packed-PCP lemma.** Formalize the counting obstruction: if a fixed
   marginal gives every challenged length-$n$ instance slice mass at least
   $n^{-a}$, then only polynomially many slices per length can be challenged.
   State precisely what kind of sparse/promise hardness assumption would be
   needed to make that useful.

4. **Computational weak-handle search.** Look for a fixed marginal where proper
   weak handles provably exist but any polynomial-time method for finding one
   decodes a hard witness. This is different from the current dense-code goal
   of forcing every wrong handle to have nonpositive correlation.

5. **Positive selector boundary.** In parallel, formulate the conditional
   positive lemma: if the class admits an efficient fixed-$P$ weak proper
   selector from samples plus an optional improper predictor, then the edge is
   true. This will make any future false witness prove failure of exactly that
   selector.

### Final Depth-2 Verdict

No atlas-ready proof or counterexample was found. Keep the edge `open` with
`evidence: unknown`.

---

## Depth 3 Follow-Up - Goldreich-Levin Code-Tower Witness Audit, 2026-05-05

- depth: 3
- date: 2026-05-05
- verdict: unresolved-open
- confidence: medium-high that this code-tower route is not atlas-ready; medium that the edge itself should remain open rather than true
- changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`

### Goal

Audit the most direct cryptographic/code-based route left by depth 2:
use a dense code so that an improper learner can recover an external code
message from examples, while any proper weak hypothesis under one fixed
marginal must recover hidden one-way structure.

The tested template is a Goldreich-Levin/Hadamard-style replacement for the
sparse one-way image-coordinate witness. At one fixed length, this template is
very clean. The obstruction is making it work for all representation sizes
under one fixed finite-encoded marginal without leaking weak proper handles.

### Sources Rechecked

Local notes:

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/witnesses/pseudorandom-function-classes.md`

External anchors:

- Goldreich and Levin, *A Hard-Core Predicate for all One-Way Functions*,
  https://www.cs.bu.edu/fac/lnd/pdf/hard.pdf. Used for the theorem shape:
  a predictor with noticeable correlation for $\langle x,p\rangle$ from
  $(f(x),p)$ can be converted into an inverter/list-recoverer for $x$.
- Goldreich, Goldwasser, and Micali, *How to Construct Random Functions*,
  https://www.wisdom.weizmann.ac.il/~oded/ggm.html and DOI
  https://doi.org/10.1145/6490.6503. Used as the standard PRF source when
  replacing one-way images by keyed pseudorandom blocks.
- Hastad, Impagliazzo, Levin, and Luby, *A Pseudorandom Generator from any
  One-Way Function*, https://doi.org/10.1137/S0097539793244708. Used only as
  the standard one-way-to-pseudorandomness background already present in the
  atlas.
- McEliece, Rodemich, Rumsey, and Welch, *New Upper Bounds on the Rate of a
  Code via the Delsarte-MacWilliams Inequalities*,
  https://authors.library.caltech.edu/records/3mas1-6h321. Used as a coding
  limitation reference near distance $1/2$.
- Guruswami and Vadhan, *A Lower Bound on List Size for List Decoding*,
  https://salil.seas.harvard.edu/publications/lower-bound-list-size-list-decoding.
  Used for the warning that near-$1/2$ list-decoding with small lists has
  unavoidable quantitative limits.

### One-Length Construction That Works

Fix a length-preserving one-way function $f:\{0,1\}^n\to\{0,1\}^n$ and a
single marginal $U_n$ over $r\in\{0,1\}^n$. For a target seed $s$, let
$y=f(s)$ and define

$$
c_s(r)=\langle y,r\rangle \pmod 2.
$$

The improper learner is easy. From labeled examples $(r,\langle y,r\rangle)$
it solves linear equations over $\mathbb F_2$ and outputs the parity vector
$y$, whether or not $y$ is represented by an actual seed in the concept class.
This is even a strong improper learner for the one fixed length and uniform
marginal.

The proper weak lower bound is also clean at this one length. A proper
hypothesis indexed by $t$ computes $\langle f(t),r\rangle$. Under $U_n$, two
distinct parity vectors have exactly zero correlation. Hence any proper
hypothesis with error below $1/2$ must satisfy

$$
f(t)=f(s),
$$

so it gives a preimage of the one-way challenge.

This is the desired geometry: improper prediction learns the image $y$, while
proper weak prediction recovers a seed. Unfortunately, this is only a
length-specific witness. The atlas edge needs one concept class and one fixed
hard marginal across all representation sizes.

### Goldreich-Levin Gives A Dichotomy, Not A Witness

The tempting move is to invoke Goldreich-Levin directly by labeling examples
with

$$
\langle s,r\rangle
$$

instead of $\langle f(s),r\rangle$. Then any weak predictor for the hidden
preimage bits from $(f(s),r)$ would indeed recover hidden structure.

But that destroys the improper/proper separation in this PAC setting. The
learner is not merely given $f(s)$; it receives labeled examples
$(r,\langle s,r\rangle)$. Gaussian elimination recovers enough linear
information about $s$ to output a consistent seed when one is needed. Under
low-rank marginals, any seed in the consistent affine subspace has the same
labels on the support. Thus the same linear algebra that makes improper
learning easy also makes proper learning easy.

So the code message must be the image $y=f(s)$, not the preimage $s$, if the
construction is to separate improper from proper learning. Once the message is
$y$, Goldreich-Levin no longer says that every partial or weak correlation
with the code recovers $s$. At one length exact Hadamard orthogonality forces
$f(t)=y$; in all-length repairs, partial image sketches can become legal weak
handles without inverting $f$.

### All-Length Repair 1: Disjoint Blocks

Put mass $\mu_n$ on a length-$n$ Hadamard block and let a length-$n$ seed be
active only on that block. This inherits the one-length lower bound locally.
It fails globally for the same reason as the sparse coordinate witness.

If a target lives on block $n$, a wrong-length seed $t$ can agree with the
target on the large inactive complement. Its error is roughly the error on the
target block plus the false-positive mass on its own block, of order

$$
\frac{\mu_n}{2}+\frac{\mu_m}{2}.
$$

For large $n,m$, this is far below $1/2$. Thus wrong-length concepts are
already weak proper handles. Increasing the local code density fixes sparse
coordinate leakage inside a block, but not inactive-complement agreement
between blocks.

### All-Length Repair 2: Universal Hash Or Code Tower

The next repair is to make every seed label every block. For example, block
$k$ could contain Hadamard tests of a public sketch $H_k(f(s))$, so that

$$
c_s(k,r)=\langle H_k(f(s)),r\rangle.
$$

An improper learner can plausibly recover the sketches that matter under a
given marginal by linear algebra. The problem moves to proper weak handles.
For a fixed finite-encoded marginal, the early or short tests carry some fixed
mass. A proper learner can use samples to recover a short sketch of the hidden
image and then search for any seed $t$ whose image matches that short sketch.
If the sketch has $O(\log |s|)$ bits, random trial finds such a $t$ in
polynomial time, and the matched high-mass sketch gives a weak proper
advantage without inverting $f$.

Making every useful sketch longer only pushes the advantage onto lower-mass
tail tests. The target's weak advantage may have an arbitrary
marginal-dependent inverse-polynomial exponent, so a tail advantage is still
allowed if it is inverse-polynomial. If the tail is made smaller than every
inverse polynomial, it can no longer force failure of the marginal-nonuniform
weak target.

This is the same fixed-marginal pressure in another form: finite examples can
only query finitely much of an all-length object, and any fixed distribution
must decide which finite sketches are visible at inverse-polynomial mass.
Visible short sketches are searchable; invisible long sketches do not enforce
a weak lower bound.

### All-Length Repair 3: General Error-Correcting Codes

A more abstract code might try to replace exact Hadamard orthogonality by a
list-decoding statement:

> If a proper codeword has inverse-polynomial correlation with the hidden
> image codeword under $P^\star$, then the hidden image is in a short list and
> can be recovered.

This is not currently atlas-ready. To rule out the target, the construction
must exclude every inverse-polynomial weak proper handle, with the polynomial
exponent unknown in advance. Polynomial-coordinate binary codes with
exponentially many messages cannot make all wrong-codeword correlations
smaller than every inverse polynomial; near distance $1/2$, the Plotkin,
linear-programming, and list-size bounds are exactly the warning signs. Any
remaining inverse-polynomial residual correlation is potentially enough for
the target, and if it is supported on polynomially many coordinates it can be
validated with polynomially many samples.

Using a superpolynomial or atomless coordinate space revives the one-length
Hadamard dream, but it leaves the atlas's finite encoded transcript model. In
that model, samples are finite strings and a learner's runtime is a pathwise
polynomial on those strings. Infinite product coordinates would need a schema
change before they could serve as witnesses here.

### What Would Be Needed For A False Witness

The right missing assumption is not merely "one-way functions exist." It is a
fixed-marginal approximate range-recovery hardness statement:

> Given $y=f(s)$, it is hard to find any seed $t$ whose public codeword
> $C(f(t))$ has inverse-polynomial positive correlation with $C(y)$ under one
> fixed finite-encoded marginal $P^\star$.

Standard one-wayness gives hardness of finding $t$ with $f(t)=y$. It does not
rule out finding $t$ that matches a short public sketch of $y$, and such a
short-sketch match is exactly what the all-length code towers tend to expose.
PRF assumptions rule out prediction on fresh pseudorandom coordinates, but
then the improper source learner also loses its easy linear-algebra handle
unless additional nonproper code structure is supplied.

Thus this depth-3 pass does not produce a conditional counterexample. It
does, however, sharpen the search target: a successful cryptographic witness
must make improper weak prediction easy by revealing an efficiently learnable
external message, while making every efficiently findable proper weak
correlate amount to approximate range recovery under the fixed marginal.

### Depth-4 Directions

1. **Formalize the Goldreich-Levin dichotomy.** Preimage-coded Hadamard labels
   make Goldreich-Levin applicable but make proper learning easy by Gaussian
   elimination. Image-coded labels keep the proper-recovery barrier but lose
   Goldreich-Levin protection against partial image-sketch handles.

2. **Define approximate range recovery.** Look for standard assumptions or
   known primitives implying that, given $y=f(s)$, finding any $t$ with
   $C(f(t))$ inverse-polynomially correlated with $C(y)$ is hard for a public
   code $C$ and fixed marginal $P^\star$. If this is nonstandard, record it as
   too bespoke for atlas metadata.

3. **Prove or refute a finite-sketch leakage lemma.** For universal code
   towers over finite encoded examples, try to show that every
   inverse-polynomial-mass visible sketch either is short enough for random
   preimage search or has too little mass to enforce the weak lower bound.

4. **Separate source learnability from PRF hardness.** A PRF block gives a
   credible target lower bound, but only after an arbitrary-marginal improper
   weak learner is proved. Dense pseudorandom labels alone are source-negative.

5. **Check atomless/product-marginal variants only as model-boundary notes.**
   If the atlas ever allows infinite random strings or oracle-valued examples,
   the all-length Hadamard construction should be revisited. Under current
   finite-transcript conventions it remains diagnostic rather than a witness.

### Final Depth-3 Verdict

No atlas-ready proof or counterexample was found. The edge should remain
`open` with `evidence: unknown`.

---

## Depth 4 Follow-Up - Trace Selectors And Fixed-Marginal Code Geometry, 2026-05-05

- depth: 4
- date: 2026-05-05
- verdict: unresolved-open
- confidence: medium-high that the edge should remain `open` under the current atlas semantics; high that pure fixed-marginal code geometry cannot remove wrong-length handles on finite encoded examples; medium that a semantics change to per-marginal advice would make the weak proper target much easier
- changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`

### Goal

Follow the depth-3 diagnosis in two directions:

1. check whether the marginal-nonuniform weak improper source actually implies
   the weak proper marginal target by a generic theorem under the current
   semantics;
2. check whether a fixed-marginal hardness construction can avoid the
   wrong-length or short-sketch handles that broke the Hadamard/Goldreich-Levin
   route.

### Sources And Semantics Rechecked

Local notes:

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/README.md`, especially the one-learner convention and the pathwise
  finite-transcript resource convention for computational nodes.
- `atlas/arguments/properization-open.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/witnesses/unrestricted-labelings.md`

External anchor:

- Hanneke, Moran, and Thiessen, *Marginal-Nonuniform PAC Learnability*,
  OpenReview/PDF, https://openreview.net/forum?id=aoVCFtox89. Rechecked the
  quantifier order: one learning algorithm, marginal-dependent constants, and
  uniformity over concepts for the fixed marginal. Also rechecked that their
  trichotomy is sample/statistical rather than a computational properization
  theorem.

### Theorem Route: A Near-Positive Trace Selector

There is a tempting fixed-marginal selector argument.

Fix a countably supported marginal $P$. Choose a finite set $F_P$ with
$P(F_P)>3/4$. For every label trace on $F_P$ that is realized by some concept
in $\mathcal C$, choose one proper representative realizing that trace. This is
a finite menu. If a learner could search that menu, then for every target
$c\in\mathcal C$ it would find a proper hypothesis agreeing with $c$ on
$F_P$, hence having error at most $P(X\setminus F_P)<1/4$. This gives a
constant weak advantage, and it does not use the improper source at all.

This proves useful conditional statements:

- If $P$ has explicitly known finite support and the learner has an efficient
  proper consistency/search routine on that support, then weak proper learning
  is immediate.
- If the model allowed per-marginal advice, one could advise the finite trace
  menu for $F_P$, again making the target trivial for that $P$.
- If running time were ignored, unbounded ERM over the proper class recovers
  the sample-only proper target, in the same spirit as the existing
  sample-complexity equivalence notes.

But this is not an atlas proof for the computational edge. The current
definition does not give the learner $P$-specific advice, and the learner is
one uniform algorithm. A finite trace menu may be arbitrarily far out in the
representation enumeration, even when all traces are realized by tiny targets
on other marginals. A marginal-dependent polynomial bound may analyze a
uniform algorithm, but it does not insert a $P$-dependent table into the code.

The pathwise finite-transcript convention makes the stopping issue sharper. An
algorithm that dovetails until it happens to find and validate the hidden menu
has no deterministic polynomial time bound unless it has a uniform stopping
certificate. Validation can give high-probability evidence that a candidate is
good, but it does not tell the learner that all relevant trace representatives
have been searched. This is exactly the missing fixed-marginal weak proper
selector.

So the theorem route currently gives only a conditional positive lemma:

> If the source class admits a uniform polynomial-time procedure that, for each
> fixed marginal $P$, finds a proper representative for every high-mass
> realizable finite trace of $P$, then the edge is true.

The source assumption alone does not supply that selector. The Hanneke-Moran-
Thiessen marginal-nonuniform trichotomy is consistent with this diagnosis: it
is a statistical rate theorem for arbitrary domains and does not provide a
polynomial-time proper search procedure.

### Fixed-Marginal Code Geometry: Why Wrong-Length Handles Reappear

The strongest way to avoid wrong-length handles would be to abandon disjoint
blocks and put every proper concept into one shared balanced code under a fixed
hard marginal $P^\star$. Then a wrong length would no longer agree for free on
an inactive complement.

For finite encoded examples, this pure geometry route runs into an atom/Gram
barrier. Suppose $P^\star$ is countably supported and let

$$
a=\max_x P^\star(x)>0.
$$

Represent concepts by $\{\pm1\}$-valued codewords, and ask for every distinct
pair to have nonpositive correlation under $P^\star$:

$$
\langle f,g\rangle_{P^\star}=\mathbb E_{P^\star}[f(X)g(X)]\le 0.
$$

Among any $M$ codewords, at least $M/2$ agree on the largest atom $x_0$. For
two such codewords, the atom contributes $+a$. To make the total correlation
nonpositive, the restriction to $X\ne x_0$ must have normalized inner product
at most

$$
-\frac{a}{1-a}.
$$

A Hilbert-space simplex bound says that unit vectors with pairwise inner
product at most $-\eta$ have size at most $1+1/\eta$. Thus the agreeing
subfamily has size at most $1/a$, and the whole weak-safe family has size at
most $2/a$. The same calculation gives a finite bound for pairwise correlation
at most any $\rho<a$.

Therefore no countable fixed-marginal code can make infinitely many
lengths/seeds all mutually weak-safe by geometry alone. A sufficiently large
proper family must contain wrong-length or wrong-seed codewords with positive
correlation under $P^\star$. This formalizes the depth-3 intuition: disjoint
blocks leak inactive-complement handles, while shared blocks leak atom/Gram
handles.

This does not by itself prove the target true. It only says a false witness
cannot rely on the statement "all wrong proper hypotheses have nonpositive
correlation." A future false witness would need computational weak-handle
hardness: correlated wrong proper hypotheses may exist, but finding any one of
them from samples should decode a hard witness.

Atomless product marginals evade the largest-atom argument and can support
Walsh/Hadamard-style infinite orthogonality. But that moves the construction
outside the finite-encoded computational witness regime used by the current
scratchpads. It is a model-boundary variant, not an atlas-ready fixed-marginal
construction.

### Different Hardness Families

The usual alternatives do not currently repair the gap.

PCP/DNF packing still puts too little mass on most hard instances once there
is one fixed marginal. Giving every instance inverse-polynomial mass would
require only polynomially many challenged instances per length, which is a
sparse-hard-set assumption rather than a standard PCP/DNF learning lower
bound.

PRF and LPN-style families have the opposite problem. They give fixed-marginal
hardness of weak prediction itself under uniform-like marginals, but then the
improper realizable source is no longer credible. In this edge the source
must weakly learn realizable labels for every marginal; a hardness family that
blocks arbitrary weak prediction attacks the source, not just properness.

The one-way image/Hadamard family remains the sharpest near miss. At a single
length, improper linear algebra recovers the image and proper weak prediction
inverts. Across all lengths, any finite-encoded fixed marginal must either
allocate tail mass to the length-$n$ fresh tests, which gives wrong-length
handles, or expose short public sketches, which can be matched without
inverting. The atom/Gram calculation above shows that a shared-code repair
cannot remove this problem purely geometrically.

### Depth-5 Directions

1. **Selector theorem boundary.** Formalize the exact extra assumption needed
   for the trace-selector proof: efficient high-mass trace representative
   search, not merely existence of a finite high-mass trace. Check whether any
   standard fixed-distribution proper-learning theorem supplies this for broad
   representation classes.

2. **Advice-semantics fork.** Write a model-boundary note: if
   marginal-nonuniform computational learning allowed per-marginal advice or
   one algorithm per marginal, the weak proper target would become much easier
   on countably supported marginals. Compare this explicitly with the atlas's
   "one uniform learner, no $P$-advice" convention.

3. **Atom/Gram lemma.** Turn the largest-atom calculation into a reusable
   obstruction lemma for finite-encoded fixed-marginal code witnesses. Include
   the approximate version with correlation threshold $\rho<a$.

4. **Computational weak-handle hardness.** Search for a standard primitive
   stronger than one-wayness but weaker than full PRF hardness: given a public
   code of $y=f(s)$, finding any seed whose code has positive inverse-
   polynomial correlation under a fixed marginal should be hard, while the
   external code message remains learnable improperly from realizable samples.

5. **Atomless model-boundary witness.** Separately analyze the atomless
   product/Hadamard construction as a possible schema change. The expected
   result is a clean fixed-marginal false witness in a richer sample model, but
   it should be kept out of the current finite-transcript atlas unless that
   convention is intentionally revised.

### Final Depth-4 Verdict

No atlas-ready theorem or counterexample was found. The edge should remain
`open` with `evidence: unknown`.

The theorem route is closer than before only under extra selector/advice
semantics. Under the present one-uniform-learner semantics, marginal-
nonuniform weak improper realizable learning does not itself provide a
polynomial-time proper selector. The fixed-marginal hardness route also
remains blocked: finite-encoded shared-code constructions cannot avoid
wrong-length or wrong-seed weak handles by geometry alone, so any future
separation must make those handles computationally hard to find.

---

## Depth 5 Follow-Up - Computational Weak-Handle Hardness After Finite-Trace Dovetailing, 2026-05-05

- depth: 5
- date: 2026-05-05
- verdict: unresolved-open
- confidence: medium-high that no current PCP, DNF, one-way, PRF, or code-tower template gives an atlas-ready false witness; medium that the finite-trace dovetailing route may actually prove the edge under an explicit recursive-representation convention
- changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`

### Goal

Push on the depth-4 instruction to look for a computational witness rather than
a purely geometric one. The desired witness would have:

1. an efficient marginal-nonuniform weak realizable improper learner;
2. one fixed hard marginal $P^\star$;
3. no polynomial-time proper learner, even for an inverse-polynomial weak
   advantage, because finding any weakly correlated proper hypothesis decodes a
   computationally hard witness.

The new obstruction is that fixed-marginal weak proper hardness has to beat a
finite-trace dovetailing argument. This is stronger than the previous
wrong-length/short-sketch diagnosis: even if correlated proper handles are
intended to be computationally hidden, any constant-mass finite trace of the
fixed marginal can often be handled by brute-force enumeration with a
$P^\star$-dependent constant.

### Sources Rechecked

Local notes:

- `atlas/README.md`, for the one-learner convention and pathwise finite
  transcript resource bounds.
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/unrestricted-labelings.md`

External anchors:

- Hanneke, Moran, and Thiessen, *Marginal-Nonuniform PAC Learnability*,
  https://openreview.net/forum?id=aoVCFtox89. Used again only for the
  marginal-dependent-rate quantifier pattern, not for computational
  properization.
- Benedek and Itai, *Learnability with respect to fixed distributions*,
  https://doi.org/10.1016/0304-3975(91)90026-X. The ScienceDirect abstract
  explicitly records the finite-cover characterization, that discrete
  distributions make every class learnable information-theoretically, and that
  computation may be infeasible or undecidable.
- Pitt and Valiant, *Computational Limitations on Learning from Examples*,
  https://www.cis.upenn.edu/~danroth/Teaching/CS446-17/Papers/p965-pitt.pdf.
  Used for representation-dependent proper hardness via consistency/search.
- Khot and Saket, *Hardness of Minimizing and Learning DNF Expressions*,
  https://cs.nyu.edu/~khot/papers/minDNF.pdf. Used for constant-advantage
  proper weak-learning hardness with explicitly supported hard distributions.
- Canetti, Goldreich, and Halevi, *The Random Oracle Methodology, Revisited*,
  https://eprint.iacr.org/1998/011, and later correlation-intractability work
  such as Canetti-Chen-Reyzin and Lombardi-Vaikuntanathan. Used only as a
  vocabulary check for "hard to find any input satisfying a sparse public
  relation"; these assumptions do not directly instantiate the PAC witness.

### Finite-Trace Dovetailing Barrier

Suppose the fixed hard marginal $P^\star$ is countably supported and the proper
representation is recursively enumerable with an effective evaluator. Fix
$\eta>0$ and choose a finite set $F$ with

$$
P^\star(F)>1/2+4\eta.
$$

For each label trace $\tau:F\to\{0,1\}$ realized by some concept in
$\mathcal C$, let $h_\tau$ be the first proper description in the enumeration
that realizes $\tau$. There are at most $2^{|F|}$ such traces. Hence, for this
fixed $P^\star$ and fixed $F$, the largest search time and output length among
the $h_\tau$ are finite constants. A learner can sample labeled examples,
enumerate proper descriptions, and validate candidates on fresh examples. With
enough $P^\star$-dependent samples, the representative matching the target
trace on $F$ has true error at most

$$
P^\star(X\setminus F)<1/2-4\eta,
$$

and validation rejects the finitely many earlier bad candidates with high
probability.

This is not yet an atlas theorem, because it depends on a representation
convention that is stronger than what is currently written in the node: an
effective enumeration of legal proper hypotheses, an effective evaluator, and a
runtime analysis allowed to absorb the first-good-representative index into the
$P^\star$-dependent polynomial. But it seriously constrains false witnesses.
Any hardness construction whose only obstacle is "finding a proper concept that
matches a fixed high-mass finite trace" is not robust: finite-trace search is a
constant-cost operation once the marginal is fixed.

So computational weak-handle hardness cannot live on a constant-mass prefix of
the marginal. It must force the useful correlation to sit on target-size
dependent sets $F_s$ whose total mass is only inverse-polynomial in the target
size. That is exactly where wrong-length, default, and short-sketch handles
re-enter.

### Why Packed PCP And DNF Hardness Still Miss

The tempting repair is to pack many Khot-Saket or PCP proper-hard instances
into a single marginal with polynomial tail weights. For a target associated
with instance or length $s$, a proper weak learner would have to gain advantage
about $w_s\Delta$, where $w_s$ is the slice mass and $\Delta$ is the local
constant soundness gap.

This does not yet refute the edge.

If the prefix of $P^\star$ outside the active hard slice has constant mass,
then finite-trace dovetailing supplies a proper hypothesis with constant weak
advantage unless the prefix is somehow made neutral for every legal proper
description. Pure neutrality is blocked by the depth-4 atom/Gram calculation.
Computational neutrality is also unstable: for any fixed finite prefix, the
first proper representative of each realized trace is a $P^\star$-dependent
constant, so brute-force enumeration can use it without solving the active
PCP/DNF instance.

If the construction hides all target-dependent information in the tail slice,
then the global weak gap is only $w_s\Delta$. That is allowed by the marginal-
nonuniform target when $w_s$ is inverse-polynomial, but it also means all
non-tail behavior must avoid giving any easier proper advantage. Existing
PCP/DNF reductions do not provide this all-prefix anti-handle guarantee. Their
hardness is local to an explicitly described distribution, and the fixed-
marginal packing adds many irrelevant regions on which a legal proper
hypothesis may agree with the target without solving the local instance.

Thus PCP/DNF hardness remains a distribution-free or slice-local proper
hardness tool. It is not a fixed-marginal weak-proper counterexample for this
edge unless paired with a new prefix-neutralization mechanism.

### Why One-Way, PRF, And Correlation-Intractability Ideas Are Still Non-Witnesses

The most plausible cryptographic target remains approximate range recovery:

> Given a learnable external message $y=f(s)$ and a fixed public code
> $C$, it is hard to find any seed $t$ such that $C(f(t))$ has positive
> inverse-polynomial correlation with $C(y)$ under $P^\star$.

This is stronger than ordinary one-wayness. One-wayness rules out finding a
preimage of $y$; it does not rule out finding a preimage of a short sketch of
$y$, a wrong-length seed agreeing on a high-mass prefix, or a fixed finite-trace
representative.

PRF-style labels push in the other direction. They can make every proper handle
look computationally hidden, but then the improper source is no longer
credible under arbitrary marginals: if the marginal concentrates on fresh PRF
coordinates, an improper learner also cannot weakly predict. Adding a public
linear or Hadamard channel makes the improper source plausible, but then the
proper learner can exploit short visible sketches unless approximate range
recovery is assumed for every inverse-polynomially visible sketch.

Correlation-intractable hash functions have related language: they try to make
it hard to find any input-output pair satisfying a sparse relation. However,
the relation needed here is not the standard random-oracle relation. It is a
PAC-specific relation saying that a legal proper seed has enough correlation
with the hidden target code under one fixed marginal, after the learner has
seen labeled samples from that target. Known correlation-intractability
constructions either require strong assumptions or are parameterized for
relations unlike this finite-trace PAC relation. Treating such a primitive as
an assumption would be too bespoke for an atlas edge unless it were stated as a
new conditional witness rather than as a standard consequence of one-way
functions.

### Current State Of The Computational Witness Search

The computational route is not merely missing a stronger hard problem. It needs
a three-way balance:

1. **Improper source:** for every marginal, there is a uniform polynomial-time
   weak improper learner. Memorization handles fixed discrete high-mass traces,
   and linear/Hadamard channels handle some dense tails.
2. **No prefix handle:** for the fixed hard marginal, every constant-mass finite
   prefix must be useless to efficient proper learning. Finite-trace
   dovetailing suggests this is impossible under ordinary recursive
   representation semantics.
3. **Tail hardness:** the remaining inverse-polynomial tail advantage must be
   hard properly but easy improperly. Current PCP, DNF, one-way, and PRF
   templates each satisfy at most two of these requirements at once.

This makes the edge look more likely to be true under an explicit enumerable
proper-representation convention, but I am not recording that as a verdict. The
atlas definitions do not yet state enough about proper hypothesis enumeration,
candidate evaluation, output-size accounting, and validation thresholds to turn
the finite-trace dovetailing sketch into a clean theorem. Conversely, without
such a theorem, I do not have a standard-assumption false witness.

### Depth-6 Directions

1. **Formalize finite-trace dovetailing.** State and prove the conditional
   theorem: for finite-string or otherwise countably supported marginals, if
   $\mathcal C$ has a recursive proper-description enumeration and effective
   evaluation, then $\mathcal C$ is efficient marginal-nonuniform weak
   realizable proper PAC learnable. Check pathwise runtime, output length, and
   validation carefully.

2. **Audit atlas representation semantics.** Decide whether computational nodes
   implicitly quantify over recursively enumerable representation classes with
   polynomial-time evaluators, or whether arbitrary non-enumerable proper
   classes are allowed. The answer may settle whether the dovetailing theorem
   is admissible.

3. **Try a tail-only hardness model.** If looking for a false witness, force
   all target-size-dependent information onto a tail of mass $s^{-k}$ while
   proving that every constant-mass prefix trace has a cheap proper
   representative independent of the hard instance and hence gives no
   target-specific advantage. This is the part current PCP/DNF packings lack.

4. **Define approximate range recovery as an explicit assumption.** If a
   cryptographic counterexample is still desired, write the exact PAC relation:
   from samples revealing $C(f(s))$ under $P^\star$, finding any proper seed
   with inverse-polynomial correlation recovers a hard witness. Then check
   whether it follows from a known primitive or is simply a custom assumption.

5. **Separate atomless model changes from current atlas work.** In an atomless
   or infinite-product sample model, Hadamard image codes may give a clean
   false witness. Under the present finite-transcript scratchpad convention,
   keep that as a model-boundary note only.

### Final Depth-5 Verdict

No atlas-ready computational counterexample was found. The edge should remain
`open` with `evidence: unknown`.

The main new takeaway is negative for the requested witness search: once the
hard marginal is fixed, any constant-mass finite trace looks vulnerable to a
$P^\star$-dependent enumerate-and-validate proper learner. A false witness must
therefore hide all useful proper correlation in an inverse-polynomial tail
while preventing wrong-length, prefix, and short-sketch handles. I do not know
a standard computational primitive that supplies exactly that.

---

## Depth 6 Final Follow-Up - Recursive Finite-Trace Boundary, 2026-05-05

- depth: 6
- date: 2026-05-05
- verdict: unresolved-open
- confidence: high that the edge should stay `open` in the current atlas; high that the finite-trace argument proves a useful conditional theorem under stronger recursive/enumerable semantics; high that the checked PCP, DNF, one-way, PRF, and code-tower templates are still non-witnesses for this exact edge
- changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`

### Final Goal

This is the last allowed depth. The remaining question is whether the
depth-5 finite-trace dovetailing sketch can be promoted from a barrier into an
atlas-ready proof of

```text
efficient-marginal-nonuniform-weak-realizable-improper-pac
->
efficient-marginal-nonuniform-weak-realizable-proper-pac.
```

The answer is: not under the definitions as currently written. It does,
however, identify a clean conditional positive theorem and a clean semantics
fork for future atlas work.

### Conditional Theorem That Almost Resolves The Edge

Here is the strongest theorem supported by the depth-6 audit.

**Conditional finite-trace proper weak learning theorem.** Suppose:

1. the instance space seen by the computational learner is countable, with
   finite encodings;
2. legal proper descriptions for $\mathcal C$ are recursively enumerable;
3. each enumerated description has an effective total evaluator on encoded
   examples;
4. the marginal-nonuniform runtime convention allows the fixed marginal
   $P$-dependent finite search constants below to be absorbed into the
   polynomial resource bound, and the learner has a legitimate stopping rule
   or stopping certificate for the finite search.

Then every such class is efficient marginal-nonuniform weak realizable proper
PAC learnable. The improper source is not needed.

Proof idea. Fix a marginal $P$. Choose a finite support trace $F$ with

$$
P(F)>3/4.
$$

For each trace $\tau:F\to\{0,1\}$ realized by a concept of $\mathcal C$, let
$h_\tau$ be the first proper description in the enumeration that realizes
$\tau$. There are finitely many such traces, so the largest index, output
length, and evaluation time among these $h_\tau$ are finite constants depending
on $P$ and the representation, but not on the target concept size.

Given realizable samples from target $c$, the representative $h_{c|F}$ agrees
with $c$ on $F$, hence has error at most $P(X\setminus F)<1/4$. With enough
$P$-dependent samples, an enumerate-and-validate learner can identify a
candidate whose true error is below $1/2$ with high probability. This gives a
constant weak advantage, stronger than the target's inverse-polynomial
advantage requirement.

This theorem also explains why the known fixed-marginal hardness templates keep
failing. If the hard marginal has a constant-mass finite prefix, then ordinary
recursive proper search can find a prefix representative at $P$-dependent
constant cost. Any counterexample must therefore force all useful
target-dependent proper correlation into a size-dependent tail while blocking
every prefix, wrong-length, and short-sketch handle. None of the checked
templates does that.

### Why This Is Not An Atlas-Ready Proof

The conditional theorem is too semantic to record as a resolution of the
current edge.

First, the current definition notes require one uniform learner and
pathwise/worst-case resource bounds on finite encoded sample transcripts, but
they do not explicitly state that every proper class has a recursive legal
description enumeration and an effective total evaluator. The atlas still uses
very broad witness language in places, including arbitrary measurable labelings
as absolute nonboundary failures.

Second, existence of a finite high-mass trace is not the same as an effective
uniform stopping rule. A learner is not given $P$, the high-mass set $F$, or
the finite menu $\{h_\tau\}$. Validation can certify that a displayed candidate
looks good on fresh samples, but without an explicit stopping convention it
does not tell the learner that enough of the proper enumeration has been
searched. Under the pathwise resource convention, this distinction matters.

Third, if the conditional theorem were adopted as an implicit axiom, it would
trivialize more than this implication: every recursively represented class over
countably supported finite-string marginals would satisfy the weak
marginal-nonuniform proper target, regardless of improper learnability. That is
a substantial model clarification, not a source-to-target implication proof
inside the current notes.

Thus the edge should remain `open` until the atlas either adds the recursive
finite-trace semantics explicitly or a genuine counterexample is found under
the present broader semantics.

### Final Status Of False-Witness Routes

The main candidate families are exhausted for this edge at the present depth.

- **PCP active slices and Khot-Saket/DNF hardness:** still fail because the
  hard distribution is instance-dependent, and packing instances into one
  fixed marginal multiplies the local gap by the slice mass. A constant-mass
  prefix is vulnerable to finite-trace proper search; a tail-only hard slice
  leaks wrong-slice and prefix handles unless a new neutralization mechanism is
  added.
- **One-way image-coordinate witnesses:** still prove neighboring strong
  proper lower bounds, but weak learning leaks wrong-length, sparse-support,
  default, or finite-prefix handles.
- **Hadamard/Goldreich-Levin image codes:** work at one fixed length, where
  positive proper correlation forces image equality. They still do not give one
  finite-encoded all-length fixed marginal without either tail dilution or
  searchable short sketches.
- **PRF and LPN-like routes:** make weak prediction itself hard under natural
  fixed marginals, which threatens the improper source. Adding a public channel
  for the improper learner reintroduces short-sketch proper handles.
- **Correlation-intractability language:** captures the shape of the desired
  "find any correlated proper seed" hardness, but the needed PAC relation is
  custom and not known here to follow from a standard assumption.

### Atlas-Ready Open-Note Update

No atlas file should be changed by this pass. If edits are later allowed, the
edge can stay in the same metadata family:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
summary: "Open: finite-trace dovetailing gives a conditional positive theorem for countable recursive representations, but the current atlas does not specify enough representation and stopping semantics to make it an unconditional properization proof; known fixed-marginal hardness templates still leak weak proper handles."
```

Suggested replacement body:

```markdown
`open`.

This is the weakest computational properization edge in the marginal-
nonuniform realizable layer. The source supplies one uniform weak learner whose
output may be outside $\mathcal C$; the target requires a represented concept
from $\mathcal C$.

A finite-trace argument nearly proves a positive result. For a fixed
countably supported marginal $P$, choose a finite set $F$ of mass above
$3/4$. If legal proper descriptions are recursively enumerable, effectively
evaluable, and the marginal-nonuniform runtime semantics allow the finite
$P$-dependent search constants and stopping certificate to be absorbed, then
one can choose a first proper representative for every realizable trace on
$F$. The representative matching the target trace has error below $1/4$, so
the class is weakly properly learnable for that marginal. This conditional
theorem does not use the improper source.

The current atlas definitions do not yet make that theorem unconditional:
they require one learner with pathwise finite-transcript resource bounds, but
do not explicitly provide a recursive proper enumeration, total evaluator, or
uniform stopping rule for the hidden high-mass trace. Treating those as
implicit would be a model-level clarification that would make many countable
fixed-marginal weak proper targets trivial.

Known counterexample templates are still near misses. PCP and DNF hardness put
the hard distribution in an instance-dependent marginal, and fixed-marginal
packing dilutes the weak gap. One-way coordinate witnesses force proper
recovery only at strong accuracy and leak weak handles. Hadamard image codes
separate proper from improper at one fixed length, but all-length finite-coded
versions leak tail, wrong-length, prefix, or short-sketch handles. A genuine
separation would need a fixed-marginal tail-only hardness construction in
which every inverse-polynomial proper correlation recovers a hard witness,
while improper weak learning remains efficient for every marginal.
```

### Precise Future Routes

1. **Make the semantics fork explicit.** Decide whether computational atlas
   classes always come with recursively enumerable legal proper descriptions
   and total evaluators. If yes, add a reusable finite-trace proper-learning
   theorem and reclassify the affected weak marginal-nonuniform properization
   edges as `true` under that convention.

2. **Settle the stopping-rule issue.** Formalize an enumerate-and-validate
   learner with pathwise polynomial resource bounds. The missing technical
   object is a uniform stopping certificate for "enough representatives of a
   high-mass trace have been searched" without giving the learner $P$ as
   advice.

3. **If the atlas allows nonrecursive representations, build the separation
   there.** A counterexample should make legal proper representatives
   non-enumerable or search-hard while preserving a simple improper learner.
   This would be a representation-semantics separation, not a standard PCP or
   cryptographic hardness result.

4. **If staying with standard recursive representations, abandon the current
   false-witness templates unless a new tail-only primitive is introduced.**
   The needed primitive is approximate range-recovery hardness under one fixed
   finite-encoded marginal: from samples exposing an improperly learnable
   public code of $f(s)$, finding any legal seed with inverse-polynomial
   positive correlation must recover a hard witness.

### Final Depth-6 Verdict

`unresolved-open`.

The edge is not resolved in the current atlas. The finite-trace dovetailing
argument is strong enough to become a theorem after an explicit recursive
finite-trace/stopping semantics choice, but that choice is not currently part
of the edge note. In the other direction, the standard PCP, DNF, one-way, PRF,
and code-tower constructions still do not yield an atlas-ready false edge.
