---
name: kit-flutter
description: Use ao alterar o matter-mobile-kit (matter_core, matter_design_system ou os bricks Mason) ou o matter-flutter-template — componente, token, cor, interceptor, serviço compartilhado, release de versão do kit ou atualização do kit num app.
---

# kit-flutter

O kit é a fonte do que é comum aos apps; o template é a base dos apps novos. Uma mudança aqui chega a todos, então o CLAUDE.md do kit manda e esta skill resume o que se repete.

## Entra no kit?

- **Componente:** só quando se repete em 2 apps ou é um componente nomeado no Figma do design system. Antes disso, fica no app.
- **Dependência nova:** só com o usuário de acordo.
- **Nunca:** Riverpod no `matter_design_system`; provider declarado no `matter_core`; um pacote dependendo do outro; melos ou workspaces.

## Componente novo ou alterado (`matter_design_system`)

1. Arquivo em `lib/src/components/`, exportado no barrel `matter_design_system.dart`.
2. Só token: cor literal só em `tokens/matter_palette.dart`; espaço, raio e fonte por token.
3. Teste em `test/components/` com `mocktail` onde houver dependência (ADR-0012).
4. Seção na galeria (`example/`).
5. Linha na tabela do `docs/DESIGN_SYSTEM.md` do **template**.
6. Node do Figma no `///` do componente (uma linha).

## Token ou cor

- `grep` do token nos apps e no template antes de mudar: diga o alcance no PR.
- Mudou cor: rode o `contrast_test`.
- Mudou aparência: rodapé `Release-As: <minor>`; mudou escala de token: `Release-As: <major>` (`docs/RELEASING.md` do kit).

## Release e consumo

- Nunca edite `version:` à mão: o release-please sobe a versão.
- A tag nasce no merge do PR `release core x.y.z` / `release design_system x.y.z`. **Mergeie o PR de release antes de atualizar o app.**
- O app consome por **tag** (`ref: core-vX.Y.Z` / `design_system-vX.Y.Z`), nunca por branch nem SHA solto (ADR-0011). Sem `dependency_overrides` no commit (DEP-01).
- Atualizou o kit num app: `fvm flutter pub get`, gate do app, e uma linha no PR com o que mudou do kit.

## Template e bricks

- Mudou o template: rode `dart run tool/sync_app_brick.dart ../matter-flutter-template` no kit para o brick `matterads_app` acompanhar. O `__brick__/` nunca é editado à mão.
- Mudou o formato de uma feature (camadas, testes, doc): ajuste o brick `matterads_feature` no mesmo PR.

## Gate

CI pausado no kit e no template (falta o GitHub App com acesso ao kit). Rode à mão, por pacote: `fvm dart format --set-exit-if-changed .`, `fvm flutter analyze`, `fvm flutter test`; no template, `make check`.
