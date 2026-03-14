# lex-episodic-buffer

Episodic buffer modeling for the LegionIO brain-modeled cognitive architecture.

## What It Does

Implements Baddeley's episodic buffer — the fourth component of working memory that integrates information from multiple sources into coherent, multimodal episodes. Binds visual, phonological, semantic, contextual, and emotional information into unified episode chunks. Manages a limited-capacity active buffer (4 slots) with decay, rehearsal to maintain vividness, and consolidation into long-term memory.

## Usage

```ruby
client = Legion::Extensions::EpisodicBuffer::Client.new

# Bind multimodal information into a coherent episode
client.bind_episode(
  content: {
    semantic: 'user asked about architecture',
    emotional: 'curious, engaged',
    contextual: 'design review session'
  },
  modalities: [:semantic, :emotional, :contextual]
)
# => { success: true, episode_id: "...", coherence: 0.75, bound: true, displaced: false }

# Rehearse an episode to maintain vividness
client.rehearse_episode(episode_id: '...')
# => { success: true, vividness_before: 0.6, vividness_after: 0.8 }

# Search by modality or content
client.search_episodes(modality: :semantic)

# Check buffer state
client.buffer_status
# => { capacity: 4, active_count: 3, buffer_load: 0.75, oldest_episode: "..." }

# Consolidate an episode into long-term memory
client.consolidate_to_memory(episode_id: '...')
# => { success: true, consolidated: true, trace: { content: ..., domain: :episodic } }

# Periodic tick: decay vividness, archive faded episodes
client.update_episodic_buffer
# => { success: true, faded_count: 1, archived_count: 1 }
```

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT
