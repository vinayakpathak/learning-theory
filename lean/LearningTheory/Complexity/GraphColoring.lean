import LearningTheory.Complexity.Classes

namespace LearningTheory
namespace Complexity

/--
A finite graph-coloring instance represented by explicit vertex and edge lists.

The `budget` is the permitted number of color classes. The edge well-formedness
fields make later reductions avoid partiality: every edge endpoint is listed as
a vertex, and no edge is a self-loop.
-/
structure GraphColoringInstance where
  Vertex : Type
  decEq : DecidableEq Vertex
  vertices : List Vertex
  edges : List (Vertex × Vertex)
  budget : Nat
  edge_left_mem :
    forall e : Vertex × Vertex, e ∈ edges -> e.1 ∈ vertices
  edge_right_mem :
    forall e : Vertex × Vertex, e ∈ edges -> e.2 ∈ vertices
  edge_ne :
    forall e : Vertex × Vertex, e ∈ edges -> e.1 ≠ e.2

namespace GraphColoringInstance

/-- A list of color classes covers every listed vertex. -/
def CoversVertices (G : GraphColoringInstance)
    (classes : List (List G.Vertex)) : Prop :=
  forall v : G.Vertex, v ∈ G.vertices ->
    Exists fun cls : List G.Vertex => cls ∈ classes /\ v ∈ cls

/-- No listed edge has both endpoints in the same color class. -/
def SeparatesEdges (G : GraphColoringInstance)
    (classes : List (List G.Vertex)) : Prop :=
  forall (e : G.Vertex × G.Vertex), e ∈ G.edges ->
    forall cls : List G.Vertex, cls ∈ classes ->
      Not (e.1 ∈ cls /\ e.2 ∈ cls)

/-- A valid coloring by at most `budget` color classes. -/
def HasColoring (G : GraphColoringInstance) : Prop :=
  Exists fun classes : List (List G.Vertex) =>
    classes.length <= G.budget
      /\ G.CoversVertices classes
      /\ G.SeparatesEdges classes

end GraphColoringInstance

/-- The graph-coloring decision problem. -/
def graphColoringDecisionProblem : DecisionProblem where
  Input := GraphColoringInstance
  accepts := fun G => G.HasColoring

/-- A direct constructor for accepted graph-coloring instances. -/
theorem graphColoring_accepts_of_coloring
    (G : GraphColoringInstance)
    (classes : List (List G.Vertex))
    (hBudget : classes.length <= G.budget)
    (hCovers : G.CoversVertices classes)
    (hSeparates : G.SeparatesEdges classes) :
    graphColoringDecisionProblem.accepts G := by
  exact Exists.intro classes
    (And.intro hBudget (And.intro hCovers hSeparates))

end Complexity
end LearningTheory
