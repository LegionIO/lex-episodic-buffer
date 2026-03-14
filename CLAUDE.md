# lex-episodic-buffer

**Level 3 Documentation** — Parent: `/Users/miverso2/rubymine/legion/extensions-agentic/CLAUDE.md`

## Purpose

Episodic buffer modeling for the LegionIO cognitive architecture. Implements Baddeley's episodic buffer — the fourth component of working memory that integrates information from multiple sources into coherent, multimodal episodes. Binds visual, phonological, semantic, and contextual information into unified episode chunks. Acts as the interface between working memory and long-term episodic memory.

## Gem Info

- **Gem name**: `lex-episodic-buffer`
- **Version**: `0.1.0`
- **Namespace**: `Legion::Extensions::EpisodicBuffer`
- **Location**: `extensions-agentic/lex-episodic-buffer/`

## File Structure

```
lib/legion/extensions/episodic_buffer/
  episodic_buffer.rb            # Top-level requires
  version.rb                    # VERSION = '0.1.0'
  client.rb                     # Client class
  helpers/
    constants.rb                # MODALITIES, BINDING_THRESHOLD, CAPACITY, labels
    episode.rb                  # Episode value object (multimodal chunk)
    episodic_buffer_store.rb    # Store: episode management, binding, retrieval
  runners/
    episodic_buffer.rb          # Runner module: all public methods
```

## Key Constants

| Constant | Value | Purpose |
|---|---|---|
| `BUFFER_CAPACITY` | 4 | Active episode slots (classic Baddeley limit) |
| `MODALITIES` | `[:visual, :phonological, :semantic, :contextual, :emotional]` | Information types that bind into an episode |
| `BINDING_THRESHOLD` | 0.5 | Minimum binding coherence to form a stable episode |
| `EPISODE_DECAY_RATE` | 0.05 | Vividness lost per maintenance cycle |
| `EPISODE_FLOOR` | 0.1 | Minimum vividness before archival |
| `MAX_EPISODE_HISTORY` | 200 | Archived episode cap |
| `REHEARSAL_BOOST` | 0.2 | Vividness increase per rehearsal |
| `COHERENCE_LABELS` | range hash | `highly_coherent / coherent / fragmented / incoherent` |
| `VIVIDNESS_LABELS` | range hash | `vivid / clear / faded / dim` |

## Runners

All methods in `Legion::Extensions::EpisodicBuffer::Runners::EpisodicBuffer`.

| Method | Key Args | Returns |
|---|---|---|
| `bind_episode` | `content: {}, modalities: [], context: {}` | `{ success:, episode_id:, coherence:, bound:, displaced: }` |
| `rehearse_episode` | `episode_id:` | `{ success:, episode_id:, vividness_before:, vividness_after: }` |
| `retrieve_episode` | `episode_id:` | `{ success:, episode:, vividness: }` |
| `active_episodes` | — | `{ success:, episodes:, count:, buffer_load: }` |
| `search_episodes` | `query: {}, modality: nil` | `{ success:, matches:, count: }` |
| `consolidate_to_memory` | `episode_id:` | `{ success:, episode_id:, consolidated:, trace: }` |
| `clear_buffer` | — | `{ success:, cleared_count:, archived_count: }` |
| `buffer_status` | — | `{ success:, capacity:, active_count:, buffer_load:, oldest_episode: }` |
| `update_episodic_buffer` | — | `{ success:, faded_count:, archived_count: }` |
| `episodic_buffer_stats` | — | Full stats hash |

## Helpers

### `Episode`
Multimodal chunk value object. Attributes: `id`, `content` (hash by modality), `modalities`, `coherence` (binding strength), `vividness` (float 0–1), `context`, `created_at`, `last_rehearsed_at`. Key methods: `rehearse!` (boosts vividness by `REHEARSAL_BOOST`), `decay!` (reduces vividness by `EPISODE_DECAY_RATE`), `faded?` (vividness <= `EPISODE_FLOOR`), `coherence_label`, `vividness_label`, `to_h`.

### `EpisodicBufferStore`
Buffer + archive manager. `@episodes` (hash by id, max BUFFER_CAPACITY active), `@history` (array, archived). Key methods:
- `bind(content:, modalities:, context:)`: computes coherence from modality coverage and content density, creates Episode, displaces least-vivid episode if at capacity, returns `displaced` flag
- `retrieve(episode_id:)`: looks in active buffer first, then history
- `search(query:, modality:)`: filters episodes by content match and/or modality
- `consolidate(episode_id:)`: extracts episode content as a trace hash for lex-memory ingestion, archives episode
- `decay_all`: calls `decay!` on all active episodes, archives those below floor
- `buffer_load`: active_count / BUFFER_CAPACITY

## Integration Points

- `bind_episode` called from lex-tick's `working_memory_integration` phase to combine phase outputs
- `consolidate_to_memory` output feeds lex-memory as a new episodic trace at the end of each tick
- `active_episodes` provides context window for lex-prediction's forward model
- `search_episodes` supports lex-dream's association walk phase
- `buffer_status[:buffer_load]` feeds lex-fatigue's working memory load dimension

## Development Notes

- BUFFER_CAPACITY = 4 reflects classic cognitive science (Cowan's 4-chunk limit, not Miller's 7±2)
- Coherence is computed at bind time from modality coverage: more modalities = higher coherence
- Displacement policy: least-vivid active episode is displaced when buffer is full (not FIFO)
- `consolidate_to_memory` archives the episode from the buffer — it does not delete it from history
- `clear_buffer` archives all active episodes rather than deleting them
