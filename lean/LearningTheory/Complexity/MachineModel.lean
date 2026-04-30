import LearningTheory.Complexity.PolynomialTime
import Cslib.Computability.Machines.SingleTapeTuring.Basic

namespace LearningTheory
namespace Complexity

universe u v w

open Polynomial

/-- Natural-coefficient polynomial evaluation is monotone on natural inputs. -/
theorem polynomial_eval_mono_nat (p : Polynomial Nat) : Monotone p.eval := by
  refine Polynomial.induction_on p ?hC ?hAdd ?hMonomial
  · intro a x y hxy
    simp
  · intro p q hp hq x y hxy
    simpa [Polynomial.eval_add] using Nat.add_le_add (hp hxy) (hq hxy)
  · intro n a _ x y hxy
    have hpow : x ^ (n + 1) <= y ^ (n + 1) :=
      Nat.pow_le_pow_left hxy (n + 1)
    simpa [Polynomial.eval_mul, Polynomial.eval_pow, Polynomial.eval_X]
      using Nat.mul_le_mul_left a hpow

namespace PolyTimeComputable

/-- The direct runtime-based output-length bound for a CSLib polynomial-time machine. -/
theorem output_length_le_input_add_time {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    {f : List Symbol -> List Symbol}
    (hf : Turing.SingleTapeTM.PolyTimeComputable f)
    (input : List Symbol) :
    (f input).length <= max 1 input.length + hf.time_bound input.length :=
  Turing.SingleTapeTM.output_length_le_input_length_add_time
    hf.tm input (f input) (hf.time_bound input.length)
    (hf.outputsFunInTime input)

/-- A polynomial output-length bound induced by a CSLib polynomial-time machine. -/
noncomputable def outputLengthPoly {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    {f : List Symbol -> List Symbol}
    (hf : Turing.SingleTapeTM.PolyTimeComputable f) :
    Polynomial Nat :=
  1 + X + hf.poly

/-- The induced output-length polynomial bounds every output length. -/
theorem output_length_le_poly {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    {f : List Symbol -> List Symbol}
    (hf : Turing.SingleTapeTM.PolyTimeComputable f)
    (input : List Symbol) :
    (f input).length <= (outputLengthPoly hf).eval input.length := by
  have hRuntime := output_length_le_input_add_time hf input
  have hMax : max 1 input.length <= 1 + input.length := by
    omega
  have hTime := hf.bounds input.length
  simp [outputLengthPoly]
  omega

end PolyTimeComputable

/--
A CSLib polynomial-time computation whose chosen time bound is monotone.

CSLib's composition theorem for single-tape machines needs monotonicity of the
second machine's time bound. This wrapper records that property once, so
machine-level reductions can compose without repeatedly threading an external
monotonicity proof.
-/
structure MonotonePolyTimeComputable {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    (f : List Symbol -> List Symbol)
    extends Turing.SingleTapeTM.PolyTimeComputable f where
  time_bound_mono : Monotone time_bound

namespace MonotonePolyTimeComputable

/--
Retiming any CSLib polynomial-time computation by its polynomial bound gives a
monotone time bound without changing the underlying Turing machine.
-/
noncomputable def ofPolyTimeComputable {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    {f : List Symbol -> List Symbol}
    (hf : Turing.SingleTapeTM.PolyTimeComputable f) :
    MonotonePolyTimeComputable f where
  toPolyTimeComputable := {
    tm := hf.tm
    time_bound := fun n => hf.poly.eval n
    outputsFunInTime := by
      intro input
      exact Relation.RelatesWithinSteps.of_le
        (hf.outputsFunInTime input)
        (hf.bounds input.length)
    poly := hf.poly
    bounds := by
      intro _
      rfl
  }
  time_bound_mono := polynomial_eval_mono_nat hf.poly

/-- The identity computation has a monotone constant time bound. -/
noncomputable def id {Symbol : Type} [Inhabited Symbol] [Fintype Symbol] :
    MonotonePolyTimeComputable (Symbol := Symbol) id where
  toPolyTimeComputable := Turing.SingleTapeTM.PolyTimeComputable.id
  time_bound_mono := by
    intro _ _ _
    rfl

/-- Composition preserves monotone polynomial-time computability. -/
noncomputable def comp {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    {f g : List Symbol -> List Symbol}
    (hf : MonotonePolyTimeComputable f)
    (hg : MonotonePolyTimeComputable g) :
    MonotonePolyTimeComputable (g ∘ f) where
  toPolyTimeComputable :=
    Turing.SingleTapeTM.PolyTimeComputable.comp
      hf.toPolyTimeComputable hg.toPolyTimeComputable hg.time_bound_mono
  time_bound_mono := by
    intro a b hab
    dsimp [Turing.SingleTapeTM.PolyTimeComputable.comp,
      Turing.SingleTapeTM.TimeComputable.comp]
    apply Nat.add_le_add
    · exact hf.time_bound_mono hab
    · apply hg.time_bound_mono
      exact Nat.add_le_add (max_le_max le_rfl hab) (hf.time_bound_mono hab)

end MonotonePolyTimeComputable

namespace PolyTimeComputable

/--
Composition of CSLib polynomial-time computations after retiming both machines
to monotone polynomial bounds.
-/
noncomputable def compRetimed {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    {f g : List Symbol -> List Symbol}
    (hf : Turing.SingleTapeTM.PolyTimeComputable f)
    (hg : Turing.SingleTapeTM.PolyTimeComputable g) :
    Turing.SingleTapeTM.PolyTimeComputable (g ∘ f) :=
  (MonotonePolyTimeComputable.comp
    (MonotonePolyTimeComputable.ofPolyTimeComputable hf)
    (MonotonePolyTimeComputable.ofPolyTimeComputable hg)).toPolyTimeComputable

end PolyTimeComputable

/--
An encoded decision problem packages a mathematical decision problem together
with a concrete string encoding of its inputs.

The encoding is intentionally one-way here. For many-one reductions we only
need to state that the string-level map sends encodings of source instances to
encodings of target instances.
-/
structure EncodedDecisionProblem (Symbol : Type) where
  Input : Type u
  encode : Input -> List Symbol
  accepts : Input -> Prop

namespace EncodedDecisionProblem

/-- Forget the encoding and retain only the underlying mathematical problem. -/
def toDecisionProblem {Symbol : Type}
    (A : EncodedDecisionProblem.{u} Symbol) : DecisionProblem.{u} where
  Input := A.Input
  accepts := A.accepts

end EncodedDecisionProblem

/--
A many-one reduction whose instance map is accompanied by a concrete
polynomial-time string transformer in CSLib's single-tape Turing-machine model.
-/
structure EncodedManyOneReduction {Symbol : Type}
    [Inhabited Symbol] [Fintype Symbol]
    (A : EncodedDecisionProblem.{u} Symbol)
    (B : EncodedDecisionProblem.{v} Symbol) where
  map : A.Input -> B.Input
  sound : forall x : A.Input, A.accepts x -> B.accepts (map x)
  complete : forall x : A.Input, B.accepts (map x) -> A.accepts x
  encodedMap : List Symbol -> List Symbol
  encodedMap_correct :
    forall x : A.Input, encodedMap (A.encode x) = B.encode (map x)
  polytime : Turing.SingleTapeTM.PolyTimeComputable encodedMap

namespace EncodedManyOneReduction

/-- The polynomial output-length bound induced by the encoded map's machine proof. -/
noncomputable def outputLengthPoly {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    {A : EncodedDecisionProblem.{u} Symbol}
    {B : EncodedDecisionProblem.{v} Symbol}
    (f : EncodedManyOneReduction A B) :
    Polynomial Nat :=
  PolyTimeComputable.outputLengthPoly f.polytime

/-- The encoded map of an encoded many-one reduction has polynomially bounded output length. -/
theorem encodedMap_length_le_outputLengthPoly
    {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    {A : EncodedDecisionProblem.{u} Symbol}
    {B : EncodedDecisionProblem.{v} Symbol}
    (f : EncodedManyOneReduction A B)
    (input : List Symbol) :
    (f.encodedMap input).length <=
      (f.outputLengthPoly).eval input.length := by
  exact PolyTimeComputable.output_length_le_poly f.polytime input

/-- Forget the machine-level evidence and keep the underlying many-one map. -/
def toManyOneReduction {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    {A : EncodedDecisionProblem.{u} Symbol}
    {B : EncodedDecisionProblem.{v} Symbol}
    (f : EncodedManyOneReduction A B) :
    ManyOneReduction A.toDecisionProblem B.toDecisionProblem where
  map := f.map
  sound := f.sound
  complete := f.complete

/-- The identity encoded reduction. -/
noncomputable def refl {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    (A : EncodedDecisionProblem.{u} Symbol) :
    EncodedManyOneReduction A A where
  map := fun x => x
  sound := by
    intro _ h
    exact h
  complete := by
    intro _ h
    exact h
  encodedMap := fun w => w
  encodedMap_correct := by
    intro _
    rfl
  polytime := Turing.SingleTapeTM.PolyTimeComputable.id

/--
Composition of encoded reductions. CSLib currently asks for monotonicity of
the second time bound when composing polynomial-time machines, so that
hypothesis is threaded explicitly.
-/
noncomputable def comp {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    {A : EncodedDecisionProblem.{u} Symbol}
    {B : EncodedDecisionProblem.{v} Symbol}
    {C : EncodedDecisionProblem.{w} Symbol}
    (f : EncodedManyOneReduction A B)
    (g : EncodedManyOneReduction B C)
    (hMono : Monotone g.polytime.time_bound) :
    EncodedManyOneReduction A C where
  map := fun x => g.map (f.map x)
  sound := by
    intro x hx
    exact g.sound (f.map x) (f.sound x hx)
  complete := by
    intro x hx
    exact f.complete x (g.complete (f.map x) hx)
  encodedMap := g.encodedMap ∘ f.encodedMap
  encodedMap_correct := by
    intro x
    simp [f.encodedMap_correct x, g.encodedMap_correct (f.map x)]
  polytime := Turing.SingleTapeTM.PolyTimeComputable.comp
    f.polytime g.polytime hMono

/--
Composition of encoded reductions using retimed polynomial bounds, so no
external monotonicity hypothesis is needed.
-/
noncomputable def compRetimed {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    {A : EncodedDecisionProblem.{u} Symbol}
    {B : EncodedDecisionProblem.{v} Symbol}
    {C : EncodedDecisionProblem.{w} Symbol}
    (f : EncodedManyOneReduction A B)
    (g : EncodedManyOneReduction B C) :
    EncodedManyOneReduction A C where
  map := fun x => g.map (f.map x)
  sound := by
    intro x hx
    exact g.sound (f.map x) (f.sound x hx)
  complete := by
    intro x hx
    exact f.complete x (g.complete (f.map x) hx)
  encodedMap := g.encodedMap ∘ f.encodedMap
  encodedMap_correct := by
    intro x
    simp [f.encodedMap_correct x, g.encodedMap_correct (f.map x)]
  polytime := PolyTimeComputable.compRetimed f.polytime g.polytime

end EncodedManyOneReduction

/--
An encoded many-one reduction whose concrete string transformer has a monotone
CSLib polynomial-time bound. This is a convenience layer over
`EncodedManyOneReduction` for repeated composition.
-/
structure MonotoneEncodedManyOneReduction {Symbol : Type}
    [Inhabited Symbol] [Fintype Symbol]
    (A : EncodedDecisionProblem.{u} Symbol)
    (B : EncodedDecisionProblem.{v} Symbol)
    extends EncodedManyOneReduction A B where
  polytime_mono : Monotone polytime.time_bound

namespace MonotoneEncodedManyOneReduction

/-- Repackage the string transformer as a monotone polynomial-time computation. -/
def monotonePolytime {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    {A : EncodedDecisionProblem.{u} Symbol}
    {B : EncodedDecisionProblem.{v} Symbol}
    (red : MonotoneEncodedManyOneReduction A B) :
    MonotonePolyTimeComputable red.encodedMap where
  toPolyTimeComputable := red.polytime
  time_bound_mono := red.polytime_mono

/-- The identity monotone encoded reduction. -/
noncomputable def refl {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    (A : EncodedDecisionProblem.{u} Symbol) :
    MonotoneEncodedManyOneReduction A A where
  toEncodedManyOneReduction := EncodedManyOneReduction.refl A
  polytime_mono := by
    intro _ _ _
    rfl

/-- Composition of monotone encoded reductions. -/
noncomputable def comp {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    {A : EncodedDecisionProblem.{u} Symbol}
    {B : EncodedDecisionProblem.{v} Symbol}
    {C : EncodedDecisionProblem.{w} Symbol}
    (f : MonotoneEncodedManyOneReduction A B)
    (g : MonotoneEncodedManyOneReduction B C) :
    MonotoneEncodedManyOneReduction A C where
  map := fun x => g.map (f.map x)
  sound := by
    intro x hx
    exact g.sound (f.map x) (f.sound x hx)
  complete := by
    intro x hx
    exact f.complete x (g.complete (f.map x) hx)
  encodedMap := g.encodedMap ∘ f.encodedMap
  encodedMap_correct := by
    intro x
    simp [f.encodedMap_correct x, g.encodedMap_correct (f.map x)]
  polytime := (MonotonePolyTimeComputable.comp
    f.monotonePolytime g.monotonePolytime).toPolyTimeComputable
  polytime_mono := (MonotonePolyTimeComputable.comp
    f.monotonePolytime g.monotonePolytime).time_bound_mono

end MonotoneEncodedManyOneReduction

/--
A many-one reduction whose string transformer preserves an arbitrary trailing
suffix after a valid source encoding.

This stronger interface is useful for verifier-style arguments, where the input
string is an encoded instance followed by a certificate or random string.
-/
structure SuffixEncodedManyOneReduction {Symbol : Type}
    [Inhabited Symbol] [Fintype Symbol]
    (A : EncodedDecisionProblem.{u} Symbol)
    (B : EncodedDecisionProblem.{v} Symbol)
    extends EncodedManyOneReduction A B where
  encodedMap_correct_append :
    forall (x : A.Input) (suffix : List Symbol),
      encodedMap (A.encode x ++ suffix) = B.encode (map x) ++ suffix

/--
A suffix-preserving encoded many-one reduction whose string transformer also
has a monotone CSLib polynomial-time bound.
-/
structure MonotoneSuffixEncodedManyOneReduction {Symbol : Type}
    [Inhabited Symbol] [Fintype Symbol]
    (A : EncodedDecisionProblem.{u} Symbol)
    (B : EncodedDecisionProblem.{v} Symbol)
    extends SuffixEncodedManyOneReduction A B where
  polytime_mono : Monotone polytime.time_bound

namespace MonotoneSuffixEncodedManyOneReduction

/-- Forget suffix preservation and keep a monotone encoded many-one reduction. -/
def toMonotoneEncodedManyOneReduction {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    {A : EncodedDecisionProblem.{u} Symbol}
    {B : EncodedDecisionProblem.{v} Symbol}
    (red : MonotoneSuffixEncodedManyOneReduction A B) :
    MonotoneEncodedManyOneReduction A B where
  toEncodedManyOneReduction := red.toEncodedManyOneReduction
  polytime_mono := red.polytime_mono

/-- Repackage the string transformer as a monotone polynomial-time computation. -/
def monotonePolytime {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    {A : EncodedDecisionProblem.{u} Symbol}
    {B : EncodedDecisionProblem.{v} Symbol}
    (red : MonotoneSuffixEncodedManyOneReduction A B) :
    MonotonePolyTimeComputable red.encodedMap where
  toPolyTimeComputable := red.polytime
  time_bound_mono := red.polytime_mono

end MonotoneSuffixEncodedManyOneReduction

/-- A complexity class of encoded decision problems. -/
structure EncodedComplexityClass (Symbol : Type) where
  contains : EncodedDecisionProblem.{u} Symbol -> Prop

/-- Inclusion of encoded complexity classes. -/
def EncodedSubset {Symbol : Type}
    (A B : EncodedComplexityClass.{u} Symbol) : Prop :=
  forall L : EncodedDecisionProblem.{u} Symbol,
    A.contains L -> B.contains L

/-- Equality of encoded complexity classes as mutual inclusion. -/
def EncodedEqual {Symbol : Type}
    (A B : EncodedComplexityClass.{u} Symbol) : Prop :=
  EncodedSubset A B /\ EncodedSubset B A

/-- An encoded complexity class is closed downward under encoded many-one reductions. -/
def EncodedClosedUnderManyOne {Symbol : Type}
    [Inhabited Symbol] [Fintype Symbol]
    (K : EncodedComplexityClass.{u} Symbol) : Prop :=
  forall A B : EncodedDecisionProblem.{u} Symbol,
    EncodedManyOneReduction A B -> K.contains B -> K.contains A

namespace EncodedComplexityClass

/--
Forget encodings by viewing an encoded class as a class of ordinary decision
problems that have some encoded representative in the class.
-/
def forget {Symbol : Type}
    (K : EncodedComplexityClass.{u} Symbol) : ComplexityClass.{u} where
  contains := fun A =>
    Exists fun E : EncodedDecisionProblem.{u} Symbol =>
      E.toDecisionProblem = A /\ K.contains E

theorem forget_subset {Symbol : Type}
    {A B : EncodedComplexityClass.{u} Symbol}
    (hSub : EncodedSubset A B) :
    Subset A.forget B.forget := by
  intro L hL
  rcases hL with ⟨E, hEq, hE⟩
  exact ⟨E, hEq, hSub E hE⟩

end EncodedComplexityClass

/--
An encoded version of the usual `P`, `NP`, `RP` landscape. The classes are
parameters, while reductions are concrete encoded reductions carrying CSLib
polynomial-time machine evidence.
-/
structure EncodedComplexityLandscape (Symbol : Type)
    [Inhabited Symbol] [Fintype Symbol] where
  P : EncodedComplexityClass.{u} Symbol
  NP : EncodedComplexityClass.{u} Symbol
  RP : EncodedComplexityClass.{u} Symbol
  P_subset_RP : EncodedSubset P RP
  RP_subset_NP : EncodedSubset RP NP
  RP_closed_under_many_one : EncodedClosedUnderManyOne RP

namespace EncodedComplexityLandscape

/-- The encoded form of the separation assumption `RP != NP`. -/
def RPNeNP {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    (L : EncodedComplexityLandscape.{u} Symbol) : Prop :=
  Not (EncodedEqual L.RP L.NP)

/-- NP-hardness with respect to concrete encoded many-one reductions. -/
def NPHard {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    (L : EncodedComplexityLandscape.{u} Symbol)
    (A : EncodedDecisionProblem.{u} Symbol) : Prop :=
  forall B : EncodedDecisionProblem.{u} Symbol,
    L.NP.contains B -> Nonempty (EncodedManyOneReduction B A)

/--
If an encoded problem is NP-hard and also in `RP`, then `RP = NP`. Equivalently,
under `RP != NP`, no encoded NP-hard problem can be in `RP`.
-/
theorem not_in_RP_of_rp_ne_np_of_np_hard
    {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    (L : EncodedComplexityLandscape.{u} Symbol)
    {A : EncodedDecisionProblem.{u} Symbol}
    (hHard : L.NPHard A)
    (hRPNeNP : L.RPNeNP) :
    Not (L.RP.contains A) := by
  intro hA
  apply hRPNeNP
  constructor
  · exact L.RP_subset_NP
  · intro B hBNP
    rcases hHard B hBNP with ⟨red⟩
    exact L.RP_closed_under_many_one B A red hA

/--
Encoded NP-hardness transfers forward along encoded many-one reductions. The
monotonicity hypothesis is the one currently required by CSLib's composition
constructor for polynomial-time Turing machines.
-/
theorem nphard_of_encoded_reduction
    {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    (L : EncodedComplexityLandscape.{u} Symbol)
    {A B : EncodedDecisionProblem.{u} Symbol}
    (hHard : L.NPHard A)
    (red : EncodedManyOneReduction A B)
    (hMono : Monotone red.polytime.time_bound) :
    L.NPHard B := by
  intro C hC
  rcases hHard C hC with ⟨redCA⟩
  exact ⟨EncodedManyOneReduction.comp redCA red hMono⟩

/--
Encoded NP-hardness transfers forward along encoded many-one reductions after
retiming the component machines to monotone polynomial bounds.
-/
theorem nphard_of_encoded_reduction_retimed
    {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    (L : EncodedComplexityLandscape.{u} Symbol)
    {A B : EncodedDecisionProblem.{u} Symbol}
    (hHard : L.NPHard A)
    (red : EncodedManyOneReduction A B) :
    L.NPHard B := by
  intro C hC
  rcases hHard C hC with ⟨redCA⟩
  exact ⟨EncodedManyOneReduction.compRetimed redCA red⟩

/-- Forget an encoded landscape to the earlier abstract landscape interface. -/
def forget {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    (L : EncodedComplexityLandscape.{u} Symbol) :
    ComplexityLandscape.{u} where
  P := L.P.forget
  NP := L.NP.forget
  RP := L.RP.forget
  P_subset_RP := EncodedComplexityClass.forget_subset L.P_subset_RP
  RP_subset_NP := EncodedComplexityClass.forget_subset L.RP_subset_NP

/--
Encoded NP-hardness implies abstract NP-hardness after forgetting encodings,
for the ordinary decision problem underlying the encoded hard problem.
-/
theorem forget_nphard {Symbol : Type} [Inhabited Symbol] [Fintype Symbol]
    (L : EncodedComplexityLandscape.{u} Symbol)
    {A : EncodedDecisionProblem.{u} Symbol}
    (hHard : L.NPHard A) :
    (L.forget).NPHard A.toDecisionProblem := by
  intro B hBNP
  rcases hBNP with ⟨Benc, hEq, hBenc⟩
  cases hEq
  rcases hHard Benc hBenc with ⟨red⟩
  exact ⟨red.toManyOneReduction⟩

end EncodedComplexityLandscape

namespace BitEncoding

/-- The bit alphabet used by the concrete encodings in this project. -/
abbrev Bit := Bool

/-- Unary natural-number encoding, terminated by `false`. -/
def encodeNatUnary (n : Nat) : List Bit :=
  List.replicate n true ++ [false]

/-- Encode a finite list by prefixing each element with `true` and ending with `false`. -/
def encodeList {alpha : Type u} (encode : alpha -> List Bit) :
    List alpha -> List Bit
  | [] => [false]
  | x :: xs => true :: encode x ++ encodeList encode xs

/--
If each encoded element has length at most `m`, then the delimiter-based list
encoding has length at most `xs.length * (m + 1) + 1`.
-/
theorem encodeList_length_le_of_forall_le {alpha : Type u}
    (encode : alpha -> List Bit) (m : Nat) :
    forall xs : List alpha,
      (forall x : alpha, x ∈ xs -> (encode x).length <= m) ->
      (encodeList encode xs).length <= xs.length * (m + 1) + 1
  | [], _ => by
      simp [encodeList]
  | x :: xs, h => by
      have hx : (encode x).length <= m := h x (List.Mem.head xs)
      have htail :
          forall y : alpha, y ∈ xs -> (encode y).length <= m := by
        intro y hy
        exact h y (List.Mem.tail x hy)
      have ih := encodeList_length_le_of_forall_le encode m xs htail
      calc
        (encodeList encode (x :: xs)).length
            = 1 + (encode x).length + (encodeList encode xs).length := by
              simp [encodeList, List.length_append]
              omega
        _ <= 1 + m + (xs.length * (m + 1) + 1) := by
              omega
        _ = (x :: xs).length * (m + 1) + 1 := by
              simp
              ring_nf

/-- Encoded lists have at least one delimiter bit per element, plus one terminator. -/
theorem length_succ_le_encodeList_length {alpha : Type u}
    (encode : alpha -> List Bit) (xs : List alpha) :
    xs.length + 1 <= (encodeList encode xs).length := by
  induction xs with
  | nil =>
      rfl
  | cons x xs ih =>
      simp [encodeList, List.length_append]
      omega

/-- Pair encoding by concatenation. -/
def encodePair {alpha : Type u} {beta : Type v}
    (encodeA : alpha -> List Bit) (encodeB : beta -> List Bit)
    (p : alpha × beta) : List Bit :=
  encodeA p.1 ++ encodeB p.2

/-- Decode a unary natural number, returning the unconsumed suffix. -/
def decodeNatUnary : List Bit -> Option (Nat × List Bit)
  | [] => none
  | false :: rest => some (0, rest)
  | true :: bits =>
      match decodeNatUnary bits with
      | none => none
      | some (n, rest) => some (n + 1, rest)

/--
Decode a list encoded by `encodeList`, returning the unconsumed suffix, with
an explicit fuel parameter. The fuel counts list cells, not bits.
-/
def decodeListFuel {alpha : Type u}
    (decode : List Bit -> Option (alpha × List Bit)) :
    Nat -> List Bit -> Option (List alpha × List Bit)
  | 0, _ => none
  | _ + 1, [] => none
  | _ + 1, false :: rest => some ([], rest)
  | fuel + 1, true :: bits =>
      match decode bits with
      | none => none
      | some (x, rest₁) =>
          match decodeListFuel decode fuel rest₁ with
          | none => none
          | some (xs, rest₂) => some (x :: xs, rest₂)

@[simp]
theorem encodeNatUnary_zero :
    encodeNatUnary 0 = [false] := by
  rfl

/-- `decodeNatUnary` is a left inverse to `encodeNatUnary`, with suffixes. -/
theorem decodeNatUnary_encodeNatUnary_append
    (n : Nat) (rest : List Bit) :
    decodeNatUnary (encodeNatUnary n ++ rest) = some (n, rest) := by
  induction n with
  | zero =>
      rfl
  | succ n ih =>
      change
        decodeNatUnary
          (true :: (List.replicate n true ++ [false]) ++ rest)
          = some (n + 1, rest)
      have ih' :
          decodeNatUnary (List.replicate n true ++ false :: rest)
            = some (n, rest) := by
        simpa [encodeNatUnary, List.append_assoc] using ih
      simp [decodeNatUnary, ih']

/--
If unary decoding succeeds, the decoded prefix is exactly the unary encoding of
the returned natural number.
-/
theorem decodeNatUnary_eq_some_imp_eq_encodeNatUnary_append :
    forall (bits : List Bit) (n : Nat) (rest : List Bit),
      decodeNatUnary bits = some (n, rest) ->
        bits = encodeNatUnary n ++ rest
  | [], n, rest, h => by
      simp [decodeNatUnary] at h
  | false :: bits, n, rest, h => by
      simp [decodeNatUnary] at h
      rcases h with ⟨hn, hrest⟩
      subst n
      subst rest
      rfl
  | true :: bits, n, rest, h => by
      unfold decodeNatUnary at h
      cases hDecode : decodeNatUnary bits with
      | none =>
          simp [hDecode] at h
      | some decoded =>
        rcases decoded with ⟨m, rest'⟩
        simp [hDecode] at h
        rcases h with ⟨hn, hrest⟩
        subst n
        subst rest
        have hTail :=
          decodeNatUnary_eq_some_imp_eq_encodeNatUnary_append
            bits m rest' hDecode
        rw [hTail]
        unfold encodeNatUnary
        rw [show m + 1 = Nat.succ m by omega]
        rfl

@[simp]
theorem encodeList_nil {alpha : Type u}
    (encode : alpha -> List Bit) :
    encodeList encode [] = [false] := by
  rfl

@[simp]
theorem encodeList_cons {alpha : Type u}
    (encode : alpha -> List Bit) (x : alpha) (xs : List alpha) :
    encodeList encode (x :: xs) =
      true :: encode x ++ encodeList encode xs := by
  rfl

/-- `decodeListFuel` is a left inverse to `encodeList`, with suffixes. -/
theorem decodeListFuel_encodeList_append {alpha : Type u}
    {encode : alpha -> List Bit}
    {decode : List Bit -> Option (alpha × List Bit)}
    (hDecode :
      forall (x : alpha) (rest : List Bit),
        decode (encode x ++ rest) = some (x, rest))
    (xs : List alpha) (rest : List Bit) :
    decodeListFuel decode (xs.length + 1)
      (encodeList encode xs ++ rest) =
      some (xs, rest) := by
  induction xs with
  | nil =>
      rfl
  | cons x xs ih =>
      change
        decodeListFuel decode (xs.length + 1 + 1)
          (true :: encode x ++ encodeList encode xs ++ rest)
          = some (x :: xs, rest)
      simp [decodeListFuel, hDecode x (encodeList encode xs ++ rest),
        ih, List.append_assoc]

/--
`decodeListFuel` is a left inverse to `encodeList` with any fuel strictly
larger than the encoded list length in cells.
-/
theorem decodeListFuel_encodeList_append_of_length_lt {alpha : Type u}
    {encode : alpha -> List Bit}
    {decode : List Bit -> Option (alpha × List Bit)}
    (hDecode :
      forall (x : alpha) (rest : List Bit),
        decode (encode x ++ rest) = some (x, rest))
    (xs : List alpha) (rest : List Bit) {fuel : Nat}
    (hFuel : xs.length < fuel) :
    decodeListFuel decode fuel (encodeList encode xs ++ rest) =
      some (xs, rest) := by
  induction xs generalizing fuel rest with
  | nil =>
      cases fuel with
      | zero =>
          omega
      | succ fuel =>
          rfl
  | cons x xs ih =>
      cases fuel with
      | zero =>
          omega
      | succ fuel =>
          have hTailFuel : xs.length < fuel := by
            exact Nat.lt_of_succ_lt_succ hFuel
          have hTailDecode := ih rest hTailFuel
          change
            decodeListFuel decode (fuel + 1)
              (true :: encode x ++ encodeList encode xs ++ rest)
              = some (x :: xs, rest)
          simp [decodeListFuel, hDecode x (encodeList encode xs ++ rest),
            hTailDecode, List.append_assoc]

/--
If list decoding succeeds and the element decoder only succeeds on valid
encoded prefixes, then the input is exactly the encoded list followed by the
returned suffix.
-/
theorem decodeListFuel_eq_some_imp_eq_encodeList_append {alpha : Type u}
    {encode : alpha -> List Bit}
    {decode : List Bit -> Option (alpha × List Bit)}
    (hDecode :
      forall (bits : List Bit) (x : alpha) (rest : List Bit),
        decode bits = some (x, rest) -> bits = encode x ++ rest) :
    forall (fuel : Nat) (bits : List Bit) (xs : List alpha) (rest : List Bit),
      decodeListFuel decode fuel bits = some (xs, rest) ->
        bits = encodeList encode xs ++ rest
  | 0, bits, xs, rest, h => by
      simp [decodeListFuel] at h
  | fuel + 1, [], xs, rest, h => by
      simp [decodeListFuel] at h
  | fuel + 1, false :: bits, xs, rest, h => by
      simp [decodeListFuel] at h
      rcases h with ⟨hxs, hrest⟩
      subst xs
      subst rest
      rfl
  | fuel + 1, true :: bits, xs, rest, h => by
      unfold decodeListFuel at h
      cases hDecoded : decode bits with
      | none =>
          simp [hDecoded] at h
      | some decoded =>
        rcases decoded with ⟨x, rest₁⟩
        simp [hDecoded] at h
        cases hTailDecoded : decodeListFuel decode fuel rest₁ with
        | none =>
            simp [hTailDecoded] at h
        | some decodedTail =>
          rcases decodedTail with ⟨tail, rest₂⟩
          simp [hTailDecoded] at h
          rcases h with ⟨hxs, hrest⟩
          subst xs
          subst rest
          have hHead : bits = encode x ++ rest₁ :=
            hDecode bits x rest₁ hDecoded
          have hTail :
              rest₁ = encodeList encode tail ++ rest₂ :=
            decodeListFuel_eq_some_imp_eq_encodeList_append
              hDecode fuel rest₁ tail rest₂ hTailDecoded
          rw [hHead, hTail]
          simp [encodeList, List.append_assoc]

end BitEncoding

end Complexity
end LearningTheory
