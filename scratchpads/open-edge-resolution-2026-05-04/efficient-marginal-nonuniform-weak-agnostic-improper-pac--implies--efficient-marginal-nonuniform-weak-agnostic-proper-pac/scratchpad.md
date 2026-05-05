# Open Edge Resolution Scratchpad

Edge: `efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac`

## Research Log

## Sources Checked

## Proof Or Counterexample Attempts

## Verdict

## Follow-Up Directions

## Depth-1 Entry - 2026-05-05

### Verdict

Still `open`.

I do not see an atlas-ready theorem or counterexample at depth 1. The edge is the computational properization question at the same marginal, weak, and agnostic axes:

$$
\text{efficient marginal-nonuniform weak agnostic improper}
\Rightarrow
\text{efficient marginal-nonuniform weak agnostic proper}.
$$

The main reason it resists resolution is that the source supplies a uniform polynomial-time learner but permits outputs outside $\mathcal C$, while the target asks for an efficient search procedure returning an element of $\mathcal C$. Marginal-dependent sample rates help with existence for fixed marginals, but they do not by themselves give a polynomial-time projection/ERM procedure over $\mathcal C$.

### Definitions Used

- Source definition read: `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`.
  - One learner works for every joint distribution.
  - For each marginal $P$, there is a marginal-dependent polynomial $p_P$ and an additive tolerance $\beta_P(s)<1/2$ with inverse-polynomial gap.
  - The output may be outside $\mathcal C$.
- Target definition read: `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`.
  - Same marginal-nonuniform weak agnostic guarantee.
  - The output must satisfy $h\in\mathcal C$.
- Edge note read: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`.
  - Current status is `open`, evidence `unknown`, family `properization-open`.

### Sources Checked

Local atlas notes checked:

- `atlas/arguments/properization-open.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/fixed-k-term-DNF.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- Nearby implication notes, especially the distribution-free weak agnostic properization edge and marginal properization edges.

Primary or near-primary web sources checked:

- Hanneke, Moran, and Thiessen, *Marginal-Nonuniform PAC Learnability*, OpenReview/PDF: https://openreview.net/pdf?id=aoVCFtox89. Relevant points: marginal-nonuniform learning permits constants/rates to depend on the marginal while remaining uniform over concepts for that marginal; the paper states the marginal-nonuniform quantifier order and trichotomy.
- Feldman, *Distribution-Specific Agnostic Boosting*, PDF: https://www.cs.cmu.edu/~odonnell/hits09/feldman-agnostic-boosting.pdf. Relevant points: distribution-specific agnostic boosting can keep the instance marginal fixed by modifying labels, but it assumes an $(\alpha,\gamma)$-style weak agnostic learner, not just the atlas fixed-additive $\operatorname{OPT}+\beta_P$ source.
- Khot and Saket, *Hardness of Minimizing and Learning DNF Expressions*, PDF: https://cs.nyu.edu/~khot/papers/minDNF.pdf. Relevant points: two-term DNF is not weakly learnable by fixed $t$-term DNF to constant advantage under $\mathrm{NP}\nsubseteq\mathrm{RP}$, but this is a constant-advantage, varying-distribution hardness statement and does not match the atlas inverse-polynomial weak marginal target.
- Håstad and Khot, *Query Efficient PCPs with Perfect Completeness*, Theory of Computing page: https://theoryofcomputing.org/articles/v001a007/. Relevant points: supplies perfect-completeness logarithmic-randomness PCPs used by the active-slice witness, but the marginal version loses the polynomial-time contradiction when each hard instance gets its own marginal.
- Schapire, *The Strength of Weak Learnability*, author PDF: https://www.schapire.net/papers/strengthofweak.pdf. Relevant point: classical PAC boosting converts weak to strong in distribution-free realizable/improper settings, but it does not solve properization.
- Pitt and Valiant DOI checked from atlas refs: https://doi.org/10.1145/48014.63140. The DOI endpoint was not fetchable in the browser session, so I treated it as historical context already represented in the atlas rather than as a new primary-source basis for this entry.

### Theorem Route

Goal: convert the source learner $A$ into a proper learner $B$ for the same class and same fixed marginal $P$.

The information-theoretic route is tempting. Ignoring runtime, a marginal-nonuniform weak agnostic sample guarantee gives sample control, and the atlas sample-equivalence notes use VC/ERM reasoning to move between weak/strong, agnostic/realizable, and proper/improper variants. Hanneke-Moran-Thiessen also make precise that marginal-nonuniform guarantees fix a marginal first and then require uniformity over concepts for that marginal.

The computational gap is the problem. Given samples from $\mathcal D$ and perhaps an improper hypothesis $g=A(S)$, there is no generic efficient way to find $c\in\mathcal C$ with

$$
\operatorname{err}_{\mathcal D}(c)
\le
\inf_{c'\in\mathcal C}\operatorname{err}_{\mathcal D}(c')+\beta_P(s).
$$

Finite-sample uniform convergence only says such a proper empirical minimizer exists. It does not make proper ERM over $\mathcal C$ polynomial-time. Feldman's distribution-specific agnostic boosting is also a near miss: it can preserve the marginal, but its weak oracle is a threshold/correlation-style $(\alpha,\gamma)$ oracle and the final boosted hypothesis is not a generic proper projection into $\mathcal C$.

Conclusion for theorem route: no atlas-ready proof. A proof would need a new general computational properization principle, or an argument that the marginal-dependent polynomial can pay for enough distribution-specific search without becoming nonuniform advice.

### Counterexample Route

I checked the obvious candidate families.

1. Clause-satisfaction lookup class.

This gives efficient agnostic improper learning because the domain of clauses is polynomial-sized and a lookup-table/majority learner competes with the best assignment. It refutes stronger distribution-free proper targets. But it does not currently refute the marginal-nonuniform weak proper target: the usual 3-SAT reduction chooses the clause distribution from the input formula. In the marginal-nonuniform target, the polynomial bound may depend on that marginal, so a reduction using a fresh $P_\varphi$ for each formula no longer has a uniform polynomial runtime bound in $|\varphi|$.

2. Fixed-$k$-term DNF / Khot-Saket.

Khot-Saket show that, under $\mathrm{NP}\nsubseteq\mathrm{RP}$, two-term DNF cannot be weakly learned by fixed $t$-term DNF to constant advantage. This is close to properization, but it misses the edge in three ways:

- the hardness distribution varies with the label-cover instance;
- the advantage lower bound is constant, while the atlas weak target allows inverse-polynomial advantage that may be much smaller;
- the class does not supply the exact source, namely efficient marginal-nonuniform weak agnostic improper learning of the same class.

3. PCP active-slice lookup class.

The active-slice PCP construction separates distribution-free weak improper realizable learning from distribution-free weak proper realizable learning. The same obstruction reappears under marginal nonuniformity: if the hard reduction samples uniformly from the active slice for $\varphi$, then the marginal depends on $\varphi$, and the target's polynomial may also depend on $\varphi$. Packing all slices into one fixed marginal makes the active slice mass too small for the global weak error gap unless the packing has polynomial mass for exponentially many possible instances, which is impossible by a simple counting/mass budget.

Conclusion for counterexample route: no atlas-ready false witness. The clean false route would need one fixed marginal $P$ carrying a proper-learning hard family with polynomially visible mass for infinitely many hard instances, while the same class remains efficiently weak agnostically learnable improperly.

### Concrete Obstruction

The edge is blocked by a mismatch between two kinds of nonuniformity.

- To prove `true`, sample-theoretic marginal nonuniformity is not enough: the missing operation is computational projection into $\mathcal C$.
- To prove `false`, standard reductions put the hard instance into the marginal. But once the marginal changes with the input, the target is allowed to have a different polynomial $p_P$ for that input-dependent marginal, so the reduction cannot force a polynomial-time SAT/Label-Cover solver.

The strongest single obstruction statement I can make is:

> A counterexample must keep the hard-instance variation out of the marginal, or otherwise control the marginal-dependent polynomial uniformly across the reduction. Existing lookup, DNF, and active-slice PCP witnesses do not do this.

### Promising Next Directions

- Search for fixed-marginal proper hardness where the hard instance is encoded in the target concept/conditional labels rather than in the marginal, and where labeled examples can still be simulated without knowing a satisfying witness.
- Try a cryptographic fixed-marginal construction with an easy improper agnostic learner. Ordinary PRF/LPN-style classes have the fixed-marginal flavor, but they usually make even improper weak learning hard, so they fail the source.
- Formalize a "marginal packing lemma" explaining why slice-based SAT reductions lose their weak global gap under any fixed marginal over exponentially many slices.
- Investigate whether Feldman's label-only agnostic boosting plus a representation-specific projection oracle would prove a conditional theorem: source plus efficient approximate projection/proper ERM under each fixed marginal implies target.
- Consider adding a separate atlas argument note for "fixed-marginal properization obstruction" if more edges share this exact failure mode.

### Atlas-Ready Changes If This Were Resolved

None. I would leave the edge as:

- `status: "open"`
- `evidence: unknown`
- `assumptions: []`
- `witnesses: []`
- `ref_keys`: keep current near-miss refs, and consider adding `feldman2010distributionspecific`, `hastad2005query`, and `hanneke2025marginalnonuniform` if the atlas note is later expanded to document the obstruction more explicitly.

## Depth-2 Entry - 2026-05-05

### Verdict

Still `open`.

Depth 2 did not produce an atlas-ready theorem or counterexample. The strongest candidate remains a PCP or clause-satisfaction properness separation, but the weak agnostic and marginal-nonuniform quantifiers jointly block the known reductions.

The key update from Depth 1 is that the clause-satisfaction route can be made fixed-marginal for strong agnostic proper learning, but that does not refute the weak agnostic proper target. Under the uniform marginal over all clauses, a sparse input formula changes the proper error by only an inverse-polynomial amount, while the weak target may allow additive tolerance

$$
\beta_P(s)=\frac12-\alpha_P(s)
$$

with only inverse-polynomial $\alpha_P(s)$. A strong learner with requested accuracy below $1/|X_n|$ would solve SAT; a weak learner need only return an assignment falsifying noticeably fewer than half of all possible clauses, which need not be a satisfying assignment.

### Sources Checked

Local atlas material rechecked:

- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`

Primary or near-primary sources checked:

- Hanneke, Moran, and Thiessen, *Marginal-Nonuniform PAC Learnability*, OpenReview page/PDF: https://openreview.net/forum?id=aoVCFtox89. Relevant point: marginal-nonuniform rates may depend on the marginal but must hold uniformly over target concepts/conditionals for that marginal.
- Blumer, Ehrenfeucht, Haussler, and Warmuth, *Learnability and the Vapnik-Chervonenkis Dimension*, JACM 1989 PDF: https://www.cis.upenn.edu/~danroth/Teaching/CS446-17/Papers/p929-blumer.pdf. Relevant points: the paper explicitly distinguishes proper hypotheses from a larger hypothesis space and ties efficient proper learning to finding consistent hypotheses.
- Ben-David, Long, and Mansour, *Agnostic Boosting*, COLT 2001 DOI page via atlas refs: https://doi.org/10.1007/3-540-44581-1_33. Relevant point: the atlas weak agnostic convention is the additive $\operatorname{OPT}+\beta$ notion with $\beta<1/2$.
- Håstad and Khot, *Query Efficient PCPs with Perfect Completeness*, Theory of Computing page: https://theoryofcomputing.org/articles/v001a007/. Relevant points: logarithmic randomness, perfect completeness, and soundness below $1/2$ can power the active-slice weak proper separation.
- Karp, *Reducibility Among Combinatorial Problems*, Springer DOI via atlas refs: https://doi.org/10.1007/978-3-540-68279-0_8. Relevant point: 3-SAT/NP-completeness basis for the clause and PCP reductions.
- Arora, Karger, and Karpinski, *Polynomial Time Approximation Schemes for Dense Instances of NP-Hard Problems*, Bell Labs publication page: https://www.nokia.com/bell-labs/publications-and-media/publications/polynomial-time-approximation-schemes-for-dense-instances-of-np-hard-problems/. Relevant point: dense MAX-SNP/MAX-3SAT-style formulations have PTASs, so simply forcing a constant fraction of all possible constraints to be active is not an obvious NP-hard weak-gap route.
- Feldman, *Distribution-Specific Agnostic Boosting*, PDF: https://www.cs.cmu.edu/~odonnell/hits09/feldman-agnostic-boosting.pdf. Relevant point: label-only boosting preserves the marginal, but the weak oracle and final output format do not provide a generic proper projection.

### Theorem Route

Goal: derive a proper weak agnostic learner from the improper weak agnostic source at the same fixed marginal.

The only plausible generic theorem route is still:

1. use the improper learner to get some hypothesis with error at most $\operatorname{OPT}_{\mathcal C}+\beta_P(s)$;
2. convert or project that hypothesis to some $c\in\mathcal C$ with comparable error.

The second step is exactly the missing computational operation. Uniform convergence or finite-domain enumeration says a good proper hypothesis exists after enough samples, but it does not give a polynomial-time proper ERM procedure. Blumer et al.'s efficient-learnability discussion makes this pressure explicit in the realizable/proper case: feasibility hinges on efficiently finding a consistent proper hypothesis, not only on sample control.

Agnostic boosting is also not a theorem route for this exact edge. Feldman's distribution-specific boosting is attractive because it changes labels while preserving the instance marginal, but it assumes a stronger oracle format than the atlas fixed-additive weak learner and returns an improper aggregate/vote. For a properness separation, that aggregate can fit the clause/constraint labels without yielding a satisfying assignment or proof.

Conclusion for theorem route: no proof. A theorem would need an additional representation-specific assumption, such as efficient approximate proper ERM/projection under each fixed marginal.

### Counterexample Route

#### 1. Fixed-Marginal Clause Satisfaction

This route works for strong agnostic proper learning but not for the present weak target.

Let $X_n$ be all 3-CNF clauses over $n$ variables and let $P_n$ be uniform on $X_n$. Proper hypotheses are assignments $a$, with $h_a(C)=1$ iff $a$ satisfies clause $C$. Given a formula $\varphi$ with clause set $F$, label clauses in $F$ by $1$ and put fair-coin labels outside $F$. The non-formula region contributes the same baseline error to every assignment.

If $\varphi$ is satisfiable, the optimum proper error is the fair-noise baseline. If unsatisfiable, the optimum is larger by at least $1/|X_n|$. This refutes a strong proper agnostic learner that can be run to accuracy $o(1/|X_n|)$.

For a weak proper learner, however, the guarantee is only baseline plus $\beta_{P_n}(s)$, where $\beta_{P_n}(s)$ may be close to $1/2$. Returning an assignment that falsifies at most about half of all possible clauses is compatible with the weak guarantee and does not decide satisfiability of $\varphi$. Making $F$ a constant fraction of $X_n$ would move toward the needed weak gap, but dense MAX-3SAT/CSP instances are exactly where the Arora-Karger-Karpinski PTAS framework warns that naive density-based NP-hardness is suspect.

#### 2. Constraint-Universe PCP

A more PCP-like fixed marginal would take examples to be local constraints, and proper hypotheses to be proof strings/assignments evaluated on those constraints. Given a PCP instance, label its constraints by $1$ and put neutral noise elsewhere.

This avoids putting the formula name directly in the marginal, but it creates a mass problem. The universe of all possible arity-$q$ constraints over a polynomial-size proof has size roughly $L^q$ times a constant predicate factor. A standard logarithmic-randomness PCP supplies only polynomially many active verifier constraints. Unless the active constraints occupy a constant fraction of this universe, their contribution is too small to force error above $\beta_P(s)$ in the unsatisfiable case.

Trying to make the active set dense is not a free move. Dense CSP/MAX-SNP formulations have approximation schemes, so the usual sparse PCP hardness is not automatically preserved after densification.

#### 3. Instance-Code Plus PCP

I also tried to repair the active-slice construction by using one fixed marginal with two regions:

- an instance-code region whose labels encode the input $\varphi$;
- a PCP-check region whose labels ask for acceptance of $\varphi$.

Proper hypotheses would be pairs $(\psi,\pi)$: on the code region they output an error-correcting codeword for $\psi$, and on the PCP region they output verifier acceptance for $(\psi,\pi)$.

This almost fixes the "wrong instance" problem, but the weak threshold creates an incompatible pair of requirements. Let the PCP-check region have mass $w$. To force a hypothesis with $\psi\ne\varphi$ above the weak tolerance, the code region must have enough mass that any wrong codeword incurs error greater than $1/2-\alpha_P(s)$. With binary codes of exponentially many messages, relative distance is at most about $1/2$, so this pushes $w$ to be smaller than about $2\alpha_P(s)$.

But to make an unsatisfiable $\varphi$ reject all hypotheses with $\psi=\varphi$, the PCP-check region must itself contribute error greater than $1/2-\alpha_P(s)$, forcing $w$ to be a constant bounded away from zero. These requirements are incompatible when $\alpha_P(s)$ is merely inverse-polynomial and may be small.

This is the sharpest obstruction found at depth 2: fixed-marginal encodings must both identify the active NP instance and allocate enough mass to the PCP gap, but a binary weak threshold below $1/2$ does not leave enough mass budget for both.

### Concrete Obstruction

The proper counterexample needs all improper escape routes to remain easy while every proper hypothesis has error above the learner's allowed weak level in the no case. For weak agnostic proper learning, "above the allowed level" means above roughly $1/2-\alpha_P(s)$, not merely above the optimum by an inverse-polynomial amount.

Known fixed-marginal clause constructions only create inverse-polynomial optimum gaps. Known PCP active-slice constructions create constant weak gaps, but only after the marginal focuses on the input-dependent slice. Attempts to encode the input into labels under one fixed marginal appear to spend too much probability mass identifying the input and too little mass on the PCP acceptance gap.

Thus the Depth-1 obstruction can be sharpened:

> A false witness must put a constant weak-gap PCP-style test under one fixed marginal without allowing proper hypotheses for the wrong instance to achieve error below $1/2$, and without making the active constraint family dense enough to fall into known approximation-scheme territory.

### Next Directions

- Look for PCPs or CSP hardness where the constraint universe is fixed and the hard instance occupies a constant-mass subset without becoming a dense-CSP PTAS instance.
- Search for binary error-correcting or direct-product encodings that make all wrong instance hypotheses incur error $>1/2-\alpha$ while leaving constant mass for PCP checks. The simple code-plus-PCP mass calculation above rules out the most naive version.
- Investigate promise problems with uniquely decodable instance encodings or list-decodable labels where recovering a nearby instance from a weak proper hypothesis would still decide the original input.
- Check whether fixed-marginal hardness for proper learning can be based on planted/conditioned labels under a single universal distribution, with the hard choice residing in the conditional distribution but not requiring sparse active clauses.
- Formalize the mass-budget obstruction as an atlas argument if other open marginal weak-proper edges keep hitting the same issue.

### Atlas Changes If Resolved

Not resolved, so no atlas files should be changed.

If later resolved as `false`, the likely atlas changes would be:

- update `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md` to `status: "false"`;
- set `evidence: conditional-counterexample`;
- add the relevant complexity assumption, probably `NP not subset RP`;
- add a new witness note for the fixed-marginal weak proper hardness class;
- add primary refs for the PCP/CSP construction and any fixed-marginal encoding lemma.

If later resolved as `true`, the atlas changes would instead need a theorem-style argument note for efficient fixed-marginal approximate properization/ERM, because no such generic theorem is currently identified.

## Depth-3 Entry - 2026-05-05

### Verdict

Still `open`.

Depth 3 pursued a different concrete lead from Depth 2: instead of encoding the instance in a separate code region, try to keep one fixed marginal by combining a PCP active slice with low-OPT labels on the slice and fair-noise padding off the slice. This does not resolve the edge. The calculation suggests that fair-noise padding does not preserve the weak agnostic gap unless the active slice has roughly constant, in fact often near-half, probability mass under the fixed marginal. That is incompatible with using one fixed marginal for a large family of NP instances.

### Sources Checked

Local material rechecked:

- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- prior Depth 1 and Depth 2 entries in this scratchpad
- nearby atlas notes found by searching for low-noise, fair-noise, active-slice, and agnostic properization terminology

Primary or near-primary sources checked:

- Håstad and Khot, *Query Efficient PCPs with Perfect Completeness*, Theory of Computing page: https://theoryofcomputing.org/articles/v001a007/. Relevant point: logarithmic randomness, perfect completeness, and soundness as small as $2^{-k^2}+\epsilon$ give a strong active-slice PCP gap.
- Feldman, Guruswami, Raghavendra, and Wu, *Agnostic Learning of Monomials by Halfspaces Is Hard*, SIAM J. Comput. page: https://epubs.siam.org/doi/10.1137/120865094. Relevant point: low-OPT weak agnostic hardness is a real phenomenon; they show hardness of finding $1/2+\epsilon$ agreement even when a simple concept has $1-\epsilon$ agreement. But the reduction is not a fixed-marginal properization witness for this edge.
- Feldman, Gopalan, Khot, and Ponnuswami, *On Agnostic Learning of Parities, Monomials, and Halfspaces*, accessible author-uploaded text via ResearchGate: https://www.researchgate.net/publication/228459918_On_Agnostic_Learning_of_Parities_Monomials_and_Halfspaces. Relevant point: weak agnostic hardness with high-agreement optimum can be obtained for natural classes, but those examples do not supply an easy improper learner for the same benchmark class under one fixed marginal.
- Tiegel, *Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice Problems*, arXiv: https://arxiv.org/abs/2207.14030. Relevant point: fixed-marginal and low-OPT agnostic hardness can be very strong, even for improper hypotheses. That is the wrong direction for this edge because the source requires efficient improper weak agnostic learnability.
- Kearns, Schapire, and Sellie, *Toward Efficient Agnostic Learning*, already represented locally as `kearns1994`. Relevant point: the weak agnostic guarantee is an additive benchmark against $\operatorname{OPT}_{\mathcal C}$, so padding that raises or preserves a common baseline must still leave enough absolute error budget to force useful correlation.

### Theorem Route

The fair-noise calculation does not suggest a theorem proving the implication true. It only isolates why a natural counterexample route fails.

Suppose a fixed marginal $P$ decomposes into an active PCP slice $A_\varphi$ of mass $w$ and a padded region of mass $1-w$. On the active slice, labels are generated from the PCP acceptance predicate with independent classification noise rate $\eta<1/2$ in the yes case. Off the active slice, labels are fair coins independent of the example and of the proper hypothesis.

For a satisfying $\varphi$, a correct proof has expected error

$$
\operatorname{OPT}\leq \frac{1-w}{2}+\eta w.
$$

A proper hypothesis whose proof accepts the active verifier checks with probability $a$ has error

$$
\frac{1-w}{2}+w\left(\eta+(1-2\eta)(1-a)\right).
$$

If the weak learner has additive tolerance $\beta_P(s)=1/2-\alpha_P(s)$, the yes-case guarantee only implies

$$
a\geq 1-\frac{\beta_P(s)}{w(1-2\eta)}.
$$

To use the returned proper hypothesis as an NP witness, one needs $a$ to beat the PCP soundness $s_{\mathrm{pcp}}$, so the reduction needs

$$
\beta_P(s)<w(1-2\eta)(1-s_{\mathrm{pcp}}).
$$

Even with very low label noise $\eta\approx 0$ and very small PCP soundness, this requires $w$ just above $1/2$ when $\beta_P(s)$ is allowed to be close to $1/2$. Thus the theorem route remains blocked by computational properization, not by sample control: the padding calculation gives no way to project an improper weak learner into $\mathcal C$.

### Counterexample Route

The attempted false witness is:

1. use the PCP active-slice lookup class as the proper class;
2. fix one marginal over all slices at a given input length;
3. label the queried slice according to a satisfiable PCP predicate, with optional low classification noise;
4. label all nonactive regions by fair coins so they contribute the same baseline error to every proper hypothesis;
5. hope that a weak proper learner must output a proper hypothesis whose active-slice acceptance distinguishes satisfiable from unsatisfiable instances.

The route fails at step 5. Fair noise cancels comparisons among hypotheses on the padded region, but it does not amplify the active slice. The weak guarantee is additive in total error, so an active slice of mass $w$ can change total error by at most $w(1-2\eta)$. If $w$ is inverse-polynomial or exponentially small, the active slice cannot force the returned proper hypothesis to have any useful active-slice acceptance when $\beta_P(s)$ may be $1/2-\operatorname{poly}^{-1}$.

This also explains why low-OPT alone is not enough. Replacing fair-noise padding by deterministic zero padding makes the yes optimum smaller, but a wrong-slice or all-zero-style proper hypothesis then pays only about $w(1-\eta)$ on the active region. To rule that out under the weak guarantee again requires

$$
w(1-2\eta)>\beta_P(s),
$$

which is essentially the same mass lower bound.

Known low-OPT weak agnostic hardness results, such as the monomial/halfspace line, show that the desired numerical gap is not fantasy. They do not give this edge's counterexample because their hard distributions are instance-dependent or make improper learning hard as well. Tiegel's fixed Gaussian marginal lower bound is especially informative as a contrast case: it has the fixed marginal and low-OPT flavor, but it rules out even improper agnostic learning, so it cannot witness an improper-to-proper separation.

### Concrete Obstruction

The concrete obstruction is an active-slice mass inequality.

For any fixed-marginal PCP padding construction of this kind, if the off-slice labels are hypothesis-independent fair noise and the active labels have noise rate $\eta<1/2$, a weak proper learner can be forced to reveal PCP acceptance only when

$$
w>\frac{\beta_P(s)}{(1-2\eta)(1-s_{\mathrm{pcp}})}.
$$

Since the marginal-nonuniform weak target allows $\beta_P(s)$ arbitrarily close to $1/2$ up to an inverse-polynomial gap, even excellent PCP soundness and low label noise still demand $w$ close to or above $1/2$. A single fixed marginal cannot assign that much mass to many possible active slices. Assigning the hard instance its own high-mass slice returns to the Depth 1 problem: the marginal then depends on the input instance, so the marginal-dependent polynomial runtime can hide the reduction.

In short: fair-noise padding equalizes irrelevant regions, but the weak agnostic guarantee is too coarse to notice a small active slice.

### Next Directions

- Look for a fixed-marginal construction where every input instance changes a constant-mass part of the conditional label distribution without requiring disjoint active slices.
- Investigate whether a shared PCP verifier with instance-dependent labels on the same verifier-randomness coordinates can avoid the slice mass bound; the main risk is that proper hypotheses for the wrong instance may still fit the shared coordinates.
- Search for a low-OPT proper-only hardness result under one fixed marginal where improper learning is easy by an explicit algorithm, unlike halfspace/lattice lower bounds that rule out improper learners.
- Try to formalize the inequality above as a reusable "fair-noise padding does not amplify weak gaps" lemma for marginal weak-proper open edges.
- If a future construction resolves the edge as `false`, the atlas update should set the edge to `status: "false"`, `evidence: conditional-counterexample`, add the relevant complexity assumption, and add a witness note for the fixed-marginal low-noise PCP class. No atlas changes are justified from Depth 3.

## Depth-4 Entry - 2026-05-05

### Verdict

Still `open`.

Depth 4 pursued the shared-coordinate version of the false-witness route. This is the most promising shape so far: put every hard target at a given size on the same coordinate marginal, make the proper concepts be hard-to-find seeds, and let an improper learner use coordinate lookup/majority so that improper weak agnostic learning remains easy.

The lead does not resolve the edge. It avoids the active-slice mass loss from Depth 3, but it runs into a new quantitative obstruction: the atlas weak agnostic target may have advantage only $\alpha_P(s)=1/2-\beta_P(s)=s^{-C}$ for an unknown marginal-dependent constant $C$. A shared-coordinate cryptographic/codebook construction can force proper weak learning to find a correlated seed only when the coordinate block is large enough relative to $1/\alpha_P(s)^2$; if the block is that large and counted in the learning size, random codeword correlations swamp such a tiny advantage, while if it is not counted, the easy improper lookup learner stops being polynomial-time in the atlas size parameter.

No atlas files should be changed.

### Sources Checked

Local material checked:

- prior Depth 1, Depth 2, and Depth 3 entries in this scratchpad;
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`;
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`;
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`;
- `atlas/arguments/properization-open.md`;
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`;
- `atlas/witnesses/one-way-image-coordinate-class.md`;
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`;
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`;
- `atlas/arguments/clause-satisfaction-proper-hardness.md`;
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`.

Primary or near-primary sources checked:

- Hanneke, Moran, and Thiessen, *Marginal-Nonuniform PAC Learnability*, OpenReview page/PDF: https://openreview.net/forum?id=aoVCFtox89. Relevant point: the polynomial and weak gap may depend on the marginal, but the learner remains one uniform algorithm and the bound is still polynomial in the size parameter.
- Kearns and Valiant, *Cryptographic Limitations on Learning Boolean Formulae and Finite Automata*, JACM/author PDF: https://doi.org/10.1145/174644.174647 and https://www.cis.upenn.edu/~mkearns/papers/cryptojacm.pdf. Relevant point: cryptographic prediction hardness can rule out even weak learning, so any proper-only cryptographic separation must protect the improper learner from that same hardness.
- Håstad, Impagliazzo, Levin, and Luby, *A Pseudorandom Generator from any One-Way Function*, SIAM J. Comput.: https://doi.org/10.1137/S0097539793244708. Relevant point: one-way functions give pseudorandom generators, suggesting a shared-coordinate seed/codeword class, but pseudorandomness also threatens improper weak learning if the learner must predict unseen coordinates.
- Kearns, Schapire, and Sellie, *Toward Efficient Agnostic Learning*, already represented locally as `kearns1994`. Relevant point: the atlas weak agnostic convention is additive against $\operatorname{OPT}_{\mathcal C}$, so low $\operatorname{OPT}$ only helps if the promised advantage is quantitatively visible.

### Theorem Route

The shared-coordinate lead does not suggest a proof that the implication is `true`.

The natural positive hope would be: because all targets share one fixed marginal, maybe the improper learner's behavior on that marginal can be searched, projected, or decoded into a proper concept. The finite-support case makes this tempting. If the support has only $N$ visible coordinates and $N$ is polynomial in the size parameter, then an improper lookup-table ERM can agnostically compete with any proper class whose concepts are functions on those coordinates.

But that observation is not a properization theorem. It gives an efficient improper learner over a larger lookup class; it does not give an efficient way to find the seed or representation required by $\mathcal C$. The one-way image-coordinate notes make this explicit in the strong case: a lookup hypothesis can fit the coordinate labels while proper output would recover a one-way preimage.

For the weak agnostic edge, a generic theorem would still need a polynomial-time map

$$
g \notin \mathcal C
\quad\longmapsto\quad
c\in\mathcal C
$$

preserving error up to about $1/2-\alpha_P(s)$ under the fixed marginal. No such operation follows from marginal nonuniformity, finite VC theory, or coordinate sharing. The theorem route therefore remains blocked by the same computational projection problem as before.

### Counterexample Route

The candidate construction has the following form.

Fix a coordinate universe $[N]$ at seed length $n$ and let $P_{n,N}$ be uniform on the shared coordinates. A proper hypothesis is a seed $t\in\{0,1\}^n$ and labels coordinate $j$ by a codeword bit $W(t)_j$. Given a challenge word $y\in\{0,1\}^N$, samples are $(j,y_j)$ with $j\sim P_{n,N}$. If $y=W(s)$ for some seed $s$, then $\operatorname{OPT}_{\mathcal C}=0$. An improper learner can be the coordinate-majority or lookup learner whenever $N$ is polynomially visible; since the full lookup class contains all proper seed concepts, finite-class or VC-style uniform convergence gives agnostic improper learning against $\mathcal C$.

For proper hardness, suppose a weak proper learner has tolerance $\beta_P(s)=1/2-\alpha_P(s)$. On realizable labels $y=W(s)$ it must output a seed $t$ with

$$
\Pr_{j\sim P_{n,N}}[W(t)_j=y_j]\geq \frac12+\alpha_P(s).
$$

If $W$ is a pseudorandom generator or a random-looking codebook, one would like to distinguish $y=W(s)$ from a uniform random $y$ by checking whether the returned seed has this much correlation with $y$. For random $y$, a union bound gives

$$
\Pr\left[\exists t\in\{0,1\}^n:
\operatorname{corr}(W(t),y)\geq \alpha\right]
\leq 2^n\exp(-\Omega(\alpha^2N)).
$$

Thus the reduction needs roughly

$$
\alpha_P(s)^2N \gg n.
$$

This is the quantitative snag. In the atlas node, $\alpha_P(s)$ may be $s^{-C}$ for an unknown marginal-dependent constant $C$. If the coordinate block size $N$ is itself part of the effective learning size $s$ because the improper learner learns a table over $N$ coordinates, then the condition asks for

$$
N \gg n\,s^{2C}.
$$

For $s\gtrsim N$, this is impossible once $C\geq 1/2$ up to logarithmic slack. More generally, if $N\leq s^d$ for a fixed polynomial-time lookup learner, the union-bound distinguisher only works for weak gaps with $d>2C$. The atlas definition does not give such a bound on $C$.

Trying to repair this by using a huge stretch $N=n^d$ with $d$ chosen after seeing the learner also creates a size-accounting problem. If $d$ is not counted in $s$, the improper learner's table over $N$ coordinates and the evaluation/checking of the codeword need not be polynomial in $s$. If $d$ is counted in $s$ or if $s$ is taken to be comparable to $N$, the promised advantage may shrink as a polynomial in $N$, bringing back the same $\alpha^2N$ obstruction.

The one-way image-coordinate variant fails for a related but more semantic reason. With $W(t)=f(t)$ and $N=n$, weak proper learning only returns a seed whose image agrees with $f(s)$ on a $1/2+\alpha$ fraction of coordinates. Ordinary one-wayness is an exact inversion assumption; it does not rule out finding a preimage whose image is mildly correlated with the challenge image. Adding an error-correcting code does not cleanly fix this in the weak regime: to decode uniquely from radius $1/2-\alpha$ one needs minimum distance above $1-2\alpha$, which is incompatible with large binary codebooks at polynomial coordinate length. Replacing the code by a pseudorandom generator gives a correlation-hardness route, but then the easy improper learner only survives when the coordinate table is polynomially learnable, and the $\alpha^2N$ condition returns.

Low $\operatorname{OPT}$ is already present in this construction: for $y=W(s)$, $\operatorname{OPT}=0$. The failure is not noise. The failure is that $\operatorname{OPT}+1/2-\alpha_P(s)$ may still be so close to $1/2$ that a proper learner is required to find only an extremely tiny correlation, too tiny to imply inversion or pseudorandom distinguishing under a polynomially learnable shared coordinate block.

### Concrete Obstruction

The shared-coordinate route trades the active-slice mass obstruction for an advantage-versus-support obstruction.

To get easy improper agnostic learning by coordinate lookup, the number of relevant shared coordinates must be polynomially visible to the learner. To get proper-only cryptographic hardness from a weak proper learner, a random or pseudorandom codebook argument needs

$$
\alpha_P(s)^2N \gg \log|\mathcal C_s|
$$

so that a random label word has no proper seed with $\alpha_P(s)$ correlation. Since $\log|\mathcal C_s|$ is typically $\Theta(n)$ and the atlas weak advantage may be an arbitrarily small inverse polynomial in the effective size $s$, these requirements do not line up without an extra quantitative promise on the weak gap.

Equivalently:

> A shared-coordinate false witness must make every low-OPT proper target force more than a vanishing correlation advantage, while still allowing an improper polynomial-time learner to learn the shared coordinates. Current one-way, PRG, and codeword variants can satisfy either the proper-hardness side or the improper-easiness side, but not both for the atlas's unrestricted inverse-polynomial weak gap.

### Next Directions

- Search for a locally computable code/PRG family with polynomial-time improper agnostic learning from samples and a list-decoding guarantee at every inverse-polynomial radius measured in the atlas size parameter. This would directly attack the $\alpha^2N$ obstruction.
- Look for a proper-only hardness assumption stronger and more tailored than ordinary one-wayness: for example, hardness of finding any seed whose public image has inverse-polynomial correlation with a challenge image, while coordinate labels remain table-learnable improperly.
- Try a multi-scale coordinate construction with blocks of many polynomial sizes, plus an improper learner that adaptively learns only the empirically heavy block. The open issue is preventing the weak advantage from shrinking with the largest block size.
- Formalize the inequality $\alpha^2N\gg\log|\mathcal C_s|$ as a reusable obstruction note for shared-coordinate weak proper hardness attempts.
- If a future resolution is `false`, the likely atlas changes are: set this edge to `status: "false"`, set `evidence: conditional-counterexample`, add the cryptographic or average-case assumption used for correlation-hard seed finding, add a witness note for the shared-coordinate low-OPT class, and cite the code/PRG/list-decoding source that overcomes the quantitative gap. No such atlas changes are justified at Depth 4.

## Depth-5 Entry - 2026-05-05

### Final Verdict

Still `open`.

At the final depth, I do not see an atlas-ready implication theorem or a valid false witness. The previous four passes leave a coherent picture: every positive route needs a computational properization/projection principle that the source definition does not provide, while every negative route found so far loses either the fixed-marginal condition, the weak-gap size, or the easy-improper-learning side.

No atlas files should be changed from this investigation. The correct current atlas status remains:

- `status: "open"`
- `evidence: unknown`
- `assumptions: []`
- `witnesses: []`

### Sources Checked

Local atlas files and scratchpad entries:

- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- Depth 1 through Depth 4 entries above.

External sources already checked across the prior depths:

- Hanneke, Moran, and Thiessen, *Marginal-Nonuniform PAC Learnability*, OpenReview/PDF: https://openreview.net/forum?id=aoVCFtox89.
- Benedek and Itai, fixed-distribution learnability, DOI recorded in the atlas: https://doi.org/10.1016/0304-3975(91)90026-X.
- Ben-David, Benedek, and Mansour, parameterized distribution-dependent learnability, DOI recorded in the atlas: https://doi.org/10.1006/inco.1995.1094.
- Blumer, Ehrenfeucht, Haussler, and Warmuth, *Learnability and the Vapnik-Chervonenkis Dimension*, JACM 1989 PDF checked in Depth 2.
- Kearns, Schapire, and Sellie, *Toward Efficient Agnostic Learning*, represented locally by `kearns1994`.
- Schapire, *The Strength of Weak Learnability*, author PDF checked in Depth 1.
- Feldman, *Distribution-Specific Agnostic Boosting*, PDF checked in Depths 1 and 2.
- Ben-David, Long, and Mansour, *Agnostic Boosting*, DOI checked in Depth 2.
- Pitt and Valiant, proper learning hardness, DOI recorded in the atlas.
- Khot and Saket, *Hardness of Minimizing and Learning DNF Expressions*, PDF/FOCS DOI checked in Depths 1 and 4.
- Håstad and Khot, *Query Efficient PCPs with Perfect Completeness*, Theory of Computing page checked in Depths 1 through 3.
- Arora, Karger, and Karpinski, dense-instance approximation schemes, publication page checked in Depth 2.
- Feldman, Guruswami, Raghavendra, and Wu, weak agnostic hardness for monomials/halfspaces, SIAM page checked in Depth 3.
- Feldman, Gopalan, Khot, and Ponnuswami, agnostic learning hardness for parities/monomials/halfspaces, accessible text checked in Depth 3.
- Tiegel, fixed-marginal halfspace agnostic hardness from lattices, arXiv checked in Depth 3.
- Kearns and Valiant, cryptographic learning limitations, JACM/author PDF checked in Depth 4.
- Håstad, Impagliazzo, Levin, and Luby, PRGs from one-way functions, DOI checked in Depth 4.

### Theorem Route

The target theorem would take one uniform efficient marginal-nonuniform weak agnostic improper learner and produce one uniform efficient marginal-nonuniform weak agnostic proper learner. For a fixed marginal $P$, the improper learner guarantees

$$
\operatorname{err}_{\mathcal D}(g)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta_P(s),
\qquad \beta_P(s)<1/2.
$$

The required output, however, is some $c\in\mathcal C$ with a comparable bound. The missing step is not statistical; it is computational. Uniform convergence, finite-support lookup, and marginal-dependent sample rates can show that a good proper hypothesis exists on a sample, but they do not provide a polynomial-time way to search $\mathcal C$ or project an arbitrary improper $g$ back into $\mathcal C$.

Boosting also does not close the gap. Classical weak-to-strong and agnostic boosting arguments combine weak hypotheses, often preserving a fixed marginal when only labels are reweighted or relabeled, but the combined predictor is generally an improper aggregate. They do not supply a representation-preserving map into $\mathcal C$.

Thus the theorem route remains blocked unless one adds an extra assumption such as efficient approximate proper ERM/projection under each marginal. That would prove a conditional theorem, not the atlas edge as stated.

### Counterexample Route

The counterexample search split into four families.

First, clause-satisfaction lookup classes separate improper lookup learning from proper assignment search in stronger settings. Under a single fixed marginal over all clauses, though, a sparse formula changes total error by only inverse-polynomial mass. That can refute strong agnostic proper learning at high accuracy, but the weak target may tolerate error $\operatorname{OPT}+1/2-\alpha_P(s)$ with only inverse-polynomial $\alpha_P(s)$, so the returned assignment need not solve SAT. Making the constraint set dense risks falling into known dense-CSP approximation regimes.

Second, PCP active-slice constructions give the right properness flavor and can create a constant weak gap when the marginal concentrates on the active slice. Marginal nonuniformity defeats the direct reduction because the active-slice marginal depends on the hard input. Packing many active slices into one marginal makes each slice too light. Fair-noise or deterministic padding does not amplify a small slice: to force useful PCP acceptance from a weak proper learner, an active slice of mass $w$ must satisfy roughly

$$
w>\frac{\beta_P(s)}{(1-2\eta)(1-s_{\mathrm{pcp}})}.
$$

Since $\beta_P(s)$ may be close to $1/2$, this demands constant or near-half mass per hard instance, impossible for many disjoint slices under one fixed marginal.

Third, shared-coordinate code/PRG constructions avoid disjoint active slices. Let proper concepts be seeds $t$ whose codeword or PRG output $W(t)$ labels a common coordinate set $[N]$, and let the improper learner use coordinate lookup/majority. This protects easy improper agnostic learning when $N$ is polynomially visible. But a weak proper learner on realizable labels only needs to find a seed correlated with the target by $\alpha_P(s)$. A random-codeword or pseudorandom distinguishing argument requires

$$
\alpha_P(s)^2N \gg \log|\mathcal C_s|.
$$

The atlas definition allows $\alpha_P(s)$ to be an arbitrarily small inverse polynomial in the effective size parameter, depending on $P$. If $N$ is counted in that size parameter so the lookup learner is polynomial-time, the required inequality can fail for the unknown weak-gap exponent. If $N$ is hidden outside the size parameter, the improper learner is no longer guaranteed polynomial-time.

Fourth, I tried the genuinely new final lead suggested by Depth 4: a multi-scale shared-coordinate construction. Put blocks of sizes

$$
N_1<N_2<\cdots<N_m
$$

under one marginal, with the hope that some block is large enough for $\alpha_P(s)^2N_i\gg\log|\mathcal C_s|$ while a lookup learner can ignore blocks that are too large or too light. This does not resolve the edge. If the marginal gives each scale nonnegligible mass, there can be only polynomially many useful scales before the total support or sample budget exceeds the polynomial-time lookup requirement. If the larger scales get tiny mass, the weak learner can satisfy its total-error guarantee without extracting correlation from them, recreating the active-slice mass obstruction. If the largest scale dominates the size parameter, the marginal-dependent weak advantage may shrink as a polynomial in that largest scale, recreating the shared-coordinate obstruction. Multi-scale packing therefore interpolates between the two known failures rather than escaping them.

### Concrete Obstruction

The obstruction has two sides.

For a `true` proof, the obstacle is computational properization:

> Marginal nonuniformity changes the allowed polynomial and weak gap for each fixed marginal, but it does not give an efficient algorithm for approximate proper ERM or for converting an arbitrary improper hypothesis into a member of $\mathcal C$.

For a `false` proof, the obstacle is mass and advantage accounting:

> A hard reduction must keep one fixed marginal while making the hard part visible at the weak tolerance scale. Active-slice constructions need too much probability mass per hard instance. Shared-coordinate constructions need $\alpha_P(s)^2N\gg\log|\mathcal C_s|$ while keeping $N$ polynomially learnable by the improper lookup learner. The atlas permits the weak advantage $\alpha_P(s)$ to be too small, with an exponent depending on the marginal, for the known constructions to force a useful proper output.

This is why the edge remains genuinely unresolved rather than merely lacking a citation.

### Atlas-Ready Open-Note Text

Suggested replacement or expansion text for the current implication note, if the atlas note is later refreshed:

```markdown
## Proof Status

**Verdict.** `open`.

**Goal.** Decide whether an efficient marginal-nonuniform weak agnostic improper learner can always be converted into an efficient marginal-nonuniform weak agnostic proper learner for the same class.

**Positive route obstruction.** For a fixed marginal $P$, the source gives a uniform polynomial-time learner whose output may lie outside $\mathcal C$ and whose error is at most $\operatorname{OPT}_{\mathcal C}+\beta_P(s)$ for some marginal-dependent weak tolerance $\beta_P(s)<1/2$. Standard uniform-convergence reasoning can justify the existence of good proper hypotheses, but it does not give a polynomial-time approximate proper ERM or projection procedure. Boosting-style arguments also do not solve this, since their combined hypotheses are generally improper.

**Negative route obstruction.** Known properness-hardness witnesses do not currently survive the marginal-nonuniform weak setting. Clause-satisfaction and PCP active-slice reductions usually place the hard instance in the marginal; then the target may use an instance-dependent marginal polynomial. Packing many hard slices into one fixed marginal makes each slice too small to be detected by a weak guarantee whose advantage may be only inverse-polynomial. Shared-coordinate code or PRG variants keep the marginal fixed and preserve easy improper lookup learning, but proper hardness requires $\alpha_P(s)^2N\gg\log|\mathcal C_s|$, where $\alpha_P(s)=1/2-\beta_P(s)$; the atlas definition permits $\alpha_P(s)$ to be too small relative to any polynomially visible coordinate block.

**Conclusion.** The edge remains open. A proof would need a general efficient properization principle under each fixed marginal. A separation would need a fixed-marginal proper-only hardness construction with an easy improper agnostic learner and a weak-gap scale strong enough to overcome the active-mass or shared-coordinate correlation obstruction.
```

### Exact Atlas Changes If Resolved

Not resolved, so exact atlas changes are: none.

If later resolved as `true`, update `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md` to `status: "true"`, set `evidence: theorem`, add the theorem reference or new argument note establishing efficient marginal fixed properization, and update the body with the construction.

If later resolved as `false`, update the same edge note to `status: "false"`, set `evidence: conditional-counterexample` or `counterexample` as appropriate, add the exact assumption if any, add the witness note for the separating class, add the primary references, and explain why the class satisfies efficient marginal-nonuniform weak agnostic improper learning while failing the proper target.
