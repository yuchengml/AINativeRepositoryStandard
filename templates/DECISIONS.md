# Architecture Decision Records (ADRs)

> This document tracks significant architectural decisions made during the lifecycle of the project.

---

## [ADR-001] Use of `poetry` for Package Management

### Status
Accepted

### Context
The Python ecosystem has multiple package managers (pip, poetry, pipenv, uv). We need a reliable, mature, and standardized tool for dependency management and virtual environments that aligns with our AI-Native Repository Standard.

### Decision
We chose `poetry` as the default package management tool.

### Consequences
- **Positive:** Mature ecosystem, robust dependency resolution, lockfile support out-of-the-box, and widespread community adoption.
- **Negative:** Slightly slower dependency resolution compared to newer tools like `uv`.

---

<!-- Add new ADRs above this line -->
