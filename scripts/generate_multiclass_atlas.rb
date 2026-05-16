#!/usr/bin/env ruby
# frozen_string_literal: true

require 'fileutils'
require 'psych'
require 'set'

ROOT = File.expand_path('..', __dir__)
ATLAS = File.join(ROOT, 'atlas')
MULTI = File.join(ATLAS, 'multiclass')

DOMAIN = 'multiclass-classification'
ID_PREFIX = 'multiclass'
TITLE_PREFIX = 'Multiclass'

AXES = [
  {
    'id' => 'resource',
    'frontmatter_field' => 'resource',
    'label' => 'Resource',
    'monotone_relaxation' => { 'from' => 'computationally-efficient', 'to' => 'sample-efficient' },
    'values' => [
      { 'id' => 'computationally-efficient', 'slug_token' => 'efficient', 'title_token' => 'Efficient', 'relaxation_rank' => 0 },
      { 'id' => 'sample-efficient', 'slug_token' => 'sample-efficient', 'title_token' => 'Sample-Efficient', 'relaxation_rank' => 1 }
    ]
  },
  {
    'id' => 'distribution',
    'frontmatter_field' => 'distribution',
    'label' => 'Distribution',
    'monotone_relaxation' => { 'from' => 'distribution-free', 'to' => 'marginal-nonuniform' },
    'values' => [
      { 'id' => 'distribution-free', 'slug_token' => nil, 'title_token' => nil, 'relaxation_rank' => 0 },
      { 'id' => 'marginal-nonuniform', 'slug_token' => 'marginal-nonuniform', 'title_token' => 'Marginal-Nonuniform', 'relaxation_rank' => 1 }
    ]
  },
  {
    'id' => 'strength',
    'frontmatter_field' => 'strength',
    'label' => 'Strength',
    'monotone_relaxation' => { 'from' => 'strong', 'to' => 'weak' },
    'values' => [
      { 'id' => 'strong', 'slug_token' => nil, 'title_token' => nil, 'relaxation_rank' => 0 },
      { 'id' => 'weak', 'slug_token' => 'weak', 'title_token' => 'Weak', 'relaxation_rank' => 1 }
    ]
  },
  {
    'id' => 'realizability',
    'frontmatter_field' => 'realizability',
    'label' => 'Realizability',
    'monotone_relaxation' => { 'from' => 'agnostic', 'to' => 'realizable' },
    'values' => [
      { 'id' => 'agnostic', 'slug_token' => 'agnostic', 'title_token' => 'Agnostic', 'relaxation_rank' => 0 },
      { 'id' => 'realizable', 'slug_token' => 'realizable', 'title_token' => 'Realizable', 'relaxation_rank' => 1 }
    ]
  },
  {
    'id' => 'properness',
    'frontmatter_field' => 'properness',
    'label' => 'Properness',
    'monotone_relaxation' => { 'from' => 'proper', 'to' => 'improper' },
    'values' => [
      { 'id' => 'proper', 'slug_token' => 'proper', 'title_token' => 'Proper', 'relaxation_rank' => 0 },
      { 'id' => 'improper', 'slug_token' => 'improper', 'title_token' => 'Improper', 'relaxation_rank' => 1 }
    ]
  }
].freeze

REFS = {
  'valiant1984' => '[Valiant 1984](https://doi.org/10.1145/1968.1972)',
  'blumer1989' => '[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)',
  'schapire1990' => '[Schapire 1990](https://doi.org/10.1023/A:1022648800760)',
  'freund1995boosting' => '[Freund 1995](https://doi.org/10.1006/inco.1995.1136)',
  'bendavid2001' => '[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)',
  'kalai2008agnosticboosting' => '[Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)',
  'mukherjee2013multiclass' => '[Mukherjee and Schapire 2013](https://jmlr.org/papers/v14/mukherjee13a.html)',
  'brukhim2023boosting' => '[Brukhim et al. 2023](https://proceedings.mlr.press/v195/brukhim23a.html)',
  'daniely2014optimal' => '[Daniely and Shalev-Shwartz 2014](https://proceedings.mlr.press/v35/daniely14b.html)',
  'daniely2015multiclass' => '[Daniely et al. 2015](https://jmlr.org/papers/v16/daniely15a.html)',
  'brukhim2022' => '[Brukhim et al. 2022](https://doi.org/10.1109/FOCS54457.2022.00093)',
  'cohen2025multiclass' => '[Cohen et al. 2025](https://arxiv.org/abs/2511.12659)',
  'benedek1991fixed' => '[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)',
  'hanneke2025marginalnonuniform' => '[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)',
  'bendavid1995parameterization' => '[Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)'
}.freeze

BIB_REFS = File.read(File.join(ROOT, 'references.bib')).scan(/^@\w+\{([^,]+),(.*?)(?=^@\w+\{|\z)/m).to_h do |key, body|
  doi = body[/\bdoi\s*=\s*\{([^}]+)\}/, 1]
  url = body[/\burl\s*=\s*\{([^}]+)\}/, 1]
  href = url || (doi ? "https://doi.org/#{doi}" : nil)
  [key, href ? "[#{key}](#{href})" : "`#{key}`"]
end.freeze

SAMPLE_KEYS = %w[
  daniely2014optimal
  daniely2015multiclass
  brukhim2022
  cohen2025multiclass
].freeze

BOOSTING_KEYS = %w[
  schapire1990
  freund1995boosting
  mukherjee2013multiclass
  brukhim2023boosting
].freeze

def read_frontmatter(path)
  text = File.read(path)
  Psych.safe_load(text.split("---\n", 3)[1], permitted_classes: [], aliases: false) || {}
end

def write_note(path, frontmatter, body = nil)
  FileUtils.mkdir_p(File.dirname(path))
  yaml = Psych.dump(frontmatter, line_width: -1).sub(/\A---\n/, "---\n")
  text = +"#{yaml}---\n"
  text << "\n#{body.rstrip}\n" if body
  File.write(path, text)
end

def prefixed(id)
  "#{ID_PREFIX}-#{id}"
end

def prefixed_link(link)
  return link unless link.is_a?(String)

  link.sub(/\A\[\[([^|\]]+)(\|[^\]]+)?\]\]\z/) do
    target = Regexp.last_match(1)
    label = Regexp.last_match(2)
    "[[#{prefixed(target)}#{label}]]"
  end
end

def prefixed_match(match)
  return match unless match.is_a?(Hash)

  match.transform_values.with_index do |value, _index|
    case value
    when Hash
      prefixed_match(value)
    when Array
      value.map { |item| item.is_a?(Hash) ? prefixed_match(item) : item }
    else
      value
    end
  end.tap do |mapped|
    %w[witnesses_all witnesses_any witnesses_none].each do |field|
      mapped[field] = Array(mapped[field]).map { |witness| prefixed(witness) } if mapped[field]
    end
  end
end

def add_match_not!(match, extra)
  existing = match['not']
  match['not'] = existing ? { 'any' => [existing, extra] } : extra
end

def ref_links(keys)
  keys.map { |key| REFS[key] || BIB_REFS.fetch(key) }
end

def markdown_refs(keys)
  return "" if keys.empty?

  "\n## References\n\n#{ref_links(keys).map { |ref| "- #{ref}" }.join("\n")}\n"
end

def title_for(id)
  read_frontmatter(File.join(MULTI, 'definitions', "#{id}.md"))['title']
end

def definition_body(fm)
  id = fm.fetch('id')
  title = fm.fetch('title')
  realizability = fm.fetch('realizability')
  properness = fm.fetch('properness')
  strength = fm.fetch('strength')
  resource = fm.fetch('resource')
  distribution = fm.fetch('distribution')

  label_rule = if realizability == 'realizable'
                 'labeled examples $(x,c(x))$, where $x \sim P$ and $c \in \mathcal C$'
               else
                 'examples $(x,y)$ from an arbitrary joint distribution $\mathcal D$ over $\mathcal X\times\mathcal Y$'
               end

  guarantee = if realizability == 'realizable' && strength == 'strong'
                <<~'MD'
                  $$
                  \operatorname{err}_P(h,c) \le \varepsilon.
                  $$
                MD
              elsif realizability == 'realizable'
                <<~'MD'
                  $$
                  \operatorname{err}_P(h,c) \le \frac{1}{2}-\gamma.
                  $$

                  The weak axis deliberately uses the same majority-accuracy threshold as the binary atlas. It is stronger than merely beating uniform random guessing over $k$ labels, but it gives a clean comparison with the binary implication graph.
                MD
              elsif strength == 'strong'
                <<~'MD'
                  $$
                  \operatorname{err}_{\mathcal D}(h)
                  \le
                  \inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\varepsilon.
                  $$
                MD
              else
                <<~'MD'
                  $$
                  \operatorname{err}_{\mathcal D}(h)
                  \le
                  \inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta,
                  $$

                  where $\beta<1/2$ is a fixed additive weak-agnostic tolerance. This is the majority-accuracy analogue of the binary weak agnostic node.
                MD
              end

  output = properness == 'proper' ? 'must output $h\in\mathcal C$' : 'may output a multiclass hypothesis $h:\mathcal X\to\mathcal Y$ outside $\mathcal C$'
  resource_text = if resource == 'computationally-efficient'
                    'Both sample complexity and running time must be bounded by a polynomial in the representation size, the relevant accuracy parameter, $\log(1/\delta)$, and the finite label-set description size.'
                  else
                    'Only the sample size must be polynomially bounded. Computation is unrestricted, so exhaustive search and nonconstructive learners are allowed.'
                  end
  distribution_text = if distribution == 'distribution-free'
                        'One polynomial bound must work uniformly over all instance marginals.'
                      else
                        'The learner is marginal-nonuniform: for each fixed instance marginal $P$, the polynomial bound may depend on $P$, while remaining uniform over targets or conditional label distributions with that marginal.'
                      end

  <<~MD
    # #{title}

    ## Definition

    A multiclass class is a set $\\mathcal C\\subseteq \\mathcal Y^{\\mathcal X}$ with finite label space $\\mathcal Y$ and $|\\mathcal Y|\\ge 3$. The finite label alphabet is part of the learning problem, so these nodes are kept separate from the binary-classification nodes even when a class uses only two labels.

    A learner receives i.i.d. #{label_rule}. With probability at least $1-\\delta$, it #{output} such that

    #{guarantee.rstrip}

    #{resource_text}

    #{distribution_text}

    ## Characterization Status

    `#{fm.fetch('characterization_status')}`: #{fm.fetch('characterization')}

    ## Boundary Examples

    Binary separation classes embed into this finite multiclass setting by choosing two labels $a,b\\in\\mathcal Y$ and mapping $0$ to $a$ and $1$ to $b$. The extra labels are inert, and zero-one error is preserved. This gives multiclass versions of the computational and sample-to-computational boundary examples recorded in [[multiclass-binary-embedded-separations|Binary-Embedded Separations]].

    For sample-complexity boundaries, finite-label multiclass learning is governed by multiclass dimensions rather than plain VC dimension. The notes cite the Natarajan/graph-dimension and DS-dimension literature where those distinctions matter.

    #{markdown_refs(fm.fetch('characterization_ref_keys', []))}
    ## Outgoing Implications

    ```dataview
    TABLE target_note AS "Target", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
    FROM "atlas/multiclass/implications"
    WHERE type = "implication" AND source = "#{id}"
    SORT target ASC
    ```

    ## Incoming Implications

    ```dataview
    TABLE source_note AS "Source", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", summary AS "Summary"
    FROM "atlas/multiclass/implications"
    WHERE type = "implication" AND target = "#{id}"
    SORT source ASC
    ```
  MD
end

def implication_refs_for(edge)
  family = edge.fetch('family')
  case family
  when 'sample-complexity-equivalence'
    SAMPLE_KEYS
  when 'realizable-boosting'
    BOOSTING_KEYS
  when 'spike-tilt-uniformization-plus-boosting'
    (Array(edge['ref_keys']) + BOOSTING_KEYS).uniq
  else
    Array(edge['ref_keys'])
  end
end

def low_noise_multiclass_open_edge?(edge)
  edge.fetch('family') == 'low-noise-weak-agnostic-robustification'
end

def marginal_boosting_needs_uniformization_edge?(edge)
  edge.fetch('family') == 'realizable-boosting' &&
    edge.fetch('source').start_with?('efficient-marginal-nonuniform-weak-') &&
    edge.fetch('target').start_with?('efficient-marginal-nonuniform-realizable-improper')
end

def marginal_weak_sample_counterexample_edge?(edge)
  edge.fetch('family') == 'sample-complexity-equivalence' &&
    edge.fetch('source').start_with?('sample-efficient-marginal-nonuniform-weak-') &&
    edge.fetch('target').start_with?('sample-efficient-') &&
    !edge.fetch('target').start_with?('sample-efficient-marginal-nonuniform-weak-')
end

def marginal_weak_agnostic_open_edge?(edge)
  edge.fetch('family') == 'halfspace-agnostic-hardness' &&
    edge.fetch('source').start_with?('efficient-marginal-nonuniform-weak-agnostic-')
end

def set_refs!(fm, keys)
  keys = keys.uniq
  if keys.empty?
    fm.delete('ref_keys')
    fm['refs'] = []
  else
    fm['ref_keys'] = keys
    fm['refs'] = ref_links(keys)
  end
end

def implication_summary(edge)
  case edge.fetch('family')
  when 'monotone-relaxation'
    edge.fetch('summary')
  when 'sample-complexity-equivalence'
    'At the finite-label multiclass sample-complexity level, runtime is ignored and standard multiclass learnability characterizations give the target guarantee.'
  when 'sample-to-computational-hardness'
    'Binary pseudorandom-function separations embed into multiclass classification by using two labels and ignoring the rest.'
  else
    edge.fetch('summary')
  end
end

def implication_body(fm)
  source_title = title_for(fm.fetch('source'))
  target_title = title_for(fm.fetch('target'))
  status = fm.fetch('status')
  evidence = fm.fetch('evidence')
  refs = Array(fm['ref_keys'])
  assumptions = Array(fm['assumptions'])
  witnesses = Array(fm['witnesses'])

  explanation = if status == 'true' && evidence == 'trivial'
                  'The target relaxes one or more axis requirements already met by the source. The same multiclass learner can therefore be used unchanged.'
                elsif status == 'true' && fm['family'] == 'multiclass-sample-complexity-equivalence'
                  'Since runtime is unrestricted at the target, the implication is a sample-complexity statement. For finite multiclass labels, the Natarajan/graph-dimension theory, DS-dimension characterization, and recent agnostic sample-complexity bounds provide the standard finite-sample side of the argument.'
                elsif status == 'true'
                  "The proof is recorded in #{fm.fetch('argument_note')}. The multiclass atlas uses the majority-accuracy weak convention, so the binary-style conversion is applied to the correct-versus-incorrect zero-one loss event."
                elsif status == 'false' && fm['family'] == 'multiclass-marginal-weak-sample-collapse-counterexample'
                  "The counterexample is recorded in #{fm.fetch('argument_note')}. Countable unrestricted multiclass labelings are weakly learnable for each fixed marginal, but slow tails prevent polynomial strong marginal-nonuniform rates and no-free-lunch prevents distribution-free weak learning."
                elsif status == 'false'
                  witness_text = witnesses.empty? ? 'the recorded witness' : witnesses.map { |w| "[[#{w}|#{w.sub(/^multiclass-/, '').split('-').map(&:capitalize).join(' ')}]]" }.join(', ')
                  assumption_text = assumptions.empty? ? '' : " under #{assumptions.join(', ')}"
                  "A binary separation witness embeds into the finite multiclass setting by fixing two labels and never using the others. Thus #{witness_text} satisfies the source while failing the target#{assumption_text}."
                else
                  "No source-grounded generic multiclass implication is recorded here. The obstruction is summarized in #{fm.fetch('argument_note')}."
                end

  <<~MD
    # #{source_title} $\\Rightarrow$ #{target_title}

    ## Verdict

    `#{status}`, with evidence `#{evidence}`.

    #{explanation}

    ## Axis Delta

    #{fm.fetch('axis_delta').map { |axis, delta| "- `#{axis}`: `#{delta}`" }.join("\n")}

    #{markdown_refs(refs)}
  MD
end

def argument_body(fm, original)
  refs = Array(fm['ref_keys'])
  status = fm.fetch('status', original['status'])
  evidence = fm.fetch('evidence', original['evidence'])

  main = case original.fetch('id')
         when 'sample-complexity-equivalence'
           'For finite label spaces, multiclass PAC sample complexity is controlled by multiclass combinatorial dimensions rather than plain VC dimension. The atlas uses those results to keep the sample-only nodes comparable across realizable, agnostic, weak, strong, proper, and improper variants, while keeping computational questions separate.'
         when 'realizable-boosting'
           'The multiclass weak axis uses the majority-accuracy convention: a weak learner has zero-one error below $1/2$ by an inverse-polynomial amount. Under this convention, boosting may output an improper vote or aggregation, so it supports the improper strong targets tracked by the edge family.'
         when 'sample-to-computational-hardness'
           'Any binary cryptographic hard class can be viewed as a multiclass class by using two labels in a larger finite alphabet. A polynomial-time multiclass learner would restrict to a polynomial-time learner for the embedded binary class.'
         when 'spike-tilt-uniformization'
           <<~'TEXT'.strip
             The spike-tilt construction is stated for multiclass zero-one correctness, not for a literal binary product $c(x)h(x)$. Given a target multiclass concept $c$ and a candidate $h$, the binary correctness variable is $+1$ on the event $h(x)=c(x)$ and $-1$ otherwise. Tilting the marginal by this correctness event lets a marginal-nonuniform weak learner reveal a distribution-free weak gap.

             Once the weak learner is distribution-free in this correctness sense, standard finite-label multiclass boosting can aggregate weak hypotheses into an improper strong learner whenever the target edge is realizable and improper.
           TEXT
         when 'low-noise-weak-agnostic-robustification'
           <<~'TEXT'.strip
             The binary low-noise robustification does not transfer as a theorem to finite-label multiclass classes with the weak convention used here. In the binary proof, a high-noise branch can fall back to one of two constants, because one constant has error at most $1/2$. For $k\ge 3$ labels, the best constant can have error $1-1/k$, which may exceed the majority weak threshold $1/2$.

             The low-noise branch still suggests a route, but the middle- and high-noise cases need a genuine multiclass neutralizer or another selector that attains $\operatorname{OPT}+\beta$ for some fixed $\beta<1/2$. The atlas therefore leaves these edges open rather than importing the binary proof.
           TEXT
         when 'agnostic-boosting-open'
           <<~'TEXT'.strip
             This family remains open for the finite-label multiclass atlas. The source node supplies only a fixed-additive weak agnostic learner, $\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+\beta$ for one $\beta<1/2$. Modern agnostic boosters, including the Ghai--Singh and da Cunha--Hogsgaard--Paudice lines cited here, use stronger oracle formulations: in binary language, they ask for a relative-correlation weak learner, often with a tunable tolerance parameter. Those assumptions do not follow from the atlas node.

             Binary agnostic boosting papers therefore give close positive routes but not a source-grounded closure of these edges. Multiclass boosting papers likewise show how to combine appropriate multiclass weak hypotheses, but they do not turn this atlas's fixed-additive multiclass weak learner into arbitrary-excess-error PAC learning for every finite-label class. A false witness is also not recorded: binary hard classes embedded into two multiclass labels either fail the weak source or remain vulnerable to improper aggregation.
           TEXT
         when 'marginal-agnostic-hardness-open'
           <<~'TEXT'.strip
             This family also remains open in the multiclass atlas. Hopkins--Kane--Lovett--Mahajan give broad realizable-to-agnostic reductions, including distribution-family and finite-label settings, but the reduction constructs a finite cover by running the realizable learner over possible labelings of an unlabeled sample. That is a sample-complexity theorem rather than a representation-sensitive polynomial-time implication, so it does not close these efficient edges.

             The target here is additionally proper. The existing low-noise robustification argument gives improper weak agnostic targets by validating arbitrary hypotheses and neutral defaults. It does not automatically provide a legal proper multiclass hypothesis when the class has no constant labels, complements, balanced sampler, or other proper neutralizer. Conversely, known distribution-free agnostic hardness witnesses do not by themselves rule out marginal-dependent polynomial bounds. The right fixed-marginal proper weak selector or no-neutral separation is still missing.
           TEXT
         else
           'This note is the multiclass counterpart of the binary argument family. When it records a separation, the witness is usually obtained by embedding the binary witness into a finite multiclass label space. When it records a true implication, the proof uses only zero-one correctness and the majority-accuracy weak convention adopted by this multiclass atlas.'
         end

  <<~MD
    # #{fm.fetch('title')}

    ## Verdict

    `#{status}`, with evidence `#{evidence}`.

    #{main}

    ## Scope

    The multiclass atlas is finite-label and separate from the binary atlas. The embedding observations here are used only to transfer lower-bound examples into the multiclass type; they do not create implication edges between binary and multiclass nodes.

    #{markdown_refs(refs)}
  MD
end

def witness_body(fm, original)
  refs = Array(fm['ref_keys'])
  <<~MD
    # #{fm.fetch('title')}

    ## Role

    This witness is obtained from the binary witness [[#{original.fetch('id')}|#{original.fetch('title')}]] by fixing two labels $a,b$ in a finite multiclass label space $\\mathcal Y$ with $|\\mathcal Y|\\ge 3$ and mapping binary labels to $a$ and $b$. The resulting class has type $\\mathcal X\\to\\mathcal Y$, while zero-one errors and polynomial resource requirements on the active labels are preserved.

    Therefore any learner or separation for the multiclass embedded class would restrict to the corresponding binary learner or separation. The extra labels are inert; their only role is to make the hypothesis class genuinely multiclass-typed.

    #{markdown_refs(refs)}
  MD
end

def transformed_family_registry
  registry = read_frontmatter(File.join(ATLAS, 'registry', 'edge_families.yml'))
  registry['id'] = 'multiclass-classification-edge-families'
  registry['title'] = 'Multiclass Classification Edge Family Registry'
  registry['domain'] = DOMAIN
  registry['families'] = registry.fetch('families').map do |family|
    mapped = Marshal.load(Marshal.dump(family))
    mapped['id'] = prefixed(family.fetch('id'))
    mapped['title'] = "#{TITLE_PREFIX} #{family.fetch('title')}"
    mapped['argument_note'] = prefixed_link(family['argument_note'])
    mapped['witness_note'] = prefixed_link(family['witness_note']) if family['witness_note']
    mapped['match'] = prefixed_match(mapped['match'])
    case family.fetch('id')
    when 'sample-complexity-equivalence'
      mapped['summary'] = 'Finite-label multiclass sample-complexity characterizations collapse the sample-only PAC variants tracked here.'
      mapped['match']['ref_keys_all'] = ['daniely2015multiclass']
    when 'realizable-boosting'
      mapped['summary'] = 'Majority-accuracy weak multiclass learning boosts to strong improper multiclass learning.'
      mapped['match']['ref_keys_all'] = ['mukherjee2013multiclass']
      add_match_not!(
        mapped['match'],
        {
          'all' => [
            { 'source_axis' => { 'distribution' => 'marginal-nonuniform', 'strength' => 'weak' } },
            { 'target_axis' => { 'distribution' => 'marginal-nonuniform', 'strength' => 'strong', 'realizability' => 'realizable', 'properness' => 'improper' } }
          ]
        }
      )
    when 'spike-tilt-uniformization-plus-boosting'
      mapped['match']['ref_keys_all'] = (Array(mapped['match']['ref_keys_all']) + ['mukherjee2013multiclass']).uniq
    when 'low-noise-weak-agnostic-robustification'
      mapped['status'] = 'open'
      mapped['evidence'] = 'unknown'
      mapped.delete('result_origin')
      mapped['summary'] = 'The binary low-noise robustification lacks a finite-label multiclass neutralizer for the majority weak threshold.'
      mapped['match']['status'] = 'open'
      mapped['match']['evidence'] = 'unknown'
    when 'marginal-uniformization-open'
      mapped['match']['axis_delta'] = { 'distribution' => 'marginal-nonuniform-to-distribution-free' }
    end
    mapped
  end
  registry['families'] += [
    {
      'id' => 'multiclass-spike-tilt-uniformization-plus-boosting-to-marginal-target',
      'title' => 'Multiclass Spike-Tilt Uniformization Plus Boosting to Marginal Target',
      'status' => 'true',
      'evidence' => 'theorem',
      'result_origin' => 'new',
      'argument_note' => '[[multiclass-spike-tilt-uniformization|Spike-Tilt Uniformization]]',
      'summary' => 'Spike-tilt first uniformizes the marginal weak learner; multiclass boosting then gives a distribution-free strong learner, hence the marginal target.',
      'match' => {
        'status' => 'true',
        'evidence' => 'theorem',
        'source_axis' => {
          'resource' => 'computationally-efficient',
          'distribution' => 'marginal-nonuniform',
          'strength' => 'weak'
        },
        'target_axis' => {
          'resource' => 'computationally-efficient',
          'distribution' => 'marginal-nonuniform',
          'strength' => 'strong',
          'realizability' => 'realizable',
          'properness' => 'improper'
        },
        'axis_delta' => {
          'distribution' => 'same',
          'strength' => 'weak-to-strong'
        },
        'ref_keys_all' => %w[benedek1991fixed hanneke2025marginalnonuniform mukherjee2013multiclass]
      }
    },
    {
      'id' => 'multiclass-marginal-weak-sample-collapse-counterexample',
      'title' => 'Multiclass Marginal Weak Sample Collapse Counterexample',
      'status' => 'false',
      'evidence' => 'counterexample',
      'result_origin' => 'new',
      'argument_note' => '[[multiclass-marginal-weak-sample-collapse-counterexample|Marginal Weak Sample Collapse Counterexample]]',
      'witness_note' => '[[multiclass-unrestricted-labelings|Unrestricted Labelings]]',
      'summary' => 'Countable unrestricted labelings are fixed-marginal weakly learnable but need not have polynomial strong marginal rates and are not distribution-free weakly learnable.',
      'match' => {
        'status' => 'false',
        'evidence' => 'counterexample',
        'source_axis' => {
          'resource' => 'sample-efficient',
          'distribution' => 'marginal-nonuniform',
          'strength' => 'weak'
        },
        'target_axis' => {
          'resource' => 'sample-efficient'
        },
        'witnesses_all' => ['multiclass-unrestricted-labelings']
      }
    },
    {
      'id' => 'multiclass-marginal-weak-agnostic-open',
      'title' => 'Multiclass Marginal Weak Agnostic Open',
      'status' => 'open',
      'evidence' => 'unknown',
      'argument_note' => '[[multiclass-marginal-weak-agnostic-open|Marginal Weak Agnostic Open]]',
      'summary' => 'The halfspace lower bound does not certify the marginal weak agnostic source, and no generic multiclass closure is known.',
      'match' => {
        'status' => 'open',
        'evidence' => 'unknown',
        'source_axis' => {
          'resource' => 'computationally-efficient',
          'distribution' => 'marginal-nonuniform',
          'strength' => 'weak',
          'realizability' => 'agnostic'
        },
        'target_axis' => {
          'resource' => 'computationally-efficient',
          'realizability' => 'agnostic'
        },
        'ref_keys_all' => ['tiegel2023']
      }
    }
  ]
  registry
end

def apply_multiclass_edge_overrides!(fm, old)
  if low_noise_multiclass_open_edge?(old)
    fm['status'] = 'open'
    fm['evidence'] = 'unknown'
    fm.delete('result_origin')
    fm['summary'] = 'Open: the binary low-noise robustification uses a constant-label fallback that does not meet the finite-label multiclass majority weak threshold.'
    fm['witnesses'] = []
    fm.delete('witness_note')
    set_refs!(fm, Array(old['ref_keys']))
  elsif marginal_boosting_needs_uniformization_edge?(old)
    fm['family'] = 'multiclass-spike-tilt-uniformization-plus-boosting-to-marginal-target'
    fm['argument_note'] = '[[multiclass-spike-tilt-uniformization|Spike-Tilt Uniformization]]'
    fm['result_origin'] = 'new'
    fm['summary'] = 'True, but not by directly boosting a marginal-nonuniform weak learner: spike-tilt first gives distribution-free weak realizable learning, then multiclass boosting gives a distribution-free strong improper learner and hence the marginal target.'
    set_refs!(fm, (Array(old['ref_keys']) + BOOSTING_KEYS).uniq)
  elsif marginal_weak_sample_counterexample_edge?(old)
    fm['status'] = 'false'
    fm['evidence'] = 'counterexample'
    fm['result_origin'] = 'new'
    fm['family'] = 'multiclass-marginal-weak-sample-collapse-counterexample'
    fm['argument_note'] = '[[multiclass-marginal-weak-sample-collapse-counterexample|Marginal Weak Sample Collapse Counterexample]]'
    fm['witnesses'] = ['multiclass-unrestricted-labelings']
    fm['witness_note'] = '[[multiclass-unrestricted-labelings|Unrestricted Labelings]]'
    fm['assumptions'] = []
    fm['summary'] = 'False: countable unrestricted multiclass labelings are weakly learnable for each fixed marginal, but slow tails block polynomial strong marginal rates and no-free-lunch blocks distribution-free weak learning.'
    set_refs!(fm, %w[valiant1984 blumer1989 benedek1991fixed hanneke2025marginalnonuniform])
  elsif marginal_weak_agnostic_open_edge?(old)
    fm['status'] = 'open'
    fm['evidence'] = 'unknown'
    fm.delete('result_origin')
    fm['family'] = 'multiclass-marginal-weak-agnostic-open'
    fm['argument_note'] = '[[multiclass-marginal-weak-agnostic-open|Marginal Weak Agnostic Open]]'
    fm['witnesses'] = []
    fm.delete('witness_note')
    fm['assumptions'] = []
    fm['summary'] = 'Open: halfspace hardness gives the agnostic target obstruction, but the multiclass atlas has no fixed-gap marginal weak agnostic source proof for halfspaces.'
    set_refs!(fm, %w[tiegel2023])
  end
end

def generate_registries
  axes_registry = {
    'type' => 'registry',
    'id' => 'multiclass-classification-axes',
    'title' => 'Multiclass Classification Axis Registry',
    'domain' => DOMAIN,
    'model' => 'pac',
    'id_prefix' => ID_PREFIX,
    'id_suffix' => 'pac',
    'title_prefix' => TITLE_PREFIX,
    'title_suffix' => 'PAC Learning',
    'label_space' => 'finite-multiclass',
    'weak_convention' => 'majority-accuracy',
    'axes' => AXES
  }
  write_note(File.join(MULTI, 'registry', 'axes.yml'), axes_registry)
  write_note(File.join(MULTI, 'registry', 'edge_families.yml'), transformed_family_registry)
end

def generate_definitions
  Dir[File.join(ATLAS, 'definitions', '*.md')].sort.each do |path|
    old = read_frontmatter(path)
    fm = old.merge(
      'id' => prefixed(old.fetch('id')),
      'title' => "#{TITLE_PREFIX} #{old.fetch('title')}",
      'domain' => DOMAIN,
      'label_space' => 'finite-multiclass',
      'label_count' => 'finite, at least 3',
      'weak_convention' => 'majority-accuracy',
      'tags' => ['atlas/definition', 'learning/multiclass-classification']
    )
    keys = SAMPLE_KEYS.dup
    keys |= BOOSTING_KEYS if fm['strength'] == 'weak'
    keys.unshift('valiant1984')
    fm['characterization_ref_keys'] = keys.uniq
    fm['characterization_refs'] = ref_links(fm['characterization_ref_keys'])
    if fm['resource'] == 'sample-efficient'
      fm['characterization_status'] = 'known'
      fm['characterization'] = 'Finite-label multiclass sample learnability is characterized by the multiclass dimension theory; runtime is unrestricted.'
    else
      fm['characterization_status'] = 'partial'
      fm['characterization'] = 'The sample-complexity analogue is governed by multiclass dimension theory, but polynomial-time learnability remains representation-sensitive.'
    end
    write_note(File.join(MULTI, 'definitions', "#{fm.fetch('id')}.md"), fm, definition_body(fm))
  end
end

def generate_implications
  Dir[File.join(ATLAS, 'implications', '*.md')].sort.each do |path|
    old = read_frontmatter(path)
    source = prefixed(old.fetch('source'))
    target = prefixed(old.fetch('target'))
    source_title = title_for(source)
    target_title = title_for(target)
    keys = implication_refs_for(old)
    fm = old.merge(
      'id' => "#{source}__implies__#{target}",
      'source' => source,
      'target' => target,
      'source_note' => "[[#{source}|#{source_title}]]",
      'target_note' => "[[#{target}|#{target_title}]]",
      'domain' => DOMAIN,
      'family' => prefixed(old.fetch('family')),
      'argument_note' => prefixed_link(old.fetch('argument_note')),
      'summary' => implication_summary(old),
      'tags' => ['atlas/implication', 'learning/multiclass-classification']
    )
    fm['witnesses'] = Array(old['witnesses']).map { |w| prefixed(w) }
    fm['witness_note'] = prefixed_link(old['witness_note']) if old['witness_note']
    if keys.empty?
      fm.delete('ref_keys')
      fm['refs'] = []
    else
      fm['ref_keys'] = keys
      fm['refs'] = ref_links(keys)
    end
    apply_multiclass_edge_overrides!(fm, old)
    filename = "#{source}--implies--#{target}.md"
    write_note(File.join(MULTI, 'implications', filename), fm, implication_body(fm))
  end
end

def generate_arguments
  Dir[File.join(ATLAS, 'arguments', '*.md')].sort.each do |path|
    old = read_frontmatter(path)
    keys = case old.fetch('id')
           when 'sample-complexity-equivalence'
             SAMPLE_KEYS + %w[benedek1991fixed hanneke2025marginalnonuniform]
           when 'realizable-boosting'
             BOOSTING_KEYS
           else
             Array(old['ref_keys'])
           end
    fm = old.merge(
      'id' => prefixed(old.fetch('id')),
      'title' => "#{TITLE_PREFIX} #{old.fetch('title')}",
      'domain' => DOMAIN,
      'tags' => ['atlas/argument', 'learning/multiclass-classification']
    )
    fm['witnesses'] = Array(old['witnesses']).map { |w| prefixed(w) } if old['witnesses']
    fm['witness_note'] = prefixed_link(old['witness_note']) if old['witness_note']
    if old.fetch('id') == 'low-noise-weak-agnostic-robustification'
      fm['status'] = 'open'
      fm['evidence'] = 'unknown'
    end
    fm['ref_keys'] = keys.uniq
    fm['refs'] = ref_links(fm['ref_keys'])
    write_note(File.join(MULTI, 'arguments', "#{fm.fetch('id')}.md"), fm, argument_body(fm, old))
  end
end

def generate_custom_arguments
  sample_keys = %w[valiant1984 blumer1989 benedek1991fixed hanneke2025marginalnonuniform]
  sample_fm = {
    'type' => 'argument',
    'id' => 'multiclass-marginal-weak-sample-collapse-counterexample',
    'title' => 'Marginal Weak Sample Collapse Counterexample',
    'domain' => DOMAIN,
    'model' => 'pac',
    'status' => 'false',
    'evidence' => 'counterexample',
    'witnesses' => ['multiclass-unrestricted-labelings'],
    'witness_note' => '[[multiclass-unrestricted-labelings|Unrestricted Labelings]]',
    'assumptions' => [],
    'ref_keys' => sample_keys,
    'refs' => ref_links(sample_keys),
    'tags' => ['atlas/argument', 'learning/multiclass-classification']
  }
  sample_body = <<~'MD'
    # Marginal Weak Sample Collapse Counterexample

    ## Verdict

    `false`, with evidence `counterexample`.

    The goal is to separate fixed-marginal weak sample learnability from both distribution-free sample learnability and fixed-marginal strong sample learnability.

    Use a countably infinite instance space and fix two active labels inside a finite multiclass label set. The class contains all functions from the instance space to those two active labels. This is the finite-multiclass embedding of unrestricted binary labelings, and it is proper-friendly for active-label prediction rules.

    For any fixed marginal, weak learning is easy. Choose a finite set carrying enough probability mass to make the remaining tail below the fixed weak tolerance, estimate the best label on that finite set, and output arbitrary labels elsewhere. In the realizable case this memorizes the target on the high-mass set; in the agnostic case empirical majority labels approximate the Bayes rule on that set. Because the weak tolerance is fixed, the finite set and the required sample bound may depend on the marginal.

    Strong marginal-nonuniform sample efficiency does not follow. Some fixed countable marginals have tails whose high-mass truncation size grows faster than any polynomial in $1/\varepsilon$. On such marginals, unrestricted labelings force a learner to see essentially all high-mass points needed for the desired accuracy, so no marginal-dependent polynomial strong rate exists.

    Distribution-free weak learning also fails by the standard no-free-lunch argument for unrestricted labelings. For every proposed sample bound, choose a marginal spread over many more atoms than the sample can cover and choose labels adversarially on the unseen mass. The learner has no information about enough of the domain to guarantee error below the majority threshold.

    ## Scope

    This is the main place where the binary sample-only conclusion does not transfer to the multiclass atlas as originally recorded. Multiclass sample-complexity theory still gives the usual positive characterizations for finite-dimensional classes, but unrestricted countable labelings show that marginal-nonuniform weak sample learnability is strictly weaker than the strong or distribution-free sample nodes tracked here.

    __REFERENCES__
  MD
  sample_body = sample_body.sub('__REFERENCES__', markdown_refs(sample_keys))
  write_note(File.join(MULTI, 'arguments', "#{sample_fm.fetch('id')}.md"), sample_fm, sample_body)

  open_keys = %w[tiegel2023]
  open_fm = {
    'type' => 'argument',
    'id' => 'multiclass-marginal-weak-agnostic-open',
    'title' => 'Marginal Weak Agnostic Open',
    'domain' => DOMAIN,
    'model' => 'pac',
    'status' => 'open',
    'evidence' => 'unknown',
    'ref_keys' => open_keys,
    'refs' => ref_links(open_keys),
    'tags' => ['atlas/argument', 'learning/multiclass-classification']
  }
  open_body = <<~'MD'
    # Marginal Weak Agnostic Open

    ## Verdict

    `open`, with evidence `unknown`.

    These edges were previously assigned to the halfspace agnostic hardness family. That target obstruction is real: a strong agnostic learner for the relevant multiclass embedded halfspaces would imply the corresponding binary learner ruled out by Tiegel's hardness theorem.

    The missing part is the source. The current multiclass low-noise robustification proof does not show that halfspaces satisfy the marginal-nonuniform weak agnostic nodes with a fixed additive $\beta<1/2$. In binary, a constant fallback handles high-noise distributions because one of two constants has error at most $1/2$. With three or more labels, the best constant can have error $1-1/k$, so the same fallback can miss the majority weak threshold.

    A true edge would need a generic fixed-gap multiclass weak agnostic learner or a valid multiclass neutralizer. A false edge would need a witness satisfying the marginal weak agnostic source while failing the stronger agnostic target. The present atlas records neither.

    __REFERENCES__
  MD
  open_body = open_body.sub('__REFERENCES__', markdown_refs(open_keys))
  write_note(File.join(MULTI, 'arguments', "#{open_fm.fetch('id')}.md"), open_fm, open_body)
end

def generate_witnesses
  Dir[File.join(ATLAS, 'witnesses', '*.md')].sort.each do |path|
    old = read_frontmatter(path)
    fm = old.merge(
      'id' => prefixed(old.fetch('id')),
      'title' => "#{TITLE_PREFIX} Embedded #{old.fetch('title')}",
      'domain' => DOMAIN,
      'tags' => ['atlas/witness', 'learning/multiclass-classification']
    )
    write_note(File.join(MULTI, 'witnesses', "#{fm.fetch('id')}.md"), fm, witness_body(fm, old))
  end

  fm = {
    'type' => 'witness',
    'id' => 'multiclass-binary-embedded-separations',
    'title' => 'Binary-Embedded Separations',
    'domain' => DOMAIN,
    'model' => 'pac',
    'assumptions' => [],
    'ref_keys' => %w[valiant1984 daniely2015multiclass],
    'refs' => ref_links(%w[valiant1984 daniely2015multiclass]),
    'tags' => ['atlas/witness', 'learning/multiclass-classification']
  }
  body = <<~MD
    # Binary-Embedded Separations

    ## Role

    Let $\\mathcal B\\subseteq\\{0,1\\}^{\\mathcal X}$ be a binary class and let $\\mathcal Y$ be a finite label set with distinct labels $a,b$ and at least one additional label. The embedding sends each binary concept $c$ to the multiclass concept $\\tilde c$ with $\\tilde c(x)=a$ when $c(x)=0$ and $\\tilde c(x)=b$ when $c(x)=1$.

    For zero-one loss, errors are preserved under this embedding. Thus binary lower bounds remain valid multiclass lower bounds, even though the multiclass nodes have their own type and no implication edges to the binary nodes.

    ## References

    - #{REFS.fetch('valiant1984')}
    - #{REFS.fetch('daniely2015multiclass')}
  MD
  write_note(File.join(MULTI, 'witnesses', "#{fm.fetch('id')}.md"), fm, body)
end

def generate_readme
  fm = {
    'type' => 'readme',
    'id' => 'multiclass-atlas-readme',
    'title' => 'Multiclass Classification Atlas',
    'domain' => DOMAIN,
    'tags' => ['atlas/readme', 'learning/multiclass-classification']
  }
  body = <<~'MD'
    # Multiclass Classification Atlas

    This folder mirrors the binary PAC atlas for finite-label multiclass classification. The graph has its own definition and implication notes because a multiclass class has type $\mathcal C\subseteq\mathcal Y^{\mathcal X}$ rather than $\mathcal C\subseteq\{0,1\}^{\mathcal X}$.

    The axis registry generates the same 32 combinations as the binary atlas:

    - `resource`: `computationally-efficient -> sample-efficient`
    - `distribution`: `distribution-free -> marginal-nonuniform`
    - `strength`: `strong -> weak`
    - `realizability`: `agnostic -> realizable`
    - `properness`: `proper -> improper`

    The weak axis uses a majority-accuracy convention: a weak realizable multiclass learner has error at most $1/2-\gamma$. This is intentionally comparable with the binary atlas and should not be read as the only possible large-label weak-learning notion.

    Binary separation witnesses are embedded by using two labels in a larger finite alphabet and ignoring the rest. This transfers lower bounds into the multiclass type without adding any cross-domain implication edges.
  MD
  write_note(File.join(MULTI, 'README.md'), fm, body)
end

def generate_dashboard
  fm = {
    'type' => 'dashboard',
    'id' => 'multiclass-classification-dashboard',
    'title' => 'Multiclass Classification Dashboard',
    'domain' => DOMAIN,
    'tags' => ['atlas/dashboard', 'learning/multiclass-classification']
  }
  body = <<~MD
    # Multiclass Classification Dashboard

    This dashboard treats finite-label multiclass learning notions as nodes and implications as directed edges. It mirrors the binary atlas axes while keeping the multiclass graph in its own folder.

    Dataview must be enabled in Obsidian for the tables below to render.

    ## Definitions

    ```dataview
    TABLE title AS "Definition", resource AS "Resource", distribution AS "Distribution", realizability AS "Realizability", properness AS "Properness", strength AS "Strength", characterization_status AS "Characterization"
    FROM "atlas/multiclass/definitions"
    WHERE type = "definition" AND domain = "multiclass-classification"
    SORT resource ASC, distribution ASC, strength ASC, realizability DESC, properness DESC
    ```

    ## All Implications

    ```dataview
    TABLE source_note AS "Source", target_note AS "Target", status AS "Status", family AS "Family", evidence AS "Evidence", result_origin AS "Result Origin", assumptions AS "Assumptions", witness_note AS "Witness", argument_note AS "Argument", summary AS "Summary"
    FROM "atlas/multiclass/implications"
    WHERE type = "implication" AND domain = "multiclass-classification"
    SORT family ASC, source ASC, target ASC
    ```

    ## Open Implications

    ```dataview
    TABLE source_note AS "Source", target_note AS "Target", family AS "Family", argument_note AS "Argument", refs AS "Refs", summary AS "Summary"
    FROM "atlas/multiclass/implications"
    WHERE type = "implication" AND domain = "multiclass-classification" AND status = "open"
    SORT family ASC, source ASC, target ASC
    ```
  MD
  write_note(File.join(MULTI, 'dashboards', 'multiclass-classification.md'), fm, body)
end

FileUtils.rm_rf(MULTI)
%w[arguments dashboards definitions implications registry witnesses].each do |dir|
  FileUtils.mkdir_p(File.join(MULTI, dir))
end

generate_registries
generate_definitions
generate_implications
generate_arguments
generate_custom_arguments
generate_witnesses
generate_readme
generate_dashboard

puts "generated #{Dir[File.join(MULTI, '**', '*')].count { |path| File.file?(path) }} files under #{MULTI.sub("#{ROOT}/", '')}"
