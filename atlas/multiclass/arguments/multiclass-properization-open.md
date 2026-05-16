---
type: argument
id: multiclass-properization-open
title: Multiclass Properization Open
domain: multiclass-classification
model: pac
status: open
evidence: unknown
ref_keys:
- schapire1990
- pitt1988
- khot2008dnf
- hastad2005query
- karp1972
- kearns1994cryptographic
- hastad1999prg
- benedek1991fixed
- bendavid1995parameterization
- hanneke2025marginalnonuniform
- plotkin1960
- mceliece1977
- guruswami2010list
refs:
- "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
- "`pitt1988`"
- "[khot2008dnf](https://doi.org/10.1109/FOCS.2008.37)"
- "[hastad2005query](https://theoryofcomputing.org/articles/v001a007/)"
- "[karp1972](https://doi.org/10.1007/978-1-4684-2001-2_9)"
- "[kearns1994cryptographic](https://doi.org/10.1145/174644.174647)"
- "[hastad1999prg](https://doi.org/10.1137/S0097539793244708)"
- "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
- "[Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)"
- "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
- "[plotkin1960](https://doi.org/10.1109/TIT.1960.1057584)"
- "[mceliece1977](https://doi.org/10.1109/TIT.1977.1055688)"
- "[guruswami2010list](https://doi.org/10.1109/TIT.2010.2070170)"
tags:
- atlas/argument
- learning/multiclass-classification
---

# Multiclass Properization Open

## Verdict

`open`, with evidence `unknown`.

This note is the multiclass counterpart of the binary argument family. When it records a separation, the witness is usually obtained by embedding the binary witness into a finite multiclass label space. When it records a true implication, the proof uses only zero-one correctness and the majority-accuracy weak convention adopted by this multiclass atlas.

## Scope

The multiclass atlas is finite-label and separate from the binary atlas. The embedding observations here are used only to transfer lower-bound examples into the multiclass type; they do not create implication edges between binary and multiclass nodes.


## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- `pitt1988`
- [khot2008dnf](https://doi.org/10.1109/FOCS.2008.37)
- [hastad2005query](https://theoryofcomputing.org/articles/v001a007/)
- [karp1972](https://doi.org/10.1007/978-1-4684-2001-2_9)
- [kearns1994cryptographic](https://doi.org/10.1145/174644.174647)
- [hastad1999prg](https://doi.org/10.1137/S0097539793244708)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
- [plotkin1960](https://doi.org/10.1109/TIT.1960.1057584)
- [mceliece1977](https://doi.org/10.1109/TIT.1977.1055688)
- [guruswami2010list](https://doi.org/10.1109/TIT.2010.2070170)
