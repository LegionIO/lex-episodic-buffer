# frozen_string_literal: true

require 'legion/extensions/episodic_buffer/version'
require 'legion/extensions/episodic_buffer/helpers/constants'
require 'legion/extensions/episodic_buffer/helpers/episodic_binding'
require 'legion/extensions/episodic_buffer/helpers/episode'
require 'legion/extensions/episodic_buffer/helpers/episodic_store'
require 'legion/extensions/episodic_buffer/runners/episodic_buffer'

module Legion
  module Extensions
    module EpisodicBuffer
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
