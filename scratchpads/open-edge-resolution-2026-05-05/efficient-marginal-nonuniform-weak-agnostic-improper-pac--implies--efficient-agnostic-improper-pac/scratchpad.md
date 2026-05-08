# Edge: efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-agnostic-improper-pac

- depth: 1
- edge_file: atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac.md
- verdict: unresolved-open
- confidence: high that the current atlas edge should remain open; medium on the underlying mathematical/computational truth

## Context

The source is `efficient-marginal-nonuniform-weak-agnostic-improper-pac`.
One uniform learner receives samples from an arbitrary joint distribution
`D` over instances and labels. For each instance marginal `P = D_X`, there
are marginal-dependent polynomial resource bounds and a fixed weak agnostic
tolerance

$$
\beta_P(s) < 1/2
$$

whose gap from `1/2` is inverse-polynomial under marginal-dependent bounds.
For every joint distribution with marginal `P`, the learner outputs an
improper hypothesis satisfying

$$
\operatorname{err}_D(h)
\le
\inf_{c\in C}\operatorname{err}_D(c) + \beta_P(s).
$$

The target is `efficient-agnostic-improper-pac`. It asks for one
distribution-free polynomial-time learner which, for every `epsilon > 0`,
outputs an improper hypothesis with

$$
\operatorname{err}_D(h)
\le
\inf_{c\in C}\operatorname{err}_D(c) + \epsilon.
$$

Thus the assigned edge combines two nontrivial moves:

1. marginal-nonuniform to distribution-free computational bounds;
2. fixed-additive weak agnostic to strong agnostic accuracy.

## Attempted Resolution

### 1. Resource uniformization is largely handled, but only for pathwise resources

The newer `full-support-marginal-uniformization` argument is relevant. Under
the atlas convention that efficient PAC sample use and running time are
worst-case/pathwise bounds on finite encoded sample transcripts, a full-support
reference marginal `P*` can turn a marginal-dependent runtime polynomial into
one distribution-free runtime polynomial.

The argument is:

- choose `P*` with full support on every finitely encoded instance in each
  representation-size slice;
- apply the marginal-nonuniform source to `P*` to get a polynomial
  `p_{P*}`;
- every finite labeled transcript that can occur under any marginal has
  positive probability under `P*` for a suitable conditional label rule;
- therefore, if the learner exceeded `p_{P*}` on such a transcript, it would
  violate its source guarantee under `P*`.

This resolves the pure resource-uniformization problem for same-accuracy
edges such as

`efficient-marginal-nonuniform-agnostic-improper-pac -> efficient-agnostic-improper-pac`.

For the present weak source, however, the full-support trick does not
uniformize the weak advantage. Accuracy is still applied under the actual
marginal `P`, where the only promised excess is `\beta_P(s)`. The quantity

$$
\gamma_P(s) = 1/2 - \beta_P(s)
$$

may depend on `P`, and the source gives no distribution-free lower bound on
`\gamma_P(s)`. Any boosting reduction whose number of calls or internal
parameters depend polynomially on `1/\gamma_P(s)` would still fail to give one
distribution-free polynomial unless this dependence can also be uniformized.
The full-support transcript argument does not control error gaps under other
marginals.

### 2. Standard realizable boosting does not address the agnostic gap

Schapire/Freund realizable boosting converts weak realizable advantage into
strong realizable accuracy with an improper final vote. The agnostic source
does specialize to weak realizable learning on realizable distributions, but
that only helps sample-complexity arguments via VC/uniform convergence. It
does not produce a polynomial-time agnostic learner unless one can also run
proper or improper agnostic ERM efficiently.

The atlas `sample-complexity-equivalence` note correctly separates this: weak
agnostic sample learnability can imply strong agnostic sample learnability
because unbounded ERM is allowed. That is not a black-box polynomial-time
conversion for the computational node.

### 3. Fixed-additive agnostic boosting remains the central obstruction

In `{-1,1}` notation, the atlas weak guarantee gives

$$
\operatorname{corr}_D(h,Y)
\ge
\rho^*(D) - 2\beta_P(s),
$$

where

$$
\rho^*(D)=\sup_{c\in C}\operatorname{corr}_D(c,Y).
$$

So the learner is a fixed-additive approximation to the best correlation, not
a tunable weak oracle at an arbitrary requested scale.

The local `agnostic-boosting-open` note and neighboring scratchpads identify
three near misses.

First, Ben-David--Long--Mansour and Gavinsky study fixed-additive agnostic
weak learning, but the resulting guarantees do not give
`\operatorname{OPT}+\epsilon` for arbitrary `epsilon` from a fixed
`\operatorname{OPT}+\beta` oracle.

Second, Feldman's distribution-specific agnostic boosting is especially
important for this edge because it preserves the instance marginal: the
booster changes labels or conditional expectations rather than reweighting the
domain marginal. This means Feldman largely removes the usual marginal
bookkeeping issue for a stronger threshold/correlation weak source. But the
theorem requires a weak learner available at the target threshold scale. The
atlas source with fixed `\beta_P(s)` only yields an `(alpha, alpha-\beta_P(s))`
threshold-style learner when

$$
\alpha > \beta_P(s).
$$

To reach final excess `epsilon`, one would want `alpha = O(epsilon)`. For
`epsilon <= \beta_P(s)`, the conversion gives no positive weak advantage.
Thus Feldman supports a nearby true theorem for a threshold/correlation weak
node, but not the current fixed-additive node.

Third, Ghai--Singh and da Cunha--Hogsgaard--Paudice give modern agnostic
boosting results close to this target. Ghai--Singh type guarantees still
retain a residual term depending on the weak oracle slack, so a fixed slack
does not yield arbitrary excess error. The da Cunha et al. result is the
closest positive evidence for accepting constant nontrivial weak slack, but
the atlas notes record a computational gap: the generic runtime is not stated
as a representation-uniform polynomial-time reduction in the weak learner's
own polynomial bounds and the representation size. There is also an improper
output-class bookkeeping issue: the atlas source does not specify a fixed
low-complexity class containing all weak hypotheses returned by the oracle,
whereas modern sample/running-time bounds often depend on such base-class
parameters.

### 4. Counterexample search did not produce an atlas-ready false witness

A false resolution would need a class satisfying the source but failing the
target. That means:

- one uniform learner gives, for every marginal `P`, a fixed-additive weak
  agnostic improper guarantee with marginal-dependent polynomial resources;
- nevertheless, no distribution-free polynomial-time improper agnostic learner
  achieves arbitrary excess `epsilon`.

Existing atlas witnesses do not immediately fit.

- Halfspaces are useful negative evidence for agnostic improper learning, but
  Tiegel-style hardness threatens even weak agnostic improper learning under
  fixed marginals. That attacks the source, not only the target.
- The clause-satisfaction lookup class satisfies strong distribution-free
  agnostic improper learning, so it cannot separate this edge.
- PCP active-slice and fixed-k-term-DNF witnesses are about proper-output
  separations or realizable/proper boosting barriers. They do not separate a
  weak improper agnostic source from a strong improper agnostic target.

A plausible false route would come from approximation hardness: constant
additive agnostic approximation is easy, but PTAS-level agnostic approximation
is hard. I did not find a source-grounded class satisfying this for every
distribution with the exact atlas source guarantee.

## Proposed Atlas Update

No resolved atlas status change is justified.

If the edge note is revised for clarity, I would keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
```

Suggested sharper summary:

```yaml
summary: "Open: full-support uniformization can handle transcript-wise resource bounds, but no known polynomial-time booster converts the marginal-dependent fixed-additive weak agnostic promise into arbitrary distribution-free agnostic excess error."
```

Suggested references to retain or include:

```yaml
ref_keys:
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
  - bendavid2001
  - kalai2008agnosticboosting
  - gavinsky2003
  - feldman2010distributionspecific
  - ghai2025agnosticboosting
  - dacunha2026agnosticboosting
```

Suggested body replacement direction:

```markdown
## Verdict

`open`.

The marginal-to-distribution-free runtime issue is largely resolved under the
atlas worst-case transcript convention by full-support marginal
uniformization. However, the source is only a fixed-additive weak agnostic
learner with marginal-dependent tolerance `\beta_P(s)`. The full-support
argument does not make the weak advantage `1/2-\beta_P(s)` uniform, and known
agnostic boosting theorems either require a tunable threshold/correlation weak
oracle, leave residual error depending on fixed weak slack, or are not stated
as representation-uniform polynomial-time reductions for this atlas source.

Feldman's distribution-specific booster is a key near miss because it preserves
the instance marginal. It would prove a nearby theorem for a
threshold/correlation-style marginal-nonuniform weak agnostic source, but the
current source converts to such an oracle only above the fixed scale
`\beta_P(s)`, not at arbitrary requested `\epsilon`.

No concrete class or conditional assumption is currently recorded that
satisfies the source while refuting the target.
```

## Obstacles

1. Full-support resource uniformization does not transfer accuracy or weak
   advantage. It gives a distribution-free pathwise runtime bound for the
   original learner, but the original learner still only promises
   `OPT + \beta_P(s)` under the actual marginal.

2. The weak advantage may be marginal-dependent. Even a hypothetical booster
   whose runtime is polynomial in `1/(1/2-\beta_P(s))` would not automatically
   meet the distribution-free target unless this quantity is bounded by one
   polynomial in the representation size.

3. Known efficient agnostic boosters require stronger oracle control than the
   current atlas node supplies. Feldman removes marginal reweighting but needs
   threshold/correlation access at the final accuracy scale. Ghai--Singh needs
   shrinking slack. da Cunha et al. is a near miss but not yet a clean
   representation-uniform polynomial-time reduction for the atlas notion.

4. No false witness is ready. The obvious hardness examples either fail the
   weak agnostic source or separate proper targets rather than improper
   targets.

## Next Directions

1. Try to make the da Cunha--Hogsgaard--Paudice fixed-slack result into a
   representation-uniform polynomial-time oracle reduction. Track exactly
   which parameters enter the exponent and whether the atlas source controls
   them.

2. Add or refine a separate threshold/correlation weak agnostic
   marginal-nonuniform node. Feldman's distribution-specific booster appears
   to give a clean theorem edge from that strengthened source to strong
   marginal-nonuniform agnostic improper learning, and full-support
   uniformization would then address the distribution-free resource step if
   the weak advantage is uniformly polynomially controlled.

3. Search for approximation-hardness witnesses where fixed-additive improper
   agnostic approximation is efficient for all distributions, but arbitrary
   excess agnostic approximation is hard under a fixed marginal. This is the
   most plausible `resolved-false` route, but it needs a concrete concept
   class and a source-grounded weak learner.

4. Clarify the atlas convention for weak-node tolerances: whether
   `\beta_P(s)` is merely existential and fixed, or whether any intended
   parameterized version should expose a requested weak threshold. The current
   wording reads as fixed, and the verdict above relies on that reading.

## References Checked

- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-agnostic-improper-pac.md`
- `atlas/definitions/efficient-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/fixed-k-term-dnf-proper-boosting-separation.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac.md`
- `scratchpads/open-edge-resolution-2026-05-04/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-04/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-agnostic-improper-pac/scratchpad.md`
- `references.bib` entries for Benedek--Itai 1991, Ben-David--Benedek--Mansour 1995, Ben-David--Long--Mansour 2001, Gavinsky 2003, Kalai--Mansour--Verbin 2008, Feldman 2010, Ghai--Singh 2025, da Cunha--Hogsgaard--Paudice 2026, and Hanneke--Moran--Thiessen 2025.

verdict: unresolved-open
confidence: high that no current atlas/source-grounded proof or counterexample resolves the edge; medium on the edge's ultimate truth

## Depth-2 Entry - 2026-05-05

### Focus

This pass isolates the question requested for depth 2:

Can a known agnostic booster use an oracle that has only a hidden
marginal-dependent fixed additive tolerance
$$
\operatorname{err}_D(h)\leq \operatorname{OPT}_C(D)+\beta_P(s),
\qquad \beta_P(s)=1/2-\eta_P(s),
$$
where $\eta_P(s)>0$ is inverse-polynomial only with a
marginal-dependent exponent, and still output
$\operatorname{OPT}_C(D)+\epsilon$ in one distribution-free polynomial time
bound?

My conclusion is no known theorem does this. This does not prove the edge
false, but it keeps the atlas edge open for a sharper reason than the original
edge note states.

### What Full-Support Uniformization Gives And Does Not Give

The full-support argument can be applied to the source learner's pathwise
sample and running-time bounds. Choose a full-support reference marginal
$P^\star$. Since every finite encoded labeled transcript that occurs under any
target marginal also has positive probability under $P^\star$ for a suitable
conditional label rule, the $P^\star$ resource polynomial bounds the source
learner on all transcripts.

This does not give a uniform lower bound on
$\eta_P(s)=1/2-\beta_P(s)$. Accuracy is evaluated under the actual marginal
$P$, and the source only says that $1/\eta_P(s)$ is bounded by some
$P$-dependent polynomial. The exponent may vary with $P$. Thus any booster
whose number of calls, sample size, or search depth is polynomial in
$1/\eta_P(s)$ gives at best a marginal-nonuniform strong learner, not the
distribution-free efficient target.

This is a separate obstruction from merely not knowing the value of
$\eta_P$. A standard doubling or grid search over guessed advantages would
still have to run long enough for the true marginal's exponent. The target
requires one fixed polynomial in the representation size, $1/\epsilon$, and
$\log(1/\delta)$, with no dependence on $P$.

### Translation To Correlation-Oracles Is Too Weak Uniformly

In $\{\pm 1\}$ notation, the source guarantee under marginal $P$ gives
$$
\operatorname{corr}_D(h,Y)\geq \rho^*(D)-2\beta_P(s),
\qquad
\rho^*(D)=\sup_{c\in C}\operatorname{corr}_D(c,Y).
$$
Equivalently, using the trivial lower bound $\operatorname{corr}\geq -1$,
$$
\operatorname{corr}_D(h,Y)\geq
\max\{-1,\rho^*(D)-2\beta_P(s)\}.
$$

For a fixed marginal $P$, this can be converted into a modern weak-oracle
condition
$$
\operatorname{corr}_D(h,Y)\geq \gamma_0\rho^*(D)-\varepsilon_0
$$
with $\gamma_0>\varepsilon_0$, by choosing
$\gamma_0>1/(2(1-\beta_P))$ and
$\varepsilon_0=1-\gamma_0(1-2\beta_P)$. However, the gap
$$
\theta=(\gamma_0-\varepsilon_0)/2
$$
is on the order of $\eta_P(s)$. Since $\eta_P$ is hidden and
marginal-dependent, this conversion does not provide constants controlled by
one distribution-free polynomial.

Thus the depth-0/depth-1 positive observation still falls short here: it is a
per-marginal nontrivial oracle conversion, not a uniform one.

### Known Boosting Routes

**Feldman/distribution-specific boosting.** This is the best conceptual match
to marginal-nonuniformity because the booster can preserve the instance
marginal by changing labels or target functions rather than reweighting the
domain marginal. But the weak interface is threshold/correlation-style and
must operate at the target scale. To obtain final excess $\epsilon$, the
oracle slack/threshold must be comparable to $\epsilon$. The atlas source
offers only the fixed $\beta_P(s)$ scale. If $\epsilon<\beta_P(s)$, the
fixed-additive guarantee does not supply the positive weak edge required by
that theorem.

**Kalai--Mansour--Verbin and Ghai--Singh style observable boosters.** These
use observable reweightings or relabelings and are computationally efficient,
but their final guarantees retain a residual term depending on weak-oracle
slack, such as a constant multiple of $\varepsilon_0/\gamma_0$. Under the
conversion above, this is a fixed per-marginal loss, not an arbitrary
$\epsilon$ loss. To make the residual $O(\epsilon)$, one needs a weak oracle
whose slack can be requested smaller as $\epsilon$ shrinks.

**da Cunha--Hogsgaard--Paudice/Sun and the ALT 2026 follow-up.** These are the
closest positive evidence because they accept fixed nontrivial constants
$\gamma_0>\varepsilon_0$ and remove the residual weak-slack term
statistically. But their residual-free route pays for fixed slack through
parameters depending on the weak learner and base class. The 2026 arXiv page
states polynomial time in the sample size when the other problem parameters
are fixed. In the atlas edge, those parameters are not fixed constants: the
source learner's sample bound and the reciprocal gap may be polynomial in the
representation size with a marginal-dependent exponent, and the improper
outputs are not packaged as a base class with controlled VC/dual-VC/evaluation
parameters. Treating those quantities as fixed would silently add structure
not present in the source node.

So the current scorecard is:

- preserving the marginal is available in Feldman-type frameworks, but only
  for a stronger tunable weak oracle;
- fully efficient observable boosters are available, but they need tunable
  slack or leave a fixed residual loss;
- fixed-slack residual-free boosting exists statistically, but not as a
  representation-uniform polynomial-time black-box reduction from this atlas
  source.

### Why Hidden Gamma Is Not Just A Parameter-Guessing Nuisance

Suppose a booster has a guarantee of the form
$$
T=\operatorname{poly}(s,1/\epsilon,1/\eta_P(s),\log(1/\delta)).
$$
This is natural for realizable boosting and also for fixed-slack agnostic
boosting after translating $\beta_P$ into a correlation gap. Since the source
only says $\eta_P(s)\geq s^{-k(P)}$ for some marginal-dependent exponent
$k(P)$, the runtime may be $s^{O(k(P))}$. No single distribution-free
polynomial follows.

Trying all guesses $\eta=s^{-1},s^{-2},\ldots$ does not solve this in the
atlas target: for every fixed cutoff exponent there may be a marginal whose
legal weak gap is smaller. Also, unlike ordinary validation of a hypothesis's
error, validating the condition
$\operatorname{err}(h)\leq \operatorname{OPT}_C+\epsilon$ requires knowing or
certifying $\operatorname{OPT}_C$, which is exactly the hard agnostic
benchmark. A holdout set can compare generated hypotheses to each other, but
it does not certify that the search has reached the class optimum.

### Proposed Atlas Update If This Scratchpad Is Incorporated

Do not change the edge status. A sharper summary would be:

```yaml
status: "open"
evidence: unknown
summary: "Open: full-support uniformization controls pathwise resources, but the source weak-agnostic advantage remains marginal-dependent. Known agnostic boosters either require tunable weak slack, leave residual fixed-slack error, or run polynomially only after treating weak-learner/base-class parameters as fixed."
```

The body should distinguish the two issues:

1. Resource bounds for the original weak learner can be uniformized under the
   full-support transcript convention.
2. The weak additive tolerance cannot currently be converted into arbitrary
   $\operatorname{OPT}+\epsilon$ with one distribution-free polynomial runtime.

### Concrete Depth-3 Directions

1. Prove or refute a lower bound for residual-free fixed-slack agnostic
   boosting showing that any black-box booster must have runtime depending on
   $1/(\gamma_0-\varepsilon_0)$, even when the weak learner is efficient. Such
   a theorem would explain why hidden marginal-dependent $\eta_P$ cannot give
   a distribution-free polynomial.

2. Re-examine da Cunha--Hogsgaard--Paudice 2026 for a way to replace the
   $n^{m_0}$-style enumeration with polynomially many direct calls on
   observable relabeled distributions, while keeping the fixed-slack
   residual-free guarantee. The known proof uses hidden clean-subset
   structure; the missing ingredient is an observable substitute.

3. Formulate a strengthened atlas node with an explicit weak-oracle interface:
   given a requested $\tau$, return a hypothesis satisfying
   $\operatorname{corr}(h)\geq \gamma\rho^*-\tau$ in time polynomial in
   $1/\tau$, with the marginal preserved. Feldman/Ghai--Singh style boosters
   should then give a clean nearby true edge.

4. Search for an approximation-hardness witness where every marginal admits an
   efficient fixed-additive improper agnostic approximation with tolerance
   $<1/2$, but PTAS-level agnostic approximation is hard under some fixed
   marginal. The existing CSP/PCP templates still fail because arbitrary
   labeled distributions, not only positive CSP instances, must satisfy the
   weak source.

5. Clarify whether the atlas computational notion of "improper hypothesis"
   includes a globally controlled output class. If such a class were part of
   the definition, the modern fixed-slack boosting theorems would become
   easier to import; without it, their VC/dual-VC/evaluation parameters are
   extra assumptions.

### Sources Checked In This Pass

- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-agnostic-improper-pac.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- Existing scratchpad entries for this edge.
- Adjacent scratchpad: `scratchpads/open-edge-resolution-2026-05-04/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac/scratchpad.md`
- Primary web pages checked on 2026-05-05: da Cunha--Hogsgaard--Paudice ALT 2026 arXiv page, da Cunha--Hogsgaard--Paudice--Sun NeurIPS 2025 arXiv page, Ghai--Singh ICML 2025 PMLR page, Feldman distribution-specific agnostic boosting arXiv page, and Ghai--Singh 2024 arXiv page.

verdict: unresolved-open
confidence: high

## Depth-3 Entry - 2026-05-05

### Focus

This pass follows the requested different angle:

1. Can the edge be refuted by a class whose weak advantage is real for every
   marginal but has a hidden marginal-dependent exponent, while no uniform
   strong agnostic learner exists?
2. Can a doubling/search procedure over candidate weak-slack exponents remove
   the hidden-exponent obstruction under the current atlas definitions?

My conclusion is still `unresolved-open`. The exponent-search idea gives only a
cutoff-dependent conditional theorem, not the atlas target. The hidden-slack
counterexample idea remains plausible as a research direction, but I do not see
an atlas-ready class or assumption that satisfies the source while refuting the
target.

### What A Search Over Slack Exponents Would Need To Prove

Write the source weak gap as
$$
\eta_P(s)=1/2-\beta_P(s).
$$
For each fixed marginal $P$, the definition only promises
$$
\eta_P(s)\ge s^{-k(P)}
$$
for some exponent $k(P)$ depending on $P$. After the full-support resource
uniformization argument, the original weak learner's sample use and running
time can be bounded by one distribution-free polynomial, but the value of
$k(P)$ is still not uniformly bounded.

Suppose a black-box booster has a guarantee of the natural form:
if $\eta_P(s)\ge s^{-k}$, then after
$$
\operatorname{poly}(s^k,1/\epsilon,\log(1/\delta))
$$
work it outputs an $\operatorname{OPT}+\epsilon$ hypothesis. A search procedure
can run the booster for guesses $k=1,2,\ldots,K$ and use a holdout set to pick
the empirically best candidate. If $K\ge k(P)$, this would be fine: one
candidate is genuinely strong, and validation can select a near-best candidate
among the finite generated list.

The atlas target, however, requires one fixed polynomial. Any such polynomial
only covers a bounded range of exponents. For example, with constant target
accuracy $\epsilon=0.1$, a runtime bounded by $s^C$ can only afford guesses
$k\le O(C)$ in a booster whose cost is polynomial in $s^k$. Since the source
allows $k(P)$ to be arbitrarily large as $P$ varies, no finite polynomial-time
cutoff covers all legal marginals.

Letting $K$ grow without a fixed polynomial bound is not an efficient PAC
learner. Letting $K$ grow as a function of $1/\epsilon$ also does not solve the
distribution-free requirement: for any proposed polynomial in
$(s,1/\epsilon)$, choose a marginal whose admissible weak exponent exceeds the
polynomial's effective search cutoff at, say, $\epsilon=0.1$.

This is stronger than "we do not know $\eta_P$." Unknown parameters can often
be handled by doubling. Here the parameter is allowed to have no uniform
polynomial upper bound across marginals, while the target polynomial must be
uniform across marginals.

### Why Holdout Validation Does Not Certify Missing Exponents

Validation helps only after the search list contains at least one strong
candidate. Given candidates $h_1,\ldots,h_M$, a holdout set can estimate
their true errors and choose one whose error is nearly minimal among the list.
It cannot certify that the list contains an
$\operatorname{OPT}_C+\epsilon$ hypothesis.

The missing certificate is the agnostic benchmark
$$
\operatorname{OPT}_C(D)=\inf_{c\in C}\operatorname{err}_D(c).
$$
Estimating this benchmark is essentially the strong agnostic problem. Therefore
an exponent search cannot safely stop just because validation error has
stabilized, unless some independent theorem says the current exponent cutoff
already dominates the true $\eta_P$ scale. The current source definition gives
no such theorem.

### Does The Existential Source Learner Secretly Give Better Slack?

One possible escape would be to argue that the same uniform weak learner,
combined with full-support marginal uniformization, forces a uniform lower
bound on $\eta_P(s)$. I do not see such an argument.

The full-support proof is pathwise: a transcript that occurs under any marginal
also occurs with positive probability under a reference full-support marginal
$P^\star$, so the $P^\star$ runtime bound controls the learner's behavior on
that transcript. Accuracy does not transfer the same way. The guarantee under
$P^\star$ weights errors by $P^\star$, and a target marginal $P$ may put most
of its mass on regions to which $P^\star$ assigns tiny probability. A learner
can be very weak on those regions without violating its accuracy guarantee
under $P^\star$.

So full support uniformizes runtime, not the weak gap.

### Hidden-Slack Counterexample Search

A false witness would need a class $C$ with three properties:

1. one uniform efficient learner gives, for every marginal $P$, some
   $\operatorname{OPT}_C+\beta_P(s)$ guarantee with
   $\beta_P(s)<1/2$ and inverse-polynomial gap under a $P$-dependent exponent;
2. the exponents $k(P)$ are not bounded by any one distribution-free constant;
3. under a standard assumption, no polynomial-time improper agnostic learner
   achieves arbitrary $\operatorname{OPT}_C+\epsilon$.

The hidden-slack idea suggests a graded construction: on marginal families of
level $k$, an easy weak signal gives advantage about $s^{-k}$, while obtaining
small excess error requires solving a hard agnostic optimization problem. This
would refute the edge if the class also satisfied the source for every
possible marginal, including marginals that avoid the easy signal or mix
levels adversarially.

That last quantifier is the main obstruction. A helpful watermark, bias, or
easy feature can be assigned zero mass by an arbitrary marginal. If the hard
part remains realizable and balanced on that marginal, a fixed easy hypothesis
only gets error $1/2$, while the source requires error strictly below $1/2$ on
realizable distributions. Thus an atlas-ready witness cannot merely add a
small easy-correlated region; it must guarantee a weak edge for all marginals,
including those supported entirely on the hard region.

Known hardness examples still miss this target:

- cryptographic or lattice-style agnostic hardness examples usually threaten
  even weak agnostic learning under the hard marginal, so they fail the source;
- CSP/PCP approximation templates often give easy constant approximations on
  positive instances, but arbitrary agnostic labelings introduce signed or
  complemented constraints where the easy baseline need not be
  $\operatorname{OPT}+\beta$ for any $\beta<1/2$;
- proper-learning separations do not refute this improper target.

So hidden marginal-dependent slack is a plausible shape for a false witness,
but the current pass did not turn it into a class.

### Current Positive Near Misses Rechecked

Feldman's distribution-specific booster remains the cleanest way to avoid
marginal reweighting: the arXiv abstract states that the algorithms modify the
label distribution rather than the domain marginal, yielding strong learning
with respect to the same distribution. This would handle the marginal
bookkeeping for a threshold/correlation weak node. It still needs a weak oracle
available at the final scale, not the current fixed $\beta_P(s)$ source.

Ghai--Singh's ICML 2025 PMLR page describes a computationally efficient
agnostic booster with polynomially many additional unlabeled samples, but this
line retains a residual weak-slack term in the theorem statements checked in
the adjacent scratchpads. Fixed hidden $\eta_P$ therefore leaves fixed residual
loss.

The da Cunha--Hogsgaard--Paudice ALT 2026 arXiv page is still the strongest
positive evidence: it advertises near-optimal sample complexity and runtime
polynomial in the sample size when other problem parameters are fixed. For the
atlas edge those "other parameters" include weak-learner/base-class quantities
and the fixed-slack conversion scale; treating them as fixed would add
non-atlas assumptions.

No newer primary source found in this pass gave a fully polynomial
representation-uniform fixed-slack agnostic booster.

### Proposed Atlas Update If Incorporated

No status change is justified. If the edge note is edited, the summary should
mention both failed angles:

```yaml
status: "open"
evidence: unknown
summary: "Open: pathwise full-support uniformization controls the weak learner's resources, but not the marginal-dependent weak gap. Searching over gap exponents only works up to a fixed polynomial cutoff, and no hidden-slack counterexample class satisfying the weak source for all marginals is known."
```

### Depth-4 Directions And Obstacles

1. **Formal black-box lower bound for exponent search.** Prove a theorem saying
   that any black-box conversion from a fixed-additive weak oracle with gap
   $\eta$ to $\operatorname{OPT}+\epsilon$ must use runtime polynomially
   depending on $1/\eta$, even for improper outputs. This would not by itself
   refute the atlas edge, but it would explain why hidden marginal exponents
   cannot be removed by generic boosting.

2. **Construct a graded hardness class.** Look for a class with level-$k$
   marginals where weak agnostic learning is possible with advantage
   $s^{-k}$, but strong agnostic learning at constant $\epsilon$ solves a hard
   problem. The obstacle is the "all marginals" quantifier: the weak learner
   must still work when the marginal avoids any intentionally easy region.

3. **Signed-CSP/valued-CSP approximation route.** Search for a representation
   where every signed weighted instance admits an efficient additive
   $\beta<1/2$ approximation to the best concept, but PTAS-level approximation
   is hard. Ordinary positive Max-CSP baselines are not enough because the
   agnostic distribution can label constraints arbitrarily.

4. **Parameter-controlled fixed-slack booster.** Re-examine whether the
   da Cunha 2026 enumeration can be replaced by polynomially many observable
   relabeling calls when the weak learner is an arbitrary atlas improper
   learner. The obstacle remains access to the unknown clean subset and the
   absence of a controlled base class for weak outputs.

5. **Clarify weak-node semantics.** If the atlas intends weak agnostic learners
   to accept a requested threshold/slack parameter, the current definition
   should be changed. Under the current fixed-tolerance reading, exponent
   doubling does not yield the distribution-free strong target.

### Sources Checked In This Pass

- Existing depth-1 and depth-2 entries in this scratchpad.
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-agnostic-improper-pac.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/agnostic-boosting-open.md`
- Adjacent scratchpads for the distribution-free weak-to-strong agnostic edge
  and the marginal-nonuniform weak-to-strong agnostic edge.
- Primary web pages checked on 2026-05-05: Feldman arXiv 0909.2927,
  Ghai--Singh ICML 2025 PMLR page, da Cunha--Hogsgaard--Paudice--Sun arXiv
  2503.09384, and da Cunha--Hogsgaard--Paudice arXiv 2601.11265.

verdict: unresolved-open
confidence: high

## Depth-4 Entry - 2026-05-05

### Focus

This pass tried the requested adaptive-wrapper route:

1. Can a fixed-additive weak agnostic learner be wrapped, using relabeling,
   reweighting, and validation, into a tunable correlation/additive oracle?
2. If not, does the failure point suggest an actual counterexample rather than
   just another open boosting obstacle?

The wrapper still does not give a positive theorem. More importantly, the
current atlas already contains the ingredients for a conditional false witness:
halfspaces satisfy this source via low-noise weak agnostic robustification, but
fail the strong agnostic improper target under Tiegel's worst-case lattice
hardness assumption.

### Fixed-Additive Calls Do Not Simulate Tunable Correlation Calls

Write the source tolerance under marginal $P$ as
$$
\beta_P(s)=1/2-\eta_P(s),
$$
and use $\{\pm 1\}$ labels. A call to the source learner on any labeled
distribution $Q$ with marginal $P$ guarantees only
$$
\operatorname{corr}_Q(h,Y)
\ge
\sup_{c\in C}\operatorname{corr}_Q(c,Y)-1+2\eta_P(s).
$$
Thus it is an additive maximization oracle with fixed slack
$1-2\eta_P(s)$.

Relabeling does not shrink this slack. If labels are stochastically flipped or
rescaled so that correlations with every $c\in C$ are multiplied by
$\lambda\in[0,1]$, then translating the returned hypothesis back to the
original residual objective divides the additive error by $\lambda$. The
oracle becomes less accurate, not more accurate.

Reweighting has the same problem in a different coordinate system. The learner
approximately maximizes the weighted correlation objective only up to the same
fixed additive loss. When a booster reaches the late stage where the best
residual correlation is between $\tau$ and $1-2\eta_P(s)$, a tunable oracle
would still need to find it, but the fixed oracle may legally return a
hypothesis with no useful residual correlation.

Validation can choose the best hypothesis among the finite list already
generated, but it cannot certify that the list contains an
$\operatorname{OPT}_C+\epsilon$ hypothesis. Certifying that would require
estimating $\operatorname{OPT}_C$ itself, which is the strong agnostic learning
problem. So a dovetailed wrapper over relabelings, reweightings, and guessed
slacks can find a good candidate once a good candidate is generated; it cannot
force the fixed oracle to generate hypotheses at correlation scales below its
fixed additive slack.

This identifies the natural counterexample regime: distributions where the
best concept has only modest, non-negligible correlation. The fixed weak source
may be allowed to ignore that signal, while strong agnostic learning must find
it to get small excess error.

### Conditional Counterexample From Halfspaces

The previous entries treated halfspaces as a near miss because Tiegel-style
hardness attacks weak agnostic learning for fixed distribution-free weak
tolerances. That objection does not apply to the present source as currently
defined. The source is marginal-nonuniform and its weak gap may be
inverse-polynomial with a marginal-dependent exponent.

**Source holds.** Boolean halfspaces are efficiently realizably properly PAC
learnable by the standard linear-feasibility plus VC-generalization algorithm.
The current atlas note
`low-noise-weak-agnostic-robustification` proves that a distribution-free
realizable learner yields an efficient marginal-nonuniform weak agnostic
improper learner with an inverse-polynomial weak gap. The construction is:

- if $\operatorname{OPT}_C(D)$ is above a small gap parameter $\alpha_P(s)$,
  a constant classifier has error at most $1/2\le
  \operatorname{OPT}_C(D)+1/2-\alpha_P(s)$;
- if $\operatorname{OPT}_C(D)$ is below that scale, repeated runs of the
  realizable learner on small noisy batches produce, with inverse-polynomial
  probability, a hypothesis learned from an all-clean batch relative to a best
  concept;
- validation over those candidates and the constants gives the weak agnostic
  improper guarantee.

For marginal-nonuniform targets the gap $\alpha_P(s)$ is allowed to depend on
the marginal through the relevant polynomial bounds. Therefore halfspaces
satisfy
`efficient-marginal-nonuniform-weak-agnostic-improper-pac`.

**Target fails.** The atlas halfspace hardness notes cite Tiegel 2023: under
worst-case lattice hardness, Boolean halfspaces are not efficiently
agnostically learnable even with improper binary hypotheses. In particular,
they fail `efficient-agnostic-improper-pac`.

Putting these together gives a conditional counterexample to the assigned
edge:
$$
\text{halfspaces}\in
\texttt{efficient-marginal-nonuniform-weak-agnostic-improper-pac}
$$
but, under worst-case lattice hardness,
$$
\text{halfspaces}\notin
\texttt{efficient-agnostic-improper-pac}.
$$

The role of the adaptive-wrapper failure is now clearer. The source can be
satisfied by an algorithm that is only useful in the high-correlation or
very-low-noise regime and falls back to constants once
$\operatorname{OPT}_C$ is moderately large. A strong agnostic learner for
halfspaces would need to exploit correlations at the much finer scales ruled
out by Tiegel's hardness.

### Proposed Atlas Update

If this scratchpad is incorporated, the edge should be changed from open to a
conditional false edge:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - "worst-case lattice hardness"
witnesses:
  - "halfspaces"
ref_keys:
  - valiant1984
  - blumer1989
  - tiegel2023
summary: "Halfspaces satisfy the marginal-nonuniform weak agnostic improper source via low-noise robustification of efficient realizable learning, but fail efficient agnostic improper learning under Tiegel's worst-case lattice hardness assumption."
```

Suggested body:

```markdown
## Verdict

`false`, under worst-case lattice hardness.

Use Boolean halfspaces. They are efficiently realizably properly PAC learnable,
and the low-noise weak agnostic robustification argument turns any such
distribution-free realizable learner into an efficient marginal-nonuniform
weak agnostic improper learner with an inverse-polynomial, marginal-dependent
gap. Thus halfspaces satisfy the source.

Tiegel's halfspace hardness result rules out efficient agnostic learning of
halfspaces even with improper binary hypotheses under worst-case lattice
hardness. Therefore halfspaces fail the target, giving a conditional
counterexample to the implication.
```

### Audit Notes

Before editing the atlas, I would double-check that the project wants to rely
on the current `low-noise-weak-agnostic-robustification` lemma for this edge.
If that lemma is accepted, the counterexample is straightforward. If that
lemma is later weakened or retracted, then the wrapper analysis above leaves
the edge in the same open state recorded by the earlier depths.

verdict: resolved-false

confidence: 0.74
