---
name: bootstrap-ai-native-repo
description: Initialize a new repository to the AI-Native Repository Standard, using the repository's initial README.md as the project brief. Copies the standard's mechanical templates verbatim, customizes the narrative documents (README, AGENTS, ARCHITECTURE, DECISIONS, repo-meta, sdk registry) from the brief, scaffolds the src/tests layer skeleton, records the standard version as an ADR, and verifies the result. Use when the user asks to bootstrap, initialize, scaffold, or set up a repository following the AI-Native Repository Standard.
---

# Bootstrap an AI-Native Repository

Turn a repository that contains only a project brief (its initial `README.md`) into a repository
that follows the AI-Native Repository Standard, ready for later agents to develop in.

The standard's core principles apply to this workflow itself:

- **Deterministic Engineering** — mechanical files are copied by script, never regenerated.
- **Explicit Over Implicit** — facts not in the brief become `TODO(human)`, never guesses.
- **Machine Readability** — the result is checked by `scripts/check_compliance.sh`, not by eye.

`<skill-dir>` below means the directory containing this `SKILL.md`.

## Step 1 — Read the brief

1. Read the target repository's `README.md`. This is the project brief.
   If it is missing or empty, show the user `<skill-dir>/PROJECT_BRIEF.md` and ask them to fill it in. Stop until they do.
2. Check the required fields: **project name**, **purpose**, **project type** (API service / worker / CLI / library),
   **tech stack** (Python version, framework), **owning team(s)**.
   Ask the user for any required field that is missing. Do not infer it.
3. Keep every other unknown for Step 4 as `TODO(human)`.
4. Confirm the working tree is clean (`git status`). If there are files other than `README.md`,
   tell the user this skill targets new repositories and ask before continuing.

## Step 2 — Fetch the standard outside the repository

```bash
<skill-dir>/scripts/fetch_standard.sh [ref]
```

It prints `STANDARD_DIR=...` and `STANDARD_SHA=...`. Keep both values.
The clone goes to a temporary directory outside the target, so it can never be committed.
If the user already has a local checkout, set `AI_NATIVE_STANDARD_DIR` to it.

Read `$STANDARD_DIR/AI-Native Repository Standard.md` before continuing.

## Step 3 — Copy templates

```bash
<skill-dir>/scripts/copy_templates.sh "$STANDARD_DIR" <target-repo>
```

The script never overwrites. `README.md` is reported as `CONFLICT` because the brief is already there.
That is expected and is handled in Step 4.

## Step 4 — Apply the file policy

Every file falls into exactly one class. Do not move a file between classes.

### Verbatim — do not edit

`CLAUDE.md`, `CONTRIBUTING.md`, `tox.ini`, `.gitignore`, `.github/pull_request_template.md`,
`.ai/rules/*`, `.ai/workflows/*`, `.ai/examples/.gitkeep`, `.ai/prompts/.gitkeep`

These carry the standard's rules. Rewriting or summarizing them loses rules for every later agent.

### Parameterized — change only the listed parameters

| File | Allowed changes |
|---|---|
| `pyproject.toml` | Add a `[project]` section (see below). Keep every `[tool.*]` section unchanged. `fail_under` may only be raised. |
| `.github/workflows/ci.yml` | `PYTHON_VERSION` only. |
| `Makefile` | The `dev` target only, to match the project type (e.g. `poetry run python -m <package>` for a CLI). Remove `dev` for a library. |
| `LICENSE` | `[year]` and `[fullname]` only. If the brief names another license, ask the user. |

The template `pyproject.toml` has no project metadata, so `poetry install` fails until you add it.
Add this at the top, filled from the brief:

```toml
[project]
name = "<project-name>"
version = "0.1.0"
description = "<one-line description>"
requires-python = ">=3.10"
dependencies = [
    # runtime dependencies named in the brief, e.g. "fastapi (>=0.115)"
]

[tool.poetry]
packages = [{ include = "src" }]

[tool.poetry.group.dev.dependencies]
ruff = "*"
mypy = "*"
pytest = "*"
pytest-cov = "*"
pip-audit = "*"
tox = "*"

[build-system]
requires = ["poetry-core>=2.0.0,<3.0.0"]
build-backend = "poetry.core.masonry.api"
```

### Customized — write from the brief

| File | What to write |
|---|---|
| `README.md` | Merge the brief into the template's structure (`$STANDARD_DIR/templates/README.md`). Keep all brief content. Replace template examples with project facts; sections with no facts become `TODO(human)`. |
| `AGENTS.md` | Keep the template and its Repository Knowledge Map intact. Add project-specific items only: the brief's Constraints under Forbidden Actions, and project-specific commands. |
| `ARCHITECTURE.md` | Layers and data flow for the project type and core domains in the brief. Keep the standard layer order API → Application → Domain → Infrastructure. |
| `DECISIONS.md` | Keep ADR-001 (poetry). Add ADR-002 "Adopt the AI-Native Repository Standard", which must contain `STANDARD_SHA`. Add an ADR for each framework choice the brief states, with the reason given in the brief or `TODO(human)` if none. |
| `repo-meta/ownership.yaml` | Teams and paths from the brief. |
| `repo-meta/dependencies.yaml` | Dependencies from the brief with their `status`. Remove the template examples. |
| `sdk/REGISTRY.md` | One row per `internal` / `vendored` SDK in the brief. With none, keep the table header and write `_No vendored or internal SDKs yet._` |

**Never invent** architecture decisions, dependencies, teams, endpoints, or reasons.
Write `TODO(human): <the question a human must answer>` instead.

## Step 5 — Scaffold the skeleton

Create only structure, no business logic:

```text
src/
├── __init__.py            # docstring + __version__ = "0.1.0"
├── api/__init__.py
├── application/__init__.py
├── domain/__init__.py
└── infrastructure/__init__.py
tests/
├── __init__.py
├── unit/__init__.py
├── unit/test_version.py   # @pytest.mark.unit, asserts src.__version__ == "0.1.0"
├── integration/__init__.py
├── e2e/__init__.py
└── fixtures/__init__.py
```

Every `__init__.py` needs a one-line docstring (e.g. `"""Domain layer."""`): ruff's docstring rules reject empty packages.

For an API service, also add `src/main.py` with a minimal app object and a `GET /health` endpoint
so `make dev` works. Add a unit test for it, marked `unit`, and add `httpx` to the dev dependencies
(required by FastAPI's `TestClient`).

Follow `.ai/rules/python.md`: type hints and Google-style docstrings on everything.

## Step 6 — Verify

Run all of the following in the target repository and report the real output.
If a tool is not installed, say so. Do not report the check as passing.

```bash
poetry lock && poetry install --no-interaction
make format                           # formats only the skeleton you wrote; verbatim files are already formatted
make lint
make typecheck
make test
poetry run pytest -m unit --cov=src   # the CI unit-test job
<skill-dir>/scripts/check_compliance.sh "$STANDARD_DIR" <target-repo> "$STANDARD_SHA"
```

If `make format` changed a verbatim file, `check_compliance.sh` reports it as `FAIL`. Restore that file from
`$STANDARD_DIR/templates/` and tell the user the standard needs fixing. Do not keep the formatted version.

Fix every `FAIL` and run the checks again. `WARN` lines list the open `TODO(human)` items. Keep them.

## Step 7 — Clean up and commit

1. Remove the standard clone: `rm -rf "$STANDARD_DIR"`. Only do this if Step 2 cloned it, not if it came from `AI_NATIVE_STANDARD_DIR`.
2. `git status`. Make sure nothing outside the target repository was staged.
3. Commit on the branch the user chose. Default to `chore/bootstrap-ai-native-standard`:
   ```
   chore: bootstrap repository with AI-Native Repository Standard
   ```
   Follow the AI authorship rule in `CONTRIBUTING.md`. Do not push or open a PR unless the user asks.
4. Report to the user:
   - `STANDARD_SHA` used
   - files per class: verbatim / parameterized / customized
   - verification results
   - every `TODO(human)` with its file. These are the items for the human reviewer.

## Constraints

- Do not edit verbatim files, even to "improve" them. Propose changes to the standard repository instead.
- Do not place the standard, or any copy of it, inside the target repository.
- Do not add dependencies that the brief does not name, except the dev tools listed in Step 4.
- Do not write business logic. Feature work starts after bootstrap, via `.ai/workflows/feature-development.md`.
