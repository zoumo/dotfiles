#!/bin/bash

PKG_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
# PKG_PATH is resolved at runtime so this works from any current directory.
# shellcheck disable=SC1091
source "${PKG_PATH}/../../../framework/oo-bootstrap.sh"

namespace skills
Log::AddOutput skills NOTE

if ! Command::Exists bunx; then
    Log "bunx is required to install agent skills"
    exit 1
fi

install_skills() {
    local source=$1
    shift

    Log "Installing agent skills from ${source}..."
    if ! bunx skills add "${source}" -g -y \
        --agent claude-code codex \
        --skill "$@"; then
        Log "Failed to install agent skills from ${source}"
        exit 1
    fi
}

# Create and maintain reusable agent skills.
install_skills anthropics/skills \
    skill-creator

# Build editable Excalidraw diagrams.
install_skills coleam00/excalidraw-diagram-skill \
    excalidraw-diagram

# Render Mermaid diagrams with presentation-ready themes.
install_skills imxv/pretty-mermaid-skills \
    pretty-mermaid

# Keep agent conversations, memory, and commits concise.
install_skills JuliusBrussee/caveman \
    caveman \
    caveman-commit \
    caveman-compress \
    caveman-help

# Cover codebase design, diagnosis, review, TDD, and delivery workflows.
install_skills mattpocock/skills \
    code-review \
    codebase-design \
    diagnosing-bugs \
    domain-modeling \
    grill-with-docs \
    grilling \
    handoff \
    implement \
    improve-codebase-architecture \
    prototype \
    research \
    resolving-merge-conflicts \
    setup-matt-pocock-skills \
    tdd \
    teach \
    to-spec \
    to-tickets \
    triage \
    wayfinder

# Operate Multica through its authenticated CLI.
install_skills multica-ai/multica-cli \
    multica-cli

# Review and build interfaces without generic AI styling.
install_skills nutlope/hallmark \
    hallmark

# Generate validated architecture and lifecycle diagrams.
install_skills tt-a1i/archify \
    archify

# Automate browser-based workflows from the command line.
install_skills vercel-labs/agent-browser \
    agent-browser

# Discover additional skills from the public ecosystem.
install_skills vercel-labs/skills \
    find-skills

# Create animated HTML presentations and convert slide decks.
install_skills zarazhangrui/frontend-slides \
    frontend-slides

Log "Agent skills installed for Claude Code and Codex"

exit 0
