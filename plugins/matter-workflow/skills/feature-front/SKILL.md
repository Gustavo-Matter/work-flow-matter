---
name: feature-front
description: Use ao implementar ou alterar tela, estado ou integração com API num app Flutter da Matter (muma-fit, bencaodiaria-app-mobile ou novo). Traz as regras de arquitetura, design system, estados de tela, testes e o que documentar.
---

# feature-front (Flutter)

O CLAUDE.md do repo manda. Os dois apps têm arquiteturas diferentes:

- **muma-fit** e apps novos (`matter-flutter-template`): Riverpod + codegen, go_router, `fpdart` `Either<Failure, T>`, `matter_core` e `matter_design_system`, regras em `tool/check_architecture.dart`.
- **bencaodiaria-app-mobile** (legado): Cubit/Bloc + get_it, rotas nomeadas, `AppFailure`, mocktail. Siga o padrão do repo; não misture Riverpod nele.

## Antes de codar

1. Leia o CLAUDE.md do repo e `docs/features/<feature>.md`. Só esses e as decisões que eles citam.
2. Integração com API: leia o **contrato no repo do back** (`docs/api/<modulo>.md`). Se a rota não existe ou não serve, pare e use a skill `contrato-api`; não invente campo.
3. Tela com Figma: pegue o frame exato (link com node) **antes** de codar. Fidelidade ao Figma conferida no primeiro commit evita a sequência de `fix: como no Figma`.

## Regras

- Feature por domínio: `domain/` (Dart puro), `data/`, `providers/` (ou cubit), `presentation/`. `presentation/` não importa `data/`.
- Componente visual vem do design system. Sem cor literal, espaçamento e raio por token.
- Toda tela assíncrona trata **loading, erro (com ação de saída), vazio e dados**.
- Imagem/vídeo de rede pelo componente com cache do kit, nunca `Image.network`.
- Estado por usuário é zerado na troca de conta.
- Gerado (`.g.dart`, `.freezed.dart`) só por `build_runner`, nunca à mão.
- Dependência nova só depois de conferir o que o `matter_core` já oferece, e com o usuário de acordo.

## Checklist da stack (o `pronto` cobra)

- [ ] Os quatro estados da tela, inclusive erro de rede e lista vazia.
- [ ] Toque duplo, voltar no meio do envio, retry que falha de novo: a tela não quebra nem duplica a ação.
- [ ] Recurso apagado/sem permissão (404/403) tratado na tela.
- [ ] Tema claro e escuro; texto grande (acessibilidade) sem estourar.
- [ ] iOS e Android: permissão (câmera, galeria, notificação) negada e concedida depois.
- [ ] Teste do notifier/cubit (estados) e de widget nos fluxos críticos, com fakes.
- [ ] Gate do repo verde: `make check` (muma) ou `format + analyze + test` (bencao).

## Doc no mesmo PR

- `docs/features/<feature>.md`: estado, telas, decisões locais e **link** para o contrato do back. Não copie payload.
- Decisão com alternativa descartada: `docs/decisions/NNN-*.md`, curta, e a linha no índice.
- Doc de feature passou de ~25 KB: quebre por sub-fluxo.
