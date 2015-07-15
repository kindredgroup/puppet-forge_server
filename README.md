# forge_server

[![Build Status](https://secure.travis-ci.org/unibet/puppet-forge_server.png)](http://travis-ci.org/unibet/puppet-forge_server)
[![Puppet Forge](https://img.shields.io/puppetforge/v/unibet/forge_server.svg)](https://forge.puppetlabs.com/unibet/forge_server)
[![Puppet Forge](https://img.shields.io/puppetforge/f/unibet/forge_server.svg)](https://forge.puppetlabs.com/unibet/forge_server)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with forge_server](#setup)
    * [What forge_server affects](#what-forge_server-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with forge_server](#beginning-with-forge_server)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Manages Puppet Forge Server, a service for hosting a private puppet forge. It aims to support both the forge v1 and v3 api, cache directories and exposing modules from multiple paths. It installs as a ruby gem and requires ruby >=1.9.3

## Module Description

This module installs the puppet-forge-server gem and runs the service as a daemon. All configurable parameters can be tweaked from this module.

## Setup

### What forge_server affects

* Unprivileged forge user to run the daemon
* Gem installation either in system ruby or specific SCL
* Manages the puppet-forge-server service

### Setup Requirements

If installing in system ruby it must be at least version 1.9.3

### Beginning with forge_server

Install the module:

```
puppet module install unibet-forge_server
```

## Usage

To install puppet-forge-server:

```
class { '::forge_server': }
```

## Reference

The only "public" class is forge_server. See rdoc for usage.

## Limitations

SCL won't work on non-EL distributions.

## Development

Fork it and create a pull request
