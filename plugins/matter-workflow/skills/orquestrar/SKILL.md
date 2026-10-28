---
name: orquestrar
description: Use (no Opus) para executar um plano ou uma sub-issue delegando a modelos mais baratos — escolher o executor, escrever o brief, disparar no OpenCode (modelos gratuitos da OpenRouter) ou num subagente Haiku/Sonnet, e revisar o resultado antes do commit.
---

# orquestrar

O Opus pensa e revisa; quem digita é o modelo mais barato que dá conta. **Quem orquestra é sempre o agente que fez o planejamento da tarefa** (`planejar-feature`): ele dispara, revisa e escala até o fim, e não delega a orquestração a outro agente nem a um executor. Tabela de papéis e limites: `docs/modelos.md` do work-flow-matter (`$MATTER_HOME/work-flow-matter`).

## 1. Escolha o executor

**Sempre comece pelo gratuito.** Só sobe para o Haiku (e dele para o Sonnet) por um destes motivos, **registrado na sub-issue**: duas tentativas sem passar no gate ou na revisão; limites gratuitos do dia esgotados (OpenRouter e o do próprio OpenCode); segredo, `.env` ou dado de usuário; ferramenta que o OpenCode não tem (Linear).
- Desenho, contrato novo, ADR com trade-off, mudança de arquitetura: Opus faz.
- Código ou teste com brief fechado: gratuito.
- Linear: agente `linear-haiku` (exceção: o OpenCode não tem o Linear). Doc: gratuito.
- Envolve segredo, `.env` ou dado de usuário: **nunca** gratuito.
- Registre o executor na sub-issue do Linear (`Executor: <modelo>`) e, se não for o gratuito, o motivo (`Motivo: <qual>`).

## 2. Escreva o brief

Sem brief, não se delega. O executor não viu esta conversa.

```
## Objetivo
<o resultado, em uma ou duas frases>

## Contexto
- Repo e worktree: <caminho>
- Leia antes: <CLAUDE.md, doc do módulo, ADRs que se aplicam — caminhos exatos>
- Siga como modelo: <arquivo existente que já faz algo parecido>

## Regras que não podem ser quebradas
<decisões e ADRs aceitos, camadas, envelope, design system; comentário no código só com o porquê, 1 a 2 linhas>

## Faça
<passos, arquivos a criar/alterar>

## Não faça
<o que está fora do escopo; não crie arquivos fora da lista; não altere testes para passar>

## Pronto quando
<critério verificável + o comando do gate>

## Responda com
<lista dos arquivos alterados e uma linha por mudança>
```

**Brief de tela** (ADR-0013): antes de delegar, leia o frame com `figma:figma-design-to-code` e acrescente ao brief:
- `## Spec do Figma`: tabela peça → cor (token), tamanho, espaçamento, raio, sombra, tipografia, alinhamento; os textos exatos; os node-ids;
- as micro-animações esperadas;
- `Pronto quando` com "screenshot do simulador igual ao frame".

O executor gratuito não lê o Figma: tudo o que ele precisa está na tabela.

Brief longo é sinal de tarefa grande: quebre antes. Tela com mais de ~6 blocos, ou mais de uma página, vira uma sub-issue por parte, com executores em paralelo (worktrees separados, arquivos que não se cruzam).

## 3. Dispare

**Gratuito (OpenCode v2):** exige o OpenCode **v2** (`npm i -g @opencode/cli`; o pacote antigo `opencode-ai` é a 1.x e não tem `--standalone`). Grave o brief num arquivo e rode no worktree da tarefa. A chave vem da variável `OPENROUTER_API_KEY` do usuário (no Mac, no `~/.zshrc`); se ela não existir, do `.env` na raiz do work-flow-matter (`$MATTER_HOME`, padrão `~/Documents/matter` no Mac e `C:\Matter` no Windows). Nunca imprima a chave.

macOS / Linux:

```bash
MATTER_HOME="${MATTER_HOME:-$HOME/Documents/matter}"
[ -n "$OPENROUTER_API_KEY" ] || export OPENROUTER_API_KEY="$(sed -n 's/^OPENROUTER_API_KEY=//p' "$MATTER_HOME/work-flow-matter/.env")"
cd "$MATTER_HOME/.worktrees/<worktree>"
opencode run --standalone --auto --model 'openrouter/poolside/laguna-s-2.1:free' -f <brief.md> 'Execute a tarefa do arquivo anexo.'
```

Windows (PowerShell):

```powershell
$home_ = if ($env:MATTER_HOME) { $env:MATTER_HOME } else { 'C:\Matter' }
if (-not $env:OPENROUTER_API_KEY) { $env:OPENROUTER_API_KEY = ((Get-Content "$home_\work-flow-matter\.env" | Where-Object { $_ -match '^OPENROUTER_API_KEY=' }) -split '=', 2)[1] }
Set-Location "$home_\.worktrees\<worktree>"
opencode run --standalone --auto --model 'openrouter/poolside/laguna-s-2.1:free' -f <brief.md> 'Execute a tarefa do arquivo anexo.'
```

O `--auto` aprova tudo que não estiver negado, inclusive ler `.env`: nunca rode o gratuito num worktree com segredo em arquivo. A chave guardada por `opencode auth login` não funcionou com `run` na v2.0.31 (16/10/2026); use a variável.

Rode em segundo plano quando passar de ~2 minutos. Limite: 50 requisições/dia sem créditos; cada passo do agente gasta uma. Esgotou? O OpenCode também tem modelos gratuitos próprios (`opencode models`, prefixos `opencode/` e `opencode-go/`) com limite à parte: veja `docs/modelos.md` antes de subir para o Haiku.

**Haiku/Sonnet:** ferramenta Agent com `model: "haiku"` ou `"sonnet"` e o brief como prompt, ou os agentes `linear-haiku` e `docs-haiku`.

**Teste de fumaça de um modelo gratuito novo:** um arquivo descartável com um bug de uma linha, fora de qualquer repo; anote requisições e tempo em `docs/modelos.md`. Rode com limite de tempo (`perl -e 'alarm 120; exec @ARGV' opencode run ...`; o macOS não tem `timeout`): um modelo que não responde fica pendurado para sempre.

## 4. Revise (sempre no Opus)

1. `git diff` do worktree: só os arquivos do brief mudaram?
2. Gate do repo (skill `pronto`). Tela: compare o screenshot do simulador com o do frame antes de seguir.
3. Agente `revisor` no diff.
4. Passou: commit (skill `pronto`). Não passou: devolva ao mesmo executor com o erro exato **uma vez**; falhou de novo, suba um degrau com o brief corrigido.

Nunca commite trabalho de outro modelo sem esta revisão.
