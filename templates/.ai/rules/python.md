# Python Coding Rules

## Type Safety

- All public functions must have type hints
- Use `from __future__ import annotations` for forward references
- Prefer `TypeAlias` for complex type definitions

```python
async def get_user(user_id: str) -> User:
    ...
```

## Formatting

- Use `ruff` for linting and formatting
- Use `mypy` for static type checking
- All code must pass `pre-commit` hooks before committing

## Naming Convention

- Variables and functions: `snake_case`
- Classes: `PascalCase`
- Constants: `UPPER_SNAKE_CASE`
- Private members: `_leading_underscore`

```python
user_id = "abc"
MAX_RETRY_COUNT = 3

class UserService:
    def get_user(self, user_id: str) -> User: ...
```

## Async Rules

- Never use blocking I/O inside async functions
- Never use `time.sleep()` in async context
- Never make synchronous DB calls inside async functions

```python
# Forbidden
async def bad():
    time.sleep(1)

# Correct
async def good():
    await asyncio.sleep(1)
```

## Layer Rules

- No business logic inside API routers
- No infrastructure imports inside domain layer
- Application layer orchestrates use cases only

## Imports

- Use absolute imports
- Group imports: stdlib → third-party → internal
- No wildcard imports (`from module import *`)
