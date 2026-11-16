# AGENTS.md — lemonfiber-dashy

> **Start at the roadmap and board on [lemonfiber.app](https://lemonfiber.app),
> rendered from the report of where every unreleased version stands. Then the
> rules** every repository shares:
> [working in the repositories](https://github.com/lemonfiber/spec/blob/main/50-governance/working-in-the-repositories.md)
> and [the rules for agents](https://github.com/lemonfiber/spec/blob/main/50-governance/ai-contributors.md).
> This file holds only what is true of this repository.

## What this repo is

The image of the offered dashboard: `ghcr.io/lemonfiber/dashy`, which `plugin-dashy` runs
as its upstream (`OPS-R93`). See the spec:
[`30-repos/lemonfiber-dashy.md`](https://github.com/lemonfiber/spec/blob/main/30-repos/lemonfiber-dashy.md).

## The rules you cannot break

- **Dashy's server reaches only what its page names.** `dashy.patch` holds
  `/status-check` to each entry's status check in `conf.yml` and `/cors-proxy` to each
  status-page widget's two addresses there, read on every request, each on a host that
  is one label of a service's name (never an IP address, a dotted name, a name the
  container's hosts file holds, a container's id, or `metadata`, `instance-data` or
  `kubernetes`). `/status-check` takes no caller's headers, certificate skipping,
  accepted statuses or redirect count; `/cors-proxy` forwards a GET alone, with no
  caller's headers or body and no `Access-Control-Allow-*` answer. Neither follows a
  redirect, and `/ping-check` refuses every host. Nothing here widens that.
- **The patch is applied with `patch --forward` in a build stage.** A Dashy bump whose
  code the patch no longer fits fails the build: refresh the patch against the new
  release's files, never loosen the apply.
- **Saving the page is refused by the page itself.** The `conf.yml` `plugin-dashy`'s
  adapter writes sets `appConfig.preventWriteToDisk`, and Dashy's REST API stays off.
- **Every base image is pinned by tag and digest** (ADR-0025).
- **The manifest is `plugin-dashy`'s.** Its posture, its starting files and its
  recordings live there, and a change here is proved against that manifest's `main`.
- **No Python here.** Every check is spec's shared workflows'.
