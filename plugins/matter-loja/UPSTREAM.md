# Upstream — app-store-compliance

- Repositório de origem: [mjmirza/app-store-compliance](https://github.com/mjmirza/app-store-compliance)
- Tag: `v2.4.0`
- SHA: `d2156bab9d7189835631c0a99adcc2479d32138d`
- Data do commit: 2026-11-15

## Licença

OpenRoots Agent License 2.3 (ORA 2.3): gratuita para empresas com faturamento anual de até US$ 20 milhões. A aplicabilidade e a decisão de uso estão na [ADR-0014](../../docs/adr/0014-auditoria-de-loja-por-plugin-sem-hook.md).

## Trocas aplicadas pelo sync

No upstream, o diretório pessoal aparece como `~`; abaixo, `<home>` o representa.

- `<home>/.claude/hooks/app-store-compliance-guard.sh` → `${CLAUDE_PLUGIN_ROOT}/skills/app-store-compliance/bin/guard/app-store-compliance-guard.sh`
- `<home>/.claude/skills/app-store-compliance` → `${CLAUDE_PLUGIN_ROOT}/skills/app-store-compliance`

O script também acrescenta à skill e ao comando a regra de não executar `pull-metadata.sh` nem `monitor.py` e `monitor-*.py` e de não editar o app.

## Para atualizar

Para atualizar: clone o upstream na tag nova, leia o diff, rode o script, suba a `version` do `plugin.json` e o SHA do `store-compliance.yml` dos apps.
