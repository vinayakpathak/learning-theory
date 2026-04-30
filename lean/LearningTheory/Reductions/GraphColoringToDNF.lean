import LearningTheory.Boolean.DNFLemmas
import LearningTheory.Complexity.GraphColoring
import LearningTheory.Complexity.PolynomialTime
import LearningTheory.Learning.BooleanClasses
import LearningTheory.Learning.DNFConsistency
import LearningTheory.Learning.SearchProblems

namespace LearningTheory
namespace Reductions

open LearningTheory.Boolean
open LearningTheory.Complexity
open LearningTheory.Learning
open LearningTheory.Learning.BooleanClasses

/-- The one-hot assignment for a vertex. -/
def oneHot {V : Type} [DecidableEq V] (v : V) : V -> Bool :=
  fun x => if x = v then true else false

/-- The two-hot assignment for an edge. -/
def twoHot {V : Type} [DecidableEq V] (u v : V) : V -> Bool :=
  fun x => if x = u then true else if x = v then true else false

@[simp]
theorem oneHot_self {V : Type} [DecidableEq V] (v : V) :
    oneHot v v = true := by
  simp [oneHot]

theorem oneHot_of_ne {V : Type} [DecidableEq V] {u v : V}
    (h : u ≠ v) :
    oneHot v u = false := by
  simp [oneHot, h]

@[simp]
theorem twoHot_left {V : Type} [DecidableEq V] (u v : V) :
    twoHot u v u = true := by
  simp [twoHot]

@[simp]
theorem twoHot_right {V : Type} [DecidableEq V] (u v : V) :
    twoHot u v v = true := by
  by_cases h : v = u
  · subst h
    simp [twoHot]
  · simp [twoHot, h]

/--
The term associated with a color class: it forbids every listed vertex that is
not in the class.
-/
def termForClass {V : Type} [DecidableEq V]
    (vertices cls : List V) : Term V :=
  match vertices with
  | [] => []
  | v :: vs =>
      if v ∈ cls then
        termForClass vs cls
      else
        Literal.neg v :: termForClass vs cls

/-- A class term accepts the one-hot vector of every vertex in the class. -/
theorem termForClass_eval_oneHot_of_mem_class {V : Type} [DecidableEq V]
    (vertices cls : List V) {v : V}
    (hvClass : v ∈ cls) :
    Term.eval (termForClass vertices cls) (oneHot v) = true := by
  induction vertices with
  | nil =>
      rfl
  | cons w ws ih =>
      by_cases hwClass : w ∈ cls
      · simp [termForClass, hwClass, ih]
      · have hw_ne_v : w ≠ v := by
          intro hEq
          subst hEq
          exact hwClass hvClass
        simp [termForClass, hwClass, oneHot, hw_ne_v, ih]

/--
If a listed vertex is excluded from a class and an assignment sets that vertex
to true, the class term rejects the assignment.
-/
theorem termForClass_eval_false_of_not_mem_of_assignment_true
    {V : Type} [DecidableEq V]
    (vertices cls : List V) {u : V} {σ : V -> Bool}
    (huVertices : u ∈ vertices)
    (huClass : Not (u ∈ cls))
    (hσ : σ u = true) :
    Term.eval (termForClass vertices cls) σ = false := by
  induction vertices with
  | nil =>
      cases huVertices
  | cons w ws ih =>
      cases huVertices with
      | head =>
          simp [termForClass, huClass, hσ]
      | tail _ huTail =>
          by_cases hwClass : w ∈ cls
          · simp [termForClass, hwClass, ih huTail]
          · simp [termForClass, hwClass, ih huTail]

/-- A positive literal true on both one-hot endpoints is impossible for distinct endpoints. -/
theorem literal_eval_twoHot_of_oneHot_pair {V : Type} [DecidableEq V]
    (l : Literal V) {u v : V}
    (hNe : u ≠ v)
    (hU : Literal.eval (oneHot u) l = true)
    (hV : Literal.eval (oneHot v) l = true) :
    Literal.eval (twoHot u v) l = true := by
  cases l with
  | pos x =>
      by_cases hxu : x = u
      · by_cases hxv : x = v
        · simp [Literal.eval, twoHot, hxu]
        · have hVFalse : Literal.eval (oneHot v) (Literal.pos x) = false := by
            simp [Literal.eval, oneHot, hxv]
          rw [hVFalse] at hV
          contradiction
      · have hUFalse : Literal.eval (oneHot u) (Literal.pos x) = false := by
          simp [Literal.eval, oneHot, hxu]
        rw [hUFalse] at hU
        contradiction
  | neg x =>
      have hxu : x ≠ u := by
        intro h
        subst h
        simp [Literal.eval, oneHot] at hU
      have hxv : x ≠ v := by
        intro h
        subst h
        simp [Literal.eval, oneHot] at hV
      simp [Literal.eval, twoHot, hxu, hxv]

/--
If a term accepts the one-hot assignments of two distinct vertices, it accepts
the corresponding two-hot assignment.
-/
theorem term_eval_twoHot_of_oneHot_pair {V : Type} [DecidableEq V]
    (t : Term V) {u v : V}
    (hNe : u ≠ v)
    (hU : Term.eval t (oneHot u) = true)
    (hV : Term.eval t (oneHot v) = true) :
    Term.eval t (twoHot u v) = true := by
  induction t with
  | nil =>
      rfl
  | cons l ls ih =>
      change
        (Literal.eval (twoHot u v) l && Term.eval ls (twoHot u v)) = true
      change
        (Literal.eval (oneHot u) l && Term.eval ls (oneHot u)) = true at hU
      change
        (Literal.eval (oneHot v) l && Term.eval ls (oneHot v)) = true at hV
      cases hULit : Literal.eval (oneHot u) l <;> simp [hULit] at hU
      cases hUTail : Term.eval ls (oneHot u) <;> simp [hUTail] at hU
      cases hVLit : Literal.eval (oneHot v) l <;> simp [hVLit] at hV
      cases hVTail : Term.eval ls (oneHot v) <;> simp [hVTail] at hV
      have hLitTwo := literal_eval_twoHot_of_oneHot_pair l hNe hULit hVLit
      have hTailTwo := ih hUTail hVTail
      simp [hLitTwo, hTailTwo]

/-- The positive examples: one one-hot positive example per listed vertex. -/
def positiveExamples (G : GraphColoringInstance) :
    Sample (G.Vertex -> Bool) :=
  letI := G.decEq
  G.vertices.map fun v => { x := oneHot v, y := true }

/-- The negative examples: one two-hot negative example per listed edge. -/
def negativeExamples (G : GraphColoringInstance) :
    Sample (G.Vertex -> Bool) :=
  letI := G.decEq
  G.edges.map fun e => { x := twoHot e.1 e.2, y := false }

/-- The sample produced by the graph-coloring-to-DNF map. -/
def graphColoringSample (G : GraphColoringInstance) :
    Sample (G.Vertex -> Bool) :=
  positiveExamples G ++ negativeExamples G

/-- There is one positive example per listed vertex. -/
theorem positiveExamples_length (G : GraphColoringInstance) :
    (positiveExamples G).length = G.vertices.length := by
  unfold positiveExamples
  simp

/-- There is one negative example per listed edge. -/
theorem negativeExamples_length (G : GraphColoringInstance) :
    (negativeExamples G).length = G.edges.length := by
  unfold negativeExamples
  simp

/-- The reduction sample size is the number of listed vertices plus listed edges. -/
theorem graphColoringSample_length (G : GraphColoringInstance) :
    (graphColoringSample G).length =
      G.vertices.length + G.edges.length := by
  unfold graphColoringSample
  simp [positiveExamples_length, negativeExamples_length]

/-- Convert color classes into the corresponding DNF formula. -/
def dnfOfColorClasses (G : GraphColoringInstance)
    (classes : List (List G.Vertex)) : DNF G.Vertex :=
  letI := G.decEq
  classes.map fun cls => termForClass G.vertices cls

/-- Package color classes as a fixed-`k` term DNF. -/
def kTermDNFOfColorClasses (G : GraphColoringInstance)
    (classes : List (List G.Vertex))
    (hBudget : classes.length <= G.budget) :
    KTermDNF G.Vertex G.budget where
  formula := dnfOfColorClasses G classes
  length_le := by
    simp [dnfOfColorClasses, hBudget]

/-- The proper fixed-`k` DNF consistency problem associated with a graph. -/
def graphDNFProblem (G : GraphColoringInstance) :
    BinaryRepresentationProblem :=
  BooleanClasses.fixedKDNFImproperProblem G.Vertex G.budget

/-- The packaged proper fixed-`k` DNF consistency input associated with a graph. -/
def graphColoringDNFInput (G : GraphColoringInstance) :
    KTermDNFConsistencyInput where
  Var := G.Vertex
  decEq := G.decEq
  budget := G.budget
  sample := graphColoringSample G

/-- Vertices accepted by a term on their one-hot assignments. -/
def verticesAcceptedByTerm {V : Type} [DecidableEq V]
    (vertices : List V) (t : Term V) : List V :=
  match vertices with
  | [] => []
  | v :: vs =>
      if Term.eval t (oneHot v) = true then
        v :: verticesAcceptedByTerm vs t
      else
        verticesAcceptedByTerm vs t

/-- A vertex accepted by a term appears in the corresponding extracted class. -/
theorem mem_verticesAcceptedByTerm_of_eval {V : Type} [DecidableEq V]
    (vertices : List V) (t : Term V) {v : V}
    (hv : v ∈ vertices)
    (hEval : Term.eval t (oneHot v) = true) :
    v ∈ verticesAcceptedByTerm vertices t := by
  induction vertices with
  | nil =>
      cases hv
  | cons w ws ih =>
      cases hv with
      | head =>
          simp [verticesAcceptedByTerm, hEval]
      | tail _ hvTail =>
          by_cases hW : Term.eval t (oneHot w) = true
          · simp [verticesAcceptedByTerm, hW, ih hvTail]
          · simp [verticesAcceptedByTerm, hW, ih hvTail]

/-- Membership in an extracted class implies the term accepts the one-hot vertex. -/
theorem eval_of_mem_verticesAcceptedByTerm {V : Type} [DecidableEq V]
    (vertices : List V) (t : Term V) {v : V}
    (hv : v ∈ verticesAcceptedByTerm vertices t) :
    Term.eval t (oneHot v) = true := by
  induction vertices with
  | nil =>
      cases hv
  | cons w ws ih =>
      by_cases hW : Term.eval t (oneHot w) = true
      · simp [verticesAcceptedByTerm, hW] at hv
        cases hv with
        | inl hEq =>
            subst hEq
            exact hW
        | inr hTail =>
            exact ih hTail
      · simp [verticesAcceptedByTerm, hW] at hv
        exact ih hv

/-- Extract color classes from the terms of a DNF. -/
def colorClassesOfDNF (G : GraphColoringInstance)
    (φ : KTermDNF G.Vertex G.budget) : List (List G.Vertex) :=
  letI := G.decEq
  φ.formula.map fun t => verticesAcceptedByTerm G.vertices t

/-- Positive sample consistency exposes positive labels for listed vertices. -/
theorem eval_true_of_positiveExamples_consistent_aux
    {V : Type} [DecidableEq V]
    (eval : (V -> Bool) -> Bool)
    (vs : List V)
    (hConsistent :
      Sample.Consistent eval
        (vs.map fun v => { x := oneHot v, y := true }))
    {v : V} (hv : v ∈ vs) :
    eval (oneHot v) = true := by
  induction vs with
  | nil =>
      cases hv
  | cons w ws ih =>
      cases hConsistent with
      | intro hHead hTail =>
          cases hv with
          | head =>
              exact hHead
          | tail _ hvTail =>
              exact ih hTail hvTail

/-- Negative sample consistency exposes negative labels for listed edges. -/
theorem eval_false_of_negativeExamples_consistent_aux
    {V : Type} [DecidableEq V]
    (eval : (V -> Bool) -> Bool)
    (es : List (V × V))
    (hConsistent :
      Sample.Consistent eval
        (es.map fun e => { x := twoHot e.1 e.2, y := false }))
    {e : V × V} (he : e ∈ es) :
    eval (twoHot e.1 e.2) = false := by
  induction es with
  | nil =>
      cases he
  | cons edge edges ih =>
      cases hConsistent with
      | intro hHead hTail =>
          cases he with
          | head =>
              exact hHead
          | tail _ heTail =>
              exact ih hTail heTail

/--
If a proper DNF is consistent with the generated positive examples, then the
extracted term classes cover every listed vertex.
-/
theorem colorClasses_cover_vertices_of_positive_consistent
    (G : GraphColoringInstance)
    (φ : KTermDNF G.Vertex G.budget)
    (hPositive :
      Sample.Consistent
        (fun σ => KTermDNF.eval φ σ)
        (positiveExamples G)) :
    G.CoversVertices (colorClassesOfDNF G φ) := by
  letI := G.decEq
  intro v hv
  unfold positiveExamples at hPositive
  have hEval :
      KTermDNF.eval φ (oneHot v) = true :=
    eval_true_of_positiveExamples_consistent_aux
      (fun σ => KTermDNF.eval φ σ) G.vertices hPositive hv
  unfold KTermDNF.eval at hEval
  rcases DNF.exists_mem_of_eval_true φ.formula (oneHot v) hEval with
    ⟨t, htMem, htEval⟩
  exists verticesAcceptedByTerm G.vertices t
  constructor
  · unfold colorClassesOfDNF
    exact List.mem_map_of_mem
      (l := φ.formula)
      (a := t)
      (f := fun t => verticesAcceptedByTerm G.vertices t)
      htMem
  · exact mem_verticesAcceptedByTerm_of_eval G.vertices t hv htEval

/--
If a proper DNF is consistent with the generated negative edge examples, then
the extracted term classes separate every listed edge.
-/
theorem colorClasses_separate_edges_of_negative_consistent
    (G : GraphColoringInstance)
    (φ : KTermDNF G.Vertex G.budget)
    (hNegative :
      Sample.Consistent
        (fun σ => KTermDNF.eval φ σ)
        (negativeExamples G)) :
    G.SeparatesEdges (colorClassesOfDNF G φ) := by
  letI := G.decEq
  intro e he cls hCls hBoth
  unfold negativeExamples at hNegative
  have hEvalFalse :
      KTermDNF.eval φ (twoHot e.1 e.2) = false :=
    eval_false_of_negativeExamples_consistent_aux
      (fun σ => KTermDNF.eval φ σ) G.edges hNegative he
  unfold colorClassesOfDNF at hCls
  rcases (List.mem_map.mp hCls) with ⟨t, htMem, hClsEq⟩
  subst hClsEq
  cases hBoth with
  | intro hLeft hRight =>
      have hLeftEval :
          Term.eval t (oneHot e.1) = true :=
        eval_of_mem_verticesAcceptedByTerm G.vertices t hLeft
      have hRightEval :
          Term.eval t (oneHot e.2) = true :=
        eval_of_mem_verticesAcceptedByTerm G.vertices t hRight
      have hTermTwo :
          Term.eval t (twoHot e.1 e.2) = true :=
        term_eval_twoHot_of_oneHot_pair t (G.edge_ne e he)
          hLeftEval hRightEval
      have hDNFTwo :
          DNF.eval φ.formula (twoHot e.1 e.2) = true :=
        DNF.eval_true_of_mem htMem hTermTwo
      unfold KTermDNF.eval at hEvalFalse
      rw [hEvalFalse] at hDNFTwo
      contradiction

theorem positiveExamples_consistent_aux
    (G : GraphColoringInstance)
    (classes : List (List G.Vertex))
    (hBudget : classes.length <= G.budget)
    (vs : List G.Vertex)
    (hCovers :
      forall v : G.Vertex, v ∈ vs ->
        Exists fun cls : List G.Vertex => cls ∈ classes /\ v ∈ cls) :
    Sample.Consistent
      (fun σ => KTermDNF.eval (kTermDNFOfColorClasses G classes hBudget) σ)
      (letI := G.decEq; vs.map fun v => { x := oneHot v, y := true }) := by
  letI := G.decEq
  induction vs with
  | nil =>
      trivial
  | cons v vs ih =>
      change
        Sample.consistentExample
            (fun σ => KTermDNF.eval (kTermDNFOfColorClasses G classes hBudget) σ)
            { x := oneHot v, y := true }
          /\
          Sample.Consistent
            (fun σ => KTermDNF.eval (kTermDNFOfColorClasses G classes hBudget) σ)
            (List.map (fun v => { x := oneHot v, y := true }) vs)
      constructor
      · have hCover := hCovers v (List.Mem.head vs)
        rcases hCover with ⟨cls, hClsMem, hvCls⟩
        unfold Sample.consistentExample
        unfold KTermDNF.eval
        apply DNF.eval_true_of_mem
        · show termForClass G.vertices cls ∈
            (kTermDNFOfColorClasses G classes hBudget).formula
          unfold kTermDNFOfColorClasses
          unfold dnfOfColorClasses
          exact List.mem_map_of_mem
            (l := classes)
            (a := cls)
            (f := fun cls => termForClass G.vertices cls)
            hClsMem
        · exact termForClass_eval_oneHot_of_mem_class G.vertices cls hvCls
      · apply ih
        intro x hx
        exact hCovers x (List.Mem.tail v hx)

theorem positiveExamples_consistent_of_coloring
    (G : GraphColoringInstance)
    (classes : List (List G.Vertex))
    (hBudget : classes.length <= G.budget)
    (hCovers : G.CoversVertices classes) :
    Sample.Consistent
      (fun σ => KTermDNF.eval (kTermDNFOfColorClasses G classes hBudget) σ)
      (positiveExamples G) := by
  letI := G.decEq
  unfold positiveExamples
  exact positiveExamples_consistent_aux G classes hBudget G.vertices hCovers

/-- A separated edge example is rejected by every term generated from a color class. -/
theorem termForClass_eval_false_of_separated_edge
    (G : GraphColoringInstance)
    (cls : List G.Vertex)
    (e : G.Vertex × G.Vertex)
    (hEdge : e ∈ G.edges)
    (hSep : Not (e.1 ∈ cls /\ e.2 ∈ cls)) :
    letI := G.decEq
    Term.eval (termForClass G.vertices cls) (twoHot e.1 e.2) = false := by
  letI := G.decEq
  by_cases hLeft : e.1 ∈ cls
  · have hRight : Not (e.2 ∈ cls) := by
      intro h
      exact hSep (And.intro hLeft h)
    exact termForClass_eval_false_of_not_mem_of_assignment_true
      G.vertices cls (G.edge_right_mem e hEdge) hRight (twoHot_right e.1 e.2)
  · exact termForClass_eval_false_of_not_mem_of_assignment_true
      G.vertices cls (G.edge_left_mem e hEdge) hLeft (twoHot_left e.1 e.2)

theorem negativeExamples_consistent_aux
    (G : GraphColoringInstance)
    (classes : List (List G.Vertex))
    (hBudget : classes.length <= G.budget)
    (es : List (G.Vertex × G.Vertex))
    (hEdges : forall e : G.Vertex × G.Vertex, e ∈ es -> e ∈ G.edges)
    (hSeparates : G.SeparatesEdges classes) :
    Sample.Consistent
      (fun σ => KTermDNF.eval (kTermDNFOfColorClasses G classes hBudget) σ)
      (letI := G.decEq; es.map fun e => { x := twoHot e.1 e.2, y := false }) := by
  letI := G.decEq
  induction es with
  | nil =>
      trivial
  | cons e es ih =>
      change
        Sample.consistentExample
            (fun σ => KTermDNF.eval (kTermDNFOfColorClasses G classes hBudget) σ)
            { x := twoHot e.1 e.2, y := false }
          /\
          Sample.Consistent
            (fun σ => KTermDNF.eval (kTermDNFOfColorClasses G classes hBudget) σ)
            (List.map (fun e => { x := twoHot e.1 e.2, y := false }) es)
      constructor
      · have hEdge : e ∈ G.edges := hEdges e (List.Mem.head es)
        unfold Sample.consistentExample
        unfold KTermDNF.eval
        apply DNF.eval_false_of_forall_mem
        intro t ht
        unfold kTermDNFOfColorClasses at ht
        unfold dnfOfColorClasses at ht
        rcases (List.mem_map.mp ht) with ⟨cls, hClsMem, htEq⟩
        subst htEq
        exact termForClass_eval_false_of_separated_edge
          G cls e hEdge (hSeparates e hEdge cls hClsMem)
      · apply ih
        intro edge hEdgeTail
        exact hEdges edge (List.Mem.tail e hEdgeTail)

theorem negativeExamples_consistent_of_coloring
    (G : GraphColoringInstance)
    (classes : List (List G.Vertex))
    (hBudget : classes.length <= G.budget)
    (hSeparates : G.SeparatesEdges classes) :
    Sample.Consistent
      (fun σ => KTermDNF.eval (kTermDNFOfColorClasses G classes hBudget) σ)
      (negativeExamples G) := by
  letI := G.decEq
  unfold negativeExamples
  exact negativeExamples_consistent_aux G classes hBudget G.edges
    (fun e h => h) hSeparates

/-- A valid graph coloring gives a proper fixed-`k` DNF consistent with the generated sample. -/
theorem graphColoringSample_consistent_of_coloring
    (G : GraphColoringInstance)
    (classes : List (List G.Vertex))
    (hBudget : classes.length <= G.budget)
    (hCovers : G.CoversVertices classes)
    (hSeparates : G.SeparatesEdges classes) :
    Sample.Consistent
      (fun σ => KTermDNF.eval (kTermDNFOfColorClasses G classes hBudget) σ)
      (graphColoringSample G) := by
  unfold graphColoringSample
  exact (Sample.consistent_append_iff
    (fun σ => KTermDNF.eval (kTermDNFOfColorClasses G classes hBudget) σ)
    (positiveExamples G) (negativeExamples G)).mpr
      (And.intro
        (positiveExamples_consistent_of_coloring G classes hBudget hCovers)
        (negativeExamples_consistent_of_coloring G classes hBudget hSeparates))

/--
Soundness direction of the reduction: a colorable graph maps to a sample
consistent with some proper fixed-`k` term DNF.
-/
theorem graphColoring_to_properDNFConsistency_sound
    (G : GraphColoringInstance)
    (hColorable : graphColoringDecisionProblem.accepts G) :
    (graphDNFProblem G).properConsistencyDecisionProblem.accepts
      (graphColoringSample G) := by
  rcases hColorable with ⟨classes, hBudget, hCovers, hSeparates⟩
  exists kTermDNFOfColorClasses G classes hBudget
  exact graphColoringSample_consistent_of_coloring
    G classes hBudget hCovers hSeparates

/--
Completeness direction of the reduction: any proper fixed-`k` term DNF
consistent with the generated sample yields a coloring of the graph by at most
`k` color classes.
-/
theorem graphColoring_to_properDNFConsistency_complete
    (G : GraphColoringInstance)
    (hConsistent :
      (graphDNFProblem G).properConsistencyDecisionProblem.accepts
        (graphColoringSample G)) :
    graphColoringDecisionProblem.accepts G := by
  rcases hConsistent with ⟨φ, hφConsistent⟩
  exists colorClassesOfDNF G φ
  have hSplit := (Sample.consistent_append_iff
    (fun σ => KTermDNF.eval φ σ)
    (positiveExamples G) (negativeExamples G)).mp hφConsistent
  constructor
  · unfold colorClassesOfDNF
    simpa using φ.length_le
  constructor
  · exact colorClasses_cover_vertices_of_positive_consistent
      G φ hSplit.left
  · exact colorClasses_separate_edges_of_negative_consistent
      G φ hSplit.right

/-- Correctness of the graph-coloring-to-DNF-consistency sample construction. -/
theorem graphColoring_to_properDNFConsistency_correct
    (G : GraphColoringInstance) :
    graphColoringDecisionProblem.accepts G
      <->
    (graphDNFProblem G).properConsistencyDecisionProblem.accepts
      (graphColoringSample G) := by
  constructor
  · exact graphColoring_to_properDNFConsistency_sound G
  · exact graphColoring_to_properDNFConsistency_complete G

/-- Correctness of the packaged graph-coloring-to-DNF-consistency map. -/
theorem graphColoring_to_packagedDNFConsistency_correct
    (G : GraphColoringInstance) :
    graphColoringDecisionProblem.accepts G
      <->
    properKTermDNFConsistencyDecisionProblem.accepts
      (graphColoringDNFInput G) := by
  constructor
  · intro h
    exact graphColoring_to_properDNFConsistency_sound G h
  · intro h
    exact graphColoring_to_properDNFConsistency_complete G h

/-- The many-one reduction from graph coloring to proper fixed-`k` DNF consistency. -/
def graphColoringToProperKTermDNFConsistency :
    ManyOneReduction
      graphColoringDecisionProblem
      properKTermDNFConsistencyDecisionProblem where
  map := graphColoringDNFInput
  sound := by
    intro G h
    exact (graphColoring_to_packagedDNFConsistency_correct G).mp h
  complete := by
    intro G h
    exact (graphColoring_to_packagedDNFConsistency_correct G).mpr h

/--
If a class is closed under many-one reductions and graph coloring is not in it,
then proper fixed-`k` DNF consistency is not in it either.
-/
theorem properKTermDNFConsistency_not_in_class_of_graphColoring_not_in_class
    {K : ComplexityClass}
    (hClosed : ClosedUnderManyOne K)
    (hGraph : Not (K.contains graphColoringDecisionProblem)) :
    Not (K.contains properKTermDNFConsistencyDecisionProblem) := by
  exact not_contains_target_of_reduction hClosed
    graphColoringToProperKTermDNFConsistency hGraph

/--
Final conditional hardness schema: if graph coloring is NP-hard in a complexity
landscape, `RP` is closed under many-one reductions, and `RP != NP`, then
proper fixed-`k` DNF consistency is not in `RP`.

The remaining machine-model work is to prove the `NPHard` hypothesis for the
chosen formal model of polynomial-time reductions.
-/
theorem properKTermDNFConsistency_not_in_RP_of_RP_ne_NP
    (L : ComplexityLandscape)
    (hRPClosed : ClosedUnderManyOne L.RP)
    (hGraphHard : L.NPHard graphColoringDecisionProblem)
    (hRPNeNP : L.RPNeNP) :
    Not (L.RP.contains properKTermDNFConsistencyDecisionProblem) := by
  intro hTargetRP
  apply hRPNeNP
  constructor
  · exact L.RP_subset_NP
  · intro A hANP
    have hAtoGraph : ManyOneReduction A graphColoringDecisionProblem :=
      Classical.choice (hGraphHard A hANP)
    have hAtoTarget :
        ManyOneReduction A properKTermDNFConsistencyDecisionProblem :=
      ManyOneReduction.comp hAtoGraph graphColoringToProperKTermDNFConsistency
    exact hRPClosed A properKTermDNFConsistencyDecisionProblem
      hAtoTarget hTargetRP

end Reductions
end LearningTheory
