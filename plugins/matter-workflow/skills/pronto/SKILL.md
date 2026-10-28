---
name: pronto
description: Use antes de commitar uma feature ou correção e antes de abrir PR, em back ou front. Roda o gate do repo, o checklist da stack e o agente revisor, para que a revisão aconteça antes do commit e não num fix depois.
---

# pronto

Objetivo: o primeiro commit já sai revisado. Nada de `fix(review)` logo depois do `feat`.

## Passos

1. **Gate do repo** (CLAUDE.md diz qual): `dotnet build` + `dotnet test`, ou `make check`. Falhou: corrija antes de seguir. Nunca diga que terminou com o gate vermelho.
2. **Checklist da stack:** percorra o checklist de `feature-back` ou `feature-front` item a item contra o diff. Item que não se aplica: diga por quê em uma linha.
3. **Tela (front com Figma):** rode o app no simulador, capture a tela e compare com o `get_screenshot` do frame, item a item da spec do brief (ADR-0013). Divergência volta ao executor antes do revisor. Sem simulador, o relato final diz "fidelidade não verificada".
4. **Revisor:** chame o agente `revisor` com o diff (`git diff` do que vai entrar) e o critério de pronto da sub-issue. Corrija o que ele confirmar **no mesmo commit**.
5. **Doc:**
   - mudou só no lugar certo (fonte única, ADR-0003) e nenhum arquivo ganhou cópia de payload;
   - nenhum doc tocado passou de ~25 KB (se passou, quebre por módulo ou sub-fluxo);
   - decisão nova passou pelo critério da skill `registrar-decisao`;
   - a mudança altera algo que o `CLAUDE.md` do repo afirma (stack, deploy, banco, fase do produto, comando)? Atualize-o **neste** commit.
6. **Commit:** Conventional Commits em português, `git add <arquivos>` (nunca `git add .`), sem `--no-verify`.
7. **PR:** um por sub-issue, título com o resultado, `MAT-<n>` no corpo, template do repo preenchido, link no Linear.

## Relato final

Diga o que foi verificado e como (comando e resultado), o que não foi verificado (ex.: iOS não roda na máquina) e o que ficou de fora. Sem "deve funcionar".
