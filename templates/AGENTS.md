# AGENTS.md

> This is the primary entry point for AI Agents operating in this repository.
> Read this document completely before taking any action.

---

## 0. Start Here: Repository Knowledge Map

Before starting any task, read the following documents in order:

### Step 1 — Understand the system

| Document | Purpose |
|---|---|
| [ARCHITECTURE.md](./ARCHITECTURE.md) | Layer boundaries, dependency flow, forbidden cross-layer access |
| [DECISIONS.md](./DECISIONS.md) | Why certain architectural and tooling choices were made |

### Step 2 — Learn the rules

| Document | Purpose |
|---|---|
| [.ai/rules/python.md](./.ai/rules/python.md) | Type hints, async rules, naming conventions, layer constraints |
| [.ai/rules/testing.md](./.ai/rules/testing.md) | Test structure, required coverage, naming, agent-specific test rules |
| [.ai/rules/security.md](./.ai/rules/security.md) | Forbidden actions, secret management, input validation |

### Step 3 — Choose the right workflow for your task

| Task Type | Workflow Document |
|---|---|
| New feature | [.ai/workflows/feature-development.md](./.ai/workflows/feature-development.md) |
| Bug fix | [.ai/workflows/bug-fix.md](./.ai/workflows/bug-fix.md) |
| Release | [.ai/workflows/release-process.md](./.ai/workflows/release-process.md) |
| Refactoring | [.ai/workflows/refactoring.md](./.ai/workflows/refactoring.md) |

### Additional references

| Document | When to read |
|---|---|
| [CONTRIBUTING.md](./CONTRIBUTING.md) | Branch naming, commit conventions, PR requirements |
| [README.md](./README.md) | Project overview, tech stack, development setup |

---

## 1. Core Principles

- **Do Not Break the Build:** Always run tests and type checks before committing or finalizing changes.
- **Explain Your Reasoning:** Provide clear, concise explanations for your architectural and design choices.
- **Ask Before Destructive Actions:** Never perform actions like deleting critical databases, removing core files, or deploying to production without explicit human approval.
- **Explicit Over Implicit:** Follow written rules. Do not rely on assumptions or inferred conventions.

---

## 2. Coding Rules

Full details: [.ai/rules/python.md](./.ai/rules/python.md)

- All functions must have type hints (`mypy` compliant).
- Code format must follow the project's `ruff` configuration defined in `pyproject.toml` — do not override inline.
- Docstrings must follow Google style.
- Comments in code must be in English.
- No business logic inside API routers/controllers.
- Async code must not block the event loop (e.g., use `await asyncio.sleep()` instead of `time.sleep()`).

---

## 3. Testing Rules

Full details: [.ai/rules/testing.md](./.ai/rules/testing.md)

- All new features require unit tests.
- Integration tests are required for API or database schema changes.
- Tests must be deterministic (no flaky tests).
- Every bug fix requires a regression test written before the fix.
- Coverage configuration is defined in `pyproject.toml` — minimum threshold is 60%.

---

## 4. Architecture Constraints

Full details: [ARCHITECTURE.md](./ARCHITECTURE.md)

- Respect layer boundaries: API → Application → Domain → Infrastructure.
- No cross-layer access (e.g., API layer must not access the database directly).
- Avoid circular dependencies.
- Never modify production deployment configuration autonomously.

---

## 5. Security & Forbidden Actions

Full details: [.ai/rules/security.md](./.ai/rules/security.md)

- **NEVER** commit secrets, API keys, or credentials to the repository.
- Do not disable security scanning tools.
- Do not change permissions or access control mechanisms without human review.

---

## 6. SDK Knowledge

If you encounter an import you do not recognize, look up in this order:

1. `sdk/notes/<sdk-name>.md` — if exists, read this first
2. `sdk/<sdk-name>/src/` — vendored source for deep tracing
3. `sdk/REGISTRY.md` — index of all vendored SDKs and their status

**Never guess SDK APIs.** Always trace the source before writing any call.

This applies to:
- SDKs released after your training cutoff
- Internal packages under active development in this repository

---

## 7. Development Workflow

Full details in [.ai/workflows/](./.ai/workflows/)

1. Identify the task type (feature / bug fix / refactor / release).
2. Read the corresponding workflow file in `.ai/workflows/`.
3. Read [ARCHITECTURE.md](./ARCHITECTURE.md) and [DECISIONS.md](./DECISIONS.md) for context.
4. Implement and write tests following [.ai/rules/](./.ai/rules/).
5. Run `make lint` and `make test` — all checks must pass.
6. Follow commit and PR conventions in [CONTRIBUTING.md](./CONTRIBUTING.md).
