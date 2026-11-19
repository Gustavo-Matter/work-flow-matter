#!/usr/bin/env bash
set -euo pipefail

usage() {
    printf 'Uso: %s <caminho-do-clone-do-upstream>\n' "$(basename "$0")"
}

die() {
    printf 'Erro: %s\n' "$*" >&2
    exit 1
}

if [ "$#" -ne 1 ]; then
    usage >&2
    exit 2
fi

UPSTREAM="$1"
if [ ! -d "$UPSTREAM" ]; then
    die "o clone do upstream não existe: $UPSTREAM"
fi
if ! git -C "$UPSTREAM" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    die "o caminho não é um clone Git: $UPSTREAM"
fi
UPSTREAM="$(git -C "$UPSTREAM" rev-parse --show-toplevel)"

# Uma tag exata impede que uma revisão local entre na cópia versionada.
if ! TAG="$(git -C "$UPSTREAM" describe --tags --exact-match 2>/dev/null)"; then
    die "o HEAD do upstream não está exatamente numa tag"
fi
# Clone sujo levaria mudança local ou cache para a cópia sob um SHA limpo.
if [ -n "$(git -C "$UPSTREAM" status --porcelain --ignored)" ]; then
    die "o clone do upstream tem mudança local ou arquivo não rastreado"
fi
SHA="$(git -C "$UPSTREAM" rev-parse HEAD)"
UPSTREAM_DATE="$(git -C "$UPSTREAM" show -s --format=%ad --date=short "$SHA")"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$SCRIPT_DIR"
REPO_ROOT="$(cd "$PLUGIN_DIR/../.." && pwd)"
SKILL_DIR="$PLUGIN_DIR/skills/app-store-compliance"
COMMAND_DIR="$PLUGIN_DIR/commands"

for path in \
    agent-os/skill/SKILL.md \
    agent-os/hooks/app-store-compliance-guard.sh \
    agent-os/commands/app-store-audit.md \
    .citation-allowlist \
    VERSION \
    LICENSE \
    NOTICE \
    docs \
    data \
    references \
    templates \
    scripts; do
    [ -e "$UPSTREAM/$path" ] || die "o upstream não tem o arquivo esperado: $path"
done

rm -rf "$SKILL_DIR" "$COMMAND_DIR"
mkdir -p "$SKILL_DIR/bin/guard" "$COMMAND_DIR"

cp "$UPSTREAM/agent-os/skill/SKILL.md" "$SKILL_DIR/SKILL.md"
cp "$UPSTREAM/.citation-allowlist" "$SKILL_DIR/.citation-allowlist"
cp "$UPSTREAM/VERSION" "$SKILL_DIR/VERSION"
for directory in docs data references templates scripts; do
    cp -R "$UPSTREAM/$directory" "$SKILL_DIR/$directory"
done
while IFS= read -r -d '' cache_dir; do
    rm -rf "$cache_dir"
done < <(find "$SKILL_DIR/scripts" -type d -name '__pycache__' -print0)

# Dois níveis abaixo da skill: o guard acha os scripts auxiliares em ../../scripts.
cp "$UPSTREAM/agent-os/hooks/app-store-compliance-guard.sh" \
    "$SKILL_DIR/bin/guard/app-store-compliance-guard.sh"
chmod +x "$SKILL_DIR/bin/guard/app-store-compliance-guard.sh"

cp "$UPSTREAM/agent-os/commands/app-store-audit.md" "$COMMAND_DIR/app-store-audit.md"
cp "$UPSTREAM/LICENSE" "$PLUGIN_DIR/LICENSE"
cp "$UPSTREAM/NOTICE" "$PLUGIN_DIR/NOTICE"

# A regra local evita que a auditoria tente usar segredos ou feeds externos.
cat >> "$SKILL_DIR/SKILL.md" <<'EOF'

## Escopo no plugin Matter

Este plugin não executa `scripts/pull-metadata.sh`, que exige token da Play ou chave `.p8` da Apple, nem `scripts/monitor.py` e os `scripts/monitor-*.py`, que consultam feeds na rede; ignore os passos que mandam rodá-los ou rascunhar PR. Use apenas o scan local e as referências locais. Não edite o app: devolva o plano de correção, que segue pelo workflow (`feature-front`).
EOF
cat >> "$COMMAND_DIR/app-store-audit.md" <<'EOF'

## Escopo no plugin Matter

Não execute `scripts/pull-metadata.sh`, que exige token da Play ou chave `.p8` da Apple, nem `scripts/monitor.py` e os `scripts/monitor-*.py`, que consultam feeds na rede; ignore os passos que mandam rodá-los ou rascunhar PR. Use apenas o scan local e as referências locais. Não edite o app: devolva o plano de correção, que segue pelo workflow (`feature-front`).
EOF

# O upstream usa o caminho da instalação global; o plugin usa a própria raiz.
while IFS= read -r -d '' file; do
    perl -pi -e 's{\Q~/.claude/hooks/app-store-compliance-guard.sh\E}{\${CLAUDE_PLUGIN_ROOT}/skills/app-store-compliance/bin/guard/app-store-compliance-guard.sh}g; s{\Q~/.claude/skills/app-store-compliance\E}{\${CLAUDE_PLUGIN_ROOT}/skills/app-store-compliance}g' "$file"
done < <(find "$SKILL_DIR" "$COMMAND_DIR" -type f -name '*.md' -print0)

cat > "$PLUGIN_DIR/UPSTREAM.md" <<EOF
# Upstream — app-store-compliance

- Repositório de origem: [mjmirza/app-store-compliance](https://github.com/mjmirza/app-store-compliance)
- Tag: \`$TAG\`
- SHA: \`$SHA\`
- Data do commit: $UPSTREAM_DATE

## Licença

OpenRoots Agent License 2.3 (ORA 2.3): gratuita para empresas com faturamento anual de até US\$ 20 milhões. A aplicabilidade e a decisão de uso estão na [ADR-0014](../../docs/adr/0014-auditoria-de-loja-por-plugin-sem-hook.md).

## Trocas aplicadas pelo sync

No upstream, o diretório pessoal aparece como \`~\`; abaixo, \`<home>\` o representa.

- \`<home>/.claude/hooks/app-store-compliance-guard.sh\` → \`\${CLAUDE_PLUGIN_ROOT}/skills/app-store-compliance/bin/guard/app-store-compliance-guard.sh\`
- \`<home>/.claude/skills/app-store-compliance\` → \`\${CLAUDE_PLUGIN_ROOT}/skills/app-store-compliance\`

O script também acrescenta à skill e ao comando a regra de não executar \`pull-metadata.sh\` nem \`monitor.py\` e \`monitor-*.py\` e de não editar o app.

## Para atualizar

Para atualizar: clone o upstream na tag nova, leia o diff, rode o script, suba a \`version\` do \`plugin.json\` e o SHA do \`store-compliance.yml\` dos apps.
EOF

if grep -rn --include='*.md' '~/.claude' \
    "$REPO_ROOT/plugins/matter-loja/skills" "$REPO_ROOT/plugins/matter-loja/commands"; then
    die "a cópia ainda contém caminho de instalação global"
fi

printf 'Tag: %s\nSHA: %s\n' "$TAG" "$SHA"
