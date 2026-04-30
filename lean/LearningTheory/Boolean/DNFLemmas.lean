import LearningTheory.Boolean.Formulas

namespace LearningTheory
namespace Boolean

namespace DNF

/-- If one term in a DNF evaluates to true, then the DNF evaluates to true. -/
theorem eval_true_of_mem {Var : Type}
    {φ : DNF Var} {t : Term Var} {σ : Var -> Bool}
    (hMem : t ∈ φ) (hEval : Term.eval t σ = true) :
    eval φ σ = true := by
  induction φ with
  | nil =>
      cases hMem
  | cons head tail ih =>
      cases hMem with
      | head =>
          simp [eval, hEval]
      | tail _ hTail =>
          simp [eval, ih hTail]

/-- If every term in a DNF evaluates to false, then the DNF evaluates to false. -/
theorem eval_false_of_forall_mem {Var : Type}
    (φ : DNF Var) (σ : Var -> Bool)
    (hAll : forall t : Term Var, t ∈ φ -> Term.eval t σ = false) :
    eval φ σ = false := by
  induction φ with
  | nil =>
      rfl
  | cons head tail ih =>
      have hHead : Term.eval head σ = false := hAll head (List.Mem.head tail)
      have hTail :
          forall t : Term Var, t ∈ tail -> Term.eval t σ = false := by
        intro t ht
        exact hAll t (List.Mem.tail head ht)
      simp [eval, hHead, ih hTail]

/-- If a DNF evaluates to true, some term in it evaluates to true. -/
theorem exists_mem_of_eval_true {Var : Type}
    (φ : DNF Var) (σ : Var -> Bool)
    (hEval : eval φ σ = true) :
    Exists fun t : Term Var => t ∈ φ /\ Term.eval t σ = true := by
  induction φ with
  | nil =>
      simp [eval] at hEval
  | cons head tail ih =>
      by_cases hHead : Term.eval head σ = true
      · exact Exists.intro head (And.intro (List.Mem.head tail) hHead)
      · have hHeadFalse : Term.eval head σ = false := by
          cases h : Term.eval head σ
          · rfl
          · exact False.elim (hHead h)
        have hTailEval : eval tail σ = true := by
          simp [eval, hHeadFalse] at hEval
          exact hEval
        rcases ih hTailEval with ⟨t, htMem, htEval⟩
        exact Exists.intro t (And.intro (List.Mem.tail head htMem) htEval)

end DNF

end Boolean
end LearningTheory
