# 0011 — O kit e o template Flutter fazem parte do workflow, e o kit é consumido por tag

**Status:** Aceita · 16/10/2026

## Contexto

O Flutter da Matter tem quatro repos, e o workflow conhecia dois. O `matter-mobile-kit` (`matter_core`, `matter_design_system`, bricks Mason) e o `matter-flutter-template` definem o que os apps novos herdam, mas nenhuma skill os cobria ([diagnóstico de 16/10](../diagnosticos/2026-10-16-flutter-e-mac.md)). A regra do kit é consumir por tag, mas só existem `core-v0.1.0` e `design_system-v0.2.0`: os PRs do release-please não foram mergeados, e o muma-fit fixa o kit por SHA.

## Decisão

- Mudança no kit ou no template segue a skill `kit-flutter`. A `feature-front` manda para ela quando falta componente ou token.
- O app consome o kit **por tag**. O PR de release do release-please é mergeado antes de o app atualizar o `ref:`.
- Feature nova em app do template nasce do brick `matterads_feature`.

## Alternativas descartadas

- **Aceitar SHA como regra:** não diz qual versão o app usa, não tem changelog e um SHA de branch apagada some.
- **Deixar o kit fora do workflow:** componente criado no app em vez do kit, e o template divergindo do brick.

## Consequências

- muma-fit e template trocam o SHA pela tag quando os PRs `release core 0.2.0` e `release design_system 0.3.0` forem mergeados.
- O CI do kit e do template continua pausado até o GitHub App ter acesso ao kit; até lá o gate é local (`docs/adocao.md`).
