# Bibliography

This file records sources cited by iteration reports. Items marked "needs direct audit" should not be used for strong atlas claims until checked against the primary theorem statements.

## Agnostic Boosting

- Ben-David, Shai; Long, Philip M.; Mansour, Yishay. 2001. "Agnostic Boosting." COLT/EuroCOLT. DOI cited in reports: `10.1007/3-540-44581-1_33`. Status: needs direct audit.
- Gavinsky, Dmitry. 2003. "Optimally-Smooth Adaptive Boosting and Application to Agnostic Learning." JMLR. URL cited in reports: `https://www.jmlr.org/papers/v4/gavinsky03a.html`. Status: needs direct audit.
- Kalai, Adam; Mansour, Yishay; Verbin, Elad. 2008. "On Agnostic Boosting and Parity Learning." STOC. URL cited in reports: `https://www.microsoft.com/en-us/research/wp-content/uploads/2016/11/2008-On_Agnostic_Boosting-and_Parity_Learning.pdf`.
- Feldman, Vitaly. 2010. "Distribution-Specific Agnostic Boosting." URL cited in reports: `https://arxiv.org/abs/0909.2927`.
- Kalai, Adam; Kanade, Varun. 2009. "Potential-Based Agnostic Boosting." NeurIPS. URL cited in reports: `https://papers.neurips.cc/paper/3676-potential-based-agnostic-boosting`.
- Ghai, Udaya; Singh, Karan. 2024. "Sample-Efficient Agnostic Boosting." URL cited in reports: `https://arxiv.org/abs/2410.23632`.
- Ghai, Udaya; Singh, Karan. 2025. "Sample-Optimal Agnostic Boosting with Unlabeled Data." PMLR URL cited in reports: `https://proceedings.mlr.press/v267/ghai25a.html`.
- da Cunha, Arthur; Hogsgaard, Mikkel; Paudice, Andrea; Sun, Yuxuan. 2025. "Revisiting Agnostic Boosting." URL cited in reports: `https://arxiv.org/abs/2503.09384`.
- da Cunha, Arthur; Green Larsen, Kasper; Ritzert, Martin. 2025. "Boosting, Voting Classifiers and Randomized Sample Compression Schemes." PMLR URL cited in reports: `https://proceedings.mlr.press/v272/cunha25a.html`. Status: background only; iteration 3 did not use it for a claim.
- da Cunha, Arthur; Hogsgaard, Mikkel; Paudice, Andrea. 2026. "Sample-Near-Optimal Agnostic Boosting with Improved Running Time." URL cited in reports: `https://arxiv.org/abs/2601.11265`. Status: iteration 2 audit identifies tuple enumeration, final vote search, and `H=Range(A)` capacity assumptions as the key atlas-efficiency bottlenecks.

## Realizable Boosting And Compression Background

- Schapire, Robert E. 1990. "The Strength of Weak Learnability." URL cited in reports: `https://www.schapire.net/papers/strengthofweak.pdf`.
- Freund, Yoav; Schapire, Robert E. 1997. "A Decision-Theoretic Generalization of On-Line Learning and an Application to Boosting." JCSS. URL cited in reports: `https://dblp.uni-trier.de/rec/journals/jcss/FreundS97.html`.
- Floyd, Sally; Warmuth, Manfred K. 1995. Sample compression reference cited in reports. URL cited: `https://mwarmuth.bitbucket.io/pubs/J30.pdf`.

## SQ / Oracle-Barrier Background

- Kearns, Michael J. 1998. "Efficient Noise-Tolerant Learning from Statistical Queries." JACM. URL cited in reports: `https://homepages.math.uic.edu/~lreyzin/papers/kearns98.pdf`. Status: background for restricted-access/noise-tolerant lower-bound thinking; not direct support for public-filter lemmas.
- Blum, Avrim; Furst, Merrick; Jackson, Jeffrey; Kearns, Michael; Mansour, Yishay; Rudich, Steven. 1994. "Weakly Learning DNF and Characterizing Statistical Query Learning Using Fourier Analysis." STOC. URLs cited in reports: `https://research.duq.edu/mathcs/_jackson/dnfsq.pdf`, `https://doi.org/10.1145/195058.195147`. Status: background only unless a future SQ reduction is written.

## CSP / Refutation / Improper-Hardness Background

- Hastad, Johan. 2001. "Some Optimal Inapproximability Results." URLs cited in iteration 6 reports include `https://people.kth.se/~johanh/optimalinap.pdf` and DBLP/CiNii pages. Status: assignment-optimization inapproximability background; not direct improper PAC hardness.
- Raghavendra, Prasad. 2008. "Optimal Algorithms and Inapproximability Results for Every CSP?" STOC. URLs cited in iteration 6 reports include `https://www.cs.cornell.edu/~abrahao/tdg/papers/p245.pdf`. Status: standard CSP approximation/inapproximability background; does not supply arbitrary improper prediction hardness or signed distribution-free weak learning by itself.
- Karloff, Howard; Zwick, Uri. 1997. "A 7/8-Approximation Algorithm for MAX 3SAT?" URL cited in iteration 6 reports: `https://cris.tau.ac.il/en/publications/78-approximation-algorithm-for-max-3sat/`. Status: positive Max-3SAT approximation background; not a signed agnostic weak learner.
- Daniely, Amit; Linial, Nati; Shalev-Shwartz, Shai. 2013/2014. "From Average Case Complexity to Improper Learning Complexity." URL cited in reports: `https://arxiv.org/abs/1311.2272`. Status: relevant background for improper-learning hardness from average-case/refutation assumptions; needs exact instantiation before use.
- Daniely, Amit; Shalev-Shwartz, Shai. 2016. "Complexity Theoretic Limitations on Learning DNF's." PMLR URL cited in reports: `https://proceedings.mlr.press/v49/daniely16.html`. Status: relevant improper-hardness/refutation background; not a weak approximation algorithm.
- Kothari, Pravesh K.; Livni, Roi. 2018. "Improper Learning by Refuting." URLs cited in reports include `https://arxiv.org/abs/1709.03871` and `https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.ITCS.2018.55`. Status: relevant refutation/improper-learning background; no current ledger claim relies on a theorem-level application.

## Realizable-Learning Related Background

- Hopkins, Samuel B.; Kane, Daniel M.; Lovett, Shachar; Mahajan, Gaurav. 2024. "Realizable Learning is All You Need." TheoretiCS. URL cited in reports: `https://theoretics.episciences.org/13009`. Status: cited by iteration 2 exploration as related context; not yet used for a ledger claim.

## Hard-Core / Dense-Model Background

- Impagliazzo, Russell. 1995. "Hard-Core Distributions for Somewhat Hard Problems." DBLP URL cited in iteration 5 reports: `https://dblp.uni-trier.de/rec/conf/focs/Impagliazzo95.html`. Status: background analogy only; does not prove the public low-OPT chunk lemma.
- Barak, Boaz; Hardt, Moritz; Kale, Satyen. "The Uniform Hardcore Lemma via Approximate Bregman Projections." URL cited in iteration 5 reports: `https://www.boazbarak.org/Papers/hardcore.pdf`. Status: background only; needs direct audit before theorem-level use.
- Klivans, Adam R.; Servedio, Rocco A. 1999. "Boosting and Hard-Core Sets." URL cited in iteration 5 reports: `https://www.cs.columbia.edu/~rocco/Public/focs99.pdf`. Status: background only; no current ledger claim relies on its theorem statements.

## Halfspace And Vote-Selector Hardness Background

- Guruswami, Venkatesan; Raghavendra, Prasad. 2009. "Hardness of Learning Halfspaces with Noise." SIAM Journal on Computing. URLs cited in iteration 4 reports: `https://epubs.siam.org/doi/10.1137/070685798`, `https://www.cs.cmu.edu/~venkatg/pubs/papers/halfspace_Full.pdf`. Status: background warning for generic vote selectors; needs exact mapping to the allowed vote class before theorem-level use.
- Tiegel, Stefan. 2023. Improper agnostic halfspace-learning hardness from worst-case lattice assumptions. URL cited in iteration 4 reports: `https://arxiv.org/abs/2207.14030`. Status: background only; needs direct audit.

## Sparse-Majority Selector And Set-Cover Background

- Downey, Rodney G.; Fellows, Michael R. 1995. "Fixed-Parameter Tractability and Completeness I." DOI cited in iteration 7 reports: `https://doi.org/10.1137/S0097539792228228`. Status: background for W[2]-hardness; the in-run selector reduction uses standard Set Cover W[2]-hardness.
- Feige, Uriel. 1998. "A Threshold of ln n for Approximating Set Cover." DOI cited in iteration 7 reports: `https://doi.org/10.1145/285055.285059`. Status: background for Set Cover / Max k-Cover gaps; exact empirical-risk gap transfer still needs a written parameter audit.
- Lin, Bingkai. 2022. "Constant Approximating Parameterized k-SetCover is W[2]-hard." URL cited in iteration 7 reports: `https://arxiv.org/abs/2202.04377`. Status: parameterized approximation background; not required for the zero-error selector-hardness lemma.

## Coding-Theory Background

- Berlekamp, Elwyn R.; McEliece, Robert J.; van Tilborg, Henk C. A. 1978. "On the Inherent Intractability of Certain Coding Problems." URL cited in reports: `https://authors.library.caltech.edu/records/aw9vs-ann16`. Status: classical full-word/proper decoding hardness; not direct improper PAC evidence.
- Arora, Sanjeev; Babai, Laszlo; Stern, Jacques; Sweedyk, Z. 1997. "The Hardness of Approximate Optima in Lattices, Codes, and Systems of Linear Equations." DOI cited in reports: `https://doi.org/10.1006/jcss.1997.1472`. Status: coding hardness background; not direct improper PAC evidence.
- Dumer, Ilya; Micciancio, Daniele; Sudan, Madhu. 2003. "Hardness of Approximating the Minimum Distance of a Linear Code." URL cited in reports: `https://cseweb.ucsd.edu/~daniele/papers/DMS.html`. Status: coding hardness background.
- Guruswami, Venkatesan; Sudan, Madhu. 1999. "Improved Decoding of Reed-Solomon and Algebraic-Geometric Codes." URL cited in reports: `https://www.itsoc.org/publications/papers/improved-decoding-of-reed-solomon-and-algebraic-geometry-codes`. Status: positive list-decoding/background caveat.
- Guruswami, Venkatesan; Vardy, Alexander. 2005. "Maximum-Likelihood Decoding of Reed-Solomon Codes is NP-hard." URL cited in reports: `https://arxiv.org/abs/cs/0405005`. Status: full-word ML decoding hardness; not direct sample-access improper prediction hardness.
- Blum, Avrim; Kalai, Adam; Wasserman, Hal. 2003. "Noise-Tolerant Learning, the Parity Problem, and the Statistical Query Model." URLs cited in reports: `https://arxiv.org/abs/cs/0010022`, `https://www.microsoft.com/en-us/research/publication/noise-tolerant-learning-parity-problem-statistical-query-model/`. Status: parity/LPN background; suggests parity-like codes make the weak low-noise side hard as well.

## Additional CSP / Refutation Audit Sources From Iteration 7

- Vadhan, Salil. 2017. "On Learning vs. Refutation." PMLR URL cited in iteration 7 reports: `https://proceedings.mlr.press/v65/vadhan17a.html`. Status: useful learning/refutation vocabulary; not yet mapped to this high-noise agnostic improper edge.
- Allen, Sarah; O'Donnell, Ryan; Witmer, David. 2015. "How to Refute a Random CSP." URL cited in iteration 7 reports: `https://arxiv.org/abs/1505.04383`. Status: random-CSP refutation background; no current ledger claim relies on a theorem-level application.
- Goemans, Michel X.; Williamson, David P. 1995. "Improved Approximation Algorithms for Maximum Cut and Satisfiability Problems Using Semidefinite Programming." URL cited in iteration 7 reports: `https://research.ibm.com/publications/improved-approximation-algorithms-for-maximum-cut-and-satisflability-problems-using-semidefinite-programming`. Status: explicit Max-Cut/CSP approximation background; does not supply a succinct distribution-free signed weak learner.
- Makarychev, Konstantin; Makarychev, Yury. 2014. "Approximation Algorithm for Non-Boolean Max-k-CSP." URL cited in iteration 7 reports: `https://theoryofcomputing.org/articles/v010a013/v010a013.pdf`. Status: high-arity CSP approximation background; ratios cited in reports are too small for the needed weak-side threshold without further structure.
- Guruswami, Venkatesan; Hastad, Johan; Manokaran, Rajsekar; Raghavendra, Prasad; Charikar, Moses. "Beating the Random Ordering Is Hard." URLs cited in iteration 7 reports include `https://epubs.siam.org/doi/10.1137/090756144` and `https://www.csc.kth.se/~rajsekar/papers/ocsp.pdf`. Status: ordering-CSP hardness background; not direct improper PAC hardness.

## Parity / LPN / Goldreich-Levin Background

- Goldreich, Oded; Levin, Leonid A. 1989. "A Hard-Core Predicate for all One-Way Functions." URLs cited in iteration 8 reports include `https://www.wisdom.weizmann.ac.il/~oded/gl.html` and `https://www.cs.bu.edu/fac/lnd/pdf/hard.pdf`. Status: theorem-level background for recovering/list-decoding a parity with noticeable correlation from an efficiently evaluable predictor; it does not itself assert LPN hardness.
- Blum, Avrim; Kalai, Adam; Wasserman, Hal. 2003. "Noise-Tolerant Learning, the Parity Problem, and the Statistical Query Model." Already listed under coding-theory background. Iteration 8 uses it only as noisy-parity/LPN context, not as an unconditional hardness theorem.
- Bogdanov, Andrej; Sabin, Manuel; Vasudevan, Prashant Nalini. 2019. "XOR Codes and Sparse Learning Parity with Noise." SODA 2019, 986-1004. DBLP URL checked: `https://dblp.org/rec/conf/soda/BogdanovSV19`. Status: sparse-LPN/noisy planted linear equations background for iteration 9; not currently used as a theorem-level hardness assumption.
- Mao, Songtao. 2026. "Near Optimal Algorithms for Noisy k-XOR under Low-Degree Heuristic." arXiv:2604.10457. URL checked: `https://arxiv.org/abs/2604.10457`. Status: current noisy-`k`-XOR recovery/detection background; useful for parameter auditing, not a ledger hardness theorem.

## Local Atlas Context

- `problem.md` in this run.
- `atlas/arguments/agnostic-boosting-open.md` from the parent project.
- `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac.md` from the parent project.

## Iteration 10 Source Status

Iteration 10 did not introduce new external sources. The ghost-transfer, random-vote-list, needle-cover, and stability/compression/quotient notes are in-run arguments or conditional frameworks built from the existing local ledger. Before any atlas-level statement uses standard stability or sample-compression generalization theorems, those theorem statements should be directly audited and added here.
