# Project Name

> Short one-line project description.

---

# Overview

Describe:

- What problem this project solves
- Main responsibilities
- Core features
- Intended users
- High-level architecture

Example:

This service provides a unified AI gateway for internal applications,
including translation, RAG retrieval, and LLM orchestration.

---

# Features

- Async API support
- OpenAPI integration
- RAG retrieval
- Multi-provider LLM support
- Structured logging
- Metrics collection
- CI/CD integration

---

# Repository Structure

```text
repo/
├── src/
├── tests/
├── docs/
├── examples/
├── scripts/
├── configs/
├── schemas/
├── deployments/
├── .ai/
├── repo-meta/
├── .github/
├── .gitignore
├── pyproject.toml
├── tox.ini
├── Makefile
├── README.md
├── AGENTS.md
├── ARCHITECTURE.md
├── CONTRIBUTING.md
├── DECISIONS.md
└── LICENSE
```

---

# Architecture

See:

- `ARCHITECTURE.md`

High-level flow:

```text
Client
  ↓
API Layer
  ↓
Application Layer
  ↓
Domain Layer
  ↓
Infrastructure Layer
```

---

# Technology Stack

| Category | Technology |
|---|---|
| Language | Python 3.12 |
| Framework | FastAPI |
| Validation | Pydantic |
| Testing | pytest |
| Formatting | ruff |
| Type Checking | mypy |
| Dependency | poetry |
| CI/CD | GitHub Actions |
| Container | Docker |
| Deployment | Kubernetes |

---

# Development Setup

## Requirements

- Python 3.12+
- poetry
- Docker
- make

---

## Installation

```bash
git clone <repository>
cd <repository>

poetry install
```

---

## Run Local Development Server

```bash
make dev
```

---

## Run Tests

```bash
make test
```

---

## Run Lint

```bash
make lint
```

---

## Run Type Check

```bash
make typecheck
```

---

# Configuration

Configuration files:

```text
configs/
```

Environment variables:

| Variable     | Description          |
| ------------ | -------------------- |
| APP_ENV      | runtime environment  |
| LOG_LEVEL    | logging level        |
| DATABASE_URL | database connection  |
| API_KEY      | external service key |

---

# API Documentation

OpenAPI schema:

```text
schemas/openapi.yaml
```

Local Swagger UI:

```text
http://localhost:8000/docs
```

---

# Testing Strategy

Test structure:

```text
tests/
├── unit/
├── integration/
├── e2e/
└── fixtures/
```

Testing principles:

- Deterministic tests only
- No flaky tests
- Regression tests required for bug fixes
- Integration tests required for API changes

---

# Coding Standards

See:

- `AGENTS.md`

Key rules:

- All functions require type hints
- No business logic inside API routers
- Async code must not block event loop
- Use dependency injection
- Avoid global mutable state

---

# AI-Agent Guidelines

This repository is optimized for AI-assisted development.

## Key Reference Documents

| File | Purpose |
|---|---|
| `AGENTS.md` | AI development instructions — read this first |
| `ARCHITECTURE.md` | System architecture and layer boundaries |
| `DECISIONS.md` | Architecture decision records |
| `repo-meta/` | Machine-readable metadata |

## .ai/ Directory

The `.ai/` directory contains AI-specific rules, workflows, and resources that help AI agents operate correctly within this repository.

```text
.ai/
├── rules/        ← Coding rules for AI agents to follow
├── workflows/    ← Step-by-step development workflows
├── prompts/      ← Custom prompts for AI tools
└── examples/     ← Golden path examples for AI to reference
```

### rules/

Language- and domain-specific coding constraints:

| File | Purpose |
|---|---|
| `rules/python.md` | Type hints, async rules, naming conventions, layer constraints |
| `rules/testing.md` | Test structure, required coverage, naming, AI agent test rules |
| `rules/security.md` | Forbidden actions, secret management, input validation |

AI agents must read all files in `rules/` before making changes to this repository.

### workflows/

Standardized step-by-step processes for common development tasks:

| File | Purpose |
|---|---|
| `workflows/feature-development.md` | End-to-end flow from issue creation to PR merge |
| `workflows/bug-fix.md` | Root cause analysis, regression test first, then fix |
| `workflows/release-process.md` | Semantic versioning, changelog, tagging, publish |
| `workflows/refactoring.md` | Behavior-preserving changes with test coverage first |

AI agents must follow the appropriate workflow file for each task type.

### prompts/

Custom prompt templates for AI tools (e.g., code generation, review, analysis). Add project-specific prompts here as the project evolves.

### examples/

Golden path examples that demonstrate the expected style and structure for this project. AI agents typically replicate patterns from these examples — keep them high quality.

## AI Agent Rules

AI agents must:

- Read `AGENTS.md` before starting any task
- Follow all rules in `.ai/rules/`
- Use the appropriate workflow in `.ai/workflows/`
- Preserve architecture boundaries defined in `ARCHITECTURE.md`
- Add tests for all new functionality

AI agents must NOT:

- Commit secrets or credentials
- Modify production infrastructure automatically
- Bypass CI requirements
- Mix feature changes with refactoring in the same PR
- Delete existing tests

---

# CI/CD

GitHub Actions workflows:

```text
.github/workflows/
```

Pipeline includes:

- lint
- type-check
- unit tests
- integration tests
- security scan
- docker build

---

# Security

Security requirements:

- Never commit secrets
- Use environment variables
- Use secret management systems
- Dependency scanning required

---

# Observability

Includes:

- structured logging
- metrics
- tracing
- health checks

Metrics endpoint:

```text
/metrics
```

Health endpoint:

```text
/health
```

---

# Deployment

Deployment manifests:

```text
deployments/
```

Deployment targets:

- Kubernetes
- Docker Compose
- Local development

---

# Examples

Usage examples:

```text
examples/
```

---

# Documentation

Additional documentation:

```text
docs/
```

Includes:

- architecture
- domain knowledge
- onboarding
- deployment guides
- runbooks

---

# Contribution Guide

See:

- `CONTRIBUTING.md`

Pull requests must:

- pass all CI checks
- include tests
- include documentation updates if needed

---

# Commit Convention

```text
feat:
fix:
refactor:
test:
docs:
chore:
```

Example:

```text
feat: add async user retrieval API
```

---

# License

Specify project license.

Example:

```text
Apache-2.0
```

---

# Maintainers

| Team | Responsibility |
|---|---|
| Platform Team | infrastructure |
| Backend Team | application services |
| AI Team | LLM orchestration |

---

# Future Roadmap

Planned improvements:

- AI code review integration
- automated dependency analysis
- autonomous testing workflow
- advanced observability
- multi-region deployment

---

# References

Related resources:

- `AGENTS.md`
- `ARCHITECTURE.md`
- `DECISIONS.md`
- `CONTRIBUTING.md`

---

# Philosophy

This repository follows an AI-Native Engineering approach.

Goals:

- Human + AI collaboration
- deterministic engineering
- machine-readable systems
- scalable architecture
- maintainable workflows