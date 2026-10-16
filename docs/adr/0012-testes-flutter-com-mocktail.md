# 0012 — Testes Flutter com mock (`mocktail`), não com fake escrito à mão

**Status:** Aceita · 16/10/2026 · Nos apps do template, substitui a decisão 010 ("fakes escritos à mão")

## Contexto

O template e o muma-fit proíbem biblioteca de mock (decisão 010): cada feature tem um `helpers/fakes.dart` com fakes configuráveis, e o brick `matterads_feature` gera esse arquivo. O bencao usa `mocktail`. Fake à mão é código a mais para escrever e manter a cada mudança de interface, e cada app fazia de um jeito.

## Decisão

- Teste novo usa **`mocktail`**: mock do `Dio`/datasource no teste de repository, mock do repository no teste de notifier, cubit e widget.
- Não se escreve fake à mão em teste novo. Fake existente fica até o arquivo de teste ser tocado; aí vira mock.
- O teste confere o critério de pronto e os erros (404/403, validação, rede), e que a ação não se repete (`verify(...).called(n)`).

## Alternativas descartadas

- **Manter fakes à mão:** é o custo descrito acima, e dois padrões entre os apps.
- **Só teste contra a API real:** depende de ambiente e credencial, é lento e não cobre estado de tela. Pode complementar, não substituir.

## Consequências

- Rollout: decisão nova no `docs/decisions/` do template e do muma-fit, substituindo a 010; `mocktail` em `dev_dependencies`; o brick `matterads_feature` passa a gerar mocks em vez de `fakes.dart`.
- O agente `revisor` aponta fake novo em teste.
- O bencao já está no padrão.
