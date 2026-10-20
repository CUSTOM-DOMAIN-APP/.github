#!/usr/bin/env bash
# Apply the CustomDomain™ organization's GitHub metadata: the org profile name and
# description, and every public repository's description, homepage and topics.
#
# Why: GitHub repository search matches only a repository's name, description and
# topics (the README only with `in:readme`). Topics match as whole hyphenated
# tokens, and a search phrase has to appear in plain words in the description.
# Descriptions here are keyword-led and open with a full sentence; each is at most
# 350 characters and each repository has at most 20 topics, all [a-z0-9-].
#
# Idempotent: descriptions and homepages are set, and topics are replaced as a
# whole (PUT), so running it twice changes nothing and stale topics such as
# `active` are dropped. It renames nothing (see the commented block at the end).
#
# Needs: gh, authenticated as an organization owner (repo admin on every
# repository and admin:org for the profile).
#
# Usage:
#   scripts/apply-repo-settings.sh            # apply
#   scripts/apply-repo-settings.sh --dry-run  # print what would be sent, change nothing
set -euo pipefail
export LC_ALL=C.UTF-8

ORG="CUSTOM-DOMAIN-APP"
DRY_RUN=0
if [[ "${1:-}" == "--dry-run" ]]; then DRY_RUN=1; fi

die() { echo "error: $*" >&2; exit 1; }

check_description() {
  local repo="$1" desc="$2"
  (( ${#desc} <= 350 )) || die "$repo: description is ${#desc} characters, more than 350"
  [[ "$desc" == *"."* ]] || die "$repo: description should open with a full sentence"
}

check_topics() {
  local repo="$1"; shift
  (( $# <= 20 )) || die "$repo: $# topics, more than 20"
  local t
  for t in "$@"; do
    [[ "$t" =~ ^[a-z0-9][a-z0-9-]{0,49}$ ]] || die "$repo: invalid topic '$t'"
    [[ "$t" != "active" ]] || die "$repo: drop the 'active' topic"
  done
}

topics_json() {
  local out="" t
  for t in "$@"; do out+="${out:+,}\"$t\""; done
  printf '{"names":[%s]}' "$out"
}

apply_repo() {
  local repo="$1" homepage="$2" desc="$3"; shift 3
  check_description "$repo" "$desc"
  check_topics "$repo" "$@"
  if (( DRY_RUN )); then
    printf '\n%s (%d characters, %d topics)\n  homepage: %s\n  description: %s\n  topics: %s\n' \
      "$repo" "${#desc}" "$#" "$homepage" "$desc" "$*"
    return
  fi
  gh repo edit "$ORG/$repo" --description "$desc" --homepage "$homepage"
  topics_json "$@" | gh api --method PUT "repos/$ORG/$repo/topics" --input - > /dev/null
  echo "updated $ORG/$repo"
}

if (( ! DRY_RUN )); then
  command -v gh > /dev/null || die "gh is not installed"
  gh auth status > /dev/null 2>&1 || die "gh is not authenticated (run gh auth login)"
fi

# --- Organization profile -------------------------------------------------------

ORG_NAME="CustomDomain™"
ORG_DESCRIPTION="Custom domains for SaaS: your users connect their own domain, with DNS, verification and SSL handled. Widget, SDK, REST API and MCP server."
(( ${#ORG_DESCRIPTION} <= 160 )) || die "org description is ${#ORG_DESCRIPTION} characters, more than 160"
if (( DRY_RUN )); then
  printf 'org %s\n  name: %s\n  description (%d characters): %s\n  blog: https://customdomain.ai\n' \
    "$ORG" "$ORG_NAME" "${#ORG_DESCRIPTION}" "$ORG_DESCRIPTION"
else
  gh api --method PATCH "orgs/$ORG" \
    -f name="$ORG_NAME" -f description="$ORG_DESCRIPTION" -f blog="https://customdomain.ai" > /dev/null
  echo "updated org $ORG"
fi

# --- Repositories ---------------------------------------------------------------
# apply_repo <repository> <homepage> <description> <topic>...

apply_repo customdomain-mcp "https://customdomain.ai/mcp-server" \
  "Custom domain MCP server for AI agents: search for a domain, connect it to an app with DNS records written for you where the provider allows, verify it and issue HTTPS. Remote endpoint mcp.customdomain.ai/mcp for Claude, Cursor, VS Code and GitHub Copilot. The official CustomDomain™ product server, ai.customdomain/mcp." \
  mcp mcp-server model-context-protocol remote-mcp-server ai-agents agentic-ai claude cursor vscode github-copilot \
  custom-domains custom-domain domains domain-registration dns dns-mcp domain-mcp ssl tls customdomain

apply_repo customdomain-sdk "https://docs.customdomain.ai/docs/widget-sdk/overview" \
  "Custom domains SDK for SaaS: an embeddable widget and React component that let your users connect their own domain, with DNS records written for them where the provider allows, ownership verified and SSL issued. JavaScript and TypeScript, on npm as customdomain-js and @customdomain/react. An Entri alternative with a white-label connect flow." \
  custom-domains custom-domain byod dns dns-automation domain-verification domain-connect white-label multi-tenant saas \
  widget react react-component typescript javascript sdk ssl tls entri-alternative customdomain

apply_repo docs "https://docs.customdomain.ai/docs" \
  "Custom domains documentation for CustomDomain™: connect your users' own domains with the widget, SDK, REST API or MCP server, with DNS records, verification and SSL handled. The source of docs.customdomain.ai, with guides to DNS records, root domains, email authentication and TLS." \
  documentation custom-domains custom-domain dns dns-records domain-verification ssl tls acme rest-api \
  api-reference openapi mcp-server widget saas multi-tenant fumadocs mdx customdomain

apply_repo awesome-custom-domains "https://customdomain.ai/custom-domains-for-saas" \
  "Awesome list of custom domain tools for SaaS: managed services, DIY building blocks such as Caddy on-demand TLS and cert-manager, ACME clients, DNS provider APIs, Domain Connect, MCP servers and diagnostics for letting your users connect their own domain." \
  awesome awesome-list curated-list custom-domains custom-domain custom-hostname on-demand-tls multi-tenant multi-tenancy saas \
  dns dns-automation domain-connect acme letsencrypt caddy ssl tls white-label cloudflare-for-saas

apply_repo custom-domain-checks "https://customdomain.ai/custom-domains-for-saas" \
  "DNS and SSL health checks for GitHub Pages custom domains: a GitHub Action and a GitHub App that check DNS records, the CNAME or apex target, domain verification, CAA, certificate expiry and HTTPS enforcement, and flag a broken domain. By CustomDomain™." \
  github-app github-actions github-pages custom-domain custom-domains dns dns-check dns-monitoring ssl ssl-certificate \
  ssl-monitoring certificate-monitoring tls caa cname subdomain-takeover domain-health monitoring checks-api customdomain

apply_repo connect-domain-for-website-builders "https://customdomain.ai/for/site-builders" \
  "Custom domains for website builders: how site builders and no-code platforms let users connect their own domain, with CNAME and root records, ownership verification and automatic SSL, plus Next.js on Vercel, Caddy on-demand TLS and Cloudflare for SaaS compared. A CustomDomain™ field guide." \
  custom-domains custom-domain website-builder site-builder no-code multi-tenant saas dns cname apex-domain \
  domain-verification ssl tls on-demand-tls caddy nextjs vercel cloudflare-for-saas white-label customdomain

apply_repo connect-domain-for-email-platforms "https://docs.customdomain.ai/docs/dns/email-dns" \
  "Custom sending domains for email platforms: SPF, DKIM, DMARC, MX and return-path records for Amazon SES, SendGrid, Postmark and Resend, and how to get them into a customer's DNS automatically. A CustomDomain™ field guide." \
  custom-domains sending-domain email email-deliverability email-authentication spf dkim dmarc mx-records return-path \
  dns amazon-ses sendgrid postmark resend transactional-email saas customdomain

apply_repo connect-domain-for-ai-agents "https://customdomain.ai/for/ai-agents" \
  "Custom domains for AI agents: give an agent a real domain through a hosted MCP server and REST API that search for a domain, connect it to an app and issue HTTPS, with setup for Claude, Cursor, VS Code and GitHub Copilot. A CustomDomain™ field guide." \
  ai-agents agentic-ai mcp mcp-server model-context-protocol claude cursor vscode github-copilot custom-domains \
  custom-domain domains dns dns-automation rest-api ssl tls customdomain

apply_repo connect-domain-for-agencies "https://customdomain.ai/for/agencies-white-label" \
  "Custom domains for agencies: connect client domains to the sites you host under your own brand, without collecting registrar logins, with DNS, ownership verification and SSL handled. A CustomDomain™ field guide." \
  agency agencies client-domains custom-domains custom-domain white-label reseller dns dns-automation domain-verification \
  domain-management ssl tls godaddy cloudflare saas customdomain

apply_repo customdomain-brand-kit "https://customdomain.ai/brand" \
  "CustomDomain™ brand kit: the name rule, the oak mark, the stone color tokens and the type behind customdomain.ai, for anyone writing or designing for the product." \
  brand-guidelines brand-kit brand-identity design-system design-tokens logo typography color-palette customdomain

apply_repo .github "https://customdomain.ai" \
  "CustomDomain™ organization profile: custom domains for SaaS, where your users connect their own domain with DNS records, verification and SSL handled. The widget, SDK, REST API and MCP server, and the community health files every repository here inherits." \
  custom-domains custom-domain customdomain saas multi-tenant dns dns-automation domain-verification ssl tls \
  white-label widget rest-api mcp-server organization-profile

# --- Optional: repository renames (not applied) ---------------------------------
# Renaming a guide to lead with its searched phrase would put that phrase in the
# repository name, which repository search weighs most. It is an owner decision,
# not a metadata tweak: a rename changes every URL, GitHub's redirect from the old
# name lasts only until another repository takes it, and links in READMEs, the org
# profile, the docs and the product, plus anyone's git remote, should be updated.
# Uncomment only after that decision.
#
# gh repo rename custom-domains-for-website-builders --repo "$ORG/connect-domain-for-website-builders" --yes
# gh repo rename custom-sending-domains-for-email-platforms --repo "$ORG/connect-domain-for-email-platforms" --yes
# gh repo rename custom-domains-for-ai-agents --repo "$ORG/connect-domain-for-ai-agents" --yes
# gh repo rename custom-domains-for-agencies --repo "$ORG/connect-domain-for-agencies" --yes
