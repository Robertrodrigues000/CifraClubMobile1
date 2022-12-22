# CifraClub Mobile

[![Build Status](https://drone.sscdn.co/api/badges/StudioSol/CifraClubMobile/status.svg?ref=refs/heads/development_flutter)](https://drone.sscdn.co/StudioSol/CifraClubMobile)

Bem vind@ ao repositório do maior aplicativo de ensino de música do Brasil! 🧡


### Localização de strings

Todas as strings a serem exibidas na tela devem ser localizadas.
Novas strings devem ser adicionadas nos arquivos: 
```
lib/presentation/localizations/l10n/app_<idioma>.arb`
```

Feita a edição dos arquivos `.arb`, deve ser executado o seguinte comando para que sejam gerados os arquivos `app_localizations_<idioma>.dart`:
```
flutter gen-l10n
```

### Para gerar os arquivos `.g`
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Formatação de código

Ao editar arquivos do código, devemos rodar o seguinte comando para que o tudo fique devidamente formatado:

```
flutter format --line-length=200 lib test
```