# Testing Rules

## Test Structure

```text
tests/
├── unit/          # Isolated unit tests, no I/O
├── integration/   # Tests with real DB/cache/queue
├── e2e/           # Full system flow tests
└── fixtures/      # Shared test data and factories
```

## Required Coverage

| Type             | Requirement                          |
| ---------------- | ------------------------------------ |
| Unit Test        | Required for all domain/service code |
| Integration Test | Required for all API changes         |
| E2E Test         | Required for all critical user flows |

Coverage configuration is defined in `pyproject.toml` — do not override it inline.

Key coverage settings in effect:

| Setting | Value |
|---|---|
| `run.branch` | `true` — branch coverage measured |
| `run.source` | `["src"]` — application code only |
| `report.fail_under` | `60` — minimum threshold to pass (raise to 80%+ as project matures) |
| `html.directory` | `htmlcov` |
| `xml.output` | `coverage.xml` (consumed by CI) |

Run coverage:

```bash
pytest --cov=src --cov-report=term-missing
pytest --cov=src --cov-report=html   # generates htmlcov/
```

## Test Rules

- Every bug fix must include a regression test
- Tests must be deterministic — no random data without seeding
- Tests must not depend on external unstable services
- Use mocks/stubs for external dependencies in unit tests
- Snapshot tests are discouraged

## Naming Convention

```python
# Pattern: test_<unit>_<scenario>_<expected>
def test_get_user_not_found_raises_error(): ...
def test_create_order_valid_input_returns_order(): ...
```

## Fixtures

- Define shared fixtures in `tests/fixtures/`
- Use `factory_boy` or equivalent for entity factories
- Never hardcode test data inline if reused across tests

## AI Agent Rules

- Do not delete existing tests without explicit instruction
- Do not skip tests with `pytest.mark.skip` without a comment explaining why
- Always run the full test suite after making changes
- Verify that new tests actually fail before the fix is applied
