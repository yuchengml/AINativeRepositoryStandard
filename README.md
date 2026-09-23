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
- **`templates/.gitignore`**: Standard Python ignores (caches, virtual environments, coverage reports, `.env` files, IDE/OS files).

#### Configuration & Tooling

- **`templates/pyproject.toml`**: Pre-configured tool settings for:
  - **ruff**: Linting and formatting rules (line length 120, Google-style docstrings, strict type annotation enforcement)
  - **coverage**: Branch coverage with a 60% minimum threshold, HTML and XML report outputs
  - **pytest**: Test discovery, strict markers (`unit`, `integration`, `e2e`, `slow`), and minimum version enforcement
- **`templates/tox.ini`**: Runs the test suite across Python 3.10–3.12, plus dedicated `lint` and `typecheck` environments.
- **`templates/Makefile`**: Common developer commands (`make dev`, `make test`, `make lint`, `make format`, `make typecheck`, `make coverage`, `make clean`) matching the commands referenced throughout `templates/README.md` and `templates/AGENTS.md`.

#### `.github/` Directory

- **`templates/.github/workflows/ci.yml`**: GitHub Actions pipeline covering the six required checks from the Standard (lint, type-check, unit-test, integration-test, security-scan, build).
- **`templates/.github/pull_request_template.md`**: PR template covering Summary, Motivation, Related Issue, Test Evidence, and Breaking Changes, per the Standard's Pull Request Requirements.

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

### 3. Bootstrap Skill

- **[`skills/bootstrap-ai-native-repo/`](./skills/bootstrap-ai-native-repo/SKILL.md)**: A Claude Code skill that initializes a new repository from its initial `README.md` (the project brief). It fetches the standard into a temporary directory outside the repository, copies mechanical templates verbatim, customizes the narrative documents from the brief (unknowns become `TODO(human)`, never guesses), scaffolds the `src/` and `tests/` skeleton, records the standard's commit SHA as an ADR, and verifies the result.
  - `PROJECT_BRIEF.md`: Template for the initial `README.md` that the skill reads.
  - `scripts/fetch_standard.sh`: Clones the standard outside the target repository and prints its commit SHA.
  - `scripts/copy_templates.sh`: Copies `templates/` into the target without overwriting existing files.
  - `scripts/check_compliance.sh`: Verifies verbatim files are unchanged, parameterized files keep their invariants, customized files have no template placeholders, and the standard version is recorded.

---

## 🚀 How to Use

1. **Read the Standard**: Start by reading the `AI-Native Repository Standard.md` to understand the core philosophy (Human + AI Collaboration, Explicit Over Implicit, Machine Readability, Deterministic Engineering).
2. **Bootstrap a New Project** (choose one):
   - **With the skill (recommended)**:
     - Install it: `cp -r skills/bootstrap-ai-native-repo ~/.claude/skills/` (or into a project's `.claude/skills/`).
     - Create your new repository with only a `README.md` filled in from `skills/bootstrap-ai-native-repo/PROJECT_BRIEF.md`.
     - Ask Claude Code to bootstrap the repository with the AI-Native Repository Standard, then review the `TODO(human)` items it reports.
   - **Manually**:
     - Create your new repository.
     - Copy all files from the `templates/` folder into the root of your new repository.
3. **Customize** (manual path only; the skill does this from the brief):
   - Update `README.md` with your project's specific details.
   - Adjust `ARCHITECTURE.md` to reflect your actual system boundaries.
   - Record your initial project decisions in `DECISIONS.md`.
4. **Develop**: Follow the rules established in your new `AGENTS.md` and `CONTRIBUTING.md` files to maintain a high-quality codebase that AI agents can easily understand and assist with.

## 📝 TODO / Known Gaps

Tracking known inconsistencies and missing pieces between the Standard document and the templates:

- [x] Fix the Standard document's broken section numbering
- [x] Add missing dev/CI tooling templates (`.github/workflows/`, PR template, `Makefile`, `tox.ini`, `.gitignore`)
- [ ] Scaffold placeholders for structural directories referenced but not provided (`docs/`, `schemas/`, `examples/`, `scripts/`, `configs/`, `deployments/`)
- [ ] Complete `repo-meta/` and `sdk/` templates (missing files, and a broken example path)
- [ ] Clean up inconsistencies within `templates/README.md` and `templates/CONTRIBUTING.md` (missing Quick Start, wrong License example, mismatched principle wording, incomplete PR requirements)
- [ ] Inventory agent development scenarios and evaluate which to package as skills (evaluate and execute item by item)
  - **Common reading path** for every scenario (the references below list only what is read *in addition*):
    `CLAUDE.md` → `AGENTS.md` (§0 Knowledge Map) → `ARCHITECTURE.md` + `DECISIONS.md` → `.ai/rules/*` → `.ai/workflows/<task-type>`;
    verified by `Makefile` (`make lint` / `make test`) → `.github/workflows/ci.yml` → `.github/pull_request_template.md`.
  - **Where each kind of guidance belongs**:
    - *Always-on rules* → `AGENTS.md` / `.ai/rules/*`. Needed at any moment; a skill may not trigger at that moment.
    - *On-demand procedures* → `.ai/workflows/*` as the single source of truth, optionally with a **thin skill wrapper** (trigger description + pointer to the workflow + scripts) in the repo's `.claude/skills/`.
    - *Enforcement* → CI / scripts / hooks. A skill is advisory; CI is enforcing.
  - **Skill fit criteria**: a discrete, invocable task; scriptable steps; costly to get wrong; must not rely on being triggered by chance.
    Avoid skills that re-write workflows (they drift) or hold rules other agent tools must also follow (`AGENTS.md` is tool-agnostic; skills are Claude Code only).
  - **Tier 1 — full workflow exists; the agent can follow it end to end**
    - [x] **Repository bootstrap**
      - Refs: `skills/bootstrap-ai-native-repo/SKILL.md`, `PROJECT_BRIEF.md`, the Standard document
      - Constraints / gate: files split into verbatim / parameterized / customized; unknowns become `TODO(human)`; `check_compliance.sh` passes
      - Skill fit: ✅ High. It runs before the repository has any rules, so it must come from outside; it is scripted and reused across repositories.
      - Form: user-level skill (done)
    - [ ] **Release**
      - Refs: `.ai/workflows/release-process.md`, `pyproject.toml` (version)
      - Constraints / gate: SemVer; MAJOR bump needs human approval; never push to `main` directly; never edit past changelog entries
      - Skill fit: ✅ High. Mechanical steps (version bump, changelog, tag), high risk, needs a human checkpoint.
      - Form: repo-level thin skill + `bump_version` / changelog check scripts (depends on the `CHANGELOG.md` gap below)
    - [ ] **Bug fix**
      - Refs: `.ai/workflows/bug-fix.md`, `.ai/rules/testing.md` (AI Agent Rules)
      - Constraints / gate: regression test written first and shown failing; fix root cause only; reproduction steps in PR; `fix:` commit
      - Skill fit: 🟡 Medium. Mostly judgment, but "the regression test fails before the fix" can be verified by a script.
      - Form: thin skill wrapper + regression-test verification script
    - [ ] **Feature development**
      - Refs: `.ai/workflows/feature-development.md`, `ARCHITECTURE.md` §2, `.ai/rules/python.md` (Layer Rules), `.ai/rules/testing.md`
      - Constraints / gate: `feature/` branch; no business logic in routers; no infrastructure imports in domain; unit tests required, integration tests for API changes; `feat:` commit
      - Skill fit: 🟡 Medium. `AGENTS.md` already routes to the workflow; a skill mainly adds a one-step entry such as `/feature <issue>`.
      - Form: optional thin skill wrapper
    - [ ] **Refactoring**
      - Refs: `.ai/workflows/refactoring.md`, `.ai/rules/testing.md`
      - Constraints / gate: behavior-preserving; small independent commits; no mixed features; never delete tests; deprecation plan for public API renames
      - Skill fit: 🟠 Low. Almost entirely judgment; "run tests after each step" is already a rule.
      - Form: keep as workflow only
  - **Tier 2 — rules exist but no dedicated workflow; the agent must combine documents itself**
    - [ ] **Add or upgrade a dependency**
      - Refs: Standard §8.2–8.3, `repo-meta/dependencies.yaml`, `.ai/rules/security.md` (Dependency Security), `DECISIONS.md`
      - Constraints / gate: state the purpose; no duplicate libraries; no automatic major upgrades; CI `security-scan` (pip-audit) passes; ADR for significant choices
      - Skill fit: ✅ High. There is no workflow yet (largest gap), and the steps are fixed: `poetry add` → `pip-audit` → update `dependencies.yaml` → ADR.
      - Form: new `.ai/workflows/dependency-update.md` + thin skill wrapper
    - [ ] **Vendor a new SDK**
      - Refs: `AGENTS.md` §6, `sdk/REGISTRY.md`, `sdk/<sdk>/src/`, `sdk/notes/<sdk>.md`, `repo-meta/dependencies.yaml`
      - Constraints / gate: `sdk/`, `REGISTRY.md`, `dependencies.yaml` and `notes/` stay consistent
      - Skill fit: ✅ High. Four places must change together and one is easily missed.
      - Form: skill + consistency check script
    - [ ] **Code review (agent as reviewer)**
      - Refs: `CONTRIBUTING.md` §4–5, `.github/pull_request_template.md`, `repo-meta/ownership.yaml`, `AGENTS.md` §2–5
      - Constraints / gate: PR template sections complete; no layer or security rule violations; reviewers chosen from ownership
      - Skill fit: ✅ Medium-high. A discrete, invocable task whose checklist comes from repository documents.
      - Form: repo-level skill that uses `AGENTS.md` and `.ai/rules/*` as review criteria
    - [ ] **Fix a CI failure**
      - Refs: `.github/workflows/ci.yml`, `Makefile`, `pyproject.toml`, `tox.ini`
      - Constraints / gate: reproduce locally with the matching make target; never skip tests or lower thresholds to get green
      - Skill fit: 🟡 Medium. The CI-job → make-target mapping can be tabulated, but it is generic across repositories.
      - Form: organization-level skill
    - [ ] **Architecture decision / technology choice**
      - Refs: `ARCHITECTURE.md`, `DECISIONS.md` (ADR: Context / Decision / Consequences)
      - Constraints / gate: the agent drafts, a human decides
      - Skill fit: 🟠 Low. Human judgment; the ADR format already lives in `DECISIONS.md`.
      - Form: keep as documents
    - [ ] **Security fix**
      - Refs: `.ai/rules/security.md`, `.ai/workflows/bug-fix.md`, `ci.yml` `security-scan`
      - Constraints / gate: no hardcoded secrets, no `eval()` on user input, no SQL string concatenation; never disable scanners; permission changes need human review
      - Skill fit: ❌ Not suitable. The rules must be always on; as a skill they would only apply when remembered.
      - Form: keep as always-on rules + CI (reviews can use an existing security-review tool)
    - [ ] **SDK lookup (unrecognized import)**
      - Refs: `AGENTS.md` §6 → `sdk/notes/` → `sdk/<sdk>/src/` → `sdk/REGISTRY.md`
      - Constraints / gate: never guess SDK APIs
      - Skill fit: ❌ Not suitable. Needed at any point while writing code; a skill would not trigger at that moment.
      - Form: keep in `AGENTS.md` (always on)
    - [ ] **Add tests / raise coverage**
      - Refs: `.ai/rules/testing.md`, `pyproject.toml` `[tool.coverage]` / `[tool.pytest.ini_options]`
      - Constraints / gate: `test_<unit>_<scenario>_<expected>` naming; declared markers only; shared data in `tests/fixtures/`
      - Skill fit: ❌ Not suitable. Applies to every code change; thresholds are already enforced by `pyproject.toml`.
      - Form: keep as always-on rules + CI
    - [ ] **Documentation update**
      - Refs: `README.md`, `ARCHITECTURE.md` (Mermaid), `DECISIONS.md`
      - Constraints / gate: kept in sync with code changes; "Documentation updated" item in the PR checklist
      - Skill fit: ❌ Not suitable. It is a step inside other workflows, not a standalone task.
      - Form: keep in the PR checklist
  - **Tier 3 — referenced by the Standard but not yet supported (gaps to close before any skill)**
    - [ ] **Hotfix**: `hotfix/` branch prefix exists (§15.1) but there is no `.ai/workflows/hotfix.md`
    - [ ] **API / event schema changes**: §12 requires machine-readable schemas, but templates have no `schemas/`, so agents cannot detect breaking changes
    - [ ] **Deployment**: `AGENTS.md` forbids autonomous production changes, but there is no `deployments/` and no release pipeline in `ci.yml`
    - [ ] **Changelog**: `release-process.md` requires one, but templates have no `CHANGELOG.md`
    - [ ] **Golden path examples**: §11.5 relies on them, but `examples/`, `.ai/examples/` and `.ai/prompts/` are empty
    - [ ] **LLM evaluation**: only deterministic tests are defined; no eval marker, golden dataset, or CI job
    - [ ] **Database migrations**: `testing.md` mentions schema changes, but there is no migration tool or workflow
  - **Cross-cutting enforcement**
    - [ ] Add a CI job that runs `check_compliance.sh` to catch drift from the Standard
    - [ ] Evaluate Claude Code hooks (e.g. block edits to verbatim files) as enforcement instead of skill instructions
  - **Suggested priority**: dependency update → release → vendor SDK → code review; thin wrappers for bug fix / feature later; keep rules always on.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
