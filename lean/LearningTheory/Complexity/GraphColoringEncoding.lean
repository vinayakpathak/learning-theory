import Mathlib.Data.List.Range
import LearningTheory.Complexity.GraphColoring
import LearningTheory.Complexity.MachineModel

namespace LearningTheory
namespace Complexity

/--
A concrete graph-coloring input whose vertices are `Fin n`.

This is the graph-coloring variant that can be encoded as a bit string without
first choosing an encoding for an arbitrary vertex type.
-/
structure IndexedGraphColoringInstance where
  n : Nat
  edges : List (Fin n × Fin n)
  budget : Nat
  edge_ne : forall e : Fin n × Fin n, e ∈ edges -> e.1 ≠ e.2

namespace IndexedGraphColoringInstance

/-- The explicit vertex list of an indexed graph. -/
def vertices (G : IndexedGraphColoringInstance) : List (Fin G.n) :=
  List.finRange G.n

theorem mem_vertices (G : IndexedGraphColoringInstance) (v : Fin G.n) :
    v ∈ G.vertices := by
  unfold vertices
  exact List.mem_finRange v

/-- Convert an indexed graph-coloring instance to the generic graph interface. -/
def toGraphColoringInstance (G : IndexedGraphColoringInstance) :
    GraphColoringInstance where
  Vertex := Fin G.n
  decEq := inferInstance
  vertices := G.vertices
  edges := G.edges
  budget := G.budget
  edge_left_mem := by
    intro e _
    exact G.mem_vertices e.1
  edge_right_mem := by
    intro e _
    exact G.mem_vertices e.2
  edge_ne := G.edge_ne

/-- A certificate for indexed graph coloring, using explicit color classes. -/
structure ColoringCertificate (G : IndexedGraphColoringInstance) where
  classes : List (List (Fin G.n))
  length_le : classes.length <= G.budget
  covers : G.toGraphColoringInstance.CoversVertices classes
  separates : G.toGraphColoringInstance.SeparatesEdges classes

namespace ColoringCertificate

/-- A coloring certificate proves acceptance of the indexed graph instance. -/
theorem hasColoring {G : IndexedGraphColoringInstance}
    (cert : ColoringCertificate G) :
    G.toGraphColoringInstance.HasColoring := by
  exact ⟨cert.classes, cert.length_le, cert.covers, cert.separates⟩

end ColoringCertificate

/-- Indexed graph coloring has a valid coloring exactly when it has a certificate. -/
theorem hasColoring_iff_exists_coloringCertificate
    (G : IndexedGraphColoringInstance) :
    G.toGraphColoringInstance.HasColoring
      <->
    Nonempty (ColoringCertificate G) := by
  constructor
  · intro h
    rcases h with ⟨classes, hLength, hCovers, hSeparates⟩
    exact ⟨{
      classes := classes
      length_le := hLength
      covers := hCovers
      separates := hSeparates
    }⟩
  · intro h
    rcases h with ⟨cert⟩
    exact cert.hasColoring

/-- Unary encoding of a bounded vertex index. -/
def encodeVertex {n : Nat} (v : Fin n) : List BitEncoding.Bit :=
  BitEncoding.encodeNatUnary v.val

/-- Decode a bounded vertex index. -/
def decodeVertex (n : Nat) :
    List BitEncoding.Bit -> Option (Fin n × List BitEncoding.Bit) :=
  fun bits =>
    match BitEncoding.decodeNatUnary bits with
    | none => none
    | some (i, rest) =>
        if h : i < n then
          some (⟨i, h⟩, rest)
        else
          none

/-- `decodeVertex` is a left inverse to `encodeVertex`, with suffixes. -/
theorem decodeVertex_encodeVertex_append {n : Nat}
    (v : Fin n) (rest : List BitEncoding.Bit) :
    decodeVertex n (encodeVertex v ++ rest) = some (v, rest) := by
  unfold decodeVertex encodeVertex
  rw [BitEncoding.decodeNatUnary_encodeNatUnary_append]
  simp [v.isLt]

/-- If vertex decoding succeeds, the input has the corresponding encoded prefix. -/
theorem decodeVertex_eq_some_imp_eq_encodeVertex_append {n : Nat}
    (bits : List BitEncoding.Bit) (v : Fin n) (rest : List BitEncoding.Bit)
    (hDecode : decodeVertex n bits = some (v, rest)) :
    bits = encodeVertex v ++ rest := by
  unfold decodeVertex at hDecode
  cases hNat : BitEncoding.decodeNatUnary bits with
  | none =>
      simp [hNat] at hDecode
  | some decoded =>
      rcases decoded with ⟨i, rest'⟩
      by_cases hi : i < n
      · simp [hNat, hi] at hDecode
        rcases hDecode with ⟨hv, hrest⟩
        subst rest'
        cases hv
        unfold encodeVertex
        exact BitEncoding.decodeNatUnary_eq_some_imp_eq_encodeNatUnary_append
          bits i rest hNat
      · simp [hNat, hi] at hDecode

/-- Encode a list of bounded vertices. -/
def encodeVertexList {n : Nat} (vertices : List (Fin n)) :
    List BitEncoding.Bit :=
  BitEncoding.encodeList encodeVertex vertices

/-- Decode a vertex list using explicit list-cell fuel. -/
def decodeVertexList (n : Nat) (fuel : Nat) :
    List BitEncoding.Bit -> Option (List (Fin n) × List BitEncoding.Bit) :=
  BitEncoding.decodeListFuel (decodeVertex n) fuel

/-- Vertex-list decoding is a left inverse to vertex-list encoding, with suffixes. -/
theorem decodeVertexList_encode_append {n : Nat}
    (vertices : List (Fin n)) (rest : List BitEncoding.Bit) :
    decodeVertexList n (vertices.length + 1)
        (encodeVertexList vertices ++ rest)
      =
    some (vertices, rest) := by
  unfold decodeVertexList encodeVertexList
  exact BitEncoding.decodeListFuel_encodeList_append
    decodeVertex_encodeVertex_append vertices rest

/-- Vertex-list decoding works with any fuel larger than the vertex-list length. -/
theorem decodeVertexList_encode_append_of_length_lt {n : Nat}
    (vertices : List (Fin n)) (rest : List BitEncoding.Bit)
    {fuel : Nat} (hFuel : vertices.length < fuel) :
    decodeVertexList n fuel (encodeVertexList vertices ++ rest) =
      some (vertices, rest) := by
  unfold decodeVertexList encodeVertexList
  exact BitEncoding.decodeListFuel_encodeList_append_of_length_lt
    decodeVertex_encodeVertex_append vertices rest hFuel

/-- Decode a vertex list using the total bit length as fuel. -/
def decodeVertexListWithLengthFuel (n : Nat) :
    List BitEncoding.Bit -> Option (List (Fin n) × List BitEncoding.Bit) :=
  fun bits => decodeVertexList n (bits.length + 1) bits

/-- Length-fuel vertex-list decoding is a left inverse to vertex-list encoding. -/
theorem decodeVertexListWithLengthFuel_encode_append {n : Nat}
    (vertices : List (Fin n)) (rest : List BitEncoding.Bit) :
    decodeVertexListWithLengthFuel n (encodeVertexList vertices ++ rest) =
      some (vertices, rest) := by
  unfold decodeVertexListWithLengthFuel
  exact decodeVertexList_encode_append_of_length_lt vertices rest (by
    have hList :
        vertices.length + 1
          <= (encodeVertexList vertices).length :=
      BitEncoding.length_succ_le_encodeList_length
        encodeVertex vertices
    simp [List.length_append]
    omega)

/-- If vertex-list decoding succeeds, the input has the encoded-list prefix. -/
theorem decodeVertexList_eq_some_imp_eq_encode_append {n : Nat}
    (fuel : Nat) (bits : List BitEncoding.Bit)
    (vertices : List (Fin n)) (rest : List BitEncoding.Bit)
    (hDecode : decodeVertexList n fuel bits = some (vertices, rest)) :
    bits = encodeVertexList vertices ++ rest := by
  unfold decodeVertexList at hDecode
  unfold encodeVertexList
  exact BitEncoding.decodeListFuel_eq_some_imp_eq_encodeList_append
    decodeVertex_eq_some_imp_eq_encodeVertex_append
    fuel bits vertices rest hDecode

/-- If length-fuel vertex-list decoding succeeds, the input has the encoded-list prefix. -/
theorem decodeVertexListWithLengthFuel_eq_some_imp_eq_encode_append {n : Nat}
    (bits : List BitEncoding.Bit)
    (vertices : List (Fin n)) (rest : List BitEncoding.Bit)
    (hDecode :
      decodeVertexListWithLengthFuel n bits = some (vertices, rest)) :
    bits = encodeVertexList vertices ++ rest := by
  unfold decodeVertexListWithLengthFuel at hDecode
  exact decodeVertexList_eq_some_imp_eq_encode_append
    (bits.length + 1) bits vertices rest hDecode

/-- Encode a list of color classes. -/
def encodeColorClasses {n : Nat}
    (classes : List (List (Fin n))) : List BitEncoding.Bit :=
  BitEncoding.encodeList encodeVertexList classes

/-- Decode color classes using explicit outer list-cell fuel. -/
def decodeColorClasses (n : Nat) (classFuel : Nat) :
    List BitEncoding.Bit ->
      Option (List (List (Fin n)) × List BitEncoding.Bit) :=
  BitEncoding.decodeListFuel (decodeVertexListWithLengthFuel n) classFuel

/-- Color-class decoding is a left inverse to color-class encoding, with suffixes. -/
theorem decodeColorClasses_encode_append {n : Nat}
    (classes : List (List (Fin n))) (rest : List BitEncoding.Bit) :
    decodeColorClasses n (classes.length + 1)
        (encodeColorClasses classes ++ rest)
      =
    some (classes, rest) := by
  unfold decodeColorClasses encodeColorClasses
  exact BitEncoding.decodeListFuel_encodeList_append
    decodeVertexListWithLengthFuel_encode_append classes rest

/-- Color-class decoding works with any fuel larger than the number of classes. -/
theorem decodeColorClasses_encode_append_of_length_lt {n : Nat}
    (classes : List (List (Fin n))) (rest : List BitEncoding.Bit)
    {fuel : Nat} (hFuel : classes.length < fuel) :
    decodeColorClasses n fuel (encodeColorClasses classes ++ rest) =
      some (classes, rest) := by
  unfold decodeColorClasses encodeColorClasses
  exact BitEncoding.decodeListFuel_encodeList_append_of_length_lt
    decodeVertexListWithLengthFuel_encode_append classes rest hFuel

/-- Decode color classes using the total bit length as fuel. -/
def decodeColorClassesWithLengthFuel (n : Nat) :
    List BitEncoding.Bit ->
      Option (List (List (Fin n)) × List BitEncoding.Bit) :=
  fun bits => decodeColorClasses n (bits.length + 1) bits

/-- Length-fuel color-class decoding is a left inverse to color-class encoding. -/
theorem decodeColorClassesWithLengthFuel_encode_append {n : Nat}
    (classes : List (List (Fin n))) (rest : List BitEncoding.Bit) :
    decodeColorClassesWithLengthFuel n (encodeColorClasses classes ++ rest) =
      some (classes, rest) := by
  unfold decodeColorClassesWithLengthFuel
  exact decodeColorClasses_encode_append_of_length_lt classes rest (by
    have hList :
        classes.length + 1
          <= (encodeColorClasses classes).length :=
      BitEncoding.length_succ_le_encodeList_length
        encodeVertexList classes
    simp [List.length_append]
    omega)

/-- If color-class decoding succeeds, the input has the encoded-list prefix. -/
theorem decodeColorClasses_eq_some_imp_eq_encode_append {n : Nat}
    (fuel : Nat) (bits : List BitEncoding.Bit)
    (classes : List (List (Fin n))) (rest : List BitEncoding.Bit)
    (hDecode : decodeColorClasses n fuel bits = some (classes, rest)) :
    bits = encodeColorClasses classes ++ rest := by
  unfold decodeColorClasses at hDecode
  unfold encodeColorClasses
  exact BitEncoding.decodeListFuel_eq_some_imp_eq_encodeList_append
    decodeVertexListWithLengthFuel_eq_some_imp_eq_encode_append
    fuel bits classes rest hDecode

/-- If length-fuel color-class decoding succeeds, the input has the encoded-list prefix. -/
theorem decodeColorClassesWithLengthFuel_eq_some_imp_eq_encode_append {n : Nat}
    (bits : List BitEncoding.Bit)
    (classes : List (List (Fin n))) (rest : List BitEncoding.Bit)
    (hDecode :
      decodeColorClassesWithLengthFuel n bits = some (classes, rest)) :
    bits = encodeColorClasses classes ++ rest := by
  unfold decodeColorClassesWithLengthFuel at hDecode
  exact decodeColorClasses_eq_some_imp_eq_encode_append
    (bits.length + 1) bits classes rest hDecode

/-- Boolean membership test for a finite vertex list. -/
def vertexInList {n : Nat} (v : Fin n) : List (Fin n) -> Bool
  | [] => false
  | w :: ws => if w = v then true else vertexInList v ws

/-- Boolean vertex-list membership agrees with list membership. -/
theorem vertexInList_eq_true_iff {n : Nat}
    (v : Fin n) (vertices : List (Fin n)) :
    vertexInList v vertices = true <-> v ∈ vertices := by
  induction vertices with
  | nil =>
      simp [vertexInList]
  | cons w ws ih =>
      by_cases h : w = v
      · subst h
        simp [vertexInList]
      · constructor
        · intro hEval
          exact List.Mem.tail w (ih.mp (by
            simpa [vertexInList, h] using hEval))
        · intro hMem
          cases hMem with
          | head =>
              exact False.elim (h rfl)
          | tail _ hTail =>
              simpa [vertexInList, h] using ih.mpr hTail

/-- Boolean test that one color class covers a vertex. -/
def classesCoverVertex {n : Nat}
    (v : Fin n) : List (List (Fin n)) -> Bool
  | [] => false
  | cls :: classes =>
      vertexInList v cls || classesCoverVertex v classes

/-- Boolean vertex-cover test agrees with existence of a containing class. -/
theorem classesCoverVertex_eq_true_iff {n : Nat}
    (v : Fin n) (classes : List (List (Fin n))) :
    classesCoverVertex v classes = true
      <->
    Exists fun cls : List (Fin n) => cls ∈ classes /\ v ∈ cls := by
  induction classes with
  | nil =>
      simp [classesCoverVertex]
  | cons cls classes ih =>
      constructor
      · intro h
        simp [classesCoverVertex] at h
        cases h with
        | inl hHead =>
            exact ⟨cls, List.Mem.head classes,
              (vertexInList_eq_true_iff v cls).mp hHead⟩
        | inr hTail =>
            rcases ih.mp hTail with ⟨cls', hMem, hv⟩
            exact ⟨cls', List.Mem.tail cls hMem, hv⟩
      · intro h
        rcases h with ⟨cls', hMem, hv⟩
        cases hMem with
        | head =>
            simp [classesCoverVertex, (vertexInList_eq_true_iff v cls).mpr hv]
        | tail _ hTail =>
            simp [classesCoverVertex, ih.mpr ⟨cls', hTail, hv⟩]

/-- Boolean test that all listed vertices are covered. -/
def coversVerticesCheck {n : Nat}
    (vertices : List (Fin n)) (classes : List (List (Fin n))) : Bool :=
  match vertices with
  | [] => true
  | v :: vs => classesCoverVertex v classes && coversVerticesCheck vs classes

/-- Boolean vertex-cover checking agrees with the Prop-level cover predicate. -/
theorem coversVerticesCheck_eq_true_iff {n : Nat}
    (vertices : List (Fin n)) (classes : List (List (Fin n))) :
    coversVerticesCheck vertices classes = true
      <->
    (forall v : Fin n, v ∈ vertices ->
      Exists fun cls : List (Fin n) => cls ∈ classes /\ v ∈ cls) := by
  induction vertices with
  | nil =>
      simp [coversVerticesCheck]
  | cons v vs ih =>
      constructor
      · intro h x hx
        simp [coversVerticesCheck] at h
        cases hx with
        | head =>
            exact (classesCoverVertex_eq_true_iff v classes).mp h.left
        | tail _ hxTail =>
            exact ih.mp h.right x hxTail
      · intro h
        simp [coversVerticesCheck]
        constructor
        · exact (classesCoverVertex_eq_true_iff v classes).mpr
            (h v (List.Mem.head vs))
        · exact ih.mpr (fun x hx => h x (List.Mem.tail v hx))

/-- Boolean test that one color class separates one edge. -/
def classSeparatesEdge {n : Nat}
    (e : Fin n × Fin n) (cls : List (Fin n)) : Bool :=
  not (vertexInList e.1 cls && vertexInList e.2 cls)

/-- Boolean class-edge separation agrees with the Prop-level condition. -/
theorem classSeparatesEdge_eq_true_iff {n : Nat}
    (e : Fin n × Fin n) (cls : List (Fin n)) :
    classSeparatesEdge e cls = true
      <->
    Not (e.1 ∈ cls /\ e.2 ∈ cls) := by
  unfold classSeparatesEdge
  constructor
  · intro h hBoth
    have hLeft := (vertexInList_eq_true_iff e.1 cls).mpr hBoth.left
    have hRight := (vertexInList_eq_true_iff e.2 cls).mpr hBoth.right
    simp [hLeft, hRight] at h
  · intro h
    by_cases hLeft : e.1 ∈ cls
    · by_cases hRight : e.2 ∈ cls
      · exact False.elim (h ⟨hLeft, hRight⟩)
      · have hRightFalse : vertexInList e.2 cls = false := by
          cases hEval : vertexInList e.2 cls
          · rfl
          · exact False.elim
              (hRight ((vertexInList_eq_true_iff e.2 cls).mp hEval))
        simp [hRightFalse]
    · have hLeftFalse : vertexInList e.1 cls = false := by
        cases hEval : vertexInList e.1 cls
        · rfl
        · exact False.elim
            (hLeft ((vertexInList_eq_true_iff e.1 cls).mp hEval))
      simp [hLeftFalse]

/-- Boolean test that all classes separate one edge. -/
def edgeSeparatedByClasses {n : Nat}
    (e : Fin n × Fin n) : List (List (Fin n)) -> Bool
  | [] => true
  | cls :: classes =>
      classSeparatesEdge e cls && edgeSeparatedByClasses e classes

/-- Boolean edge separation agrees with the Prop-level condition. -/
theorem edgeSeparatedByClasses_eq_true_iff {n : Nat}
    (e : Fin n × Fin n) (classes : List (List (Fin n))) :
    edgeSeparatedByClasses e classes = true
      <->
    forall cls : List (Fin n), cls ∈ classes ->
      Not (e.1 ∈ cls /\ e.2 ∈ cls) := by
  induction classes with
  | nil =>
      simp [edgeSeparatedByClasses]
  | cons cls classes ih =>
      constructor
      · intro h cls' hMem
        simp [edgeSeparatedByClasses] at h
        cases hMem with
        | head =>
            exact (classSeparatesEdge_eq_true_iff e cls).mp h.left
        | tail _ hTail =>
            exact ih.mp h.right cls' hTail
      · intro h
        simp [edgeSeparatedByClasses]
        constructor
        · exact (classSeparatesEdge_eq_true_iff e cls).mpr
            (h cls (List.Mem.head classes))
        · exact ih.mpr
            (fun cls' hTail => h cls' (List.Mem.tail cls hTail))

/-- Boolean test that all listed edges are separated by all classes. -/
def separatesEdgesCheck {n : Nat}
    (edges : List (Fin n × Fin n)) (classes : List (List (Fin n))) : Bool :=
  match edges with
  | [] => true
  | e :: es => edgeSeparatedByClasses e classes && separatesEdgesCheck es classes

/-- Boolean edge-separation checking agrees with the Prop-level separation predicate. -/
theorem separatesEdgesCheck_eq_true_iff {n : Nat}
    (edges : List (Fin n × Fin n)) (classes : List (List (Fin n))) :
    separatesEdgesCheck edges classes = true
      <->
    (forall e : Fin n × Fin n, e ∈ edges ->
      forall cls : List (Fin n), cls ∈ classes ->
        Not (e.1 ∈ cls /\ e.2 ∈ cls)) := by
  induction edges with
  | nil =>
      simp [separatesEdgesCheck]
  | cons e es ih =>
      constructor
      · intro h e' hMem cls hCls
        simp [separatesEdgesCheck] at h
        cases hMem with
        | head =>
            exact (edgeSeparatedByClasses_eq_true_iff e classes).mp
              h.left cls hCls
        | tail _ hTail =>
            exact ih.mp h.right e' hTail cls hCls
      · intro h
        simp [separatesEdgesCheck]
        constructor
        · exact (edgeSeparatedByClasses_eq_true_iff e classes).mpr
            (fun cls hCls => h e (List.Mem.head es) cls hCls)
        · exact ih.mpr
            (fun e' hTail cls hCls =>
              h e' (List.Mem.tail e hTail) cls hCls)

/-- Boolean verifier for graph-coloring certificates represented as color classes. -/
def coloringCertificateCheck
    (G : IndexedGraphColoringInstance)
    (classes : List (List (Fin G.n))) : Bool :=
  decide (classes.length <= G.budget)
    && coversVerticesCheck G.vertices classes
    && separatesEdgesCheck G.edges classes

/-- The Boolean graph-coloring certificate checker agrees with the certificate predicate. -/
theorem coloringCertificateCheck_eq_true_iff
    (G : IndexedGraphColoringInstance)
    (classes : List (List (Fin G.n))) :
    coloringCertificateCheck G classes = true
      <->
    (classes.length <= G.budget
      /\ G.toGraphColoringInstance.CoversVertices classes
      /\ G.toGraphColoringInstance.SeparatesEdges classes) := by
  unfold coloringCertificateCheck
  rw [Bool.and_eq_true, Bool.and_eq_true]
  constructor
  · intro h
    rcases h with ⟨⟨hLength, hCovers⟩, hSeparates⟩
    exact ⟨of_decide_eq_true hLength,
      (coversVerticesCheck_eq_true_iff G.vertices classes).mp hCovers,
      (separatesEdgesCheck_eq_true_iff G.edges classes).mp hSeparates⟩
  · intro h
    rcases h with ⟨hLength, hCovers, hSeparates⟩
    exact ⟨⟨decide_eq_true hLength,
      (coversVerticesCheck_eq_true_iff G.vertices classes).mpr hCovers⟩,
      (separatesEdgesCheck_eq_true_iff G.edges classes).mpr hSeparates⟩

/-- Restrict a color class to the canonical vertex list, removing irrelevant entries. -/
def restrictColorClass
    (G : IndexedGraphColoringInstance) (cls : List (Fin G.n)) :
    List (Fin G.n) :=
  G.vertices.filter (fun v => vertexInList v cls)

/-- Restricting a color class preserves membership for indexed graph vertices. -/
theorem mem_restrictColorClass_iff
    (G : IndexedGraphColoringInstance) (cls : List (Fin G.n))
    (v : Fin G.n) :
    v ∈ G.restrictColorClass cls <-> v ∈ cls := by
  unfold restrictColorClass
  simp [G.mem_vertices v, vertexInList_eq_true_iff v cls]

/-- A restricted color class has at most one slot per indexed vertex. -/
theorem restrictColorClass_length_le
    (G : IndexedGraphColoringInstance) (cls : List (Fin G.n)) :
    (G.restrictColorClass cls).length <= G.n := by
  unfold restrictColorClass vertices
  simpa using
    List.length_filter_le (fun v : Fin G.n => vertexInList v cls)
      (List.finRange G.n)

/-- Normalize every color class by restricting it to the canonical vertex list. -/
def normalizeColorClasses
    (G : IndexedGraphColoringInstance)
    (classes : List (List (Fin G.n))) :
    List (List (Fin G.n)) :=
  classes.map (fun cls => G.restrictColorClass cls)

/-- Normalizing classes preserves the number of classes. -/
theorem normalizeColorClasses_length
    (G : IndexedGraphColoringInstance)
    (classes : List (List (Fin G.n))) :
    (G.normalizeColorClasses classes).length = classes.length := by
  simp [normalizeColorClasses]

/-- Normalizing classes preserves vertex coverage. -/
theorem covers_normalizeColorClasses
    (G : IndexedGraphColoringInstance)
    {classes : List (List (Fin G.n))}
    (hCovers : G.toGraphColoringInstance.CoversVertices classes) :
    G.toGraphColoringInstance.CoversVertices
      (G.normalizeColorClasses classes) := by
  intro v hv
  rcases hCovers v hv with ⟨cls, hMem, hvCls⟩
  exact ⟨G.restrictColorClass cls,
    List.mem_map.mpr ⟨cls, hMem, rfl⟩,
    (G.mem_restrictColorClass_iff cls v).mpr hvCls⟩

/-- Normalizing classes preserves edge separation. -/
theorem separates_normalizeColorClasses
    (G : IndexedGraphColoringInstance)
    {classes : List (List (Fin G.n))}
    (hSeparates : G.toGraphColoringInstance.SeparatesEdges classes) :
    G.toGraphColoringInstance.SeparatesEdges
      (G.normalizeColorClasses classes) := by
  intro e he cls hCls hBoth
  rcases List.mem_map.mp hCls with ⟨original, hOriginal, hEq⟩
  subst hEq
  exact hSeparates e he original hOriginal
    ⟨(G.mem_restrictColorClass_iff original e.1).mp hBoth.1,
      (G.mem_restrictColorClass_iff original e.2).mp hBoth.2⟩

/-- Unary vertex encodings have length at most `n + 1`. -/
theorem encodeVertex_length_le {n : Nat} (v : Fin n) :
    (encodeVertex v).length <= n + 1 := by
  unfold encodeVertex BitEncoding.encodeNatUnary
  simp

/-- Encoded vertex lists have a quadratic-free linear bound in `n` and list length. -/
theorem encodeVertexList_length_le {n : Nat}
    (vertices : List (Fin n)) :
    (encodeVertexList vertices).length
      <= vertices.length * ((n + 1) + 1) + 1 := by
  unfold encodeVertexList
  exact BitEncoding.encodeList_length_le_of_forall_le
    encodeVertex (n + 1) vertices
    (fun v _ => encodeVertex_length_le v)

/-- Encoded restricted classes have length bounded by a polynomial in `n`. -/
theorem encodeVertexList_restrictColorClass_length_le
    (G : IndexedGraphColoringInstance) (cls : List (Fin G.n)) :
    (encodeVertexList (G.restrictColorClass cls)).length
      <= G.n * ((G.n + 1) + 1) + 1 := by
  calc
    (encodeVertexList (G.restrictColorClass cls)).length
        <= (G.restrictColorClass cls).length * ((G.n + 1) + 1) + 1 :=
          encodeVertexList_length_le (G.restrictColorClass cls)
    _ <= G.n * ((G.n + 1) + 1) + 1 := by
          exact Nat.add_le_add_right
            (Nat.mul_le_mul_right ((G.n + 1) + 1)
              (G.restrictColorClass_length_le cls))
            1

/--
Encoding normalized color classes is bounded by a polynomial in the vertex count
and color budget.
-/
theorem encodeColorClasses_normalizeColorClasses_length_le
    (G : IndexedGraphColoringInstance)
    (classes : List (List (Fin G.n)))
    (hLength : classes.length <= G.budget) :
    (encodeColorClasses (G.normalizeColorClasses classes)).length
      <=
    G.budget * ((G.n * ((G.n + 1) + 1) + 1) + 1) + 1 := by
  have hEach :
      forall cls : List (Fin G.n),
        cls ∈ G.normalizeColorClasses classes ->
          (encodeVertexList cls).length
            <= G.n * ((G.n + 1) + 1) + 1 := by
    intro cls hMem
    rcases List.mem_map.mp hMem with ⟨original, _, hEq⟩
    subst hEq
    exact G.encodeVertexList_restrictColorClass_length_le original
  have hOuter :=
    BitEncoding.encodeList_length_le_of_forall_le
      encodeVertexList (G.n * ((G.n + 1) + 1) + 1)
      (G.normalizeColorClasses classes) hEach
  have hClassCount :
      (G.normalizeColorClasses classes).length <= G.budget := by
    simpa [G.normalizeColorClasses_length classes] using hLength
  calc
    (encodeColorClasses (G.normalizeColorClasses classes)).length
        <=
      (G.normalizeColorClasses classes).length
          * ((G.n * ((G.n + 1) + 1) + 1) + 1) + 1 := by
          simpa [encodeColorClasses] using hOuter
    _ <= G.budget * ((G.n * ((G.n + 1) + 1) + 1) + 1) + 1 := by
          exact Nat.add_le_add_right
            (Nat.mul_le_mul_right
              ((G.n * ((G.n + 1) + 1) + 1) + 1)
              hClassCount)
            1

namespace ColoringCertificate

/-- Encode a graph-coloring certificate by encoding its color classes. -/
def encode {G : IndexedGraphColoringInstance}
    (cert : ColoringCertificate G) : List BitEncoding.Bit :=
  encodeColorClasses cert.classes

/-- Decode a graph-coloring certificate for a fixed indexed graph input. -/
def decode (G : IndexedGraphColoringInstance) :
    List BitEncoding.Bit ->
      Option (ColoringCertificate G × List BitEncoding.Bit) :=
  fun bits =>
    match decodeColorClassesWithLengthFuel G.n bits with
    | none => none
    | some (classes, rest) =>
        if hCheck : coloringCertificateCheck G classes = true then
          have hCert := (coloringCertificateCheck_eq_true_iff G classes).mp hCheck
          some ({
            classes := classes
            length_le := hCert.1
            covers := hCert.2.1
            separates := hCert.2.2
          }, rest)
        else
          none

/-- Certificate decoding is a left inverse to certificate encoding, with suffixes. -/
theorem decode_encode_append {G : IndexedGraphColoringInstance}
    (cert : ColoringCertificate G) (rest : List BitEncoding.Bit) :
    decode G (encode cert ++ rest) = some (cert, rest) := by
  cases cert with
  | mk classes length_le covers separates =>
      unfold decode encode
      rw [decodeColorClassesWithLengthFuel_encode_append]
      have hCheck : coloringCertificateCheck G classes = true :=
        (coloringCertificateCheck_eq_true_iff G classes).mpr
          ⟨length_le, covers, separates⟩
      simp [hCheck]

/-- Verify an encoded graph-coloring certificate string for a fixed input. -/
def verifyString (G : IndexedGraphColoringInstance)
    (certBits : List BitEncoding.Bit) : Bool :=
  match decode G certBits with
  | some (_, []) => true
  | _ => false

/-- A verifying graph-coloring certificate string proves colorability. -/
theorem verifyString_sound
    (G : IndexedGraphColoringInstance)
    (certBits : List BitEncoding.Bit)
    (hVerify : verifyString G certBits = true) :
    G.toGraphColoringInstance.HasColoring := by
  unfold verifyString at hVerify
  cases hDecode : decode G certBits with
  | none =>
      simp [hDecode] at hVerify
  | some decoded =>
      rcases decoded with ⟨cert, rest⟩
      cases rest with
      | nil =>
          exact cert.hasColoring
      | cons b bs =>
          simp [hDecode] at hVerify

/-- Encoding a graph-coloring certificate produces a verifying string. -/
theorem verifyString_encode
    {G : IndexedGraphColoringInstance}
    (cert : ColoringCertificate G) :
    verifyString G (encode cert) = true := by
  unfold verifyString
  rw [show encode cert = encode cert ++ [] by simp]
  rw [decode_encode_append cert []]

/-- Normalize a graph-coloring certificate without changing its validity. -/
def normalized {G : IndexedGraphColoringInstance}
    (cert : ColoringCertificate G) : ColoringCertificate G where
  classes := G.normalizeColorClasses cert.classes
  length_le := by
    simpa [G.normalizeColorClasses_length cert.classes] using cert.length_le
  covers := G.covers_normalizeColorClasses cert.covers
  separates := G.separates_normalizeColorClasses cert.separates

/-- The normalized certificate encoding has an explicit polynomial size bound. -/
theorem encode_normalized_length_le {G : IndexedGraphColoringInstance}
    (cert : ColoringCertificate G) :
    (encode cert.normalized).length
      <=
    G.budget * ((G.n * ((G.n + 1) + 1) + 1) + 1) + 1 := by
  unfold encode normalized
  exact G.encodeColorClasses_normalizeColorClasses_length_le
    cert.classes cert.length_le

end ColoringCertificate

/-- Indexed graph coloring accepts exactly inputs with a verifying certificate string. -/
theorem accepts_iff_exists_verifyingString
    (G : IndexedGraphColoringInstance) :
    G.toGraphColoringInstance.HasColoring
      <->
    Exists fun certBits : List BitEncoding.Bit =>
      ColoringCertificate.verifyString G certBits = true := by
  constructor
  · intro h
    rcases (G.hasColoring_iff_exists_coloringCertificate.mp h) with ⟨cert⟩
    exact ⟨cert.encode, ColoringCertificate.verifyString_encode cert⟩
  · intro h
    rcases h with ⟨certBits, hVerify⟩
    exact ColoringCertificate.verifyString_sound G certBits hVerify

/--
Accepted indexed graph-coloring instances have a verifying certificate string
with an explicit polynomial size bound in the vertex count and color budget.
-/
theorem exists_bounded_verifyingString_of_hasColoring
    (G : IndexedGraphColoringInstance)
    (h : G.toGraphColoringInstance.HasColoring) :
    Exists fun certBits : List BitEncoding.Bit =>
      certBits.length
        <= G.budget * ((G.n * ((G.n + 1) + 1) + 1) + 1) + 1
        /\ ColoringCertificate.verifyString G certBits = true := by
  rcases (G.hasColoring_iff_exists_coloringCertificate.mp h) with ⟨cert⟩
  let normalized := cert.normalized
  exact ⟨normalized.encode,
    ⟨ColoringCertificate.encode_normalized_length_le cert,
      ColoringCertificate.verifyString_encode normalized⟩⟩

/-- A polynomial certificate bound as a function of encoded input length. -/
def certificateLengthBound (codeLength : Nat) : Nat :=
  codeLength * ((codeLength * ((codeLength + 1) + 1) + 1) + 1) + 1

/-- Encoding of one edge in an indexed graph. -/
def encodeEdge {n : Nat} (e : Fin n × Fin n) : List BitEncoding.Bit :=
  BitEncoding.encodePair encodeVertex encodeVertex e

/-- Decode a non-loop edge. -/
def decodeEdge (n : Nat) :
    List BitEncoding.Bit ->
      Option ({e : Fin n × Fin n // e.1 ≠ e.2} × List BitEncoding.Bit) :=
  fun bits =>
    match decodeVertex n bits with
    | none => none
    | some (u, rest₁) =>
        match decodeVertex n rest₁ with
        | none => none
        | some (v, rest₂) =>
            if h : u ≠ v then
              some (⟨(u, v), h⟩, rest₂)
            else
              none

/-- `decodeEdge` is a left inverse to `encodeEdge` on non-loop edges. -/
theorem decodeEdge_encodeEdge_append {n : Nat}
    (e : Fin n × Fin n) (hNe : e.1 ≠ e.2)
    (rest : List BitEncoding.Bit) :
    decodeEdge n (encodeEdge e ++ rest) =
      some (⟨e, hNe⟩, rest) := by
  unfold decodeEdge encodeEdge BitEncoding.encodePair
  rw [List.append_assoc]
  rw [decodeVertex_encodeVertex_append e.1
    (encodeVertex e.2 ++ rest)]
  simp [decodeVertex_encodeVertex_append e.2 rest, hNe]

/-- An indexed edge bundled with its no-self-loop proof. -/
abbrev CheckedEdge (n : Nat) :=
  {e : Fin n × Fin n // e.1 ≠ e.2}

/-- Encode a checked edge by forgetting the proof. -/
def encodeCheckedEdge {n : Nat} (e : CheckedEdge n) :
    List BitEncoding.Bit :=
  encodeEdge e.val

/-- Checked-edge encoding depends only on the underlying edge, not the proof. -/
theorem encodeCheckedEdge_eq_of_val_eq {n : Nat}
    (e₁ e₂ : CheckedEdge n) (h : e₁.val = e₂.val) :
    encodeCheckedEdge e₁ = encodeCheckedEdge e₂ := by
  cases e₁
  cases e₂
  cases h
  rfl

/-- Lists of checked edges with the same underlying edges have the same encoding. -/
theorem encodeCheckedEdge_list_eq_of_map_val_eq {n : Nat} :
    forall (xs ys : List (CheckedEdge n)),
      xs.map Subtype.val = ys.map Subtype.val ->
        BitEncoding.encodeList encodeCheckedEdge xs =
          BitEncoding.encodeList encodeCheckedEdge ys
  | [], [], _ => by
      rfl
  | [], y :: ys, h => by
      simp at h
  | x :: xs, [], h => by
      simp at h
  | x :: xs, y :: ys, h => by
      simp at h
      rcases h with ⟨hHead, hTail⟩
      simp [BitEncoding.encodeList,
        encodeCheckedEdge_eq_of_val_eq x y hHead,
        encodeCheckedEdge_list_eq_of_map_val_eq xs ys hTail]

/-- `decodeEdge` is a left inverse to `encodeCheckedEdge`, with suffixes. -/
theorem decodeEdge_encodeCheckedEdge_append {n : Nat}
    (e : CheckedEdge n) (rest : List BitEncoding.Bit) :
    decodeEdge n (encodeCheckedEdge e ++ rest) = some (e, rest) := by
  rcases e with ⟨e, hNe⟩
  exact decodeEdge_encodeEdge_append e hNe rest

/-- If edge decoding succeeds, the input has the corresponding encoded prefix. -/
theorem decodeEdge_eq_some_imp_eq_encodeCheckedEdge_append {n : Nat}
    (bits : List BitEncoding.Bit) (e : CheckedEdge n)
    (rest : List BitEncoding.Bit)
    (hDecode : decodeEdge n bits = some (e, rest)) :
    bits = encodeCheckedEdge e ++ rest := by
  unfold decodeEdge at hDecode
  cases hLeft : decodeVertex n bits with
  | none =>
      simp [hLeft] at hDecode
  | some decodedLeft =>
      rcases decodedLeft with ⟨u, rest₁⟩
      cases hRight : decodeVertex n rest₁ with
      | none =>
          simp [hLeft, hRight] at hDecode
      | some decodedRight =>
          rcases decodedRight with ⟨v, rest₂⟩
          by_cases hNe : u ≠ v
          · simp [hLeft, hRight, hNe] at hDecode
            rcases hDecode with ⟨he, hrest⟩
            subst rest₂
            cases he
            have hLeftBits :=
              decodeVertex_eq_some_imp_eq_encodeVertex_append
                bits u rest₁ hLeft
            have hRightBits :=
              decodeVertex_eq_some_imp_eq_encodeVertex_append
                rest₁ v rest hRight
            rw [hLeftBits, hRightBits]
            unfold encodeCheckedEdge encodeEdge BitEncoding.encodePair
            simp [List.append_assoc]
          · simp [hLeft, hRight, hNe] at hDecode

/-- Decode a checked edge list using explicit list-cell fuel. -/
def decodeEdges (n : Nat) (fuel : Nat) :
    List BitEncoding.Bit ->
      Option (List (CheckedEdge n) × List BitEncoding.Bit) :=
  BitEncoding.decodeListFuel (decodeEdge n) fuel

/-- The checked edge list associated with a graph-coloring input. -/
def checkedEdges (G : IndexedGraphColoringInstance) :
    List (CheckedEdge G.n) :=
  G.edges.attach.map fun e => ⟨e.val, G.edge_ne e.val e.property⟩

/-- Forgetting proofs from `checkedEdges` recovers the original edge list. -/
theorem checkedEdges_map_val (G : IndexedGraphColoringInstance) :
    G.checkedEdges.map Subtype.val = G.edges := by
  simpa [checkedEdges, Function.comp_def]
    using (List.attach_map_subtype_val G.edges)

/-- `checkedEdges` has one checked edge for each original edge. -/
theorem checkedEdges_length (G : IndexedGraphColoringInstance) :
    G.checkedEdges.length = G.edges.length := by
  simp [checkedEdges]

/-- `decodeEdges` is a left inverse to checked-edge list encoding, with suffixes. -/
theorem decodeEdges_encodeList_append {n : Nat}
    (edges : List (CheckedEdge n)) (rest : List BitEncoding.Bit) :
    decodeEdges n (edges.length + 1)
        (BitEncoding.encodeList encodeCheckedEdge edges ++ rest)
      =
    some (edges, rest) := by
  unfold decodeEdges
  exact BitEncoding.decodeListFuel_encodeList_append
    decodeEdge_encodeCheckedEdge_append edges rest

/-- Checked-edge list decoding works with any fuel larger than the edge count. -/
theorem decodeEdges_encodeList_append_of_length_lt {n : Nat}
    (edges : List (CheckedEdge n)) (rest : List BitEncoding.Bit)
    {fuel : Nat} (hFuel : edges.length < fuel) :
    decodeEdges n fuel
        (BitEncoding.encodeList encodeCheckedEdge edges ++ rest)
      =
    some (edges, rest) := by
  unfold decodeEdges
  exact BitEncoding.decodeListFuel_encodeList_append_of_length_lt
    decodeEdge_encodeCheckedEdge_append edges rest hFuel

/-- If edge-list decoding succeeds, the input has the encoded-list prefix. -/
theorem decodeEdges_eq_some_imp_eq_encode_append {n : Nat}
    (fuel : Nat) (bits : List BitEncoding.Bit)
    (edges : List (CheckedEdge n)) (rest : List BitEncoding.Bit)
    (hDecode : decodeEdges n fuel bits = some (edges, rest)) :
    bits = BitEncoding.encodeList encodeCheckedEdge edges ++ rest := by
  unfold decodeEdges at hDecode
  exact BitEncoding.decodeListFuel_eq_some_imp_eq_encodeList_append
    decodeEdge_eq_some_imp_eq_encodeCheckedEdge_append
    fuel bits edges rest hDecode

/-- Bit encoding of an indexed graph-coloring instance. -/
def encode (G : IndexedGraphColoringInstance) : List BitEncoding.Bit :=
  BitEncoding.encodeNatUnary G.n
    ++ BitEncoding.encodeNatUnary G.budget
    ++ BitEncoding.encodeList
      encodeCheckedEdge
      G.checkedEdges

/-- Decode an indexed graph-coloring instance using explicit edge-list fuel. -/
def decodeWithEdgeFuel (edgeFuel : Nat) :
    List BitEncoding.Bit ->
      Option (IndexedGraphColoringInstance × List BitEncoding.Bit) :=
  fun bits =>
    match BitEncoding.decodeNatUnary bits with
    | none => none
    | some (n, rest₁) =>
        match BitEncoding.decodeNatUnary rest₁ with
        | none => none
        | some (budget, rest₂) =>
            match decodeEdges n edgeFuel rest₂ with
            | none => none
            | some (edges, rest₃) =>
                some ({
                  n := n
                  edges := edges.map Subtype.val
                  budget := budget
                  edge_ne := by
                    intro e he
                    rcases List.mem_map.mp he with ⟨checked, _, hEq⟩
                    rw [← hEq]
                    exact checked.property
                }, rest₃)

/-- `decodeWithEdgeFuel` is a left inverse to graph encoding, with suffixes. -/
theorem decodeWithEdgeFuel_encode_append
    (G : IndexedGraphColoringInstance)
  (rest : List BitEncoding.Bit) :
    decodeWithEdgeFuel (G.checkedEdges.length + 1)
        (G.encode ++ rest)
      =
    some (G, rest) := by
  unfold decodeWithEdgeFuel encode
  simp only [List.append_assoc]
  simp [BitEncoding.decodeNatUnary_encodeNatUnary_append,
    decodeEdges_encodeList_append, checkedEdges_map_val]

/-- Graph decoding works with any fuel larger than the checked-edge count. -/
theorem decodeWithEdgeFuel_encode_append_of_checkedEdges_length_lt
    (G : IndexedGraphColoringInstance)
    (rest : List BitEncoding.Bit) {edgeFuel : Nat}
    (hFuel : G.checkedEdges.length < edgeFuel) :
    decodeWithEdgeFuel edgeFuel (G.encode ++ rest) =
      some (G, rest) := by
  unfold decodeWithEdgeFuel encode
  simp only [List.append_assoc]
  simp [BitEncoding.decodeNatUnary_encodeNatUnary_append,
    decodeEdges_encodeList_append_of_length_lt G.checkedEdges rest hFuel,
    checkedEdges_map_val]

/-- If graph decoding succeeds, the input has the corresponding graph encoding prefix. -/
theorem decodeWithEdgeFuel_eq_some_imp_eq_encode_append
    (edgeFuel : Nat) (bits : List BitEncoding.Bit)
    (G : IndexedGraphColoringInstance) (rest : List BitEncoding.Bit)
    (hDecode : decodeWithEdgeFuel edgeFuel bits = some (G, rest)) :
    bits = G.encode ++ rest := by
  unfold decodeWithEdgeFuel at hDecode
  cases hN : BitEncoding.decodeNatUnary bits with
  | none =>
      simp [hN] at hDecode
  | some decodedN =>
      rcases decodedN with ⟨n, rest₁⟩
      cases hBudget : BitEncoding.decodeNatUnary rest₁ with
      | none =>
          simp [hN, hBudget] at hDecode
      | some decodedBudget =>
          rcases decodedBudget with ⟨budget, rest₂⟩
          cases hEdges : decodeEdges n edgeFuel rest₂ with
          | none =>
              simp [hN, hBudget, hEdges] at hDecode
          | some decodedEdges =>
              rcases decodedEdges with ⟨edges, rest₃⟩
              simp [hN, hBudget, hEdges] at hDecode
              rcases hDecode with ⟨hG, hrest⟩
              subst rest
              have hBits :
                  bits = BitEncoding.encodeNatUnary n ++ rest₁ :=
                BitEncoding.decodeNatUnary_eq_some_imp_eq_encodeNatUnary_append
                  bits n rest₁ hN
              have hBudgetBits :
                  rest₁ = BitEncoding.encodeNatUnary budget ++ rest₂ :=
                BitEncoding.decodeNatUnary_eq_some_imp_eq_encodeNatUnary_append
                  rest₁ budget rest₂ hBudget
              have hEdgesBits :
                  rest₂ = BitEncoding.encodeList encodeCheckedEdge edges ++ rest₃ :=
                decodeEdges_eq_some_imp_eq_encode_append
                  edgeFuel rest₂ edges rest₃ hEdges
              have hEncodeG :
                  G.encode =
                    BitEncoding.encodeNatUnary n
                      ++ BitEncoding.encodeNatUnary budget
                      ++ BitEncoding.encodeList encodeCheckedEdge edges := by
                rw [← hG]
                unfold encode
                have hCheckedEncode :
                    BitEncoding.encodeList encodeCheckedEdge
                        (({
                          n := n
                          edges := edges.map Subtype.val
                          budget := budget
                          edge_ne := by
                            intro e he
                            rcases List.mem_map.mp he with ⟨checked, _, hEq⟩
                            rw [← hEq]
                            exact checked.property
                        } : IndexedGraphColoringInstance).checkedEdges)
                      =
                    BitEncoding.encodeList encodeCheckedEdge edges := by
                  apply encodeCheckedEdge_list_eq_of_map_val_eq
                  simpa [checkedEdges, Function.comp_def]
                    using (List.attach_map_subtype_val
                      (edges.map Subtype.val))
                simp [List.append_assoc, hCheckedEncode]
              rw [hBits, hBudgetBits, hEdgesBits]
              rw [hEncodeG]
              simp [List.append_assoc]

/-- The checked-edge count is bounded by the bit length of the graph encoding. -/
theorem checkedEdges_length_lt_encode_length_succ
    (G : IndexedGraphColoringInstance) :
    G.checkedEdges.length < G.encode.length + 1 := by
  have hList :
      G.checkedEdges.length + 1
        <= (BitEncoding.encodeList encodeCheckedEdge G.checkedEdges).length :=
    BitEncoding.length_succ_le_encodeList_length
      encodeCheckedEdge G.checkedEdges
  unfold encode
  simp [List.length_append]
  omega

/-- The edge count is bounded by the bit length of the graph encoding. -/
theorem edges_length_le_encode_length
    (G : IndexedGraphColoringInstance) :
    G.edges.length <= G.encode.length := by
  have hChecked := G.checkedEdges_length_lt_encode_length_succ
  rw [G.checkedEdges_length] at hChecked
  omega

/--
Graph decoding with fuel `bits.length + 1` is a left inverse on exact valid
graph encodings.
-/
theorem decodeWithLengthFuel_encode
    (G : IndexedGraphColoringInstance) :
    decodeWithEdgeFuel (G.encode.length + 1) G.encode =
      some (G, []) := by
  simpa using
    decodeWithEdgeFuel_encode_append_of_checkedEdges_length_lt
      G [] (checkedEdges_length_lt_encode_length_succ G)

/-- The vertex count is bounded by the bit length of the graph encoding. -/
theorem n_le_encode_length
    (G : IndexedGraphColoringInstance) :
    G.n <= G.encode.length := by
  unfold encode BitEncoding.encodeNatUnary
  simp [List.length_append]

/-- The color budget is bounded by the bit length of the graph encoding. -/
theorem budget_le_encode_length
    (G : IndexedGraphColoringInstance) :
    G.budget <= G.encode.length := by
  unfold encode BitEncoding.encodeNatUnary
  simp [List.length_append]
  omega

/--
The graph-certificate bound in terms of `n` and the budget is bounded by the
polynomial certificate bound in terms of encoded input length.
-/
theorem certificate_bound_le_codeLength_bound
    (G : IndexedGraphColoringInstance) :
    G.budget * ((G.n * ((G.n + 1) + 1) + 1) + 1) + 1
      <= certificateLengthBound G.encode.length := by
  let L := G.encode.length
  have hn : G.n <= L := by
    simpa [L] using G.n_le_encode_length
  have hb : G.budget <= L := by
    simpa [L] using G.budget_le_encode_length
  have hFactor : (G.n + 1) + 1 <= (L + 1) + 1 := by
    omega
  have hInner :
      G.n * ((G.n + 1) + 1) <= L * ((L + 1) + 1) :=
    Nat.mul_le_mul hn hFactor
  have hOuter :
      (G.n * ((G.n + 1) + 1) + 1) + 1
        <= (L * ((L + 1) + 1) + 1) + 1 := by
    omega
  have hMul :
      G.budget * ((G.n * ((G.n + 1) + 1) + 1) + 1)
        <= L * ((L * ((L + 1) + 1) + 1) + 1) :=
    Nat.mul_le_mul hb hOuter
  simpa [certificateLengthBound, L] using Nat.add_le_add_right hMul 1

/--
Combined graph-coloring verifier for strings of the form
`encodedGraph ++ certificate`.
-/
def verifyCertificateString (bits : List BitEncoding.Bit) : Bool :=
  match decodeWithEdgeFuel (bits.length + 1) bits with
  | none => false
  | some (G, certBits) => ColoringCertificate.verifyString G certBits

/-- The combined verifier agrees with certificate verification after a valid encoding. -/
theorem verifyCertificateString_encode_append
    (G : IndexedGraphColoringInstance)
    (certBits : List BitEncoding.Bit) :
    verifyCertificateString (G.encode ++ certBits)
      =
    ColoringCertificate.verifyString G certBits := by
  unfold verifyCertificateString
  rw [decodeWithEdgeFuel_encode_append_of_checkedEdges_length_lt
    G certBits (by
      have hFuel := checkedEdges_length_lt_encode_length_succ G
      simp [List.length_append] at hFuel ⊢
      omega)]

/-- Soundness of the combined graph-coloring certificate verifier. -/
theorem verifyCertificateString_sound
    (G : IndexedGraphColoringInstance)
    (certBits : List BitEncoding.Bit)
    (hVerify : verifyCertificateString (G.encode ++ certBits) = true) :
    G.toGraphColoringInstance.HasColoring := by
  rw [verifyCertificateString_encode_append] at hVerify
  exact ColoringCertificate.verifyString_sound G certBits hVerify

/--
Accepted graph-coloring instances have polynomially bounded certificate strings
for the combined verifier, with the bound expressed in terms of input length.
-/
theorem exists_bounded_certificateString_of_accepts
    (G : IndexedGraphColoringInstance)
    (h : G.toGraphColoringInstance.HasColoring) :
    Exists fun certBits : List BitEncoding.Bit =>
      certBits.length <= certificateLengthBound G.encode.length
        /\ verifyCertificateString (G.encode ++ certBits) = true := by
  rcases G.exists_bounded_verifyingString_of_hasColoring h with
    ⟨certBits, hLength, hVerify⟩
  exact ⟨certBits,
    ⟨le_trans hLength (G.certificate_bound_le_codeLength_bound),
      by simpa [verifyCertificateString_encode_append G certBits] using hVerify⟩⟩

end IndexedGraphColoringInstance

/-- The indexed graph-coloring decision problem. -/
def indexedGraphColoringDecisionProblem : DecisionProblem where
  Input := IndexedGraphColoringInstance
  accepts := fun G => (G.toGraphColoringInstance).HasColoring

/-- Soundness of the combined verifier for the indexed graph-coloring decision problem. -/
theorem indexedGraphColoring_verifyCertificateString_sound
    (G : IndexedGraphColoringInstance)
    (certBits : List BitEncoding.Bit)
    (hVerify :
      IndexedGraphColoringInstance.verifyCertificateString
        (G.encode ++ certBits) = true) :
    indexedGraphColoringDecisionProblem.accepts G :=
  G.verifyCertificateString_sound certBits hVerify

/--
Accepted indexed graph-coloring inputs have polynomially bounded certificate
strings for the combined verifier.
-/
theorem indexedGraphColoring_exists_bounded_certificateString
    (G : IndexedGraphColoringInstance)
    (h : indexedGraphColoringDecisionProblem.accepts G) :
    Exists fun certBits : List BitEncoding.Bit =>
      certBits.length
        <= IndexedGraphColoringInstance.certificateLengthBound G.encode.length
        /\ IndexedGraphColoringInstance.verifyCertificateString
          (G.encode ++ certBits) = true :=
  G.exists_bounded_certificateString_of_accepts h

/-- The indexed graph-coloring decision problem accepts exactly certificate-bearing graphs. -/
theorem indexedGraphColoring_accepts_iff_exists_certificate
    (G : IndexedGraphColoringInstance) :
    indexedGraphColoringDecisionProblem.accepts G
      <->
    Nonempty (G.ColoringCertificate) := by
  exact G.hasColoring_iff_exists_coloringCertificate

/-- The indexed graph-coloring decision problem accepts exactly verifying strings. -/
theorem indexedGraphColoring_accepts_iff_exists_verifyingString
    (G : IndexedGraphColoringInstance) :
    indexedGraphColoringDecisionProblem.accepts G
      <->
    Exists fun certBits : List BitEncoding.Bit =>
      IndexedGraphColoringInstance.ColoringCertificate.verifyString G certBits = true := by
  exact G.accepts_iff_exists_verifyingString

/-- The same indexed graph-coloring problem, with its concrete bit encoding. -/
def encodedIndexedGraphColoringDecisionProblem :
    EncodedDecisionProblem Bool where
  Input := IndexedGraphColoringInstance
  encode := IndexedGraphColoringInstance.encode
  accepts := indexedGraphColoringDecisionProblem.accepts

/-- Forgetting indices gives a plain many-one reduction to generic graph coloring. -/
def indexedGraphColoringToGraphColoring :
    ManyOneReduction
      indexedGraphColoringDecisionProblem
      graphColoringDecisionProblem where
  map := IndexedGraphColoringInstance.toGraphColoringInstance
  sound := by
    intro _ h
    exact h
  complete := by
    intro _ h
    exact h

end Complexity
end LearningTheory
