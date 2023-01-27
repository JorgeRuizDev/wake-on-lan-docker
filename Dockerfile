FROM python:3.10 as poetry

WORKDIR /poetry

RUN pip install poetry==1.3.2

COPY poetry.lock pyproject.toml ./

RUN poetry config virtualenvs.in-project true

RUN poetry install

FROM python:3.10-slim as base

WORKDIR /app

COPY --from=poetry /poetry/.venv /venv

COPY . .

CMD ["/venv/bin/python", "-c", "print(0)"]