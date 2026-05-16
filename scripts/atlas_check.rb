#!/usr/bin/env ruby
# frozen_string_literal: true

require 'psych'
require 'set'

ROOT = File.expand_path('..', __dir__)
ATLAS = File.join(ROOT, 'atlas')

@errors = []
@summaries = []

def error(message)
  @errors << message
end

def rel(path)
  path.sub(%r{\A#{Regexp.escape(ROOT)}/?}, '')
end

def load_yaml(path)
  Psych.safe_load(File.read(path), permitted_classes: [], aliases: false) || {}
rescue Psych::Exception => e
  error("#{rel(path)}: YAML parse error: #{e.message}")
  {}
end

def frontmatter(path)
  text = File.read(path)
  unless text.start_with?("---\n")
    error("#{rel(path)}: missing frontmatter")
    return {}
  end

  yaml = text.split("---\n", 3)[1]
  Psych.safe_load(yaml, permitted_classes: [], aliases: false) || {}
rescue Psych::Exception => e
  error("#{rel(path)}: frontmatter parse error: #{e.message}")
  {}
end

def wiki_target(link)
  return nil unless link.is_a?(String)

  link[/\A\[\[([^|\]]+)/, 1]
end

def axis_combinations(axis_ids, axis_value_ids)
  axis_ids.reduce([{}]) do |partials, axis_id|
    partials.flat_map do |partial|
      axis_value_ids.fetch(axis_id).map { |value| partial.merge(axis_id => value) }
    end
  end
end

def expected_node_id(combo, axes_registry, axis_ids, axis_slug_tokens)
  tokens = [axes_registry['id_prefix']]
  axis_ids.each do |axis_id|
    token = axis_slug_tokens.fetch(axis_id).fetch(combo.fetch(axis_id))
    tokens << token if token
  end
  tokens << axes_registry['id_suffix']
  tokens.compact.join('-')
end

def expected_node_title(combo, axes_registry, axis_ids, axis_title_tokens)
  tokens = [axes_registry['title_prefix']]
  axis_ids.each do |axis_id|
    token = axis_title_tokens.fetch(axis_id).fetch(combo.fetch(axis_id))
    tokens << token if token
  end
  tokens << axes_registry['title_suffix']
  tokens.compact.join(' ')
end

def axis_delta(source_axes, target_axes, axis_ids)
  axis_ids.to_h do |axis_id|
    source = source_axes.fetch(axis_id)
    target = target_axes.fetch(axis_id)
    [axis_id, source == target ? 'same' : "#{source}-to-#{target}"]
  end
end

def monotone_relaxation?(source_axes, target_axes, axis_ids, axis_ranks)
  axis_ids.all? do |axis_id|
    axis_ranks.fetch(axis_id).fetch(target_axes.fetch(axis_id)) >=
      axis_ranks.fetch(axis_id).fetch(source_axes.fetch(axis_id))
  end && axis_ids.any? do |axis_id|
    axis_ranks.fetch(axis_id).fetch(target_axes.fetch(axis_id)) >
      axis_ranks.fetch(axis_id).fetch(source_axes.fetch(axis_id))
  end
end

def values_include_all?(values, required)
  required.all? { |item| values.include?(item) }
end

def values_include_any?(values, required)
  required.any? { |item| values.include?(item) }
end

def values_include_none?(values, forbidden)
  forbidden.none? { |item| values.include?(item) }
end

def match_family?(match, edge, source_axes, target_axes, context)
  return true unless match

  Array(match['all']).all? { |child| match_family?(child, edge, source_axes, target_axes, context) } &&
    (match['any'].nil? || Array(match['any']).any? { |child| match_family?(child, edge, source_axes, target_axes, context) }) &&
    (match['not'].nil? || !match_family?(match['not'], edge, source_axes, target_axes, context)) &&
    (match['status'].nil? || edge['status'] == match['status']) &&
    (match['evidence'].nil? || edge['evidence'] == match['evidence']) &&
    (match['monotone_relaxation'].nil? || context.fetch(:monotone_relaxation) == match['monotone_relaxation']) &&
    (match['ref_keys_all'].nil? || values_include_all?(Array(edge['ref_keys']), Array(match['ref_keys_all']))) &&
    (match['ref_keys_any'].nil? || values_include_any?(Array(edge['ref_keys']), Array(match['ref_keys_any']))) &&
    (match['ref_keys_none'].nil? || values_include_none?(Array(edge['ref_keys']), Array(match['ref_keys_none']))) &&
    (match['witnesses_all'].nil? || values_include_all?(Array(edge['witnesses']), Array(match['witnesses_all']))) &&
    (match['witnesses_any'].nil? || values_include_any?(Array(edge['witnesses']), Array(match['witnesses_any']))) &&
    (match['witnesses_none'].nil? || values_include_none?(Array(edge['witnesses']), Array(match['witnesses_none']))) &&
    (match['source_axis'].nil? || match['source_axis'].all? { |axis_id, value| source_axes[axis_id] == value }) &&
    (match['target_axis'].nil? || match['target_axis'].all? { |axis_id, value| target_axes[axis_id] == value }) &&
    (match['axis_delta'].nil? || match['axis_delta'].all? { |axis_id, value| context.fetch(:axis_delta)[axis_id] == value })
end

def graph_specs
  [
    {
      name: 'binary',
      base: ATLAS,
      registry: File.join(ATLAS, 'registry'),
      definitions: File.join(ATLAS, 'definitions'),
      implications: File.join(ATLAS, 'implications'),
      arguments: File.join(ATLAS, 'arguments'),
      witnesses: File.join(ATLAS, 'witnesses')
    },
    {
      name: 'multiclass',
      base: File.join(ATLAS, 'multiclass'),
      registry: File.join(ATLAS, 'multiclass', 'registry'),
      definitions: File.join(ATLAS, 'multiclass', 'definitions'),
      implications: File.join(ATLAS, 'multiclass', 'implications'),
      arguments: File.join(ATLAS, 'multiclass', 'arguments'),
      witnesses: File.join(ATLAS, 'multiclass', 'witnesses')
    }
  ].select { |spec| File.exist?(File.join(spec[:registry], 'axes.yml')) }
end

def validate_graph(spec)
  axes_registry_path = File.join(spec[:registry], 'axes.yml')
  families_registry_path = File.join(spec[:registry], 'edge_families.yml')
  axes_registry = load_yaml(axes_registry_path)
  families_registry = load_yaml(families_registry_path)

  axes = Array(axes_registry['axes'])
  axis_ids = axes.map { |axis| axis['id'] }
  axis_fields = axes.to_h { |axis| [axis['id'], axis['frontmatter_field'] || axis['id']] }
  axis_values = axes.to_h { |axis| [axis['id'], Array(axis['values'])] }
  axis_value_ids = axis_values.transform_values { |values| values.map { |value| value['id'] } }
  axis_ranks = axis_values.transform_values do |values|
    values.to_h { |value| [value['id'], Integer(value['relaxation_rank'])] }
  end
  axis_slug_tokens = axis_values.transform_values do |values|
    values.to_h { |value| [value['id'], value['slug_token']] }
  end
  axis_title_tokens = axis_values.transform_values do |values|
    values.to_h { |value| [value['id'], value['title_token']] }
  end

  families = Array(families_registry['families'])
  families_by_id = families.to_h { |family| [family['id'], family] }
  allowed_status_evidence = families_registry.fetch('allowed_status_evidence', {})
  allowed_result_origins = Array(families_registry['allowed_result_origins'] || %w[known new unclear])

  combinations = axis_combinations(axis_ids, axis_value_ids)
  expected_nodes = combinations.to_h do |combo|
    id = expected_node_id(combo, axes_registry, axis_ids, axis_slug_tokens)
    [id, {
      'id' => id,
      'title' => expected_node_title(combo, axes_registry, axis_ids, axis_title_tokens),
      'axes' => combo
    }]
  end

  definition_files = Dir[File.join(spec[:definitions], '*.md')]
  definitions = definition_files.to_h do |path|
    fm = frontmatter(path)
    [fm['id'], fm.merge('_path' => path)]
  end

  expected_nodes.each do |id, expected|
    fm = definitions[id]
    if fm.nil?
      error("#{rel(spec[:definitions])}: missing generated node #{id}")
      next
    end

    error("#{rel(fm['_path'])}: type should be definition") unless fm['type'] == 'definition'
    error("#{rel(fm['_path'])}: domain should be #{axes_registry['domain']}") unless fm['domain'] == axes_registry['domain']
    error("#{rel(fm['_path'])}: model should be #{axes_registry['model']}") unless fm['model'] == axes_registry['model']
    error("#{rel(fm['_path'])}: title should be #{expected['title'].inspect}") unless fm['title'] == expected['title']

    expected['axes'].each do |axis_id, value|
      field = axis_fields.fetch(axis_id)
      error("#{rel(fm['_path'])}: #{field} should be #{value}") unless fm[field] == value
    end
  end

  definitions.each do |id, fm|
    next unless fm['type'] == 'definition' && fm['domain'] == axes_registry['domain']

    unless expected_nodes.key?(id)
      error("#{rel(fm['_path'])}: definition id is not generated by #{rel(axes_registry_path)}")
    end
  end

  implication_files = Dir[File.join(spec[:implications], '*.md')]
  implications = {}
  implication_files.each do |path|
    fm = frontmatter(path)
    next unless fm['type'] == 'implication' && fm['domain'] == axes_registry['domain']

    key = [fm['source'], fm['target']]
    error("#{rel(path)}: duplicate implication for #{key.join(' -> ')}") if implications.key?(key)
    implications[key] = fm.merge('_path' => path)
  end

  expected_nodes.keys.each do |source_id|
    expected_nodes.keys.each do |target_id|
      next if source_id == target_id

      edge = implications[[source_id, target_id]]
      if edge.nil?
        error("#{rel(spec[:implications])}: missing #{source_id} -> #{target_id}")
        next
      end

      expected_id = "#{source_id}__implies__#{target_id}"
      error("#{rel(edge['_path'])}: id should be #{expected_id}") unless edge['id'] == expected_id

      allowed_evidence = Array(allowed_status_evidence[edge['status']])
      unless allowed_evidence.include?(edge['evidence'])
        error("#{rel(edge['_path'])}: evidence #{edge['evidence'].inspect} is not allowed for status #{edge['status'].inspect}")
      end

      if edge['status'] == 'open'
        if edge.key?('result_origin') && edge['result_origin']
          error("#{rel(edge['_path'])}: result_origin should be omitted for open edges")
        end
      elsif !edge.key?('result_origin')
        error("#{rel(edge['_path'])}: result_origin is required for non-open edges")
      elsif !allowed_result_origins.include?(edge['result_origin'])
        error("#{rel(edge['_path'])}: result_origin #{edge['result_origin'].inspect} is not allowed")
      end

      source_axes = expected_nodes.fetch(source_id).fetch('axes')
      target_axes = expected_nodes.fetch(target_id).fetch('axes')
      delta = axis_delta(source_axes, target_axes, axis_ids)
      context = {
        axis_delta: delta,
        monotone_relaxation: monotone_relaxation?(source_axes, target_axes, axis_ids, axis_ranks)
      }
      matches = families.select { |family| match_family?(family['match'], edge, source_axes, target_axes, context) }

      if matches.length != 1
        error("#{rel(edge['_path'])}: expected exactly one edge family, found #{matches.map { |family| family['id'] }.inspect}")
        next
      end

      family = matches.first
      if edge['family'] != family['id']
        error("#{rel(edge['_path'])}: family should be #{family['id'].inspect}, got #{edge['family'].inspect}")
      end

      unless edge['axis_delta'] == delta
        error("#{rel(edge['_path'])}: axis_delta should be #{delta.inspect}, got #{edge['axis_delta'].inspect}")
      end

      if edge['argument_note'] != family['argument_note']
        error("#{rel(edge['_path'])}: argument_note should be #{family['argument_note'].inspect}, got #{edge['argument_note'].inspect}")
      end

      if edge['status'] == 'open'
        if family.key?('result_origin') && family['result_origin']
          error("#{rel(families_registry_path)}: open family #{family['id']} should omit result_origin")
        end
      elsif family['result_origin'].nil?
        error("#{rel(families_registry_path)}: family #{family['id']} needs result_origin for non-open edges")
      elsif edge['result_origin'] != family['result_origin']
        error("#{rel(edge['_path'])}: result_origin should be #{family['result_origin'].inspect}, got #{edge['result_origin'].inspect}")
      end

      expected_witness_note = family['witness_note']
      if expected_witness_note
        if edge['witness_note'] != expected_witness_note
          error("#{rel(edge['_path'])}: witness_note should be #{expected_witness_note.inspect}, got #{edge['witness_note'].inspect}")
        end
      elsif edge.key?('witness_note') && edge['witness_note']
        error("#{rel(edge['_path'])}: witness_note should be omitted for family #{family['id']}")
      end
    end
  end

  implications.each do |(source_id, target_id), edge|
    next if expected_nodes.key?(source_id) && expected_nodes.key?(target_id) && source_id != target_id

    error("#{rel(edge['_path'])}: implication pair is not generated by #{rel(axes_registry_path)}")
  end

  witness_files = Dir[File.join(spec[:witnesses], '*.md')].to_h do |path|
    fm = frontmatter(path)
    [fm['id'], fm.merge('_path' => path)]
  end

  implications.each_value do |edge|
    Array(edge['witnesses']).each do |witness_id|
      witness = witness_files[witness_id]
      if witness.nil?
        error("#{rel(edge['_path'])}: witness #{witness_id.inspect} has no #{rel(spec[:witnesses])} note")
      elsif witness['type'] != 'witness'
        error("#{rel(witness['_path'])}: type should be witness")
      end
    end
  end

  families_by_id.each_value do |family|
    target = wiki_target(family['argument_note'])
    next unless target

    path = File.join(spec[:arguments], "#{target}.md")
    if File.exist?(path)
      fm = frontmatter(path)
      error("#{rel(path)}: id should be #{target}") unless fm['id'] == target
    else
      error("#{rel(families_registry_path)}: missing argument note #{target}")
    end
  end

  family_counts = implications.values.each_with_object(Hash.new(0)) { |edge, counts| counts[edge['family']] += 1 }
  status_counts = implications.values.each_with_object(Hash.new(0)) { |edge, counts| counts[edge['status']] += 1 }
  @summaries << {
    name: spec[:name],
    definitions: expected_nodes.length,
    implications: implications.length,
    statuses: status_counts,
    families: family_counts
  }
end

graph_specs.each { |spec| validate_graph(spec) }

reference_keys = File.read(File.join(ROOT, 'references.bib')).scan(/^@\w+\{([^,]+),/).flatten.to_set
Dir[File.join(ATLAS, '**', '*.md')].each do |path|
  next unless File.read(path).start_with?("---\n")

  fm = frontmatter(path)
  %w[ref_keys characterization_ref_keys].each do |field|
    Array(fm[field]).each do |key|
      error("#{rel(path)}: #{field} contains missing reference key #{key}") unless reference_keys.include?(key)
    end
  end
end

if @errors.empty?
  puts 'atlas_check passed'
  @summaries.each do |summary|
    puts "#{summary[:name]} definitions=#{summary[:definitions]} implications=#{summary[:implications]}"
    puts "#{summary[:name]} statuses=#{summary[:statuses].sort.map { |key, value| "#{key}=#{value}" }.join(' ')}"
    puts "#{summary[:name]} families=#{summary[:families].sort.map { |key, value| "#{key}=#{value}" }.join(' ')}"
  end
else
  @errors.each { |message| warn(message) }
  warn "#{@errors.length} atlas check error(s)"
  exit 1
end
