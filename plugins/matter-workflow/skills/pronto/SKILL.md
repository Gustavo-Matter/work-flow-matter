---
name: pronto
description: Use antes de commitar uma feature ou correção e antes de abrir PR, em back ou front. Roda o gate do repo, o checklist da stack e o agente revisor, para que a revisão aconteça antes do commit e não num fix depois.
---

# pronto

Objetivo: o primeiro commit já sai revisado. Nada de `fix(review)` logo depois do `feat`.

## Passos

1. **Gate do repo** (CLAUDE.md diz qual): `dotnet build` + `dotnet test`, ou `make check`. Falhou: corrija antes de seguir. Nunca diga que terminou com o gate vermelho.
2. **Checklist da stack:** percorra o checklist de `feature-back` ou `feature-front` item a item contra o diff. Item que não se aplica: diga por quê em uma linha.
3. **Revisor:** chame o agente `revisor` com o diff (`git diff` do que vai entrar) e o critério de pronto da sub-issue. Corrija o que ele confirmar **no mesmo commit**.
4. **Doc:** confira que a doc mudou só no lugar certo (ver `docs/workflow.md` → fonte única) e que nenhum arquivo de doc ganhou cópia de payload.
5. **Commit:** Conventional Commits em português, `git add <arquivos>` (nunca `git add .`), sem `--no-verify`.
6. **PR:** um por sub-issue, título com o resultado, `MAT-<n>` no corpo, template do repo preenchido, link no Linear.

## Relato final

Diga o que foi verificado e como (comando e resultado), o que não foi verificado (ex.: iOS não roda na máquina) e o que ficou de fora. Sem "deve funcionar".
