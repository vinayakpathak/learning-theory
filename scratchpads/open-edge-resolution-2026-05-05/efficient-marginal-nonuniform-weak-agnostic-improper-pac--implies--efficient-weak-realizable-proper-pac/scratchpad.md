# Depth-1 Resolution: efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-weak-realizable-proper-pac

## Local Context Read

I read the target edge note:

- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-realizable-proper-pac.md`

and the two endpoint definitions:

- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-weak-realizable-proper-pac.md`

Relevant nearby notes:

- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-agnostic-improper-pac.md`
- `atlas/definitions/efficient-weak-agnostic-improper-pac.md`

The current edge note is marked open because it frames the problem as simultaneous marginal-uniformization plus improper-to-proper. But the PCP active-slice witness bypasses the marginal issue: it satisfies the much stronger distribution-free strong agnostic improper source, hence also the marginal-nonuniform weak agnostic improper source.

## Verdict

Resolved false, conditionally on $\mathrm{NP}\nsubseteq\mathrm{RP}$.

Use the PCP active-slice lookup class. It is efficiently agnostically learnable by an improper one-slice lookup-table ERM, so it satisfies the source by monotone relaxation. An efficient weak realizable proper learner for the same class would decide an NP-complete language with one-sided randomized error.

## Counterexample

Fix a logarithmic-randomness PCP verifier for an NP-complete language with perfect completeness and soundness $s<1/2$. Håstad and Khot give such PCPs: for fixed constant parameters, the verifier uses logarithmic randomness, has perfect completeness, and has soundness below one half. Karp supplies the standard NP-completeness basis.

For an instance $\varphi$ and proof string $\pi$, define the proper concept $c_{\varphi,\pi}$ on examples $(\psi,r)$ by

$$
c_{\varphi,\pi}(\psi,r)=1
\quad\Longleftrightarrow\quad
\psi=\varphi \text{ and } V(\varphi,\pi,r)=1.
$$

If $\psi\neq\varphi$, the concept outputs $0$. Since $r$ has logarithmic length, the active slice $\{(\varphi,r)\}$ has polynomial size.

## Why The Source Holds

The source asks only for marginal-nonuniform weak agnostic improper learning. The witness has the stronger property of efficient distribution-free strong agnostic improper learning.

For each size parameter, let the improper comparison/output class contain the all-zero hypothesis and every one-slice lookup table: choose an active instance $\psi$, then choose an arbitrary Boolean table over the polynomially many verifier random strings $r$ on that slice, and output $0$ off the slice.

This improper class contains every proper concept $c_{\varphi,\pi}$. Its logarithmic size is polynomial: specifying $\psi$ costs polynomially many bits, and the lookup table has polynomially many entries because the verifier randomness is logarithmic.

ERM is polynomial on a sample. Only slices that appear in the sample can beat the all-zero hypothesis on empirical error; for each sampled slice, the best table is obtained by empirical majority vote independently for each sampled $r$. Standard finite-class uniform convergence gives, with polynomially many samples,

$$
\operatorname{err}_{\mathcal D}(\hat h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\varepsilon
$$

for every joint distribution $\mathcal D$. Thus the class is efficiently agnostically PAC learnable improperly. Running this learner with any fixed $\varepsilon<1/2$, for example $\varepsilon=1/3$, gives the weak agnostic guarantee with a constant gap. Since the guarantee is distribution-free, the same polynomial can be used as $p_P$ for every marginal $P$ in the marginal-nonuniform source definition.

## Why The Target Fails

Suppose there were an efficient weak realizable proper PAC learner for this class. Given an NP instance $\varphi$, define a distribution that samples $r$ uniformly from the active slice and labels every example $(\varphi,r)$ by $1$.

If $\varphi$ is satisfiable, perfect completeness gives a proof $\pi^\star$ such that $c_{\varphi,\pi^\star}$ labels the whole active slice by $1$. Hence the distribution is realizable. The weak proper learner must return a proper concept with error at most $1/2-\gamma(n)$ for some inverse-polynomial $\gamma(n)>0$. Therefore the returned proof is accepted on more than half of the verifier random strings.

If $\varphi$ is unsatisfiable, PCP soundness says every proof is accepted on at most an $s<1/2$ fraction of verifier random strings. Any proper hypothesis whose active instance is not $\varphi$ accepts none of the active slice. Thus no proper hypothesis can pass the threshold of acceptance greater than $1/2$.

Because the active slice has polynomial size, the reduction can enumerate all verifier random strings and exactly compute the returned proper hypothesis's acceptance fraction. Accept iff this fraction is greater than $1/2$. This gives a randomized polynomial-time one-sided decision procedure for the NP-complete language: satisfiable instances are accepted with the learner's success probability, and unsatisfiable instances are never accepted. Therefore the target would imply $\mathrm{NP}\subseteq\mathrm{RP}$.

Under $\mathrm{NP}\nsubseteq\mathrm{RP}$, the target does not hold for this class, while the source does.

## Proposed Atlas Update

Change the edge to a conditional false edge:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - "NP not subset RP"
witnesses:
  - pcp-active-slice-lookup-class
ref_keys:
  - blumer1989
  - hastad2005query
  - karp1972
summary: "False under NP not subset RP: the PCP active-slice lookup class is efficiently agnostically learnable improperly, hence satisfies the marginal-nonuniform weak agnostic improper source, but weak realizable proper learning would decide an NP-complete language."
family: pcp-active-slice-weak-proper-hardness
argument_note: "[[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]"
witness_note: "[[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]"
```

Suggested body replacement: adapt the proof from `efficient-agnostic-improper-pac--implies--efficient-weak-realizable-proper-pac.md`, adding one sentence that the distribution-free strong agnostic improper learner implies the marginal-nonuniform weak agnostic improper source via `efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`.

## Source Checks

- Håstad and Khot, "Query Efficient PCPs with Perfect Completeness", Theory of Computing 2005: the abstract states logarithmic randomness, perfect completeness, and soundness $2^{-k^2}+\epsilon$, which is below $1/2$ for fixed suitable $k$ and small $\epsilon$: https://theoryofcomputing.org/articles/v001a007/
- Blumer, Ehrenfeucht, Haussler, and Warmuth, "Learnability and the Vapnik-Chervonenkis dimension", JACM 1989, is the standard finite-class/VC uniform convergence reference: https://dblp.org/rec/journals/jacm/BlumerEHW89
- Karp, "Reducibility among Combinatorial Problems", 1972, is the standard NP-completeness reference: https://doi.org/10.1007/978-1-4684-2001-2_9

verdict: resolved-false
confidence: high
