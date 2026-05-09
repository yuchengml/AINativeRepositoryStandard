# Contributing Guide

> Welcome! This document outlines the process for contributing to this repository.

---

## 1. Local Development Setup

1. Clone the repository.
2. Install the package management tool: `poetry` (recommended).
3. Install dependencies: `poetry install`.
4. Set up pre-commit hooks if available.

---

## 2. Branching Strategy

We use the following branch naming conventions:

- `feature/<ticket-id>-<short-description>`: For new features.
- `fix/<ticket-id>-<short-description>`: For bug fixes.
- `refactor/<short-description>`: For code refactoring.
- `docs/<short-description>`: For documentation updates.

---

## 3. Commit Conventions

We follow conventional commits. Please prefix your commit messages appropriately:

- `feat:` A new feature.
- `fix:` A bug fix.
- `refactor:` Code change that neither fixes a bug nor adds a feature.
- `test:` Adding missing tests or correcting existing tests.
- `docs:` Documentation only changes.
- `chore:` Changes to the build process or auxiliary tools.

*Example: `feat: add user authentication middleware`*

---

## 4. Pull Request Process

1. Ensure your branch is up to date with the main branch.
2. Verify that all tests and linting checks pass locally.
3. Create a Pull Request (PR) with a clear title and description.
4. Fill out the PR template completely.
5. Request a review from code owners or relevant team members.
6. Apply appropriate labels/tags to the PR.

### Required PR Labels
Please use at least one of the following basic labels:
- `enhancement`: New feature or request
- `bug`: Something isn't working
- `documentation`: Improvements or additions to documentation
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `dependencies`: Pull requests that update a dependency file

### PR Requirements:
- All CI tests must pass.
- Code coverage should not decrease.
- New features must include tests.

---

## 5. Code Review

- Be respectful and constructive in reviews.
- Focus on the code, not the person.
- Ensure the code adheres to `AGENTS.md` and `ARCHITECTURE.md`.
