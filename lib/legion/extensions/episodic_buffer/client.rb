# frozen_string_literal: true

require 'legion/extensions/episodic_buffer/runners/episodic_buffer'

module Legion
  module Extensions
    module EpisodicBuffer
      class Client
        include Legion::Extensions::EpisodicBuffer::Runners::EpisodicBuffer

        def initialize(store: nil, **)
          @default_store = store || Helpers::EpisodicStore.new
        end

        private

        attr_reader :default_store
      end
    end
  end
end
