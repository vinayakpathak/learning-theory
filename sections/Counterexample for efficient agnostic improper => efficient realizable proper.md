\documentclass[11pt]{article}

\usepackage[margin=1in]{geometry}
\usepackage{amsmath,amssymb,amsthm,mathtools}

\newtheorem{theorem}{Theorem}
\newtheorem{claim}{Claim}
\newtheorem{remark}{Remark}

\DeclareMathOperator{\err}{err}
\DeclareMathOperator{\opt}{opt}

\newcommand{\calH}{\mathcal{H}}
\newcommand{\calF}{\mathcal{F}}
\newcommand{\calD}{\mathcal{D}}
\newcommand{\RP}{\mathrm{RP}}
\newcommand{\NP}{\mathrm{NP}}

\begin{document}

\section*{Improper agnostic learning need not imply proper realizable learning}

\begin{theorem}
Assume $\NP \nsubseteq \RP$. There exists a binary hypothesis class
\[
\calH = \{\calH_n\}_{n \ge 1}
\]
with efficiently evaluable proper hypotheses such that $\calH$ is efficiently agnostically PAC learnable by an improper learner, but $\calH$ is not efficiently properly PAC learnable even in the realizable case.
\end{theorem}

\begin{proof}
We construct a class whose improper agnostic learning problem is easy because the domain is polynomially sized, but whose proper realizable learning problem would require solving satisfiable instances of $3$-SAT.

\medskip

\noindent
\textbf{The class.}
Fix $n$. Let $X_n$ be the set of all $3$-CNF clauses over variables
\[
x_1,\dots,x_n,
\]
allowing repeated literals. Thus a point $C \in X_n$ is a disjunction of three literals, and
\[
|X_n| \le (2n)^3 = O(n^3).
\]

For every assignment $a \in \{0,1\}^n$, define a classifier
\[
h_a : X_n \to \{0,1\}
\]
by
\[
h_a(C) = 1
\quad \Longleftrightarrow \quad
a \text{ satisfies the clause } C.
\]

Let
\[
\calH_n = \{h_a : a \in \{0,1\}^n\}.
\]

A proper hypothesis is represented by the assignment $a$, and evaluation is efficient: given $a$ and a clause $C$, one can check in polynomial time whether $a$ satisfies $C$.

\medskip

\noindent
\textbf{Efficient improper agnostic learning.}
Let
\[
\calF_n = \{0,1\}^{X_n}
\]
be the class of all Boolean functions on $X_n$. Since $|X_n|=O(n^3)$, the class $\calF_n$ has size
\[
|\calF_n| = 2^{|X_n|},
\]
and therefore
\[
\log |\calF_n| = |X_n| = O(n^3).
\]

Given a labeled sample
\[
S = \bigl((C_1,y_1),\dots,(C_m,y_m)\bigr),
\]
an empirical risk minimizer over $\calF_n$ is easy to compute: for each clause $C \in X_n$, label $C$ according to the empirical majority label among the sample points equal to $C$, breaking ties arbitrarily. This gives a lookup-table classifier
\[
\hat g : X_n \to \{0,1\}.
\]

In general, $\hat g$ need not equal $h_a$ for any assignment $a$, so this learner is improper.

By the standard finite-class uniform convergence bound, for

\[
m =
O\left(
\frac{\log |\calF_n| + \log(1/\delta)}{\epsilon^2}
\right)
=
O\left(
\frac{n^3 + \log(1/\delta)}{\epsilon^2}
\right),
\]

with probability at least $1-\delta$, every $g \in \calF_n$ satisfies

\[
\left|
\err_{\calD}(g) - \widehat{\err}_S(g)
\right|
\le \frac{\epsilon}{2}.
\]

Let
\[
g^\star \in \arg\min_{g \in \calF_n} \err_{\calD}(g).
\]
Since $\hat g$ is an empirical risk minimizer over $\calF_n$,

\[
\widehat{\err}_S(\hat g)
\le
\widehat{\err}_S(g^\star).
\]

Therefore, on the uniform convergence event,

\begin{align*}
\err_{\calD}(\hat g)
&\le
\widehat{\err}_S(\hat g) + \frac{\epsilon}{2} \\
&\le
\widehat{\err}_S(g^\star) + \frac{\epsilon}{2} \\
&\le
\err_{\calD}(g^\star) + \epsilon \\
&=
\min_{g \in \calF_n} \err_{\calD}(g) + \epsilon.
\end{align*}

Since
\[
\calH_n \subseteq \calF_n,
\]
we have

\[
\min_{g \in \calF_n} \err_{\calD}(g)
\le
\min_{h \in \calH_n} \err_{\calD}(h).
\]

Thus

\[
\err_{\calD}(\hat g)
\le
\min_{h \in \calH_n} \err_{\calD}(h) + \epsilon.
\]

Hence $\calH$ is efficiently agnostically PAC learnable by an improper learner.

\medskip

\noindent
\textbf{Hardness of efficient proper realizable learning.}
Now suppose, toward contradiction, that $\calH$ has an efficient proper PAC learner in the realizable case. We show that this gives an $\RP$ algorithm for $3$-SAT.

Let

\[
\varphi = C_1 \wedge C_2 \wedge \cdots \wedge C_m
\]

be a $3$-CNF formula over variables $x_1,\dots,x_n$.

Define a distribution $\calD_\varphi$ over labeled examples by choosing $j \in [m]$ uniformly at random and outputting

\[
(C_j,1).
\]

If $\varphi$ is satisfiable, then there exists an assignment $a^\star \in \{0,1\}^n$ satisfying every clause $C_j$. Therefore

\[
h_{a^\star}(C_j)=1
\]

for every $j \in [m]$, so $\calD_\varphi$ is realizable by $\calH_n$.

Run the assumed proper realizable PAC learner on sample access to $\calD_\varphi$ with parameters

\[
\epsilon = \frac{1}{2m},
\qquad
\delta = \frac{1}{3}.
\]

If $\varphi$ is satisfiable, then with probability at least $2/3$, the learner outputs some proper hypothesis $h \in \calH_n$ satisfying

\[
\err_{\calD_\varphi}(h)
\le
\frac{1}{2m}
<
\frac{1}{m}.
\]

But under $\calD_\varphi$,

\[
\err_{\calD_\varphi}(h)
=
\frac{1}{m}
\left|
\{j \in [m] : h(C_j)=0\}
\right|.
\]

Thus, if $h$ makes even one mistake on the clauses of $\varphi$, then

\[
\err_{\calD_\varphi}(h) \ge \frac{1}{m}.
\]

Since the learner's successful output has error strictly less than $1/m$, it must satisfy

\[
h(C_j)=1
\]

for every $j \in [m]$.

Because the learner is proper, $h \in \calH_n$, so $h=h_a$ for some assignment $a$. Hence $a$ satisfies every clause of $\varphi$.

Therefore, to decide $3$-SAT, we can do the following:

\begin{enumerate}
    \item Given $\varphi$, simulate sample access to $\calD_\varphi$.
    \item Run the proper realizable learner with $\epsilon=1/(2m)$ and $\delta=1/3$.
    \item Let $h$ be the returned proper hypothesis.
    \item Accept if and only if $h(C_j)=1$ for every clause $C_j$ of $\varphi$.
\end{enumerate}

If $\varphi$ is satisfiable, this algorithm accepts with probability at least $2/3$. If $\varphi$ is unsatisfiable, then no assignment satisfies every clause, and hence no proper hypothesis $h \in \calH_n$ labels all clauses by $1$. Therefore the algorithm never accepts.

Thus $3$-SAT has a randomized polynomial-time algorithm with one-sided error, so

\[
\NP \subseteq \RP.
\]

This contradicts the assumption $\NP \nsubseteq \RP$.

Consequently, under $\NP \nsubseteq \RP$, $\calH$ cannot be efficiently properly PAC learnable in the realizable case.
\end{proof}

\begin{remark}
The point of the construction is that the improper agnostic learner is allowed to output an arbitrary low-error lookup table on the finite domain $X_n$. A proper learner, however, must output a classifier induced by a single assignment $a \in \{0,1\}^n$. In the realizable distribution built from a satisfiable formula, producing such a proper classifier is exactly the task of finding a satisfying assignment.
\end{remark}

\end{document}