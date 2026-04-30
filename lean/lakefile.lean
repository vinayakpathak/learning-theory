import Lake

open Lake DSL

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.30.0-rc2"

require cslib from git
  "https://github.com/leanprover/cslib.git" @ "v4.30.0-rc2"

package learning_theory where
  leanOptions := #[
    ⟨`autoImplicit, false⟩
  ]

@[default_target]
lean_lib LearningTheory where
  globs := #[`LearningTheory.+]
