#!/usr/bin/env bash
set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_SRC="${SCRIPT_DIR}/bin/kitty-tips"
BIN_DEST="${HOME}/.local/bin/kitty-tips"

echo -e "${CYAN}${BOLD}Installing kitty-tips...${RESET}"
echo

# Check source exists
if [[ ! -f "${BIN_SRC}" ]]; then
    echo -e "${RED}Error: bin/kitty-tips not found. Are you in the kitty-tips directory?${RESET}"
    exit 1
fi

# Create bin directory
mkdir -p "${HOME}/.local/bin"

# Copy binary
cp "${BIN_SRC}" "${BIN_DEST}"
chmod +x "${BIN_DEST}"
echo -e "  ${GREEN}✓${RESET} Installed binary to ${BIN_DEST}"

# Detect shell and install completions
install_fish_completions() {
    local dest="${HOME}/.config/fish/completions/kitty-tips.fish"
    local src="${SCRIPT_DIR}/completions/kitty-tips.fish"
    if [[ -f "${src}" ]]; then
        mkdir -p "$(dirname "${dest}")"
        cp "${src}" "${dest}"
        echo -e "  ${GREEN}✓${RESET} Installed Fish completions"
    fi
}

install_bash_completions() {
    local dest="${HOME}/.local/share/bash-completion/completions/kitty-tips"
    local src="${SCRIPT_DIR}/completions/kitty-tips.bash"
    if [[ -f "${src}" ]]; then
        mkdir -p "$(dirname "${dest}")"
        cp "${src}" "${dest}"
        echo -e "  ${GREEN}✓${RESET} Installed Bash completions"
    fi
}

install_zsh_completions() {
    local src="${SCRIPT_DIR}/completions/_kitty-tips"
    if [[ -f "${src}" ]]; then
        # Try common zsh completion directories
        local zsh_dirs=(
            "${HOME}/.zsh/completions"
            "${HOME}/.local/share/zsh/site-functions"
            "/usr/local/share/zsh/site-functions"
        )
        for dir in "${zsh_dirs[@]}"; do
            if [[ -d "${dir}" ]] && [[ -w "${dir}" ]]; then
                cp "${src}" "${dir}/_kitty-tips"
                echo -e "  ${GREEN}✓${RESET} Installed Zsh completions to ${dir}"
                return
            fi
        done
        # Create default directory
        mkdir -p "${HOME}/.zsh/completions"
        cp "${src}" "${HOME}/.zsh/completions/_kitty-tips"
        echo -e "  ${GREEN}✓${RESET} Installed Zsh completions to ~/.zsh/completions"
        echo -e "  ${YELLOW}!${RESET} Make sure ${HOME}/.zsh/completions is in your fpath"
    fi
}

# Detect current shell
CURRENT_SHELL="$(basename "${SHELL:-bash}")"

case "${CURRENT_SHELL}" in
    fish)
        install_fish_completions
        ;;
    bash)
        install_bash_completions
        ;;
    zsh)
        install_zsh_completions
        ;;
    *)
        echo -e "  ${YELLOW}!${RESET} Unknown shell '${CURRENT_SHELL}', skipping completions"
        echo -e "    You can manually copy completions from the completions/ directory"
        ;;
esac

# Also install completions for other detected shells
if [[ "${CURRENT_SHELL}" != "fish" ]] && command -v fish &>/dev/null; then
    install_fish_completions
fi
if [[ "${CURRENT_SHELL}" != "bash" ]] && [[ -d "${HOME}/.local/share/bash-completion" ]]; then
    install_bash_completions
fi
if [[ "${CURRENT_SHELL}" != "zsh" ]] && command -v zsh &>/dev/null; then
    install_zsh_completions
fi

# Check PATH
echo
if echo "${PATH}" | tr ':' '\n' | grep -q "${HOME}/.local/bin"; then
    echo -e "  ${GREEN}✓${RESET} ~/.local/bin is in your PATH"
else
    echo -e "  ${YELLOW}!${RESET} ~/.local/bin is not in your PATH"
    echo -e "    Add it to your shell config:"
    case "${CURRENT_SHELL}" in
        fish)
            echo -e "    ${CYAN}fish_add_path ~/.local/bin${RESET}"
            ;;
        bash)
            echo -e "    ${CYAN}echo 'export PATH=\"\$HOME/.local/bin:\$PATH\"' >> ~/.bashrc${RESET}"
            ;;
        zsh)
            echo -e "    ${CYAN}echo 'export PATH=\"\$HOME/.local/bin:\$PATH\"' >> ~/.zshrc${RESET}"
            ;;
    esac
fi

echo
echo -e "${GREEN}${BOLD}Installation complete!${RESET}"
echo
echo -e "  Try it out:"
echo -e "    ${CYAN}kitty-tips${RESET}          Show a random tip"
echo -e "    ${CYAN}kitty-tips daily${RESET}    Tip of the day"
echo -e "    ${CYAN}kitty-tips --help${RESET}   See all commands"
echo
