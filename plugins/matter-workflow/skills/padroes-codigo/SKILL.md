---
name: padroes-codigo
description: Use ao escrever ou alterar código em Python, Node/React ou Go num projeto da Matter, ou ao configurar lint, estrutura de pastas, envelope de resposta e logging de um projeto novo. Traz os padrões de código do time (fonte oficial no Notion).
---

# padroes-codigo

Fonte oficial: Notion → [Padronização de código](https://app.notion.com/p/Padroniza-o-de-c-digo-34c6fee3118c803e9df6f179b52c0019). Esta skill é a versão que o agente lê; quando o Notion mudar, ela muda junto. Vale para **código novo ou alterado**; não obriga refatorar legado inteiro, mas o que for tocado sai no padrão.

Para .NET e Flutter, a aplicação destes princípios está em `feature-back` e `feature-front`.

## 1. Lint e formatter

- **Python:** Ruff. `line-length=100`, `target-version=py311`, `quote-style=single`, `indent-style=space`, seleção `E,F,W,C,B,I,UP`, `mccabe.max-complexity=10`. Rodar `ruff check` e `ruff format`.
- **Node/React:** ESLint (airbnb / airbnb + airbnb/hooks) + Prettier. `printWidth=100`, `tabWidth=4`, `singleQuote`, `trailingComma=all`, `semi`, `arrowParens=always`. Proibidos: `no-console`, `no-unused-vars`, `import/no-cycle`; imports ordenados. `max-lines` 800 (back) / 300 (front).
- **Go:** gofmt + golangci-lint (govet, staticcheck, errcheck, gocyclo min-complexity 10, revive).

## 2. Estrutura por domínio

```
src/
  main            entrypoint
  config/         configs globais (settings, logger)
  modules/<dominio>/  router · service · repository · schemas(dto) · models
  shared/         só utils genéricos, erros globais, helpers
  infra/          tudo externo isolado: banco, APIs, SDKs
```

Nunca `services/` ou `controllers/` globais. Módulo não importa outro módulo direto: comunica via interface/`shared`.

## 3. Fluxo da requisição

`request → router/controller → service → repository → response`

- Router/controller: valida input, chama service, devolve response. Sem regra de negócio, sem banco.
- Service: regra, orquestração, validação de domínio. Não conhece HTTP.
- Repository: acesso a dados. Sem regra.

PR que quebra o fluxo é recusado em code review.

## 4. Validação e output

- Input validation no framework (FastAPI + Pydantic → 422; Node → Zod em middleware; Go → validator no início do handler).
- Business validation (ex.: "email já existe") no service.
- Toda rota devolve o envelope `{ transactionId: <nanoid>, message, data?, error? }`. Python:

```python
def http_response(status_code, message, data=None, error=None):
    body = {'transactionId': nanoid.generate(), 'message': message}
    if data is not None: body['data'] = data
    if error is not None: body['error'] = error
    return JSONResponse(status_code=status_code, content=body)
```

## 5. Logging

- JSON estruturado, nunca `print`/`console`. Python: loguru (`serialize=True`); Node: pino; Go: zerolog.
- Campos mínimos: `timestamp, level, message, service, environment, requestId`. Extras: `userId, action, duration`.
- DEBUG desligado em prod. Nunca logar senha, token, dado sensível ou payload gigante. Se ninguém vai ler, não loga.
