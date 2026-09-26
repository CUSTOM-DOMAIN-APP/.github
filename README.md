# CustomDomain™: the organization home

The front door to the CustomDomain™ organization on GitHub: the org profile page, the community health files every repository inherits, and the images those pages embed.

**Status:** Public · active · rendered live on the organization page

[![product](https://img.shields.io/badge/product-customdomain.ai-1c1917?style=flat)](https://customdomain.ai)
[![status](https://img.shields.io/badge/status-status.customdomain.ai-1c1917?style=flat)](https://status.customdomain.ai)
[![mcp](https://img.shields.io/badge/mcp-ai.customdomain%2Fmcp-1c1917?style=flat)](https://customdomain.ai/mcp-server)
[![docs](https://img.shields.io/badge/docs-docs.customdomain.ai-1c1917?style=flat)](https://docs.customdomain.ai/docs)
[![license](https://img.shields.io/badge/license-per%20repository-1c1917?style=flat)](#license)

[Website](https://customdomain.ai) · [Docs](https://docs.customdomain.ai/docs) · [Console](https://app.customdomain.ai) · [Sign up free](https://app.customdomain.ai/signup) · [Trust center](https://trust.customdomain.ai)

| | |
|---|---|
| **What it is** | The `.github` metadata repository for the CustomDomain™ organization: the org profile page, org-wide community health defaults, and the brand assets those pages embed. |
| **Who it's for** | Anyone landing on this organization from a search result, an MCP registry entry, an npm package page, or a docs link, plus the maintainers who edit the org's public surface. |
| **Live at** | [customdomain.ai](https://customdomain.ai) (product) · [docs.customdomain.ai/docs](https://docs.customdomain.ai/docs) (docs) · [status.customdomain.ai](https://status.customdomain.ai) (uptime) |
| **Stack** | Markdown and static assets only. No build, no runtime, no dependencies. GitHub renders it directly. |
| **Status** | Public. Active. Default branch `main`. Rendered live on the organization page. |

**CustomDomain™ is the managed domain-connection platform for SaaS products.** It lets your
users put a domain they already own in front of your product, with the DNS records written,
the ownership proven, and the TLS certificate issued and renewed for them. This repository is
the front door to that organization: it holds the profile page GitHub renders at
[github.com/CUSTOM-DOMAIN-APP](https://github.com/CUSTOM-DOMAIN-APP), the community health
files every other repository here inherits, and the screenshots and demo capture those pages
embed.

## About this repository

GitHub gives every organization one repository with a reserved name, `.github`, and reads
two things out of it. The file at `profile/README.md` becomes the organization's front page,
shown above the repository list to every visitor who opens
[github.com/CUSTOM-DOMAIN-APP](https://github.com/CUSTOM-DOMAIN-APP). The community health
files at the root become the defaults for every repository in the organization that does not
ship its own copy, so a contributor who clicks "Report a vulnerability" in any repository here
reaches the same policy.

That makes this repository small but load-bearing. It is the only place in the organization
where a stranger's first impression is written, and the only place a security report gets
routed from. It carries no code, no build step and no dependencies: four Markdown files, one
profile page, and four committed image assets that the profile page embeds by relative path.

The rest of this document is split in half on purpose. Everything above the Quickstart
explains what CustomDomain™ is and who it is for, because that is what a first-time visitor
needs. Everything below it explains how this repository and the organization's public surface
are put together, because that is what a maintainer needs.

## The problem

Every multi-tenant product eventually hits the same request: a customer wants the product to
live at `app.acme.com` instead of `acme.yourproduct.com`. It sounds like a small feature. It
is not. There are dozens of DNS providers with incompatible record models and no shared API.
Apex domains cannot hold a `CNAME` at all under RFC 1034, so half your customers need a
different record type than the other half. Certificates have to be issued and then renewed
forever, per customer, without anyone thinking about it. And every one of those steps happens
in an account you do not control, by a person who has never opened a DNS panel.

So the feature ships as a support-ticket generator. The customer is handed a table of records
to copy, gets one of them wrong or puts it on the wrong host, and the connection sits in
"pending" while nobody can tell them why. Teams that build this in-house typically spend weeks
on it and then keep paying for it in a queue of "my domain says pending" tickets that never
fully goes away. The work is unglamorous, it is nobody's differentiator, and it is genuinely
hard to get right for the long tail of registrars.

## What it does

CustomDomain™ replaces that whole surface with one connect flow that you embed, call, or hand
to an agent. Your user types their domain. The platform works out where its DNS actually
lives, picks the best rail it can use for that provider, writes the records, watches public
DNS until they resolve to the intended values, and issues a certificate at a managed edge that
then terminates TLS for that hostname.

- **Connects a domain in about thirty seconds** on the one-click authorization path, from the
  moment the user types it to the moment the hostname serves HTTPS.
- **Covers 63 DNS and registrar providers** through a single census, with exactly 25 of them
  configured fully automatically (17 by scoped API token, 6 by provider OAuth, 2 by Domain
  Connect) and no dead end for the other 38, which fall back to a guided manual flow whose
  records are verified automatically once they appear.
- **Issues and renews real Let's Encrypt certificates** at the edge. Verified end to end in
  July 2026 against a live connected domain: a browser-trusted production certificate, valid
  chain, issued on first handshake and cached thereafter.
- **Proves control without a verification chore.** There is no separate ownership challenge to
  paste. Control is established by the rail that writes the records (an authorization at the
  provider, a one-click apply, or a scoped token), or by the records showing up in the
  domain's own authoritative DNS, checked by value rather than by presence.
- **Handles email domains through the same flow**, writing MX, SPF, DKIM and DMARC records
  from server-side templates rather than asking anyone to hand-assemble an SPF string.
- **Gives AI agents a first-class path.** The hosted MCP server (version 0.4.0) exposes twelve
  tools over streamable HTTP, speaks protocol revision `2025-06-18`, and is listed in the
  official MCP registry as `ai.customdomain/mcp`. No tool accepts a raw DNS record as input, which closes
  off the prompt-injection paths that would otherwise end in arbitrary DNS writes.
- **Isolates tenants strictly.** A July 2026 black-box production audit walked the API as a
  second tenant and got `404` on every resource belonging to the first, with no cross-tenant
  leakage found.

All 18 of the platform's Domain Connect templates are merged upstream into the
[Domain-Connect/Templates](https://github.com/Domain-Connect/Templates) registry (`#1323`,
`#1340`, and the 16 template catalog in `#1346`), which is what lets a supporting provider apply
the record set from its own dashboard rather than from ours.

Pricing starts at [$0](https://customdomain.ai/pricing): the Free plan includes ten domain
connections per year with the Connect DNS engine, the widget and SDK, the REST API and
webhooks, DNS drift detection, and the MCP server. The reverse-proxy edge and the SSL
management API start on the Growth plan.

## Who it is for

If your product has tenants, and your tenants have brands, this is for you.

| Audience | The shape of the need | Start here |
|---|---|---|
| **Website builders** | Every published site wants its own name in the address bar, at tenant scale. | [connect-domain-for-website-builders](https://github.com/CUSTOM-DOMAIN-APP/connect-domain-for-website-builders) |
| **Email platforms** | Sending domains need SPF, DKIM, DMARC and return-path written correctly the first time. | [connect-domain-for-email-platforms](https://github.com/CUSTOM-DOMAIN-APP/connect-domain-for-email-platforms) |
| **AI agents** | An agent that ships a site needs a real domain: search it, buy it, connect it, without a human in the loop. | [connect-domain-for-ai-agents](https://github.com/CUSTOM-DOMAIN-APP/connect-domain-for-ai-agents) |
| **Agencies** | Client domains connected under your own brand, without collecting anyone's registrar login. | [connect-domain-for-agencies](https://github.com/CUSTOM-DOMAIN-APP/connect-domain-for-agencies) |

It also fits e-commerce platforms giving each merchant a storefront domain, creator tools
giving each creator a domain, and any multi-tenant SaaS where a shared subdomain is the thing
customers complain about. The common thread is not the industry, it is the shape: you have
many customers, each customer has a brand, and the address bar is the most visible place that
brand either shows up or does not. Products that get this right stop looking like a tool their
customers rent and start looking like something their customers own, which is why custom
domains keep appearing near the top of enterprise-plan feature lists rather than in the
backlog. The cost of getting it wrong is equally consistent: a queue of tickets that says
"pending" and a sales objection nobody on the team can answer. The vocabulary, if the category is new to you, is in the glossary:
[bring your own domain](https://customdomain.ai/glossary/bring-your-own-domain) and
[custom domain vs subdomain](https://customdomain.ai/glossary/custom-domain-vs-subdomain).

---

## Quickstart

There is nothing to install to work on **this** repository. Clone it, edit Markdown, push.

```bash
git clone https://github.com/CUSTOM-DOMAIN-APP/.github.git
cd .github

# The org front page. This is the file GitHub renders at github.com/CUSTOM-DOMAIN-APP.
$EDITOR profile/README.md

# Check every link still resolves before you push (see Testing, below).
grep -oE 'https?://[^)"< ]+' profile/README.md README.md | sort -u | \
  while read -r u; do printf '%s %s\n' "$(curl -sL -o /dev/null -w '%{http_code}' --max-time 12 "$u")" "$u"; done

git commit -am "profile: <what changed>" && git push
```

To use the **product** instead, connect a domain from the command line with an API key from
[the console](https://app.customdomain.ai/signup). Keys look like `sk_live_...` and are shown
once, at creation.

```bash
export CUSTOMDOMAIN_API_KEY="<your API key>"   # read it from your secret manager; never commit it

# 1. Create a connection for your user's domain.
curl -X POST https://api.customdomain.ai/v1/connections \
  -H "Authorization: Bearer $CUSTOMDOMAIN_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"domain": "app.customer.com"}'

# 2. Poll until it reports connected: records written, DNS observed, TLS issued.
curl https://api.customdomain.ai/v1/connections/<connection_id> \
  -H "Authorization: Bearer $CUSTOMDOMAIN_API_KEY"
```

Or point an MCP client at the hosted server and let an agent do it. Nothing to install and
nothing to keep running:

```bash
claude mcp add --transport http customdomain https://mcp.customdomain.ai/mcp \
  --header "Authorization: Bearer $CUSTOMDOMAIN_API_KEY"
```

The create call takes `domain` as its only required field; the application comes from the key,
and unknown body fields are rejected with a `400`. Exact request and response shapes live in the
[API reference](https://docs.customdomain.ai/docs/api-reference); the tool catalog lives in
[customdomain-mcp](https://github.com/CUSTOM-DOMAIN-APP/customdomain-mcp).

## Repository layout

Nine tracked files. Every one of them is either rendered by GitHub or embedded by something
that is.

```text
.github/
├── README.md            You are here. Explains the org and this repository.
├── profile/
│   └── README.md        THE ORG FRONT PAGE. GitHub renders this at github.com/CUSTOM-DOMAIN-APP.
├── CONTRIBUTING.md      Org-wide contribution defaults: where docs live, house style.
├── SECURITY.md          Org-wide vulnerability policy and the reporting address.
├── SUPPORT.md           Org-wide support routing: docs, discussions, book a call.
└── assets/
    ├── connect-flow-demo.gif    3.5 MB. A real domain going live, start to finish.
    ├── provider-logos.png       769 KB. The supported provider wall.
    ├── app-connect-domain.jpg    39 KB. The console, mid-connect.
    └── app-domain-live.jpg       40 KB. The same domain, live on HTTPS.
```

Two constraints are worth knowing before you edit. First, `profile/README.md` references
assets with a relative `../assets/...` path, which resolves correctly on the organization page
because GitHub serves the profile from this repository's tree; a rename of `assets/` breaks
the front page silently. Second, GitHub's Markdown sanitizer strips inline `<svg>` markup
entirely, so every image here is a committed file referenced by `<img src>`, never inline
vector markup. That is a hard constraint, not a stylistic choice.

## Architecture of the public surface

This repository is one of four layers that make up everything a stranger can see. Nothing here
runs; the layer boundaries are about who renders what.

| Layer | Rendered by | Source of truth | What it is for |
|---|---|---|---|
| Organization profile | GitHub, from `profile/README.md` | This repository | The 30-second pitch and the map of every repository |
| Community health defaults | GitHub, from the root `*.md` files | This repository | One security policy, one contributing guide, one support route, inherited org-wide |
| Documentation site | Fumadocs and Next.js in the `docs` repository | [`CUSTOM-DOMAIN-APP/docs`](https://github.com/CUSTOM-DOMAIN-APP/docs) | 100+ MDX pages: guides, concepts, and 60+ API reference pages |
| Product surfaces | The private product monorepo | `CUSTOM-DOMAIN-APP/custom-domains` | The console, REST API, edge, widget and MCP server |

The important property is that no layer copies another. The docs site reads its own `content/`
directory directly, with no sync step in the path a reader sees. This README and the profile
README are separately authored and neither is generated. When they disagree, the repository
that owns the subject wins: the docs repository owns behavior, this one owns positioning.

## Repository map and package boundaries

The organization's repositories, one product. Public unless noted.

| Repository | Language | What it holds |
|---|---|---|
| [`docs`](https://github.com/CUSTOM-DOMAIN-APP/docs) | MDX | The documentation source of truth, plus the Fumadocs renderer in `site/` that serves docs.customdomain.ai |
| [`customdomain-sdk`](https://github.com/CUSTOM-DOMAIN-APP/customdomain-sdk) | TypeScript | The browser SDK (`customdomain-js`), the React wrapper (`@customdomain/react`), and the widget bundle they load. Both packages are 0.5.0 on npm |
| [`customdomain-mcp`](https://github.com/CUSTOM-DOMAIN-APP/customdomain-mcp) | Markdown | The hosted MCP server's public face: server version 0.4.0 (release v0.4.0), twelve tools, auth model, client configs for Claude, Cursor and ChatGPT |
| [`custom-domain-checks`](https://github.com/CUSTOM-DOMAIN-APP/custom-domain-checks) | JavaScript | A GitHub App that posts a domain-health check on every push: DNS resolution, target correctness, CAA, certificate expiry, HTTPS enforcement. v0.1.0; the service is deployed, the public App is not registered yet |
| [`awesome-custom-domains`](https://github.com/CUSTOM-DOMAIN-APP/awesome-custom-domains) | Markdown | The curated map of the category: managed services, DIY building blocks, protocols, examples |
| [`connect-domain-for-website-builders`](https://github.com/CUSTOM-DOMAIN-APP/connect-domain-for-website-builders) | Markdown | Use-case guide: records, verification, TLS at tenant scale, connect-flow UX |
| [`connect-domain-for-email-platforms`](https://github.com/CUSTOM-DOMAIN-APP/connect-domain-for-email-platforms) | Markdown | Use-case guide: sending-domain onboarding, SPF, DKIM, DMARC, return-path, deliverability |
| [`connect-domain-for-ai-agents`](https://github.com/CUSTOM-DOMAIN-APP/connect-domain-for-ai-agents) | Markdown | Use-case guide: the MCP server, the API flow, agent-safe DNS security |
| [`connect-domain-for-agencies`](https://github.com/CUSTOM-DOMAIN-APP/connect-domain-for-agencies) | Markdown | Use-case guide: fleet-scale client domains, white-label connection, drift monitoring |
| [`customdomain-brand-kit`](https://github.com/CUSTOM-DOMAIN-APP/customdomain-brand-kit) | Markdown | The brand reference: name rule, oak mark, stone palette and type (`IDENTITY.md`); the asset files are not committed yet |
| [`.github`](https://github.com/CUSTOM-DOMAIN-APP/.github) | Markdown | This repository |
| `custom-domains` | Go, TypeScript | **Private.** The product monorepo: Go control plane and TLS-terminating edge, Next.js console, widget, MCP service |
| `customdomain-site` | TypeScript | **Private.** The marketing site at customdomain.ai (Next.js, HeroUI, Tailwind) |
| `dashboard-custom-domain` | TypeScript | **Private.** The internal marketing engine |
| `CD-APPENDIX` | Markdown | **Private.** Product profile, architecture notes and diligence material |

The boundary that matters most: **the SDK never talks to a DNS provider.** It opens the
widget, the widget talks to the control plane, and only the control plane holds provider
credentials and writes records. That is what makes it safe to embed in a customer's settings
page, and it is why the widget token is minted server-side rather than shipping an API key to
a browser.

## How it works: a domain from typed to live

```text
  your app  ──►  widget / REST / MCP  ──►  control plane
                                              │
                        ┌─────────────────────┼─────────────────────┐
                        ▼                     ▼                     ▼
                 provider detect         write records          poll public DNS
                 (NS + zone walk)   (OAuth · token · Domain    (by value, ~60s)
                                     Connect · guided manual)
                                              │
                                              ▼
                                     edge issues Let's Encrypt cert
                                     (TLS-ALPN-01 :443 · HTTP-01 :80)
                                              │
                                              ▼
                                    hostname serves HTTPS  ──►  status: live
```

1. **Detect.** The control plane resolves the domain's nameservers, walks up the zone for
   subdomains, and works out which provider actually answers for it and which rails that
   provider supports.
2. **Write.** The best available rail applies the record set. In descending order of user
   effort that is: a one-click authorization at the provider, a Domain Connect apply, a scoped
   API token the user pastes, or a guided manual list the user copies.
3. **Observe.** A background poller re-checks `pending` and `propagating` connections about
   once a minute and compares each record against public DNS by value, not merely by presence.
   Polling faster than that gains nothing.
4. **Issue.** Once the connection reaches `live` or `propagating`, the edge asks the control
   plane whether the hostname is approved, then issues a Let's Encrypt certificate on the first
   TLS handshake and caches it.
5. **Serve.** The edge terminates TLS for the customer hostname and proxies to your origin.

Connections move `pending` to `propagating` to `live`, with `failed` as the one error state.
Key completion off the boolean `connected` rather than the status string, so your code survives
the enum growing. Automatic rails give up after 24 hours in `propagating`. Manual connections
never fail on their own, because a human has to get to their DNS panel: after 72 hours in
`pending` they carry `error_code: setup_incomplete` as a diagnosis and are re-checked every six
hours. A `failed` connection clears on its own if the records later resolve, so `failed` is
recoverable and is never a reason to tell a user to start over.

## Configuration

**This repository has no runtime and therefore no environment variables.** Its configuration
is the set of paths GitHub reads by convention, plus repository metadata set through the API.

| Configuration | Where it lives | Effect |
|---|---|---|
| Organization front page | `profile/README.md` | Rendered above the repository list on the org page |
| Contribution defaults | `CONTRIBUTING.md` | Inherited by every repo in the org without its own copy |
| Security policy | `SECURITY.md` | Powers "Report a vulnerability" org-wide; routes to `security@customdomain.ai` |
| Support routing | `SUPPORT.md` | Shown in the new-issue chooser org-wide |
| Repository description, homepage, topics | GitHub repository metadata | `gh repo edit`, not a file in the tree |

Integrators consuming the platform supply exactly three credential shapes. All three are
secrets. **None of them belongs in a file that is committed anywhere**, in this organization
or in yours. Reference them from a secret manager and inject at run time.

| Name | What it is | Scope |
|---|---|---|
| `CUSTOMDOMAIN_API_KEY` | Console API key, `sk_live_...` or `sk_test_...`, shown once at creation and stored only as a hash | The whole tenant: every application, connection, webhook and billing record |
| `APPLICATION_ID` | The application identifier, also called `CLIENT_ID` in OAuth contexts. Not a secret on its own | One application |
| `CLIENT_SECRET` | Returned once when an application is created. Its only job is minting short-lived JWTs | One application |

Prefer the JWT path over a raw API key whenever an agent or a service only needs one
application: exchange `APPLICATION_ID` and `CLIENT_SECRET` at
`POST https://mcp.customdomain.ai/token` for an hour-long bearer token. A leaked `sk_live_` key carries the entire tenant; a leaked JWT expires. Widget
tokens follow the same rule and are minted server-side, never in the browser.

## Deployment and operations

This repository ships by being pushed. There is no workflow, no build and no artifact.

```bash
git push origin main
# GitHub re-renders github.com/CUSTOM-DOMAIN-APP within seconds.
# Assets are served from raw.githubusercontent.com/CUSTOM-DOMAIN-APP/.github/main/assets/...
```

Three operational notes for anyone editing it:

- **Community health inheritance is opt-out, not opt-in.** Adding a file here changes the
  behavior of every repository in the organization at once. A repository that ships its own `SECURITY.md`
  keeps it; every other one starts pointing at this one on the next page load.
- **Asset weight is a real cost.** `connect-flow-demo.gif` is 3.5 MB and loads on every visit
  to the organization page. Anything added to `assets/` should earn its bytes, and new
  screenshots should stay in the tens of kilobytes, like the two already there.
- **Renaming this repository breaks the org profile.** GitHub only reads `profile/README.md`
  from a repository literally named `.github`.

Where the rest of the platform runs, for context: the private product monorepo deploys the Go
control plane and edge together on AWS, with the edge holding its own elastic IP so it can own
ports 80 and 443 for customer hostnames; each product deploy rebuilds the docs site from the
`docs` repository's `main`; and the SDK publishes to npm from a tagged release workflow using npm
provenance and Trusted Publishing, so no long-lived npm token sits in the repository. Live
availability for all of it is published at
[status.customdomain.ai](https://status.customdomain.ai), and the control plane reports its
own build on an unauthenticated endpoint, which is the fastest way to confirm what is actually
deployed:

```bash
curl -s https://api.customdomain.ai/v1/config
# {"api_version":"v1","env":"production","products":["connect","secure","sell","power","monitor","mcp"],
#  "service":"customdomain-control-plane","version":"0.1.448"}    (as returned on 2026-09-26)
```

## Testing

There is no test suite to run here, and inventing one would be theater. What this repository
is actually verified against is link rot and render correctness, both of which are cheap to
check and are the only two ways it can be wrong.

```bash
# 1. Every link resolves. Use GET, not HEAD: several hosts answer 405 to HEAD.
grep -ohE 'https?://[^)"< ]+' *.md profile/*.md | sed 's/[.,)]*$//' | sort -u | \
  while read -r u; do
    code=$(curl -sL -o /dev/null -w '%{http_code}' --max-time 15 "$u")
    [ "$code" = 200 ] || printf 'FAIL %s %s\n' "$code" "$u"
  done

# 2. Every relative asset reference points at a file that exists.
grep -ohE '\.\./assets/[A-Za-z0-9._-]+' profile/README.md | sort -u | \
  while read -r a; do [ -f "${a#../}" ] || echo "MISSING $a"; done

# 3. No secret ever lands in the tree.
grep -rnE 'sk_live_|sk_test_|ghp_|AKIA[0-9A-Z]{16}' . --exclude-dir=.git && echo "STOP" || echo "clean"
```

Run the first check before every push. A dead link on the organization front page is the most
visible defect this repository can have, and it is the one that decays without anyone touching
the file.

## Contributing

Corrections are welcome, including typo-only pull requests. Open one against `main`.

- **Product documentation** lives in [`CUSTOM-DOMAIN-APP/docs`](https://github.com/CUSTOM-DOMAIN-APP/docs)
  under `content/`, not here. Changes merged to its `main` go live on docs.customdomain.ai with
  the next product deploy, which rebuilds the docs site from `main`.
- **Use-case guides** live in the four `connect-domain-for-*` repositories and welcome
  provider notes, corrections and clearer examples.
- **The tools list** in [`awesome-custom-domains`](https://github.com/CUSTOM-DOMAIN-APP/awesome-custom-domains)
  accepts anything genuinely relevant to connecting customer-owned domains: one line per tool,
  alphabetical within its section, factual descriptions.

House style, applied everywhere in this organization: plain language, short paragraphs, tables
where they clarify, no em dashes or en dashes, American English, and real DNS and TLS facts
only. The product name is CustomDomain™: one word, capital C and D, with the ™; "custom
domain" in lowercase is the generic thing a customer connects. No invented numbers. If you
cannot source a figure, leave it out.

Questions and ideas belong in
[Discussions on the docs repository](https://github.com/CUSTOM-DOMAIN-APP/docs/discussions).

## Related

- [docs](https://github.com/CUSTOM-DOMAIN-APP/docs): the CustomDomain™ documentation source, rendered at [docs.customdomain.ai](https://docs.customdomain.ai/docs)
- [customdomain-sdk](https://github.com/CUSTOM-DOMAIN-APP/customdomain-sdk): the browser SDK `customdomain-js` and the React wrapper `@customdomain/react`, 0.5.0 on npm
- [customdomain-mcp](https://github.com/CUSTOM-DOMAIN-APP/customdomain-mcp): the hosted MCP server, version 0.4.0, twelve tools
- [custom-domain-checks](https://github.com/CUSTOM-DOMAIN-APP/custom-domain-checks): the GitHub App for DNS and TLS health checks, v0.1.0, public App not registered yet
- [awesome-custom-domains](https://github.com/CUSTOM-DOMAIN-APP/awesome-custom-domains): the curated list of the category, including the alternatives to this product
- [customdomain-brand-kit](https://github.com/CUSTOM-DOMAIN-APP/customdomain-brand-kit): the name rule, mark, palette and type
- [connect-domain-for-ai-agents](https://github.com/CUSTOM-DOMAIN-APP/connect-domain-for-ai-agents): CustomDomain™ for AI Agents
- [connect-domain-for-agencies](https://github.com/CUSTOM-DOMAIN-APP/connect-domain-for-agencies): CustomDomain™ for Agencies
- [connect-domain-for-email-platforms](https://github.com/CUSTOM-DOMAIN-APP/connect-domain-for-email-platforms): CustomDomain™ for Email Platforms
- [connect-domain-for-website-builders](https://github.com/CUSTOM-DOMAIN-APP/connect-domain-for-website-builders): CustomDomain™ for Website Builders

## Support

- **Docs:** [docs.customdomain.ai](https://docs.customdomain.ai/docs)
- **Questions and ideas:** [GitHub Discussions](https://github.com/CUSTOM-DOMAIN-APP/docs/discussions)
- **Bugs and corrections:** [open an issue](https://github.com/CUSTOM-DOMAIN-APP/.github/issues) on this repository
- **Service status:** [status.customdomain.ai](https://status.customdomain.ai)
- **Account and billing:** connect@customdomain.ai
- **Talk to the team:** [book a call](https://customdomain.ai/book)
- **Security:** report privately to security@customdomain.ai, never in a public issue. Policy: [app.customdomain.ai/security](https://app.customdomain.ai/security). The org-wide policy file, with scope and the trust center, is [SECURITY.md](SECURITY.md)

## License

This repository has no `LICENSE` file. The images in `assets/` are CustomDomain™ brand material,
all rights reserved, and are not licensed for reuse. Where a repository carries its own `LICENSE`
file, that file governs: `customdomain-sdk` is **Apache-2.0**; `customdomain-mcp`, `docs`,
`custom-domain-checks`, `awesome-custom-domains` and the four `connect-domain-for-*` guides are
**MIT**. `customdomain-brand-kit` has no open source license (all rights reserved), and
`custom-domains`, the product monorepo, carries an Apache-2.0 file but is private. CustomDomain™
is a product of EverJust Company.
