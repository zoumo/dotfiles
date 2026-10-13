#!/bin/bash

PKG_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
# PKG_PATH is resolved at runtime so this works from any current directory.
# shellcheck disable=SC1091
source "${PKG_PATH}/../../../framework/oo-bootstrap.sh"

namespace skills
Log::AddOutput skills NOTE

install_skills_manager_cli() {
    local install_root="$HOME/.skills-manager"
    local binary="${install_root}/bin/skills-manager-cli"
    local platform arch download_file

    if Command::Exists skills-manager-cli || [[ -x "${binary}" ]]; then
        Log "skills-manager-cli already installed, skipping"
        return 0
    fi

    if Command::Exists cargo && Command::Exists rustc &&
        cargo --version >/dev/null 2>&1 && rustc --version >/dev/null 2>&1; then
        Log "Building skills-manager-cli with Cargo..."
        cargo install --git https://github.com/xingkongliang/skills-manager \
            --bin skills-manager-cli --locked --root "${install_root}" || return 1
    else
        if os::macos; then
            platform=macOS
        elif [[ "$(uname -s)" == Linux ]]; then
            platform=Linux
        else
            Log "Unsupported OS for skills-manager-cli: $(uname -s)"
            return 1
        fi
        arch=$(OS::Arch)
        case "${arch}" in
            arm64) ;;
            amd64) arch=x64 ;;
            *) Log "Unsupported architecture for skills-manager-cli: ${arch}"; return 1 ;;
        esac

        Log "Downloading skills-manager-cli for ${platform}-${arch}..."
        mkdir -p "${install_root}/bin" || return 1
        download_file=$(mktemp "${install_root}/bin/.skills-manager-cli.XXXXXX") || return 1
        if ! curl --fail --location --retry 3 \
            "https://gh-proxy.org/https://github.com/xingkongliang/skills-manager/releases/latest/download/skills-manager-cli-${platform}-${arch}" \
            --output "${download_file}" ||
            ! chmod +x "${download_file}" ||
            ! "${download_file}" --version ||
            ! mv -f "${download_file}" "${binary}"; then
            rm -f "${download_file}"
            Log "Failed to install skills-manager-cli"
            return 1
        fi
    fi

    "${binary}" --version || return 1
    Log "skills-manager-cli installed at ${binary}"
}

install_skills_manager_cli || exit 1

SKILLS_MANAGER_CLI="$HOME/.skills-manager/bin/skills-manager-cli"
if [[ ! -x "${SKILLS_MANAGER_CLI}" ]]; then
    SKILLS_MANAGER_CLI=$(command -v skills-manager-cli) || exit 1
fi

install_skills() {
    local source=$1
    local skill
    shift

    Log "Installing agent skills from ${source}..."
    for skill in "$@"; do
        if "${SKILLS_MANAGER_CLI}" skills status "${skill}" >/dev/null 2>&1; then
            Log "${skill} already in the library, skipping install"
            continue
        fi
        if ! "${SKILLS_MANAGER_CLI}" skills install "${source}@${skill}"; then
            Log "Failed to install ${skill} from ${source}"
            exit 1
        fi
    done

    if ! "${SKILLS_MANAGER_CLI}" skills deploy "$@" \
        --agent claude_code --agent codex; then
        Log "Failed to deploy agent skills from ${source}"
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

# Write clear technical English using ASD-STE100.
install_skills danyuchn/asd-ste100-skill \
    asd-ste100

Log "Agent skills installed for Claude Code and Codex"

exit 0
