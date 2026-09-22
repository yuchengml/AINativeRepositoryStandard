.PHONY: install dev lint format typecheck test test-unit test-integration test-e2e coverage clean

install:
	poetry install

dev:
	poetry run uvicorn src.main:app --reload

lint:
	poetry run ruff check .
	poetry run ruff format --check .

format:
	poetry run ruff format .
	poetry run ruff check --fix .

typecheck:
	poetry run mypy src

test:
	poetry run pytest

test-unit:
	poetry run pytest -m unit

test-integration:
	poetry run pytest -m integration

test-e2e:
	poetry run pytest -m e2e

coverage:
	poetry run pytest --cov=src --cov-report=term-missing --cov-report=html

clean:
	rm -rf .pytest_cache .mypy_cache .ruff_cache htmlcov coverage.xml dist build
	find . -type d -name '__pycache__' -exec rm -rf {} +
