# Templates rendering engine microservice

[![Deps Status](https://beta.hexfaktor.org/badge/all/github/edenlabllc/man.api.svg)](https://beta.hexfaktor.org/github/edenlabllc/man.api) [![Build Status](https://travis-ci.org/edenlabllc/man.api.svg?branch=master)](https://travis-ci.org/edenlabllc/man.api) [![Coverage Status](https://coveralls.io/repos/github/edenlabllc/man.api/badge.svg?branch=master)](https://coveralls.io/github/edenlabllc/man.api?branch=master)
![Man Logo](https://github.com/edenlabllc/man.api/raw/master/docs/images/logo.png)

Mán stores templates (in `iex`, `mustache`) or `markdown` documents, renders it over HTTP API with dispatch in PDF, JSON or HTML formats.

> "Mán" translates from the Sindarin as "Spirit". Sindarin is one of the many languages spoken by the immortal Elves.

## Docs

Full API and installation description available on [dedicated page](http://docs.man2.apiary.io/).

## Introduction

Man consists of two main parts:

- REST API back-end that allows to manage and render Templates;
- Management UI that simplifies configuration and management.

## Use Cases

- Rendering reports;
- Central control over Email or/and SMS templates;
- PDF/HTML printout forms generation;
- Rendering HTML pages over API.

## UI

![UI Demo](https://github.com/edenlabllc/man.web/raw/master/docs/images/ui-animated.gif)

## Performance

We encourage you to perform your own tests, because synthetic results are far from real life situation. We provide them only as starting point in understanding Man's performance.

### Test environment

* MacBook Pro (15-inch, 2016)
* CPU 2,7 GHz Intel Core i7
* RAM 16 ГБ 2133 MHz LPDDR3
* Man v0.1.16 and PostgreSQL v9.6.2 running in edenlabllc Docker contianers (listed below);
* ApacheBench v2.3;
* wkhtmltopdf v0.12.4 (with patched qt).

### Results

| **Metric**/**Template Syntax**                          | **Mustache** | **Markdown** | **Mustache with PDF format** | **Mustache with PDF format** **and PDF cache enabled** |
| ------------------------------------------------------- | ------------ | ------------ | ------------- | ------------- |
| Concurrency Level                                       | 50           | 50           | 50            | 50 |
| Time taken for tests                                    | 8.412 sec    | 8.142 sec    | 442.214 sec   | 11.255 sec |
| Complete requests                                       | 10000        | 10000        | 10000         | 10000 |
| Failed requests                                         | 0            | 0            | 0             | 0 |
| Requests per second [#/sec] (mean)                      | **1188.84**  | **1228.25**  | **22.61**     | **888.52** |
| Time per request                                        | 42.058 [ms]  | 40.708 [ms]  | 2211.070 [ms] | 56.274 [ms] |
| Time per request (mean, across all concurrent requests) | 0.841 [ms]   | 0.814 [ms]   | 44.221 [ms]   | 1.125 [ms] |

Full console output is available in [`pertest.md`](https://github.com/edenlabllc/man.api/blob/master/docs/perftest.md).

### PDF Output Cache

Since generating PDF is slow, Man allows to cache `wkhtmltopdf` output.

This cache can be used when you have less than 1000 of different templates variations (eg. markdown templates, or mustache templates but all variables are continuous or enums). To enable it simply set `CACHE_PDF_OUTPUT=true` in your environment.

Enabling cache when output variety is high will hurt your performance (cache will always be cold, since it's based on HTML checksum) and may lead to node crashes (ETC table may overflow).

## Build history

[![Build history](https://buildstats.info/travisci/chart/edenlabllc/man.api)](https://travis-ci.org/edenlabllc/man.api)

## Setup Guide

Application is configured via environment variables. List of supported keys and their default values can be found in [docs/ENVIRONMENT.md](docs/ENVIRONMENT.md).

### Docker

Easiest way to deploy Man is to use docker containers.
We constantly are releasing pre-built versions that will reduce time to deploy:

- [Back-End Docker container](https://hub.docker.com/r/edenlabllc/man_api/);
- [PostgreSQL Docker container](https://hub.docker.com/r/edenlabllc/alpine-postgre/);
- [UI Docker container](https://hub.docker.com/r/edenlabllc/man-web/).

### Heroku

Template allows to deploy Man to Heroku just in minute (and use it for free within Heroku tiers):

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/edenlabllc/man.api)

## Binary dependencies

`wkhtmltopdf` is used for HTML to PDF conversion.

## License

See [LICENSE.md](LICENSE.md).
