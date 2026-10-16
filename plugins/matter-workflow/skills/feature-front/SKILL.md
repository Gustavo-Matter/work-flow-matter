---
name: feature-front
description: Use ao implementar ou alterar tela, estado ou integração com API num app Flutter da Matter (muma-fit, bencaodiaria-app-mobile ou app novo do matter-flutter-template). Traz o perfil de cada app, o scaffold por brick, a checagem de Figma, o checklist da stack, os testes com mock e o que documentar.
---

# feature-front (Flutter)

O CLAUDE.md do repo manda. Esta skill cobre o que ele não diz. Mudança em componente, token ou pacote compartilhado não é feita no app: é a skill `kit-flutter`.

## Perfil do app

| | Template, muma-fit e apps novos | bencaodiaria-app-mobile (legado) |
|---|---|---|
| Estado e injeção | Riverpod 3 + codegen; retry automático desligado | Cubit/Bloc + get_it; não misture Riverpod |
| Camadas | `features/<x>/{domain,data,providers,presentation}`; `presentation` não importa `data` | página + cubit + state em `features/<x>/`; dados em `lib/app/repositories` e `lib/app/models` |
| Erro | `Either<Failure, T>` (`fpdart`) via `failureFromException` do `matter_core` | `sealed AppFailure` + `localizedMessage(l10n)` |
| UI | `matter_design_system`: sem cor literal, espaço e raio por token (DS-01/02) | `context.color` / `context.text` do próprio app |
| Imagem e vídeo de rede | `MatterNetworkImage` / `MatterVideo` (MEDIA-01) | `AppNetworkImage` |
| Tela assíncrona | `AsyncScreen` no muma (ASYNC-01) | estados selados do cubit |
| Config | `--dart-define-from-file=config/<env>.env`; nunca em `assets` | `.env` empacotado como asset: **é público no binário**, nada secreto nele |
| Gate | `make check` (format + analyze + `tool/check_architecture.dart` + test). CI pausado: é o único gate | `dart format` (sem gerados) + `flutter analyze` + `flutter test`; o CI também compila Android e iOS |
| Doc | `docs/features/<x>.md` (DOC-01, até ~25 KB) | `docs/features/<x>.md` criado quando a feature for tocada |

Recursos que só um dos apps tem entram no checklist como condicionais (abaixo).

## Antes de codar

1. Leia o CLAUDE.md do repo e `docs/features/<feature>.md`. Só esses e as decisões que eles citam.
2. **Feature nova no template ou no muma:** gere o esqueleto com `mason make matterads_feature` (brick do `matter-mobile-kit`) em vez de escrever as camadas à mão. Depois registre a rota e rode o gate.
3. **Integração com API:** leia o contrato no repo do back (`docs/api/<modulo>.md`). Rota ou campo que não existe: pare e use a skill `contrato-api`; não invente campo.
4. **Tela com Figma:** o link com node tem que estar na sub-issue; sem ele, peça antes de codar. Leia o frame pela skill `figma:figma-design-to-code` (não pelo print).
5. **Faltou componente no kit:** não crie botão, campo ou card no app. Use a skill `kit-flutter`.

## Regras

- Componente visual vem do design system do app. Sem cor literal.
- Toda tela assíncrona trata **loading, erro (com ação de saída), vazio e dados**.
- Estado por usuário é zerado na troca de conta (muma: chave por usuário em `shared_preferences` e `invalidate` dos providers).
- Gerado (`.g.dart`, `.freezed.dart`) só por `build_runner`, nunca à mão.
- Comentário e `///` no máximo 1 a 2 linhas, só com o porquê.
- Dependência nova só depois de conferir o que o `matter_core` já oferece, e com o usuário de acordo.

## Testes: mock, não fake

Teste usa **mock com `mocktail`** (ADR-0012 do work-flow-matter). Não escreva fake à mão em teste novo; fake existente fica até o arquivo ser tocado.

- **Repository e datasource:** mock do `Dio` (ou do datasource) com `when(...).thenAnswer`; cubra sucesso, 404/403, erro de validação e falha de rede, conferindo o `Failure` devolvido.
- **Notifier / cubit:** mock do repository; confira a sequência de estados e que a ação não repete (`verify(...).called(1)`).
- **Widget:** mock do repository injetado (`ProviderScope(overrides:)` ou `get_it`); os quatro estados da tela.
- Registre `registerFallbackValue` para os tipos usados com `any()`.
- Não altere teste para passar: o teste descreve o comportamento do critério de pronto.

## Checklist da stack (o `pronto` cobra)

Montado com os defeitos que mais voltaram como `fix` nos dois apps.

**Sempre:**
- [ ] **Fidelidade ao Figma**, conferida contra o frame antes do commit: cor e preenchimento dos CTAs, posição dos controles, CTA fixo ou rolando com o conteúdo, alinhamento (topo × centro), espaçamentos, variante do componente do kit (`soft`, `overlay`…).
- [ ] **Quatro estados** da tela, inclusive erro de rede e lista vazia; 404/403 tratados.
- [ ] **Concorrência e ciclo de vida:** toque duplo, ação idempotente, retry que falha de novo, voltar no meio do envio; ação em várias etapas termina com a tela fechada ou bloqueia a saída; nada de `emit` depois de `close` nem `context` depois de `!mounted`.
- [ ] **Paginação:** fim em página vazia, falha na página seguinte sem loop, não recarrega ao voltar.
- [ ] **Sincronia com a API:** relê o recurso depois de salvar; PUT só quando algo mudou; DTO tolerante a campo ausente; datas em `toLocal()`.
- [ ] **Layout extremo:** tela baixa, texto grande, nome longo, sheet sobre a bottom nav, rótulo para leitor de tela.
- [ ] **Testes com `mocktail`** cobrindo o critério de pronto e os erros acima.
- [ ] Gate do repo verde.

**Quando o app ou a feature tem o recurso:**
- [ ] **Mídia e permissão:** negada e concedida depois (relê ao voltar das configurações); foto só no iCloud; arquivos temporários (compressão, foto reduzida) apagados.
- [ ] **l10n** (bencao): texto nos ARB dos 3 idiomas (pt, en, es); nada de texto literal.
- [ ] **Tema escuro** (bencao): os dois temas conferidos e o contraste.
- [ ] **Push** (bencao): listener não duplica; deep link abre a tela certa.
- [ ] **Anúncios:** template/muma só pelo `AdsService` do `matter_core`; bencao: ATT não concorre com o alerta de push.
- [ ] **Plataforma:** `PrivacyInfo.xcprivacy`, `CFBundleLocalizations`, `targetSdk`, permissões no `Info.plist`/`AndroidManifest`.

Item que não se aplica: diga por quê em uma linha.

## Doc no mesmo PR

- `docs/features/<feature>.md`: estado, telas, decisões locais e **link** para o contrato do back. Não copie payload.
- Decisão: skill `registrar-decisao` (detalhe de tela fica no doc da feature).
- Doc de feature passou de ~25 KB: quebre por sub-fluxo.
- Mudou tela: evidência visual no PR (print ou vídeo, claro e escuro quando houver).
