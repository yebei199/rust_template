# General Development Standards

## Core Principles

1. **No mod.rs**
   Prohibit the use of `mod.rs`. Use folder-named external module files instead (e.g., use `src/core.rs` instead of `src/core/mod.rs`).

2. **Explicit Over Implicit**
   Code intent must be clear and unambiguous. Avoid obscure logic and magic
   behaviors.

2. **Language Convention**
   Think and execute in English, but explain and ask users in Chinese only when
   delivering final
   responses.

3. Deprecate the use of standard print statements in favor of structured
   logging at the debug level.

## Code Structure

1. **Function Design**

- Strictly control function length; each function must be atomic with a single
  responsibility,
  recommended max 40 lines
- Prohibit nesting deeper than 3 levels; prefer Guard Clauses for early returns
- Follow Single Responsibility Principle

2. **Constants and Configuration**

- Prohibit magic numbers or hardcoded strings in logic code
- Extract all configuration items, paths, and fixed values outside functions as
  constants

## Documentation and Comments

1. **Documentation Requirements**

- All public functions, types, and modules must have clear documentation
  comments
- Comments should use clear and efficient English
- Must describe functionality, parameter meanings, return values, and potential
  error/exception
  conditions
- Complex logic requires inline comments explaining design intent

## Error Handling

1. **Error Propagation and Handling**

- Prefer language-idiomatic error propagation mechanisms (e.g., Rust's `?`,
  Python's exceptions)
- Prohibit silently catching errors or using empty error handling blocks
- If assertion of success is required, include clear error descriptions

2. **Input Validation**

- External input data must be validated before processing
- Boundary conditions must be explicitly handled

## Testing Standards

1. **Test Coverage Requirements**

- Core business logic must include test cases
- Tests should cover both happy paths and edge cases
- Test code should not affect production build artifacts

## Security and Performance

1. **Security Controls**

- Default prohibition of unsafe language features (e.g., Rust's `unsafe`)
- If required, add comments before code explaining safety guarantees

2. **Performance Optimization**

- Avoid unnecessary resource copying and memory allocation
- Prefer language-efficient abstractions (e.g., iterators over explicit loops)

## Communication and Confirmation

1. **Requirement Clarification**

- When requirements are ambiguous or multiple implementation approaches exist,
  must ask user for
  confirmation first
- Prohibit making assumptions or arbitrary changes without clear instructions
- For major architectural adjustments or breaking changes, obtain user consent
  beforehand

## Code Style

1. **Clarity and Readability First Priority**

- Follow language community code formatting standards
- Variable naming must be semantically clear
- Maintain clear module structure with appropriate visibility controls

---

# Rust Standards

## Error Handling

1. Never use `unwrap()` directly
2. Prefer `?` operator for error propagation
3. If assertion is required, use `expect()` with concise error description

## Constants

1. All configuration items, paths, and fixed values should be defined as `const`
   or `static`

## Documentation

1. Prefer `///` doc comments
2. Every public or private function, struct field, and enum variant requires
   clear description of
   functionality, parameter meanings, and potential Panic conditions

## Idioms and Performance

1. Follow `rustfmt` and `clippy` standards
2. Variable naming and ownership transfer must follow best practices
3. Prefer `Iterator` over explicit loops
4. Avoid unnecessary `Clone`; optimize memory usage in performance-critical
   scenarios

## Testing

1. Unit tests should be placed in `#[cfg(test)] mod tests` within the same
   source file
2. Tests should cover both normal paths and boundary conditions

## Safety

1. Default prohibition of `unsafe` blocks
2. If required, add comments before the block explaining memory safety
   guarantees

## Dependencies and Modules

1. Maintain clear module structure with appropriate `pub` visibility control

