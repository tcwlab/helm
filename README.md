# `helm`
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Ftcwlab%2Fhelm.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Ftcwlab%2Fhelm?ref=badge_shield)
[![pipeline status](https://gitlab.com/tcwlab.com/saas/baseline/images/helm/badges/main/pipeline.svg)](https://gitlab.com/tcwlab.com/saas/baseline/images/helm/-/commits/main)
[![coverage report](https://gitlab.com/tcwlab.com/saas/baseline/images/helm/badges/main/coverage.svg)](https://gitlab.com/tcwlab.com/saas/baseline/images/helm/-/commits/main)
[![GitHub tag](https://img.shields.io/github/tag/tcwlab/helm)](https://github.com/tcwlab/helm/releases/?include_prereleases&sort=semver "View GitHub releases")
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## tl;dr

This image contains `helm` on a as-small-as-possible alpine image. Every image contains the latest stable version of `helm` at build time.
The goal is to make CI/CD tasks as easy as possible.
We only set up this project, because all other projects we found 'in the wild' seems to be somehow orphaned.

## Quick reference

- **Maintained by:** [Sascha Willomitzer](https://thechameleonway.com) [(of the TCWlab project)](https://gitlab.com/sascha_willomitzer)
- **Where to get help:** [file an issue](https://gitlab.com/tcwlab.com/saas/baseline/images/helm/-/issues)
- **Supported architectures:** linux/amd64
- **Published image artifact details:** [see source code repository](https://gitlab.com/tcwlab.com/saas/baseline/images/helm/-/tree/main)
- **Documentation:** see `helm`: [official documentation](https://helm.sh/docs/)

## Getting started

This image is intended to be used both locally _and_ as a part of a pipeline.
Find the steps how to use it below, depending on your needs.

### Using it locally

#### Using `~/.kube` as volume
We thought it would be easy to just mount all of your kubernetes configs inside the container,
so that you can easily interact with it.
It's as easy as calling:

```bash
docker run -v ~/.kube:/.kube tcwlab/helm:latest helm version
```
or in interactive mode:
```bash
docker run -it --rm -v ~/.kube:/.kube tcwlab/helm:latest /bin/bash
```

#### Using only one specific `kubeconfig`
Instead of mounting all your kubeconfigs to the container, you could also only set one specific
config as environment variable:
```bash
docker run -e KUBE_CONFIG_B64="$(base64 -i ~/.kube/config)" tcwlab/helm:latest helm version
```

### Using as CI/CD image
As we are using GitLab ourselves, this only describes the GitLab CI/CD way,
using this `.gitlab-ci.yml` snippet:

```yaml
helm-example:
  stage: demo
  image: tcwlab/helm:latest
  variables:
    KUBE_CONFIG_B64: $YOUR_ENV_VAR_CONTAINING_B64_KUBECONFIG
  script:
    - helm -n default list
```

If you'd like to see some example configurations, have a look at our [bootstrap project](https://gitlab.com/tcwlab.com/saas/baseline/bootstrap/-/blob/main/.gitlab-ci.yml).

## Roadmap
If you are interested in the upcoming/planned features, ideas and milestones,
please have a look at our [board](https://gitlab.com/tcwlab.com/saas/baseline/images/helm/-/boards).

## License
This project is licensed under [Apache License v2](./LICENSE).

## Project status
This project is maintained "best effort", which means, we strive for automation as much as we can
A lot of updates will be done "automagically".

We do **not** have a specific dedicated set of people to work on this project.

It absolutely comes with **no warranty**.

[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Ftcwlab%2Fhelm.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Ftcwlab%2Fhelm?ref=badge_large)
