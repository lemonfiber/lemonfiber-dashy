# lemonfiber-dashy

The image of the offered dashboard in a [lemonfiber](https://github.com/lemonfiber/lemonfiber)
stack: Dashy, with its server's outbound endpoints held to the addresses its page names.
Dashy's own image answers anybody who reaches the page: `/cors-proxy` forwards any request
to any address, and `/status-check` and `/ping-check` reach any host. On a page the
household reaches without signing in, that would be a way into every service on the
stack's internal network. Here `/cors-proxy` and `/status-check` reach only an address the
page names, each entry's status check and each status-page widget's two addresses, on a
host that is one label of a service's name on the stack's network: never a name the
container's own hosts file holds (`localhost`, `ip6-localhost` and the other `ip6-` names),
a container's id, or a metadata or cluster name a host's search domains complete
(`metadata`, `instance-data`, `kubernetes`). They follow no redirect. `/ping-check` refuses every host.

This repository builds `ghcr.io/lemonfiber/dashy`. You do not run it yourself:
[`plugin-dashy`](https://github.com/lemonfiber/plugin-dashy) runs it as the upstream its
adapter speaks lemonfiber's `dashboard.show` contract for, and pins it by digest.

## What is here

| Path | What it is |
| --- | --- |
| `Dockerfile` | The image, from Dashy's own pinned by digest |
| `dashy.patch` | The change to Dashy's server, applied with `patch --forward` in a build stage, so a Dashy whose code it no longer fits fails the build |

The page it starts with is `plugin-dashy`'s, under `config/dashy/` there, written into
its configuration directory when lemonfiber installs it.

## How it is published

Every commit on `main` that changes what the image is built from builds `linux/amd64`
and `linux/arm64` under one index, tagged `main-<commit>`, and moves `plugin-dashy`'s pin
to it on a pull request there. The release train never tags this repository:
`plugin-dashy`'s release pins the image its `main` holds. The specification has the
details: [`30-repos/lemonfiber-dashy.md`](https://github.com/lemonfiber/spec/blob/main/30-repos/lemonfiber-dashy.md).

## Contributing and security

Read the [contributing guide](https://github.com/lemonfiber/spec/blob/main/50-governance/contributing.md)
before opening a pull request. Report a vulnerability as the
[security policy](https://github.com/lemonfiber/.github/blob/main/SECURITY.md)
describes, not in a public issue.

## Licence

[Hippocratic License 3.0](LICENSE).
