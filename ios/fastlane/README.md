fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios firebase

```sh
[bundle exec] fastlane ios firebase
```

Envia uma build para o Firebase App Distribution

### ios testflight

```sh
[bundle exec] fastlane ios testflight
```

Envia uma build ao TestFlight para teste interno. Sem criar um PR de update no GitHub

### ios beta

```sh
[bundle exec] fastlane ios beta
```

Envia uma build ao TestFlight para ser lançada na loja, em seguida cria um PR de update no GitHub

### ios test

```sh
[bundle exec] fastlane ios test
```

Executa todos os testes

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
