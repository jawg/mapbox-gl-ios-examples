# Integrating Jawg Maps with Mapbox GL iOS : Examples

Welcome to our example repository to integrate Jawg with Mapbox GL iOS.

Don't forget to set your access token in [ViewController.swift](./iOSJawgMaps/ViewController.swift).
If you don't have any access token yet, get one on [Jawg Lab](https://jawg.io/lab).

## Examples description :

[SimpleMapViewController](./iOSJawgMaps/Controllers/SimpleMapViewController.swift) : Displaying a simple dynamic map.

[AddMarkerViewController](./iOSJawgMaps/Controllers/AddMarkerViewController.swift) : Adding a simple marker on a map.

[AddPopupViewController](./iOSJawgMaps/Controllers/AddPopupViewController.swift) : Adding a popup with markers on a map.

[AddGeometryViewController](./iOSJawgMaps/Controllers/AddGeometryViewController.swift) : Adding geometry on your map with GeoJSON.

[ChangeLanguageViewController](./iOSJawgMaps/Controllers/ChangeLanguageViewController.swift) : Changing your map's language.

[ChangeStyleViewController](./iOSJawgMaps/Controllers/ChangeStyleViewController.swift) : Changing your map style using our default styles.

[CustomStyleViewController](./iOSJawgMaps/Controllers/CustomStyleViewController.swift) : Using a custom style from [Jawg Lab](https://jawg.io/lab) on your map.

> You'll need to set a style ID in `CustomStyleViewController` to make this example work.
>
> If you don't have any style ID yet, go to [Jawg Lab](https://jawg.io/lab/styles) to create one or read the [documentation](https://jawg.io/docs/maps#get-custom-style-id) for more informations.