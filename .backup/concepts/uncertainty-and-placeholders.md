# uncertainty principle & placeholder pattern in skogai

## philosophical foundation

skogai implements two complementary patterns that embody its core philosophy of knowledge archaeology and explicit epistemology.

### the uncertainty principle

**purpose**: quantify and declare epistemic uncertainty rather than presenting false confidence

**implementation**:
```
[@certainty:"<percentage>":"<specific claim>"]
```

**mechanics**:
- percentage: integer 0-99 representing confidence level
- claim: the specific statement with lowest certainty
- placement: end of each message from claude

**philosophy**: 
- aligns with "explicit uncertainty over false confidence" 
- creates accountability for knowledge claims
- enables trust through transparency
- similar to how the universe handles observer paradoxes

**locations**:
- defined: `/home/skogix/git-fuckery/claude/CLAUDE.md:41-50`
- enforced: claude's output style configuration

### the placeholder pattern

**purpose**: mark integration points and future work without creating premature implementations

**notation**:
```
[@todo]           # general placeholder
[@todo:owner]     # assigned placeholder
[@placeholder]    # alternative form (less common)
```

**philosophy**:
- knowledge archaeology: recover existing solutions before generating new
- living computation: placeholders re-evaluate on access
- explicit incompleteness over hidden assumptions
- democratic participation: owners can be agents or humans

**found in**:
- `SKOGAI.md`: env section awaiting configuration
- `RULES.md`: scripts section ([@todo:skogix]), git-flow section
- `skogcontext/.backup/argc/docs/`: multiple technical sections
- goose scripts: [placeholder] comments for future features

## integration with skogai notation

both patterns are part of the larger skogai notation system that treats:
- code as philosophy
- philosophy as executable
- uncertainty as computable
- incompleteness as explicit state

### notation examples in context

```bash
# invoke with uncertainty
skogai '[@claude:"explain quantum computing"]' 
# output includes: [@certainty:"75":"quantum states exist in superposition"]

# query placeholders
skogai '[@find:"[@todo]"]'
# returns all pending integration points

# living computation
skogai '[@todo:"integrate memory system"]'
# re-evaluates on each access, checking if completed
```

## architectural implications

### for agents
- agents must handle uncertainty declarations
- placeholders become coordination points
- todo ownership enables task distribution

### for the ecosystem
- uncertainty creates trust boundaries
- placeholders prevent premature optimization
- both patterns enable incremental evolution

### for knowledge archaeology
- uncertainty reveals knowledge gaps
- placeholders mark discovered but unintegrated solutions
- together they create a map of the known and unknown

## practical usage

### when to use uncertainty
- making claims about external systems
- predictions about behavior
- interpretations of ambiguous requirements
- statements about future states

### when to use placeholders
- discovered functionality not yet connected
- planned features with unclear implementation
- integration points between modules
- ownership assignments for distributed work

## relationship to core principles

1. **knowledge archaeology over solution generation**
   - placeholders mark found but unintegrated knowledge
   - uncertainty quantifies archaeological confidence

2. **constraint-driven effectiveness**
   - uncertainty constrains overconfidence
   - placeholders constrain premature implementation

3. **democratic participation**
   - placeholder ownership enables task distribution
   - uncertainty enables informed consensus

4. **the core isn't code; it's relationships**
   - uncertainty creates honest relationships
   - placeholders create collaborative relationships

## future evolution

as skogai evolves, these patterns will:
- enable multi-agent consensus through shared uncertainty
- create self-organizing task distribution via placeholders
- bridge the gap between human intent and machine execution
- maintain constitutional continuity across system resets

the patterns themselves are living definitions - they evolve through use while maintaining their core purpose of explicit epistemology and collaborative incompleteness.