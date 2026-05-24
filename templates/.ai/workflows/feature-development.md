# Workflow: Feature Development

## Steps

1. **Create Issue**
   - Define the feature clearly with acceptance criteria
   - Link to related issues or PRs if applicable

2. **Create Branch**
   ```
   git checkout -b feature/<short-description>
   ```

3. **Understand the Codebase**
   - Read `ARCHITECTURE.md` to understand layer boundaries
   - Read `AGENTS.md` for coding rules and constraints
   - Identify which layers and modules will be affected

4. **Implement Feature**
   - Follow layer responsibilities defined in `ARCHITECTURE.md`
   - Apply coding rules from `.ai/rules/`
   - No business logic in API layer
   - No infrastructure imports in domain layer

5. **Add Tests**
   - Unit tests for all new domain/service logic
   - Integration tests if API endpoints are added or changed
   - Follow rules in `.ai/rules/testing.md`

6. **Run Checks Locally**
   ```bash
   make lint        # ruff + mypy
   make test        # full test suite
   ```

7. **Commit**
   ```
   feat: <short description of what was added>
   ```

8. **Create Pull Request**
   - Fill in PR template: summary, motivation, test evidence, breaking changes
   - Link the related issue

9. **Code Review**
   - Address all review comments before merging
   - Do not merge without approval

## AI Agent Constraints

- Do not skip any step above
- Do not modify unrelated files
- Do not introduce new dependencies without documenting the reason
- Always verify tests pass before marking the task as complete
