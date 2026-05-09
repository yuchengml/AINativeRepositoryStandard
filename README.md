# AINativeRepositoryStandard

Defining standards for AI development projects so that human engineers and AI Agents can collaborate efficiently and ensure high-quality, deterministic development.

## 📌 Repository Contents

This repository provides two main components to help you bootstrap and standardize your AI-Native engineering workflows:

### 1. The Core Standard Document
- **[`AI-Native Repository Standard.md`](./AI-Native%20Repository%20Standard.md)**: The foundational guideline document. It defines directory rules, coding standards, layer responsibilities, testing requirements, CI/CD rules, and specific instructions for AI Agents (like avoiding implicit rules and adhering to machine-readability).
- **Appendix**: Includes a highly detailed, golden-standard repository directory tree based on Domain-Driven Design (DDD) and Clean Architecture.

### 2. Ready-to-Use Templates
Located in the `templates/` directory, these are standardized Markdown files that you can directly copy into your new projects to establish immediate alignment with the AI-Native Standard.

- **`templates/README.md`**: The primary entry point for your project, pre-structured to include architecture flow, tech stack, and observability endpoints.
- **`templates/AGENTS.md`**: Explicit constraints and rules for AI Agents (e.g., coding rules, forbidden actions like committing secrets, and development workflows).
- **`templates/ARCHITECTURE.md`**: A template to define system boundaries, layer responsibilities (API, Application, Domain, Infrastructure), and data flow using Mermaid diagrams.
- **`templates/CONTRIBUTING.md`**: Standardized branch naming, conventional commits, and PR label requirements (e.g., `enhancement`, `bug`). Configured to recommend `poetry` as the default package manager.
- **`templates/DECISIONS.md`**: A template for Architecture Decision Records (ADRs) to track why certain architectural or tooling choices were made.

---

## 🚀 How to Use

1. **Read the Standard**: Start by reading the `AI-Native Repository Standard.md` to understand the core philosophy (Human + AI Collaboration, Explicit Over Implicit, Deterministic Engineering).
2. **Bootstrap a New Project**:
   - Create your new repository.
   - Copy all files from the `templates/` folder into the root of your new repository.
3. **Customize**: 
   - Update `README.md` with your project's specific details.
   - Adjust `ARCHITECTURE.md` to reflect your actual system boundaries.
   - Record your initial project decisions in `DECISIONS.md`.
4. **Develop**: Follow the rules established in your new `AGENTS.md` and `CONTRIBUTING.md` files to maintain a high-quality codebase that AI agents can easily understand and assist with.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
