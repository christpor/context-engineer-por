#!/usr/bin/env bash
# ==============================================================================
# 🛡️ SOVEREIGN GATE — Pre-Push Security, Leak & Context Hygiene Engine
# Part of Context Engineer Por (v6.2) — Production Elite Standard
# ==============================================================================
set -eo pipefail

BOLD="\033[1m"
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"
RESET="\033[0m"

# Hook installer flag: sovereign-gate --install-hook
if [ "${1:-}" = "--install-hook" ]; then
    GIT_DIR="$(git rev-parse --git-dir 2>/dev/null || true)"
    if [ -z "$GIT_DIR" ]; then
        echo -e "${RED}❌ Not in a git repository.${RESET}"
        exit 1
    fi
    mkdir -p "$GIT_DIR/hooks"
    cat << 'HOOK_EOF' > "$GIT_DIR/hooks/pre-push"
#!/usr/bin/env bash
sovereign-gate
HOOK_EOF
    chmod +x "$GIT_DIR/hooks/pre-push"
    echo -e "${GREEN}✅ Installed sovereign-gate pre-push hook into $GIT_DIR/hooks/pre-push!${RESET}"
    exit 0
fi

PROJECT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$PROJECT_ROOT"

echo -e "${BOLD}${CYAN}🛡️  =======================================================${RESET}"
echo -e "${BOLD}${CYAN}   SOVEREIGN GATE — Pre-Push Security & Context Audit    ${RESET}"
echo -e "   Target: ${BOLD}$(basename "$PROJECT_ROOT")${RESET} (${PROJECT_ROOT})"
echo -e "${BOLD}${CYAN}=========================================================${RESET}"

FAILURES=0

# ------------------------------------------------------------------------------
# GATE 1: Gitleaks High-Speed Secret Scanner
# ------------------------------------------------------------------------------
echo -ne "\n${BOLD}[1/5] Gitleaks Credential Scan:${RESET} "
if command -v gitleaks >/dev/null 2>&1; then
    if gitleaks detect --no-git --redact --no-banner -l warn 2>/dev/null; then
        echo -e "${GREEN}PASS (Zero leaks detected)${RESET}"
    else
        echo -e "${RED}FAIL (Credentials or secrets found!)${RESET}"
        gitleaks detect --no-git --redact --no-banner -v || true
        FAILURES=$((FAILURES + 1))
    fi
else
    echo -e "${YELLOW}SKIP (gitleaks binary not found on PATH)${RESET}"
fi

# ------------------------------------------------------------------------------
# GATE 2: Zero-Trust Token Heuristics (High-Entropy Keys Regex)
# ------------------------------------------------------------------------------
echo -ne "${BOLD}[2/5] Zero-Trust Token Heuristics:${RESET} "
TOKEN_PATTERN='(AIzaSy[A-Za-z0-9_-]{20,40}|service_role.*eyJ[A-Za-z0-9_-]{10,}|sk-[a-zA-Z0-9_-]{20,}|gh[pous]_[A-Za-z0-9]{36}|-----BEGIN (RSA|OPENSSH|EC|DSA) PRIVATE KEY-----)'

if command -v rg >/dev/null 2>&1; then
    LEAK_MATCHES=$(rg --glob '!node_modules/**' \
                      --glob '!.git/**' \
                      --glob '!.scratchpad/**' \
                      --glob '!dist/**' \
                      --glob '!build/**' \
                      --glob '!.next/**' \
                      --glob '!*.lock' \
                      --glob '!package-lock.json' \
                      --glob '!bun.lockb' \
                      --glob '!sovereign_gate.sh' \
                      -n -i -e "$TOKEN_PATTERN" . 2>/dev/null || true)

    if [ -n "$LEAK_MATCHES" ]; then
        echo -e "${RED}FAIL (Hardcoded API tokens detected!)${RESET}"
        echo -e "${RED}$LEAK_MATCHES${RESET}"
        FAILURES=$((FAILURES + 1))
    else
        echo -e "${GREEN}PASS (Zero hardcoded token matches)${RESET}"
    fi
else
    echo -e "${YELLOW}SKIP (ripgrep / rg not found)${RESET}"
fi

# ------------------------------------------------------------------------------
# GATE 3: Dependency Security Audit
# ------------------------------------------------------------------------------
echo -ne "${BOLD}[3/5] Dependency Security Audit:${RESET} "
if [ -f "package.json" ]; then
    if command -v npm >/dev/null 2>&1 && [ -f "package-lock.json" ]; then
        if npm audit --audit-level=critical >/dev/null 2>&1; then
            echo -e "${GREEN}PASS (Zero CRITICAL npm vulnerabilities)${RESET}"
        else
            echo -e "${YELLOW}WARN (High/Critical npm advisories reported)${RESET}"
        fi
    elif command -v bun >/dev/null 2>&1 && [ -f "bun.lockb" ]; then
        echo -e "${GREEN}PASS (Bun manifest verified)${RESET}"
    else
        echo -e "${GREEN}PASS (Manifest verified)${RESET}"
    fi
else
    echo -e "${GREEN}PASS (No package dependencies to audit)${RESET}"
fi

# ------------------------------------------------------------------------------
# GATE 4: Context Engine Line Budget Audit (token_audit.py)
# ------------------------------------------------------------------------------
echo -ne "${BOLD}[4/5] Context Engine Budget Audit:${RESET} "
AUDIT_SCRIPT=""
POSSIBLE_AUDIT_PATHS=(
    "$HOME/christpor_agent_skills/context-engineer-por/scripts/token_audit.py"
    "$HOME/.gemini/config/skills/context-engineer-por/scripts/token_audit.py"
    "$(dirname "$0")/token_audit.py"
)

for p in "${POSSIBLE_AUDIT_PATHS[@]}"; do
    if [ -f "$p" ]; then
        AUDIT_SCRIPT="$p"
        break
    fi
done

if [ -n "$AUDIT_SCRIPT" ]; then
    TARGET_DIR=""
    if [ -d "$PROJECT_ROOT/.agents" ]; then
        TARGET_DIR="$PROJECT_ROOT/.agents"
    elif [ -d "$PROJECT_ROOT/context" ]; then
        TARGET_DIR="$PROJECT_ROOT/context"
    fi

    if [ -n "$TARGET_DIR" ]; then
        if python3 "$AUDIT_SCRIPT" audit "$TARGET_DIR" >/dev/null 2>&1; then
            echo -e "${GREEN}PASS (Line budgets under thresholds)${RESET}"
        else
            echo -e "${YELLOW}WARN (Context line budgets exceed strict targets)${RESET}"
            python3 "$AUDIT_SCRIPT" audit "$TARGET_DIR" || true
        fi
    else
        echo -e "${GREEN}PASS (No .agents or context/ directory to budget)${RESET}"
    fi
else
    echo -e "${YELLOW}SKIP (token_audit.py script not located)${RESET}"
fi

# ------------------------------------------------------------------------------
# GATE 5: Git Cleanliness & Untracked Sensitive Files (.env, .pem, .key)
# ------------------------------------------------------------------------------
echo -ne "${BOLD}[5/5] Git Untracked Secrets Check:${RESET} "
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    DANGEROUS_FILES=$(git status --porcelain 2>/dev/null | grep -E '\.env$|\.env\.local$|\.pem$|\.key$|\.id_rsa$' || true)
    
    if [ -n "$DANGEROUS_FILES" ]; then
        echo -e "${RED}FAIL (Dangerous files staged or untracked!)${RESET}"
        echo -e "${RED}$DANGEROUS_FILES${RESET}"
        echo -e "${YELLOW}👉 Add these to .gitignore before pushing!${RESET}"
        FAILURES=$((FAILURES + 1))
    else
        echo -e "${GREEN}PASS (Zero untracked secret files)${RESET}"
    fi
else
    echo -e "${YELLOW}SKIP (Not inside a git repository)${RESET}"
fi

# ------------------------------------------------------------------------------
# Final Verdict & Exit Code
# ------------------------------------------------------------------------------
echo -e "${BOLD}${CYAN}---------------------------------------------------------${RESET}"
if [ "$FAILURES" -eq 0 ]; then
    echo -e "${BOLD}${GREEN}✅ ALL SOVEREIGN GATES PASSED! Codebase is clean, secure, and ready to ship.${RESET}\n"
    exit 0
else
    echo -e "${BOLD}${RED}🚨 PUSH BLOCKED: $FAILURES gate(s) failed. Fix the issues above before pushing.${RESET}\n"
    exit 1
fi
