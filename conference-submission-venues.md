# Conference Submission Venues For Learning Theory Problems

Last checked: 2026-05-05.

This is an exhaustive practical list of serious archival conferences I would consider for
the learning-theory problems in this repository: PAC and agnostic learning, proper versus
improper learning, weak learning and boosting, computational hardness of learning,
sample/computational complexity separations, distributional assumptions, online learning,
privacy/fairness constraints, and related complexity-theoretic reductions.

I am not including small regional conferences, broad pay-to-publish venues, purely applied
domain conferences, or individual workshops except where the workshop deadlines are useful
as a fallback. When the next cycle is not posted yet, I record the latest official cycle
and say so explicitly.

## How To Prioritize

For a pure learning-theory theorem, try COLT first and ALT second. If the result is
especially clean, broadly machine-learning relevant, or speaks to modern models, ICML,
NeurIPS, AISTATS, UAI, and sometimes ICLR can be plausible.

For a complexity or reduction paper whose main contribution is a new lower bound,
separation, average-case barrier, or cryptographic/complexity connection, also consider
STOC, FOCS, CCC, ITCS, ICALP, SODA, and APPROX/RANDOM depending on the techniques.

For work whose mathematical content is embedded in AI, data mining, fairness, economics,
or uncertainty, the secondary targets are IJCAI/ECAI, AAAI, KDD, ECML PKDD, ACM EC, and
ACM FAccT. These should usually be used only when the paper is framed for that community.

## Primary Learning Theory Venues

### COLT - Conference on Learning Theory

- Fit: Best match for the atlas. COLT explicitly covers theoretical aspects of machine
  learning, including learnability, statistical and computational complexity of learning,
  supervised/agnostic/online learning, high-dimensional statistics, and constraints such as
  privacy, fairness, memory, and communication.
- 2026 location: San Diego, California, USA; Bahia Resort Hotel.
- 2026 dates: June 29-July 3, 2026.
- 2026 important dates:
  - Submission deadline: February 4, 2026 AoE.
  - Reviews released: April 3, 2026.
  - Initial author response due: April 10, 2026.
  - Discussion period: April 10-April 20, 2026.
  - Author notification: May 4, 2026.
  - Workshop/tutorial/community event proposals: May 7, 2026.
  - Conference: June 29-July 3, 2026.
- Status as of 2026-05-05: 2026 main-track submissions are closed.
- Source: [COLT 2026 homepage](https://learningtheory.org/colt2026/),
  [COLT 2026 CFP](https://learningtheory.org/colt2026/cfp.html).

### ALT - International Conference on Algorithmic Learning Theory

- Fit: Core target. ALT is dedicated to theoretical and algorithmic aspects of machine
  learning, including statistical/computational foundations, online learning, robustness,
  sample complexity, learning with combinatorial structure, and algorithmic constraints.
- 2026 location: Fields Institute, Toronto, Canada.
- 2026 dates: Main conference February 23-26, 2026; ShaiFest February 27, 2026.
- 2026 important dates:
  - Paper submission deadline: October 2, 2025, 11:59 PM AoE.
  - Author feedback: November 17-23, 2025.
  - Author notification: December 18, 2025.
  - Main conference: February 23-26, 2026.
- Status as of 2026-05-05: 2026 cycle is complete; next CFP not posted on the official
  site when checked.
- Source: [ALT 2026 homepage](https://algorithmiclearningtheory.org/alt2026/),
  [ALT 2026 CFP](https://algorithmiclearningtheory.org/alt2026/call-for-papers/).

## Broad Machine Learning And Statistics Venues

### ICML - International Conference on Machine Learning

- Fit: Strong if the result has broad ML interest or can be framed as theory of machine
  learning. The 2026 CFP explicitly includes statistical learning theory, bandits, game
  theory, decision theory, optimization, trustworthy ML, and general ML.
- 2026 location: COEX Convention and Exhibition Center, Seoul, South Korea.
- 2026 dates: July 6-11, 2026.
- 2026 important dates:
  - Submission site opens: January 8, 2026.
  - Abstract deadline: January 23, 2026 AoE.
  - Full paper deadline: January 28, 2026 AoE.
  - Reviews released to authors: March 24, 2026 AoE.
  - Author response deadline: March 30, 2026 AoE.
  - Author-reviewer discussion ends: April 7, 2026 AoE.
  - Author notification: April 30, 2026 AoE.
  - Tutorials/expo: July 6, 2026.
  - Main conference: July 7-9, 2026.
  - Workshops: July 10-11, 2026.
- Status as of 2026-05-05: 2026 main-track submissions are closed.
- Source: [ICML 2026 CFP](https://icml.cc/Conferences/2026/CallForPapers),
  [ICML 2026 dates](https://icml.cc/Conferences/2026/Dates).

### NeurIPS - Neural Information Processing Systems

- Fit: Strong if the result can be made broadly interesting to ML/AI. NeurIPS is less
  theory-specialist than COLT/ALT but very receptive to clean theory with ML consequences.
- 2026 location: Official site lists Sydney, Australia; Atlanta, Georgia, USA; and Paris,
  France as 2026 sites/satellites. The dates page lists Georgia World Congress Center,
  International Convention Centre, and Palais des Congres de Paris.
- 2026 dates: December 6-12, 2026.
- 2026 important dates:
  - Main-track abstract deadline: May 4, 2026 AoE.
  - Main-track full paper deadline: May 6, 2026 AoE.
  - Main-track author notifications: September 24, 2026 AoE.
  - Workshop application deadline: June 6, 2026 AoE.
  - Workshop acceptance notifications: July 11, 2026 AoE.
  - Suggested workshop-contribution submission date: August 29, 2026 AoE.
  - Workshop mandatory accept/reject notification: September 29, 2026 AoE.
  - Conference sessions: December 8-10, 2026.
  - Workshops: December 11-12, 2026.
- Status as of 2026-05-05: Abstract deadline has passed. The May 6, 2026 full-paper
  deadline is only useful for work whose abstract was already submitted.
- Source: [NeurIPS 2026 homepage](https://nips.cc/Conferences/2026),
  [NeurIPS 2026 dates](https://nips.cc/Conferences/2026/Dates).

### ICLR - International Conference on Learning Representations

- Fit: Good only if the result is connected to representation learning, deep learning,
  optimization, generalization, feature learning, in-context learning, or LLMs. Not the
  default for classical PAC/properization questions unless the framing is very modern.
- 2026 location: Rio de Janeiro, Brazil; Riocentro Convention and Event Center.
- 2026 dates: April 23-27, 2026.
- 2026 important dates:
  - Abstract deadline: September 19, 2025 AoE.
  - Paper deadline: September 24, 2025 AoE.
  - Reviews released: November 11, 2025.
  - Discussion ends: December 3, 2025.
  - Decision notification: January 25, 2026 AoE.
  - Main conference: April 23-25, 2026.
  - Workshops: April 26-27, 2026.
- Status as of 2026-05-05: 2026 cycle is over; 2027 submission dates were not posted on
  the official site when checked.
- Source: [ICLR 2026 homepage](https://iclr.cc/Conferences/2026),
  [ICLR 2026 dates](https://iclr.cc/Conferences/2026/Dates).

### AISTATS - Artificial Intelligence and Statistics

- Fit: Strong for statistical learning theory, sample complexity, decision theory,
  Bayesian/probabilistic methods, optimization, online learning, bandits, and results at
  the ML/statistics interface.
- 2026 location: Tangier, Morocco.
- 2026 dates: May 2-5, 2026.
- 2026 important dates:
  - Abstract deadline: September 25, 2025 AoE.
  - Full paper deadline: October 2, 2025 AoE.
  - Supplementary material deadline: October 9, 2025 AoE.
  - Author rebuttal begins: November 22, 2025.
  - Author-reviewer discussion: December 1-8, 2025.
  - Paper decision notifications: January 22, 2026 AoE.
  - Journal-to-conference submission deadline: January 31, 2026 AoE.
  - Camera-ready deadline: March 31, 2026 AoE.
  - Conference begins: May 2, 2026.
- Status as of 2026-05-05: 2026 conference is ending today; next CFP not posted on the
  official site when checked.
- Source: [AISTATS 2026 CFP](https://virtual.aistats.org/Conferences/2026/CallForPapers),
  [AISTATS 2026 dates](https://virtual.aistats.org/Conferences/2026/Dates).

### UAI - Conference on Uncertainty in Artificial Intelligence

- Fit: Good for learning theory connected to probabilistic modeling, uncertainty,
  causality, Bayesian methods, decision theory, and rigorous ML/statistics.
- 2026 location: KIT Events, Amsterdam, Netherlands.
- 2026 dates: Tutorials August 17, main conference August 18-20, workshops August 21,
  2026.
- 2026 important dates:
  - Submission starts: January 25, 2026.
  - Paper deadline: February 25, 2026, 23:59 AoE.
  - Reviews released: April 23, 2026.
  - Author response/discussion: April 23-May 2, 2026.
  - Author notification: June 1, 2026, 23:59 AoE.
  - Camera-ready deadline: July 8, 2026, 23:59 AoE.
  - Tutorials: August 17, 2026.
  - Main conference: August 18-20, 2026.
  - Workshops: August 21, 2026.
- Status as of 2026-05-05: Submission deadline passed; decisions still upcoming.
- Source: [UAI 2026 important dates](https://www.auai.org/uai2026/important_dates),
  [UAI 2026 CFP](https://www.auai.org/uai2026/call_for_papers).

### ECML PKDD - European Conference on Machine Learning and Principles and Practice of Knowledge Discovery in Databases

- Fit: Good European ML/data-mining venue. Best if the learning-theory paper is framed as
  a general ML result, data-mining foundation, or theoretical insight for knowledge
  discovery.
- 2026 location: Naples, Italy.
- 2026 dates: September 7-11, 2026.
- 2026 research-track important dates:
  - CMT submission system opens: February 5, 2026.
  - Abstract deadline: March 5, 2026.
  - Paper deadline: March 12, 2026.
  - Author notification: May 27, 2026.
  - Camera-ready deadline: June 18, 2026.
  - Conference: September 7-11, 2026.
- Status as of 2026-05-05: 2026 research-track submission deadline passed; notification
  is upcoming.
- Source: [ECML PKDD 2026 homepage](https://ecmlpkdd.org/2026/),
  [ECML PKDD 2026 research track](https://ecmlpkdd.org/2026/submissions-research-track).

## General AI And Data Mining Venues

### AAAI - AAAI Conference on Artificial Intelligence

- Fit: Plausible for broad AI-facing learning theory, especially if connected to
  algorithms, search, reasoning, planning, alignment, social impact, or modern AI systems.
  Pure theorem-only PAC work is usually better aimed at COLT/ALT/theory venues.
- 2026 location: Singapore EXPO, Singapore.
- 2026 dates: January 20-27, 2026.
- 2026 main technical track important dates:
  - Abstract deadline: July 25, 2025 AoE.
  - Full paper deadline: August 1, 2025 AoE.
  - Supplementary material/code deadline: August 4, 2025 AoE.
  - Final notification: November 3, 2025.
  - Conference: January 20-27, 2026.
- Status as of 2026-05-05: 2026 cycle is complete; 2027 CFP not posted on the official
  site when checked. The official AAAI page was Cloudflare-blocked from the local shell,
  but indexed official search snippets provided the above dates.
- Source: [AAAI-26 main technical track CFP](https://aaai.org/conference/aaai/aaai-26/main-technical-track-call/),
  [AAAI-26 homepage](https://aaai.org/conference/aaai/aaai-26/).

### IJCAI/ECAI - International Joint Conference on Artificial Intelligence / European Conference on Artificial Intelligence

- Fit: Plausible for broad AI-facing learning theory. Stronger fit when the theorem says
  something about AI methods, reasoning, robustness, alignment, or general AI foundations.
- 2026 location: Bremen, Germany.
- 2026 dates: August 15-21, 2026.
- 2026 important dates:
  - Abstract deadline: January 12, 2026.
  - Full paper deadline: January 19, 2026.
  - Non-primary paper payment deadline: January 26, 2026.
  - Summary reject notification: March 4, 2026.
  - Author response: April 7-10, 2026.
  - Paper notification: April 29, 2026.
  - Conference: August 15-21, 2026.
- Status as of 2026-05-05: 2026 main-track submission and notification have passed;
  camera-ready dates may still apply for accepted papers.
- Source: [IJCAI-ECAI 2026 main-track CFP](https://2026.ijcai.org/ijcai-ecai-2026-call-for-papers-main-track/).

### KDD - ACM SIGKDD Conference on Knowledge Discovery and Data Mining

- Fit: Secondary fit. Use for data-mining/data-science-facing theory, scalable learning,
  foundations of data science, trustworthy/responsible data science, graph/time-series
  learning, or methods with strong empirical or systems relevance. Less natural for a
  purely abstract PAC separation.
- 2026 location: International Convention Center Jeju, Jeju, Korea.
- 2026 dates: August 9-13, 2026.
- 2026 research-track Cycle 2 important dates:
  - Abstract deadline: February 1, 2026 AoE.
  - Paper deadline: February 8, 2026 AoE.
  - Author rebuttal: April 4-17, 2026.
  - Notification: May 16, 2026.
  - Camera-ready: TBD on the official page.
- 2026 Cycle 1 dates:
  - Abstract deadline: July 24, 2025 AoE.
  - Paper deadline: July 31, 2025 AoE.
  - Rebuttal: October 4-18, 2025.
  - Notification: November 23, 2025.
- Status as of 2026-05-05: 2026 submission deadlines passed; Cycle 2 notification is
  upcoming.
- Source: [KDD 2026 homepage](https://kdd2026.kdd.org/),
  [KDD 2026 research-track CFP](https://kdd2026.kdd.org/research-track-call-for-papers/).

## Theory, Algorithms, And Complexity Venues

### STOC - ACM Symposium on Theory of Computing

- Fit: Strong for major theory contributions: new complexity separations, reductions,
  computational learning theory breakthroughs, cryptographic or average-case hardness,
  Boolean function analysis, pseudorandomness, optimization, and foundational ML theory.
- 2026 location: Salt Lake City, Utah, USA.
- 2026 dates: June 22-26, 2026.
- 2026 important dates:
  - Paper submission deadline: November 4, 2025, 4:59 PM EST.
  - Notification: February 1, 2026.
  - Final version due: March 31, 2026 AoE.
  - Conference: June 22-26, 2026.
- Status as of 2026-05-05: 2026 submissions are closed; 2027 CFP not posted when checked.
- Source: [STOC 2026 homepage](https://acm-stoc.org/stoc2026/),
  [STOC 2026 CFP](https://acm-stoc.org/stoc2026/STOC-2026-CFP.html).

### FOCS - IEEE Symposium on Foundations of Computer Science

- Fit: Strong for major theory contributions. The 2026 CFP explicitly includes
  computational learning theory and foundations of machine learning, along with
  complexity, pseudorandomness, cryptography, privacy/fairness, approximation, and
  optimization.
- 2026 location: New York City, New York, USA.
- 2026 dates: November 8-11, 2026.
- 2026 important dates:
  - Paper submission deadline: April 1, 2026, 5:00 PM EDT.
  - Paper notification: July 3, 2026.
  - Conference: November 8-11, 2026.
- Status as of 2026-05-05: 2026 submission deadline passed; notification is upcoming.
- Source: [FOCS 2026 CFP](https://sanjeevkhanna.org/FOCS2026_CFP.html),
  [IEEE TCMF FOCS 2026 notice](https://tc.computer.org/tcmf/2026/03/01/focs-2025-call-for-papers-2/).

### ITCS - Innovations in Theoretical Computer Science

- Fit: Strong for novel conceptual frameworks, surprising links, new models, bold
  conjectural programs, or early but technically meaningful theory ideas. Good home for a
  clean learning-theory/complexity connection if the conceptual novelty is high.
- 2026 location: Bocconi University, Milan, Italy.
- 2026 dates: January 27-30, 2026.
- 2026 important dates:
  - Abstract deadline: September 4, 2025, 4:59 PM PDT.
  - Submission deadline: September 6, 2025, 4:59 PM PDT.
  - Author notification: November 10, 2025.
  - Conference: January 27-30, 2026.
- Status as of 2026-05-05: 2026 cycle is complete; 2027 CFP not posted when checked.
- Source: [ITCS 2026 CFP](https://itcs-conf.org/),
  [Bocconi ITCS 2026 page](https://cs.unibocconi.eu/itcs2026).

### CCC - Computational Complexity Conference

- Fit: Strong if the main result is complexity-theoretic: hardness of learning, circuit
  lower bounds, reductions, average-case complexity, proof complexity, pseudorandomness,
  derandomization, or complexity-theoretic aspects of machine learning.
- 2026 location: Lisbon, Portugal.
- 2026 dates: August 3-6, 2026.
- 2026 important dates:
  - Submission deadline: February 6, 2026, 23:59 AoE.
  - Notification: May 1, 2026.
  - Camera-ready: end of May 2026.
  - Conference: August 3-6, 2026.
- Status as of 2026-05-05: 2026 submission and notification dates have passed.
- Source: [CCC 2026 CFP](https://computationalcomplexity.org/Archive/2026/cfp.html).

### ICALP - International Colloquium on Automata, Languages, and Programming

- Fit: Good European theory venue. Track A is relevant for algorithms, complexity, games,
  privacy/security, and theoretical CS foundations of learning; Track B is less relevant
  unless the work has logic/semantics/formal-language content.
- 2026 location: Royal Holloway, University of London, Egham, United Kingdom.
- 2026 dates: Workshops July 6, main conference July 7-10, 2026.
- 2026 important dates:
  - Abstract registration deadline: February 3, 2026 AoE.
  - Submission deadline: February 6, 2026 AoE.
  - Track B rebuttal: March 21-24, 2026.
  - Author notification: April 20, 2026.
  - Camera-ready deadline: May 11, 2026.
  - Conference: July 7-10, 2026.
- Status as of 2026-05-05: 2026 submission deadline passed; camera-ready may still be
  relevant for accepted papers.
- Source: [ICALP 2026 page](https://icalppodcspaa2026.cs.rhul.ac.uk/icalp/),
  [EATCS future ICALPs](https://eatcs.org/index.php/future-icalps).

### SODA - ACM-SIAM Symposium on Discrete Algorithms

- Fit: Good if the work has a strong algorithms/discrete-math component: efficient
  learning algorithms, data structures, lower bounds, online algorithms, streaming,
  combinatorics, graph algorithms, or optimization. Not ideal for purely statistical
  learning theory.
- Latest official cycle found: SODA 2026.
- 2026 location: Hyatt Regency Vancouver, Vancouver, Canada.
- 2026 dates: January 11-14, 2026.
- 2026 important dates:
  - Submission deadline: July 14, 2025.
  - Early registration/hotel deadline: December 8, 2025.
  - Conference: January 11-14, 2026.
- Status as of 2026-05-05: 2026 cycle is complete; SODA 2027 CFP was not posted on the
  SIAM page when checked. Historically the submission deadline is usually in the summer
  before the January conference, but do not treat that as official until the CFP appears.
- Source: [SODA 2026 SIAM page](https://www.siam.org/conferences-events/past-event-archive/soda26/).

### APPROX/RANDOM - Approximation Algorithms And Randomization And Computation

- Fit: Good if the work involves approximation hardness, randomized algorithms,
  pseudorandomness, derandomization, property testing, sublinear algorithms, approximate
  learning, or learning-theory results built from randomization/approximation techniques.
- 2026 location: Boston University, Boston, Massachusetts, USA.
- 2026 dates: August 19-21, 2026.
- 2026 important dates:
  - Submission deadline: May 6, 2026 AoE.
  - Notification: June 25, 2026.
  - Camera-ready deadline: July 12, 2026.
  - Conference: August 19-21, 2026.
- Status as of 2026-05-05: Submission deadline is tomorrow, May 6, 2026.
- Source: [APPROX/RANDOM 2026 CFP PDF](https://approxconference.com/wp-content/uploads/2026/04/cfp.pdf).

### STACS - Symposium on Theoretical Aspects of Computer Science

- Fit: Good European TCS venue for algorithms, data structures, complexity, randomness,
  cryptography, algorithms for machine learning, and logical aspects of learning theory.
  Use when the work is framed as theory of computation rather than primarily ML.
- 2026 location: Grenoble, France.
- 2026 dates: Tutorial March 9; main conference March 10-13, 2026.
- 2026 important dates:
  - Submission deadline: September 25, 2025, 23:59 AoE.
  - Rebuttal: November 17-21, 2025.
  - Notification: December 12, 2025.
  - Conference: March 10-13, 2026.
- Status as of 2026-05-05: 2026 cycle is complete; 2027 CFP not posted when checked.
- Source: [STACS 2026 page](https://stacs2026.imag.fr/),
  [STACS main site](https://www.stacs-conf.org/).

### MFCS - Mathematical Foundations of Computer Science

- Fit: Broad European TCS venue. Relevant for computational complexity, algorithms,
  foundations of computing, and theoretical issues in AI and machine learning.
- 2026 location: Paris, France.
- 2026 dates: Young Researchers Forum August 23; main conference August 24-28, 2026.
- 2026 important dates:
  - Submission deadline: April 24, 2026 AoE.
  - Author notification: June 19, 2026.
  - Camera-ready version: June 26, 2026 AoE.
  - Conference: August 24-28, 2026.
- Status as of 2026-05-05: 2026 submission deadline passed; notification is upcoming.
- Source: [MFCS 2026 page](https://mfcs2026.irif.fr/).

### ESA - European Symposium on Algorithms

- Fit: Good if the contribution is algorithmic: efficient learning algorithms,
  online/streaming/randomized algorithms, combinatorial optimization, approximation,
  algorithmic data science, or a clean simplification of an algorithmic result.
- 2026 location: L'Aquila, Italy, as part of ALGO 2026.
- 2026 dates: ALGO 2026 runs August 31-September 4, 2026.
- 2026 important dates:
  - Abstract submission deadline: April 21, 2026 AoE.
  - Paper submission deadline: April 23, 2026 AoE.
  - Notification: June 26, 2026.
  - Conference: during ALGO, August 31-September 4, 2026.
- Status as of 2026-05-05: 2026 submission deadline passed; notification is upcoming.
- Source: [ESA 2026 page](https://algo-conference.org/2026/esa/),
  [ALGO 2026 page](https://algo-conference.org/2026/).

### ISAAC - International Symposium on Algorithms and Computation

- Fit: Good for algorithms-and-computation versions of learning theory, especially
  randomized algorithms, approximation, online algorithms, streaming, parameterized
  algorithms, cryptographic/complexity connections, and algorithmic game theory.
- 2026 location: Hangzhou, China.
- 2026 dates: December 6-9, 2026.
- 2026 important dates:
  - Paper submission deadline: June 26, 2026 AoE.
  - Notification of paper acceptance: early September 2026.
  - Camera-ready version: TBA.
  - Conference: December 6-9, 2026.
- Status as of 2026-05-05: 2026 submission deadline is still upcoming.
- Source: [ISAAC 2026 CFP](https://www.algo-door.com/isaac2026/call-for-papers.html).

### SWAT/WADS - Scandinavian Symposium on Algorithm Theory / Algorithms and Data Structures Symposium

- Fit: Good for algorithmic learning-theory results when the main contribution is an
  algorithm, data structure, online/approximation/randomized analysis, or clean discrete
  technique. SWAT and WADS alternate years.
- 2026 location: Copenhagen, Denmark, for SWAT 2026.
- 2026 dates: June 17-19, 2026.
- 2026 important dates:
  - Abstract submission deadline: February 16, 2026 AoE.
  - Submission deadline: February 20, 2026 AoE.
  - Author notification: April 10, 2026.
  - Final paper due: April 17, 2026.
  - Conference: June 17-19, 2026.
- Status as of 2026-05-05: SWAT 2026 submission and notification dates passed. The next
  WADS cycle should be 2027 by alternation, but its official CFP was not posted when
  checked.
- Source: [SWAT 2026 page](https://swat2026.compute.dtu.dk/).

### SPAA - ACM Symposium on Parallelism in Algorithms and Architectures

- Fit: Relevant when the learning-theory result is about parallel/distributed algorithms,
  parallel complexity, memory or I/O efficiency, parallelism in machine learning, or
  scalable algorithmic foundations.
- 2026 location: Royal Holloway, University of London, Egham/London, United Kingdom.
- 2026 dates: July 6-10, 2026, co-located with PODC and ICALP.
- 2026 important dates:
  - Abstract registration: February 20, 2026 AoE.
  - Full paper submission: February 27, 2026 AoE.
  - Rebuttal period: April 27-May 1, 2026.
  - Author notification: May 15, 2026.
  - Camera-ready version due: June 5, 2026.
  - Conference: July 6-10, 2026.
- Status as of 2026-05-05: 2026 submission deadline passed; notification is upcoming.
- Source: [SPAA 2026 CFP](https://spaa.acm.org/cfp/).

### PODC/DISC - Principles of Distributed Computing / International Symposium on Distributed Computing

- Fit: Relevant only for distributed learning, distributed lower bounds, communication
  complexity in learning systems, consensus/coordination aspects of online learning, or
  mathematically central distributed-computing models. Not a default venue for ordinary
  PAC or agnostic learning theory.
- 2026 PODC location: Royal Holloway, University of London, Egham, England.
- 2026 PODC dates: July 6-10, 2026, co-located with ICALP and SPAA.
- 2026 PODC important dates:
  - Full paper submission: February 16, 2026.
  - Conference: July 6-10, 2026.
- 2026 DISC location: Rome, Italy.
- 2026 DISC dates: November 9-13, 2026.
- DISC important dates: Main-paper submission dates were not visible on the official DISC
  2026 page when checked.
- Status as of 2026-05-05: PODC 2026 submission deadline passed; DISC 2026 conference
  dates are posted but full CFP details were not yet visible on the official page.
- Source: [PODC 2026 page](https://www.podc.org/),
  [DISC 2026 page](https://www.disc-conference.org/wp/disc2026/).

### SOSA - SIAM Symposium on Simplicity in Algorithms

- Fit: Good when the contribution is a simpler algorithm, simpler proof, cleaner analysis,
  or especially teachable conceptual explanation of an algorithmic result. This can fit
  learning theory only when the paper is algorithmically centered and unusually elegant.
- Latest official cycle found: SOSA 2026.
- 2026 location: Hyatt Regency Vancouver, Vancouver, Canada.
- 2026 dates: January 12-14, 2026.
- 2026 important dates:
  - Submission deadline: August 7, 2025.
  - Early registration/hotel deadline: December 8, 2025.
  - Conference: January 12-14, 2026.
- Status as of 2026-05-05: 2026 cycle is complete; SOSA 2027 CFP was not posted on the
  SIAM page when checked.
- Source: [SOSA 2026 SIAM page](https://www.siam.org/conferences-events/past-event-archive/sosa26/).

## Specialized But Sometimes Relevant Venues

### ACM EC - ACM Conference on Economics and Computation

- Fit: Good for learning in games, online learning with incentives, strategic
  classification, mechanism design, algorithmic game theory, pricing, auctions, and
  decision-making with economic structure. Not a default for classical PAC work.
- 2026 location: Rome, Italy.
- 2026 dates: July 6-10, 2026.
- 2026 important dates:
  - Abstract deadline: February 2, 2026, 11:59 PM AoE.
  - Paper deadline: February 9, 2026, 11:59 PM AoE.
  - First-round decisions: March 26, 2026.
  - Second-round reviews/rebuttal begins: April 21, 2026.
  - Author response due: April 25, 2026.
  - Final notifications: May 18, 2026.
  - Technical program: July 6-10, 2026.
- Status as of 2026-05-05: 2026 submission deadline passed; final notification is
  upcoming.
- Source: [ACM EC 2026 homepage](https://ec26.sigecom.org/).

### AAMAS - International Conference on Autonomous Agents and Multiagent Systems

- Fit: Relevant for learning in multi-agent systems, multi-agent online learning,
  strategic/adversarial learning, agentic AI theory, verification or safety of agents, and
  game-theoretic learning. Not a default venue for single-agent PAC theory.
- 2026 location: Coral Beach Hotel and Resort, Paphos, Cyprus.
- 2026 dates: May 25-29, 2026.
- 2026 important dates:
  - Abstract submission: October 1, 2025 AoE.
  - Paper submission: October 8, 2025 AoE.
  - Rebuttal period: November 21-25, 2025.
  - Author notification: December 22, 2025.
  - Camera-ready paper: February 11-February 18, 2026.
  - Author registration deadline: March 31, 2026.
  - Conference: May 25-29, 2026.
- Status as of 2026-05-05: 2026 submission and camera-ready dates passed; conference is
  upcoming.
- Source: [AAMAS 2026 main-track CFP](https://cyprusconferences.org/aamas2026/call-for-papers-main-track/).

### SAGT - International Symposium on Algorithmic Game Theory

- Fit: Strong when the learning-theory question is genuinely game-theoretic: learning and
  dynamics in games, mechanism design with learning, strategic classification, online
  platforms, information design, markets, or equilibria with learning constraints.
- 2026 location: University of Augsburg, Augsburg, Germany.
- 2026 dates: September 15-18, 2026.
- 2026 important dates:
  - Abstract submission: May 20, 2026 AoE.
  - Full paper submission: May 26, 2026 AoE.
  - Notification: July 9, 2026.
  - Camera-ready submission: July 15, 2026.
  - Conference: September 15-18, 2026.
- Status as of 2026-05-05: 2026 submission deadlines are still upcoming.
- Source: [SAGT 2026 page](https://intranet.uni-augsburg.de/de/fakultaet/fai/conferences/sagt-2026/).

### WINE - Conference on Web and Internet Economics

- Fit: Strong for incentives-and-computation work involving learning in games and markets,
  economic or strategic aspects of ML models, online platforms, privacy/fairness/security,
  auctions, pricing, market design, social choice, or algorithmic economics.
- 2026 location: University of Hong Kong, Hong Kong, China.
- 2026 dates: December 1-4, 2026.
- 2026 important dates:
  - Paper submission deadline: July 2, 2026 AoE.
  - Rebuttal period: August 17-20, 2026.
  - Author notification: September 10, 2026.
  - Camera-ready: September 30, 2026.
  - Conference: December 1-4, 2026.
- Status as of 2026-05-05: 2026 submission deadline is still upcoming.
- Source: [WINE 2026 page](https://wine2026conf.github.io/).

### ACM FAccT - Fairness, Accountability, and Transparency

- Fit: Relevant only when the learning-theory result has a serious fairness,
  accountability, transparency, privacy, safety, or sociotechnical-computing angle. The
  venue accepts theoretical research, but expects deep engagement with responsible
  computing concerns.
- 2026 location: Le Centre Sheraton Montreal, Montreal, Canada.
- 2026 dates: June 25-28, 2026.
- 2026 important dates:
  - Abstract deadline: January 8, 2026 AoE.
  - Paper deadline: January 13, 2026 AoE.
  - Preliminary reviews released: February 20, 2026.
  - Rebuttal due: February 24, 2026.
  - Accept/revise/reject notification: March 2, 2026.
  - Revision deadline: March 25, 2026.
  - Final notification: April 15, 2026.
  - Round 1 camera-ready: April 24, 2026.
  - Revise-and-resubmit camera-ready: May 11, 2026.
  - Conference: June 25-28, 2026.
- Status as of 2026-05-05: 2026 submission and final notification dates passed.
- Source: [ACM FAccT 2026 CFP](https://facctconference.org/2026/cfp.html).

### FORC - Symposium on Foundations of Responsible Computing

- Fit: Strong for mathematical work on responsible computing: theory of algorithmic
  fairness, privacy, accountability, societal impacts of computation, statistical or
  economic foundations of responsible ML, and rigorous computation-and-society results.
  Often a better fit than FAccT for theorem-heavy fairness/privacy foundations papers.
- 2026 location: Harvard University, Cambridge/Allston, Massachusetts, USA.
- 2026 dates: June 3-5, 2026.
- 2026 important dates:
  - First-cycle submission deadline: November 11, 2025 AoE.
  - First-cycle author notification: December 23, 2025.
  - Second-cycle submission deadline: February 17, 2026 AoE.
  - Second-cycle author notification: March 31, 2026.
  - Highlights nomination deadline: February 17, 2026 AoE.
  - Final version deadline: April 14, 2026.
  - Conference: June 3-5, 2026.
- Status as of 2026-05-05: 2026 submission and notification dates passed; conference is
  upcoming.
- Source: [FORC 2026 page](https://responsiblecomputing.org/forc-2026/),
  [FORC 2026 CFP](https://responsiblecomputing.org/forc-2026-call-for-papers/).

### TCC / IACR Cryptography Venues

- Fit: Only for work where the main theorem is cryptographic, not merely a learning result
  that uses a cryptographic assumption. For example, a new pseudorandomness or one-way
  function theorem that has learning consequences might fit TCC; a learning separation
  conditional on standard crypto is usually better sent to COLT, ALT, CCC, STOC, or FOCS.
- Latest official information found: the IACR TCC page lists TCC as an annual area
  conference and links through TCC 2025 in Aarhus, Denmark. I did not find an official
  TCC 2026 CFP/date page on 2026-05-05.
- Important dates/location: TBA for the next official TCC cycle at time of checking.
- Source: [IACR TCC page](https://www.iacr.org/meetings/tcc/).

## Usually Not First-Line For This Repository

These are worth considering only if a specific paper changes shape:

- ACL, EMNLP, NAACL, COLM: for language-model or formal-language learning work with a
  substantial NLP contribution.
- CVPR, ICCV, ECCV: for vision-specific learning theory with nontrivial computer-vision
  consequences.
- ICRA, IROS, CoRL: for robot-learning theory tied to robotics experiments or control.
- ICASSP, ISIT, ITW: for signal-processing or information-theory framings.
- CRYPTO, EUROCRYPT, ASIACRYPT, PKC: for primarily cryptographic contributions.
- POPL, LICS, CSL, FoSSaCS: for logic, programming-language, or formal-methods versions
  of learning theory, not standard PAC separations.
- PODS, SIGMOD, VLDB: for database-learning theory only if the result is fundamentally
  about query models, data management, or database systems.

## Quick Submission Map

- New theorem about PAC/agnostic/proper/improper learnability: COLT, ALT, then ICML or
  AISTATS if broad.
- New hardness/separation via complexity theory: CCC, STOC, FOCS, ITCS, ICALP, then
  COLT/ALT if the learning formulation is central.
- New randomized/approximation/property-testing technique for learning: RANDOM, APPROX,
  SODA, STOC/FOCS, COLT, STACS, ESA, ISAAC.
- New online-learning/game-theory result: COLT, ALT, ICML, NeurIPS, ACM EC, SAGT, WINE,
  SODA.
- New statistical or Bayesian learning-theory result: AISTATS, COLT, UAI, ICML.
- Learning theory for fairness/privacy/accountability: COLT, ALT, FORC, FAccT, ICML,
  NeurIPS.
- Crypto-motivated learning result: COLT/ALT/CCC/STOC/FOCS first; TCC only if the
  cryptography itself is the main contribution.

## Submission Deadline Table

| Conference | Cycle | Approx paper/full submission date | Abstract/registration date | Status as of 2026-05-05 |
| --- | --- | --- | --- | --- |
| SODA | 2026 | 2025-07-14 | None listed | Closed |
| KDD, Cycle 1 | 2026 | 2025-07-31 | 2025-07-24 | Closed |
| AAAI | AAAI-26 | 2025-08-01 | 2025-07-25 | Closed |
| SOSA | 2026 | 2025-08-07 | None listed | Closed |
| ITCS | 2026 | 2025-09-06 | 2025-09-04 | Closed |
| ICLR | 2026 | 2025-09-24 | 2025-09-19 | Closed |
| STACS | 2026 | 2025-09-25 | None listed | Closed |
| AISTATS | 2026 | 2025-10-02 | 2025-09-25 | Closed |
| ALT | 2026 | 2025-10-02 | None listed | Closed |
| AAMAS | 2026 | 2025-10-08 | 2025-10-01 | Closed |
| STOC | 2026 | 2025-11-04 | None listed | Closed |
| FORC, first cycle | 2026 | 2025-11-11 | None listed | Closed |
| ACM FAccT | 2026 | 2026-01-13 | 2026-01-08 | Closed |
| IJCAI/ECAI | 2026 | 2026-01-19 | 2026-01-12 | Closed |
| ICML | 2026 | 2026-01-28 | 2026-01-23 | Closed |
| COLT | 2026 | 2026-02-04 | None listed | Closed |
| CCC | 2026 | 2026-02-06 | None listed | Closed |
| ICALP | 2026 | 2026-02-06 | 2026-02-03 | Closed |
| KDD, Cycle 2 | 2026 | 2026-02-08 | 2026-02-01 | Closed |
| ACM EC | 2026 | 2026-02-09 | 2026-02-02 | Closed |
| PODC | 2026 | 2026-02-16 | None listed | Closed |
| FORC, second cycle | 2026 | 2026-02-17 | None listed | Closed |
| SWAT | 2026 | 2026-02-20 | 2026-02-16 | Closed |
| UAI | 2026 | 2026-02-25 | Submissions opened 2026-01-25 | Closed |
| SPAA | 2026 | 2026-02-27 | 2026-02-20 | Closed |
| ECML PKDD | 2026 | 2026-03-12 | 2026-03-05 | Closed |
| FOCS | 2026 | 2026-04-01 | None listed | Closed |
| ESA | 2026 | 2026-04-23 | 2026-04-21 | Closed |
| MFCS | 2026 | 2026-04-24 | None listed | Closed |
| APPROX/RANDOM | 2026 | 2026-05-06 | None listed | Due tomorrow |
| NeurIPS | 2026 | 2026-05-06 | 2026-05-04 | Full-paper deadline only useful if abstract was already submitted |
| SAGT | 2026 | 2026-05-26 | 2026-05-20 | Upcoming |
| ISAAC | 2026 | 2026-06-26 | None listed | Upcoming |
| WINE | 2026 | 2026-07-02 | None listed | Upcoming |
| DISC | 2026 | TBA | TBA | CFP dates not visible when checked |
| TCC / IACR cryptography venues | Next official cycle | TBA | TBA | Next official cycle not found when checked |
