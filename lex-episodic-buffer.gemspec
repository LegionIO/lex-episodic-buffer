# frozen_string_literal: true

require_relative 'lib/legion/extensions/episodic_buffer/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-episodic-buffer'
  spec.version       = Legion::Extensions::EpisodicBuffer::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']

  spec.summary       = 'LEX Episodic Buffer'
  spec.description   = "Baddeley's episodic buffer — binds multimodal information into coherent episodic " \
                       'representations for the LegionIO cognitive architecture'
  spec.homepage      = 'https://github.com/LegionIO/lex-episodic-buffer'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri']        = spec.homepage
  spec.metadata['source_code_uri']     = 'https://github.com/LegionIO/lex-episodic-buffer'
  spec.metadata['documentation_uri']   = 'https://github.com/LegionIO/lex-episodic-buffer'
  spec.metadata['changelog_uri']       = 'https://github.com/LegionIO/lex-episodic-buffer'
  spec.metadata['bug_tracker_uri']     = 'https://github.com/LegionIO/lex-episodic-buffer/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.glob('{lib}/**/*', File::FNM_DOTMATCH).reject { |f| File.directory?(f) }
  spec.require_paths = ['lib']
end
