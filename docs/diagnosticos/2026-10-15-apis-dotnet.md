# Diagnóstico das APIs .NET — 15/10/2026

`muma-fit-api` (.NET 10, pasta local `C:\Matter\muma-fit`) e `bencaodiaria-app-api` (.NET 8).

## Ciclo de uma feature (padrão observado no git)

```
planejamento em docs/ (+ tarefa central no Linear)
  → feat(...)                       código + testes
  → fix(...): ajustes da revisão     a própria IA revisa e corrige
  → docs(...): ADR + api + flow + handoff + domain + roadmap + README
  → docs(...): align / clarify       corrige a doc que acabou de escrever
  → um PR por plano
```

Exemplos no muma-fit-api (stories, feed e conquistas da 0.14):

- `feat(feed)` → `fix(feed): harden…` → `docs(feed)` → `docs(feed): align… with the hardening`
- `feat(groups): achievements` → `docs(groups): ADR-0040…` → `fix(groups)` → `docs(groups): document EndsOn…` → `docs(flutter): clarify 0.14 handoff`

No bencao, o plano inteiro (MAT-1511 a MAT-1531) está numa branch chamada `docs/planejamento-features`: **33 commits, 214 arquivos, ~18 mil linhas** num único PR. Cada bloco de `feat` tem seu `fix(api): ajustes da revisão…` logo depois.

## Documentação

| | muma-fit-api | bencao |
|---|---|---|
| `CLAUDE.md` | 1,7 KB, índice | 6,9 KB, repete a arquitetura e está desatualizado na `main` |
| ADRs | 40 | 9 |
| `docs/` | ~14 mil linhas (~900 KB) | ~2,5 mil linhas |
| Maiores arquivos | `api.md` 108 KB, `domain.md` 58 KB, `flutter/grupos-e-gamificacao.md` 47 KB, `CHANGELOG.md` 45 KB | — |

Uma feature média do muma-fit-api toca **7–8 arquivos de doc** (ADR, `api.md`, `flows/`, `flutter/handoff-x.md`, `flutter/README.md`, `domain.md`, `roadmap.md`, `docs/README.md`) e depois o `CHANGELOG.md`. A mesma rota é escrita 3–4 vezes.

## Problemas

1. **Documentação em leque.** ~250–480 linhas de doc por mudança; as cópias divergem e geram os `docs: align/clarify`. `api.md` com 108 KB não cabe numa leitura.
2. **Retrabalho embutido.** Quase todo `feat` tem um `fix` de revisão atrás: contador não atômico, regra de membro, fuso, `EndsOn`.
3. **PR gigante por plano**, com nome de branch (`docs/…`) que não bate com o conteúdo.
4. **Contexto errado na `main` do bencao.** O `CLAUDE.md` diz Bitbucket → DigitalOcean, MySQL e PRs para `develop`; o deploy real é GitHub Actions → ECR → EC2 arm64.
5. **Regras contraditórias.** muma-fit-api proíbe XML doc (`///`); bencao liga `GenerateDocumentationFile` e espera XML doc.
6. **Handoff com código Dart** em `docs/flutter/`, copiando o contrato que o app também copia em `docs/back/`.

Correções: ADRs [0002](../adr/0002-pr-por-sub-issue.md), [0003](../adr/0003-fonte-unica-de-doc.md), [0004](../adr/0004-contrato-back-front.md) e [0006](../adr/0006-revisao-antes-do-commit.md).
