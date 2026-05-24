# AI-Native Repository Standard

> 一套讓人類工程師與 AI Agent 都能高效協作的 Repository 開發規範。

---

# 1. Introduction

本文件定義 AI-Native Repository 的開發標準。

此標準的目標：

* 提升 Repository 可維護性
* 提升多人協作效率
* 提升 AI Agent 對專案的理解能力
* 降低 AI 修改程式碼時的風險
* 建立可擴展、可驗證、可自動化的工程流程

本規範適用於：

* Backend Service
* SDK / Library
* CLI Tool
* AI Service
* Agent Framework
* RAG System
* Microservice
* Internal Platform

---

# 2. Core Principles

## 2.1 Human + AI Collaboration

Repository 不只提供人類閱讀。

也必須讓：

* AI Coding Assistant
* AI Agent
* Autonomous Development Tool
* CI Automation
* Code Review Agent
* Testing Agent

能夠：

* 理解架構
* 推理程式行為
* 安全修改程式
* 自動驗證
* 維持一致性

---

## 2.2 Explicit Over Implicit

所有規範應盡量明確。

避免：

* 隱含規則
* 團隊默契
* 不可追蹤的架構決策
* 模糊命名

AI 對於 Explicit 規則的遵循能力遠高於 Implicit 規則。

---

## 2.3 Machine Readability

除了人類可讀性外，Repository 必須具備：

* Machine-readable schema
* Structured metadata
* Standardized documentation
* Predictable directory layout

---

## 2.4 Deterministic Engineering

所有流程應盡可能：

* 可重現
* 可驗證
* 可測試
* 可自動化

AI Agent 高度依賴 deterministic workflow。

---

# 3. Recommended Repository Structure

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
├── pyproject.toml
├── tox.ini
├── Makefile
├── README.md
├── AGENTS.md
├── CLAUDE.md
├── ARCHITECTURE.md
├── CONTRIBUTING.md
├── DECISIONS.md
└── LICENSE
```

---

# 4. Required Root-Level Documents

## 4.1 README.md

README 必須包含：

* Project Overview
* Features
* Installation
* Quick Start
* Architecture Summary
* Development Setup
* Testing
* Deployment
* Contribution Guide

README 是 AI 與人類理解專案的第一入口。

---

## 4.2 AGENTS.md

**AI Agent 的主入口文件。**

AI Agent 進入 Repository 後必須先閱讀 `AGENTS.md`，再開始執行任何任務。

應包含：

* Repository Knowledge Map（指引 Agent 依序閱讀所有相關文件）
* Coding Standards
* Testing Rules
* Architecture Constraints
* Forbidden Changes
* Dependency Rules
* Development Workflow（指向 `.ai/workflows/`）
* Common Commands

建議的閱讀順序應明確定義於 `AGENTS.md` 中：

```text
AGENTS.md
    ↓
ARCHITECTURE.md + DECISIONS.md   ← 理解系統架構
    ↓
.ai/rules/*                      ← 學習詳細規則
    ↓
.ai/workflows/<task-type>        ← 依任務類型選擇對應 workflow
```

範例：

```md
# AGENTS.md

## Coding Rules
- All functions must have type hints
- No business logic inside routers
- Async code must not block event loop

## Testing Rules
- All new features require unit tests
- Integration tests required for API changes

## Forbidden
- Never modify production deployment
- Never commit secrets
```

---

## 4.6 CLAUDE.md

專為 Claude Code 設計的入口文件。

Claude Code 會在每個 session 開始時自動讀取 `CLAUDE.md`。

設計原則：

* 內容應極簡，只需引導 Claude Code 閱讀 `AGENTS.md`
* 不重複 `AGENTS.md` 的內容
* 確保 Claude Code 與其他 AI Agent 遵循相同的規範

範例：

```md
# CLAUDE.md

This file is read automatically by Claude Code at the start of every session.

## Start Here

Read `AGENTS.md` before taking any action in this repository.
```

其他 AI 工具（Cursor、Copilot 等）若有類似的自動讀取機制，可依相同模式建立對應的入口文件，並同樣指向 `AGENTS.md`。

---

## 4.3 ARCHITECTURE.md

定義：

* System boundaries
* Layer responsibilities
* Dependency flow
* Communication patterns
* Event flow
* Service interactions

範例：

```text
Frontend
   ↓
API Gateway
   ↓
Application Layer
   ↓
Domain Layer
   ↓
Infrastructure Layer
```

應避免：

* Circular dependency
* Cross-layer access
* Shared mutable state

---

## 4.4 CONTRIBUTING.md

定義：

* Branch strategy
* Pull request rules
* Commit conventions
* Review process
* Local development workflow

---

## 4.5 DECISIONS.md

紀錄架構決策。

範例：

```md
# Decision: Use FastAPI

## Reason
- Async support
- OpenAPI integration
- Strong typing

## Alternatives
- Flask
- Django
```

AI Agent 非常需要這些背景資訊。

---

# 5. Source Code Standards

## 5.1 Directory Rules

```text
src/
├── api/
├── application/
├── domain/
├── infrastructure/
├── models/
├── services/
└── utils/
```

---

## 5.2 Layer Responsibilities

### API Layer

負責：

* Request parsing
* Response formatting
* Authentication
* Validation

禁止：

* Business logic
* Database access

---

### Application Layer

負責：

* Use case orchestration
* Workflow coordination
* Transaction handling

---

### Domain Layer

負責：

* Core business logic
* Domain entities
* Domain rules

禁止：

* Infrastructure dependency

---

### Infrastructure Layer

負責：

* Database
* Cache
* External APIs
* Messaging systems

---

# 6. Coding Standards

## 6.1 Type Safety

所有公開函式必須具有 type hints。

```python
async def get_user(user_id: str) -> User:
    ...
```

---

## 6.2 Formatting

使用：

* ruff
* mypy
* pre-commit

---

## 6.3 Naming Convention

### Variables

```python
user_id
request_timeout
```

### Classes

```python
UserService
OrderRepository
```

### Constants

```python
MAX_RETRY_COUNT
DEFAULT_TIMEOUT
```

---

## 6.4 Async Rules

禁止：

* Blocking I/O inside async function
* time.sleep()
* synchronous DB call in async context

應使用：

```python
await asyncio.sleep(1)
```

---

# 7. Testing Standards

## 7.1 Test Structure

```text
tests/
├── unit/
├── integration/
├── e2e/
└── fixtures/
```

---

## 7.2 Required Test Coverage

| Type             | Requirement                |
| ---------------- | -------------------------- |
| Unit Test        | Required                   |
| Integration Test | Required for API changes   |
| E2E Test         | Required for critical flow |

---

## 7.3 Test Rules

* Every bug fix requires regression test
* Snapshot tests discouraged
* Tests must be deterministic
* Tests must not depend on external unstable services

---

# 8. Dependency Management

## 8.1 Package Management

使用：

* poetry
* requirements.txt

---

## 8.2 Dependency Rules

新增 dependency 時必須：

* 說明用途
* 避免 duplicate libraries
* 評估 maintenance status
* 評估 security risk

---

## 8.3 Upgrade Rules

禁止：

* Automatic major upgrade
* Unreviewed dependency updates

---

# 9. CI/CD Standards

## 9.1 Required Pipelines

```text
.github/workflows/
```

必須包含：

* lint
* type-check
* unit-test
* integration-test
* build
* security-scan

---

## 9.2 CI Requirements

Pull Request 必須：

* All tests passing
* No lint errors
* No type errors
* Security scan passing

---

# 10. AI-Specific Standards

## 10.1 Agent Entry Point Design

AI Agent 進入 Repository 的閱讀路徑應明確定義：

```text
CLAUDE.md (Claude Code)
    ↓
AGENTS.md                        ← 所有 AI Agent 的主入口
    ↓
ARCHITECTURE.md + DECISIONS.md   ← 系統架構與決策背景
    ↓
.ai/rules/*                      ← 詳細的 coding / testing / security 規則
    ↓
.ai/workflows/<task-type>        ← 依任務類型執行對應 workflow
```

`AGENTS.md` 必須包含此閱讀路徑的說明，讓 Agent 知道每個文件的用途與閱讀時機。

---

## 10.2 .ai Directory

```text
.ai/
├── prompts/
├── rules/
├── workflows/
└── examples/
```

---

## 10.3 AI Rules

`.ai/rules/` 存放語言與領域的詳細規範，供 Agent 在實作前閱讀：

```text
.ai/rules/python.md      ← type hints、async 規則、命名慣例、layer 限制
.ai/rules/testing.md     ← 測試結構、覆蓋率要求、命名規範
.ai/rules/security.md    ← 禁止行為、secret 管理、input validation
```

---

## 10.4 Workflow Templates

`.ai/workflows/` 存放各任務類型的逐步流程，Agent 應依任務類型選擇對應文件：

```text
.ai/workflows/
├── feature-development.md   ← 新功能開發
├── bug-fix.md               ← 先寫 regression test 再修 bug
├── release-process.md       ← semantic versioning、changelog、發布
└── refactoring.md           ← 行為不變的重構，測試先行
```

---

## 10.4 Golden Path Examples

提供 AI 最容易成功的範例。

```text
examples/
├── api-service/
├── worker-service/
├── sdk-library/
└── cli-tool/
```

AI Agent 通常會模仿 examples 的風格。

---

# 11. Machine-Readable Schemas

## 11.1 API Schema

```text
schemas/openapi.yaml
```

---

## 11.2 Event Schema

```text
schemas/events/
```

---

## 11.3 Config Schema

```text
schemas/config/
```

---

## 11.4 Metadata

```text
repo-meta/
├── ownership.yaml
├── dependencies.yaml
├── module-boundaries.yaml
└── service-catalog.yaml
```

---

# 12. Security Standards

## 12.1 Forbidden Actions

禁止：

* Commit secrets
* Modify production infrastructure automatically
* Store credentials in source code
* Disable security scanning

---

## 12.2 Secret Management

應使用：

* Environment variables
* Secret manager
* Vault systems

禁止：

```python
API_KEY = "hardcoded-secret"
```

---

# 13. Documentation Standards

## 13.1 docs Structure

```text
docs/
├── architecture/
├── domain/
├── api/
├── deployment/
├── runbooks/
└── onboarding/
```

---

## 13.2 Domain Knowledge

```text
docs/domain/
├── terminology.md
├── metrics.md
├── pubsub.md
└── workflows.md
```

AI RAG 系統非常適合使用這些知識。

---

# 14. Git Standards

## 14.1 Branch Naming

```text
feature/
fix/
refactor/
hotfix/
```

---

## 14.2 Commit Convention

```text
feat:
fix:
refactor:
test:
docs:
chore:
```

範例：

```text
feat: add user authentication middleware
fix: resolve async session leak
```

---

# 15. Development Workflow

## 15.1 Feature Development

1. Create issue
2. Define acceptance criteria
3. Implement feature
4. Add tests
5. Run lint and type check
6. Create pull request
7. Code review
8. Merge

---

## 15.2 Pull Request Requirements

PR 必須包含：

* Summary
* Motivation
* Test evidence
* Breaking changes
* Related issue

---

# 16. Repository Templates

建議建立 organization-level template repository。

```text
engineering-standards/
├── templates/
├── examples/
├── standards/
└── golden-path/
```

---

# 17. Recommended Tooling

## Python

| Purpose            | Tool       |
| ------------------ | ---------- |
| Formatting         | ruff       |
| Type Checking      | mypy       |
| Testing            | pytest     |
| Multi-version Test | tox        |
| Dependency         | poetry     |
| Git Hooks          | pre-commit |

---

# 18. AI-Agent Optimization Checklist

## Required

* Clear repository structure
* AGENTS.md（含 Repository Knowledge Map）
* ARCHITECTURE.md
* CI/CD pipeline
* Type hints
* Deterministic tests
* Machine-readable schema
* Golden path examples

---

## Recommended

* CLAUDE.md（Claude Code 使用者）
* repo-meta/
* .ai/（含 rules/ 與 workflows/）
* Structured domain docs
* Architecture decision records
* OpenAPI schema
* Event schema

---

# 19. Example Minimal AI-Native Repository

```text
repo/
├── src/
├── tests/
├── docs/
├── .ai/
│   ├── rules/
│   └── workflows/
├── README.md
├── AGENTS.md
├── CLAUDE.md
├── ARCHITECTURE.md
├── pyproject.toml
└── .github/workflows/
```

---

# 20. Final Goal

AI-Native Repository 的核心目標：

* AI 可理解
* AI 可推理
* AI 可安全修改
* AI 可驗證
* AI 可維護
* AI 可自動化協作

最終建立：

> Human + AI Collaborative Engineering System

---

# 21. Future Extensions

未來可擴展：

* AI Code Review Agent
* AI Architecture Validation
* AI Dependency Analysis
* AI Security Review
* AI Test Generation
* AI Refactoring Workflow
* AI Release Automation

---

# 22. Suggested Adoption Roadmap

## Phase 1

建立：

* README.md
* AGENTS.md
* ARCHITECTURE.md
* tests/
* CI pipeline

---

## Phase 2

加入：

* ruff
* mypy
* pre-commit
* tox
* OpenAPI schema

---

## Phase 3

建立：

* .ai/
* repo-meta/
* decision records
* golden path examples

---

## Phase 4

導入：

* AI review workflow
* AI automation pipeline
* AI architecture validation
* autonomous testing

---

# 23. License

建議所有 Repository 明確定義 License：

* MIT
* Apache-2.0
* BSD-3-Clause
* Proprietary

避免 AI 或人類對授權產生誤解。

---

# 24. Summary

AI 時代的 Repository 已不只是程式碼儲存空間。

它同時也是：

* Knowledge Base
* Machine-readable System
* Collaboration Protocol
* Engineering Contract
* AI Operational Context

Repository 結構與規範品質，將直接影響：

* 開發效率
* 維護成本
* AI Agent 成功率
* 系統穩定性
* 團隊擴展能力

因此：

> Repository Standardization 將成為 AI-Native Engineering 的核心基礎能力。

---

# 25. Appendix: Detailed Repository Structure Example

這是一個高度符合 Domain-Driven Design (DDD) 與 Clean Architecture 的完整 AI-Native Repository 目錄結構範例：

```text
repo/
├── src/
│   ├── api/
│   │   ├── routers/
│   │   ├── middleware/
│   │   ├── dependencies/
│   │   └── schemas/
│   │
│   ├── application/
│   │   ├── services/
│   │   ├── use_cases/
│   │   ├── commands/
│   │   ├── queries/
│   │   └── dto/
│   │
│   ├── domain/
│   │   ├── entities/
│   │   ├── value_objects/
│   │   ├── repositories/
│   │   ├── events/
│   │   ├── exceptions/
│   │   └── specifications/
│   │
│   ├── infrastructure/
│   │   ├── database/
│   │   ├── cache/
│   │   ├── messaging/
│   │   ├── clients/
│   │   ├── repositories/
│   │   ├── observability/
│   │   └── security/
│   │
│   ├── shared/
│   │   ├── constants/
│   │   ├── enums/
│   │   ├── utilities/
│   │   ├── exceptions/
│   │   └── types/
│   │
│   ├── config/
│   ├── main.py
│   └── lifecycle.py
│
├── tests/
│   ├── unit/
│   ├── integration/
│   ├── contract/
│   ├── e2e/
│   ├── performance/
│   └── fixtures/
│
├── docs/
│   ├── architecture/
│   ├── domain/
│   ├── api/
│   ├── deployment/
│   ├── onboarding/
│   ├── runbooks/
│   └── decisions/
│
├── examples/
│   ├── api/
│   ├── sdk/
│   └── workflows/
│
├── scripts/
│   ├── development/
│   ├── deployment/
│   ├── migration/
│   └── maintenance/
│
├── configs/
│   ├── development/
│   ├── staging/
│   ├── production/
│   └── testing/
│
├── schemas/
│   ├── api/
│   ├── events/
│   ├── config/
│   └── database/
│
├── deployments/
│   ├── docker/
│   ├── kubernetes/
│   ├── helm/
└── LICENSE
```
