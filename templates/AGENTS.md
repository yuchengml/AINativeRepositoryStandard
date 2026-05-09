# AI Agent Guidelines

> This document outlines the constraints, rules, and best practices for AI Agents operating within this repository.

---

## 1. Core Principles

- **Do Not Break the Build:** Always run tests and type checks before committing or finalizing changes.
- **Explain Your Reasoning:** Provide clear, concise explanations for your architectural and design choices.
- **Ask Before Destructive Actions:** Never perform actions like deleting critical databases, removing core files, or deploying to production without explicit human approval.

---

## 2. Coding Rules

- All functions must have type hints (`mypy` compliant).
- Code format must follow the project's `ruff` configuration.
- Docstrings must follow Google style.
- The comments in the code must be in English.
- No business logic inside API routers/controllers.
- Async code must not block the event loop (e.g., use `await asyncio.sleep()` instead of `time.sleep()`).

---

## 3. Testing Rules

- All new features require unit tests.
- Integration tests are required for API or database schema changes.
- Tests must be deterministic (no flaky tests).
- Every bug fix requires a corresponding regression test.

---

## 4. Architecture Constraints

- Respect the layer boundaries defined in `ARCHITECTURE.md`.
- No cross-layer access (e.g., API layer directly accessing the Database).
- Avoid circular dependencies.
- Never modify the production deployment configuration autonomously.

---

## 5. Security & Forbidden Actions

- **NEVER** commit secrets, API keys, or credentials to the repository.
- Do not disable security scanning tools.
- Do not change permissions or access control mechanisms without human review.

---

## 6. Development Workflow

1. Read the issue or task description carefully.
2. Check `ARCHITECTURE.md` and `DECISIONS.md` for context.
3. Implement the feature and write tests.
4. Run `uv run ruff check .` and tests.
5. Ensure all checks pass before submitting the PR or concluding the task.
