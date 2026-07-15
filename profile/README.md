# Custom Domain

**Custom domains for SaaS, live in about 30 seconds when users authorize their DNS provider.**

Custom Domain lets your users connect a domain they already own to your platform in one click. It detects the user's DNS provider, configures the records automatically, verifies domain ownership, and issues and renews TLS certificates, so your customers never copy DNS records by hand and your team never maintains registrar-specific help docs. This GitHub organization holds the product source, the public documentation, and educational guides for [customdomain.ai](https://customdomain.ai).

## The problem we work on

Almost every platform that offers white-label sites, hosted storefronts, or branded apps hits the same wall: the moment a customer has to configure DNS by hand, many of them stall. The records themselves are simple. The problem is that every DNS provider has a different interface, and the person doing the setup is rarely the person who understands DNS. The Domain Connect Association's public knowledge base (CC0) describes this gap well: service providers know which records are needed but cannot touch the zone, DNS providers control the zone but do not know the service, and the user is left translating between the two.

Custom Domain closes that gap with a managed control plane and a reverse-proxy edge that terminates TLS with strict multi-tenant isolation:

- **63 DNS and registrar providers.** One-click provider authorization, API token connections, or a guided manual flow with automatic verification. 25+ providers are configured fully automatically. Where a provider supports the Domain Connect protocol, an open standard from the Domain Connect Association, that is one of the paths one-click authorization uses.
- **Live in about 30 seconds** when the user authorizes their provider.
- **Automatic HTTPS.** Certificates issue before the domain goes live and renew without further DNS changes.
- **Every surface you might integrate from:** an [embeddable connect widget and SDK](https://customdomain.ai/connect-domain-widget), a full [REST API](https://customdomain.ai/custom-domain-api) covering connections, DNS records, verification, TLS, monitoring, webhooks, and registrar search and purchase, plus a [hosted MCP server](https://customdomain.ai/mcp-server) so AI agents can do all of the above.
- **Pricing starts at $0**, so you can wire it up before you commit.

## Repositories in this organization

| Repository | What you'll find |
| --- | --- |
| `custom-domains` | The product itself: control plane, edge, and dashboard. Private. |
| [`docs`](https://github.com/CUSTOM-DOMAIN-APP/docs) | The public product documentation, rendered at [app.customdomain.ai/docs](https://app.customdomain.ai/docs). |
| [`connect-domain-for-website-builders`](https://github.com/CUSTOM-DOMAIN-APP/connect-domain-for-website-builders) | Guides for [site builders and hosting platforms](https://customdomain.ai/for/site-builders) shipping domain connection to thousands of non-technical users. |
| [`connect-domain-for-email-platforms`](https://github.com/CUSTOM-DOMAIN-APP/connect-domain-for-email-platforms) | Guides for email platforms: automated SPF, DKIM, and DMARC setup for customer sending domains. |
| [`connect-domain-for-agencies`](https://github.com/CUSTOM-DOMAIN-APP/connect-domain-for-agencies) | Guides for [agencies and white-label platforms](https://customdomain.ai/for/agencies-white-label) putting client sites on client domains. |
| [`connect-domain-for-ai-agents`](https://github.com/CUSTOM-DOMAIN-APP/connect-domain-for-ai-agents) | Guides for [AI agents](https://customdomain.ai/for/ai-agents) that search, buy, and connect domains over MCP. |
| [`awesome-custom-domains`](https://github.com/CUSTOM-DOMAIN-APP/awesome-custom-domains) | A curated list of the whole custom-domain tooling space: managed services, DIY building blocks, protocols, examples. |
| [`customdomain-mcp`](https://github.com/ever-just/customdomain-mcp) | The MCP server for Custom Domain, hosted at `mcp.customdomain.ai/mcp` (streamable HTTP, OAuth client credentials). |

## Getting started

1. **See it in context.** Start at [customdomain.ai](https://customdomain.ai), or with the plain-language guide to [how to set up a custom domain](https://customdomain.ai/guides/how-to-set-up-a-custom-domain).
2. **Read the docs.** The [developer documentation](https://app.customdomain.ai/docs) covers the connect flow, API reference, widget SDK, webhooks, and MCP.
3. **Connect a domain.** [Sign up](https://app.customdomain.ai/signup) and try the flow on your own domain.
4. **Talk to us.** [Book a call](https://customdomain.ai/appointment) if you are evaluating for a platform with real volume.

## Who this is for

- **SaaS platforms** where every tenant wants `app.theirbrand.com` instead of `theirbrand.yourapp.com`. Start with [custom domains for SaaS](https://customdomain.ai/custom-domains-for-saas).
- **Site builders** that need [one-click DNS setup](https://customdomain.ai/one-click-dns-setup) to work for users who have never opened a registrar dashboard.
- **Agencies** running client sites under client domains without babysitting DNS changes.
- **AI agents** provisioning domains end to end through the [MCP server](https://customdomain.ai/mcp-server).

Still working out the basics? The glossary entry on [custom domain vs subdomain](https://customdomain.ai/glossary/custom-domain-vs-subdomain) is a good first stop.

## About Custom Domain

Custom Domain is the managed domain-connection platform at [customdomain.ai](https://customdomain.ai). We build and maintain every repository in this organization, including the educational guides, and we say so plainly: they teach the problem space first and link to our product where it is the natural answer.

- Website: [customdomain.ai](https://customdomain.ai)
- Documentation: [app.customdomain.ai/docs](https://app.customdomain.ai/docs)
- Sign up: [app.customdomain.ai/signup](https://app.customdomain.ai/signup)
- MCP server: [github.com/ever-just/customdomain-mcp](https://github.com/ever-just/customdomain-mcp)
