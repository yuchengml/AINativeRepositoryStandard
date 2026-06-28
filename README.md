# AINativeRepositoryStandard

Defining standards for AI development projects so that human engineers and AI Agents can collaborate efficiently and ensure high-quality, deterministic development.

## 📌 Repository Contents

This repository provides two main components to help you bootstrap and standardize your AI-Native engineering workflows:

### 1. The Core Standard Document
- **[`AI-Native Repository Standard.md`](./AI-Native%20Repository%20Standard.md)**: The foundational guideline document. It defines directory rules, coding standards, layer responsibilities, testing requirements, CI/CD rules, and specific instructions for AI Agents (like avoiding implicit rules and adhering to machine-readability).
- **Appendix**: Includes a highly detailed, golden-standard repository directory tree based on Domain-Driven Design (DDD) and Clean Architecture.

### 2. Ready-to-Use Templates
Located in the `templates/` directory, these files can be copied directly into your new projects to establish immediate alignment with the AI-Native Standard.

#### Root-Level Documents

- **`templates/README.md`**: The primary entry point for your project, pre-structured to include architecture flow, tech stack, and observability endpoints.
- **`templates/AGENTS.md`**: Explicit constraints and rules for AI Agents (e.g., coding rules, forbidden actions like committing secrets, and development workflows). This is the primary entry point for all AI agents.
- **`templates/CLAUDE.md`**: Auto-read by Claude Code at the start of every session. Directs Claude to read `AGENTS.md` before taking any action, ensuring consistent agent behavior.
- **`templates/ARCHITECTURE.md`**: A template to define system boundaries, layer responsibilities (API, Application, Domain, Infrastructure), and data flow using Mermaid diagrams.
- **`templates/CONTRIBUTING.md`**: Standardized branch naming, conventional commits, and PR label requirements (e.g., `enhancement`, `bug`). Configured to recommend `poetry` as the default package manager.
- **`templates/DECISIONS.md`**: A template for Architecture Decision Records (ADRs) to track why certain architectural or tooling choices were made.
- **`templates/LICENSE`**: MIT License file, ready to use.

#### Configuration

- **`templates/pyproject.toml`**: Pre-configured tool settings for:
  - **ruff**: Linting and formatting rules (line length 120, Google-style docstrings, strict type annotation enforcement)
  - **coverage**: Branch coverage with a 60% minimum threshold, HTML and XML report outputs
  - **pytest**: Test discovery, strict markers (`unit`, `integration`, `e2e`, `slow`), and minimum version enforcement

#### `.ai/` Directory

The `.ai/` directory provides machine-readable rules and workflows for AI agents. It is structured for direct consumption by tools like Claude Code.

**Rules** (`templates/.ai/rules/`): Coding constraints that AI agents must follow at all times.

- **`python.md`**: Python-specific rules covering type safety, ruff/mypy formatting, naming conventions, async constraints, layer boundaries, and import structure.
- **`security.md`**: Security rules including forbidden actions (hardcoded secrets, `eval()` with user input, SQL string concatenation), secret management practices, input validation, and dependency auditing.
- **`testing.md`**: Testing rules covering test structure (`unit/`, `integration/`, `e2e/`, `fixtures/`), coverage requirements per test type, naming conventions, and fixture management.

**Workflows** (`templates/.ai/workflows/`): Step-by-step procedures for common development tasks, with explicit AI agent constraints at each step.

- **`feature-development.md`**: End-to-end workflow from issue creation through branch, implementation, tests, and PR.
- **`bug-fix.md`**: Root cause analysis and regression-test-first approach before applying any fix.
- **`refactoring.md`**: Behavior-preserving refactoring in small, independently committed steps.
- **`release-process.md`**: Semantic versioning, changelog update, tag creation, and deployment verification.

**Placeholders** (`templates/.ai/examples/`, `templates/.ai/prompts/`): Empty directories reserved for project-specific prompt templates and usage examples.

#### `sdk/` Directory

- **`templates/sdk/REGISTRY.md`**: Index of all vendored and internal SDKs in the repository. AI agents must consult this file before writing any call to an unrecognized import. Lists each SDK's name, status (`internal` or `vendored`), source path, and purpose.

#### `repo-meta/` Directory

Machine-readable metadata consumed by AI agents and tooling.

- **`templates/repo-meta/ownership.yaml`**: Maps teams to the repository paths they own, enabling AI agents to identify the right reviewers and understand code ownership boundaries.
- **`templates/repo-meta/dependencies.yaml`**: Annotates each project dependency with a `status` field (`well-known`, `internal`, or `vendored`) so AI agents know which ones require `sdk/` lookup before use.

---

## 🚀 How to Use

1. **Read the Standard**: Start by reading the `AI-Native Repository Standard.md` to understand the core philosophy (Human + AI Collaboration, Explicit Over Implicit, Deterministic Engineering).
2. **Bootstrap a New Project**:
   - Create your new repository.
   - Copy all files from the `templates/` folder into the root of your new repository.
3. **Customize**: 
   - Update `README.md` with your project's specific details.
   - Adjust `ARCHITECTURE.md` to reflect your actual system boundaries.
   - Record your initial project decisions in `DECISIONS.md`.
4. **Develop**: Follow the rules established in your new `AGENTS.md` and `CONTRIBUTING.md` files to maintain a high-quality codebase that AI agents can easily understand and assist with.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
