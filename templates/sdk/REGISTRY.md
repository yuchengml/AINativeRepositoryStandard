# SDK Registry

> Index of all vendored and internal SDKs in this repository.
> AI agents must consult this file before writing any call to an unrecognized import.

| Name | Status | Source Path | Purpose |
|------|--------|-------------|---------|
| example-sdk | vendored | sdk/example-sdk/ | Example vendored SDK not in LLM training data |

## Status Definitions

| Status | Meaning |
|--------|---------|
| `internal` | Developed internally in this project; not published as a public package |
| `vendored` | Publicly released but not covered by LLM training data |
