import Mathlib.Data.Finset.Card
import Cslib.Init

namespace LearningTheory

/-- Smoke test that the project can import Mathlib. -/
theorem mathlib_smoke_test (α : Type) :
    (∅ : Finset α).card = 0 := by
  simp

/-- Smoke test that the project can import CSLib. -/
theorem cslib_smoke_test : True := by
  trivial

end LearningTheory
