# Security Rules

## Forbidden Actions

- Never commit secrets, API keys, or credentials to source code
- Never modify production infrastructure automatically
- Never store credentials in source code or config files
- Never disable security scanning in CI/CD
- Never use `eval()` or `exec()` with user-supplied input
- Never construct SQL queries with string concatenation

## Secret Management

Always use:
- Environment variables for runtime secrets
- A secret manager (e.g., AWS Secrets Manager, HashiCorp Vault)
- `.env` files only for local development (must be in `.gitignore`)

```python
# Forbidden
API_KEY = "sk-hardcoded-secret"

# Correct
import os
API_KEY = os.environ["API_KEY"]
```

## Input Validation

- Validate all user input at the API boundary
- Use schema validation (e.g., Pydantic) for all request bodies
- Never trust data from external systems without validation

## Dependency Security

- Run `pip audit` or equivalent regularly
- Do not use dependencies with known critical vulnerabilities
- Review all new dependencies before adding them

## AI Agent Rules

- Never generate or suggest hardcoded credentials
- Always use environment variables for secrets in generated code
- Flag any existing hardcoded secrets found in the codebase
- Do not modify IAM roles, firewall rules, or security group configs without explicit approval
