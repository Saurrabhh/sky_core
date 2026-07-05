# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 2026-07-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_bloc` - `v2.0.11`](#sky_bloc---v2011)
 - [`sky_network` - `v1.1.7`](#sky_network---v117)
 - [`sky_telemetry` - `v1.1.2`](#sky_telemetry---v112)
 - [`sky_telemetry_firebase` - `v1.1.2`](#sky_telemetry_firebase---v112)
 - [`sky_router` - `v1.1.3`](#sky_router---v113)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `sky_router` - `v1.1.3`

---

#### `sky_bloc` - `v2.0.11`

 - **FIX**(sky_bloc): rename AppLogging to AppLoggerRegistry in BLoC observer.

#### `sky_network` - `v1.1.7`

 - **FIX**(sky_network): rename AppLogging to AppLoggerRegistry in telemetry interceptor and mock tests.

#### `sky_telemetry` - `v1.1.2`

 - **FIX**(sky_telemetry): standardize naming to AppCrashlytics and registry suffix.

#### `sky_telemetry_firebase` - `v1.1.2`

 - **FIX**(sky_telemetry_firebase): update Firebase crashlytics concrete reporter to implement AppCrashlytics.


## 2026-07-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_router` - `v1.1.2`](#sky_router---v112)
 - [`sky_telemetry` - `v1.1.1`](#sky_telemetry---v111)
 - [`sky_telemetry_firebase` - `v1.1.1`](#sky_telemetry_firebase---v111)
 - [`sky_bloc` - `v2.0.10`](#sky_bloc---v2010)
 - [`sky_network` - `v1.1.6`](#sky_network---v116)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `sky_bloc` - `v2.0.10`
 - `sky_network` - `v1.1.6`

---

#### `sky_router` - `v1.1.2`

 - **FIX**(sky_router): add LICENSE and README for pub compliance.

#### `sky_telemetry` - `v1.1.1`

 - **FIX**(sky_telemetry): remove library.

#### `sky_telemetry_firebase` - `v1.1.1`

 - **FIX**(sky_telemetry_firebase): add LICENSE and README for pub compliance.


## 2026-07-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_bloc` - `v2.0.9`](#sky_bloc---v209)
 - [`sky_network` - `v1.1.5`](#sky_network---v115)
 - [`sky_router` - `v1.1.1`](#sky_router---v111)
 - [`sky_telemetry` - `v1.1.0`](#sky_telemetry---v110)
 - [`sky_telemetry_firebase` - `v1.1.0`](#sky_telemetry_firebase---v110)

---

#### `sky_bloc` - `v2.0.9`

 - **FIX**(sky_bloc): update Cubit/BLoC observer references to AppLogging.

#### `sky_network` - `v1.1.5`

 - **FIX**(sky_network): update telemetry interceptor and mock tests to App registries.

#### `sky_router` - `v1.1.1`

 - **FIX**(sky_router): update custom navigator observer to AppLogger and remove telemetry exports.

#### `sky_telemetry` - `v1.1.0`

 - **FEAT**(sky_telemetry): refactor logging, analytics, and crash reporting contracts to App prefix.

#### `sky_telemetry_firebase` - `v1.1.0`

 - **FEAT**(sky_telemetry_firebase): implement Firebase Analytics and Crashlytics concrete engines.


## 2026-07-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_router` - `v1.1.0`](#sky_router---v110)

---

#### `sky_router` - `v1.1.0`

 - **FEAT**: export ConsoleLogger from sky_router.
 - **FEAT**(sky_router): add sky_router package wrapping go_router.


## 2026-07-04

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_network` - `v1.1.4`](#sky_network---v114)

---

#### `sky_network` - `v1.1.4`

 - **FIX**(sky_network): handle DioExceptionType.transformTimeout in error mapping.


## 2026-07-04

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_network` - `v1.1.3`](#sky_network---v113)

---

#### `sky_network` - `v1.1.3`

 - **FIX**(sky_network): DioFactory refactor.


## 2026-06-29

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_network` - `v1.1.2`](#sky_network---v112)

---

#### `sky_network` - `v1.1.2`

 - **FIX**(sky_network): error handling.


## 2026-06-28

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_network` - `v1.1.1`](#sky_network---v111)

---

#### `sky_network` - `v1.1.1`

 - **FIX**(sky_network): warnings fix.


## 2026-06-28

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_network` - `v1.1.0`](#sky_network---v110)

---

#### `sky_network` - `v1.1.0`

 - **FEAT**(sky_network): implement telemetry tracking, clock drift synchronization, and User-Agent enrichment.
 - **FEAT**(sky_network): implement background transformer, retry interceptor with jitter, and dynamic base URL resolver.
 - **FEAT**(sky_network): implement ssl certificate pinning and flag-based logging configuration.


## 2026-06-14

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_design_system` - `v1.7.1`](#sky_design_system---v171)

---

#### `sky_design_system` - `v1.7.1`

 - **FIX**(sky_design_system): format app_raster_web and app_svg_image_io.


## 2026-06-14

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_design_system` - `v1.7.0`](#sky_design_system---v170)

---

#### `sky_design_system` - `v1.7.0`

 - **FEAT**(sky_design_system): support web platform for local file images in AppImage.
 - **DOCS**(sky_design_system): add comprehensive doc comments to AppImage components.


## 2026-06-13

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_architecture` - `v1.6.0`](#sky_architecture---v160)
 - [`sky_design_system` - `v1.6.1`](#sky_design_system---v161)
 - [`sky_bloc` - `v2.0.8`](#sky_bloc---v208)
 - [`sky_network` - `v1.0.9`](#sky_network---v109)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `sky_bloc` - `v2.0.8`
 - `sky_network` - `v1.0.9`

---

#### `sky_architecture` - `v1.6.0`

 - **FEAT**(sky_architecture): add functional error handling typedefs.

#### `sky_design_system` - `v1.6.1`

 - **FIX**(sky_design_system): reformat ternary operators in AppSnackBar.


## 2026-06-07

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_design_system` - `v1.6.0`](#sky_design_system---v160)

---

#### `sky_design_system` - `v1.6.0`

 - **FEAT**(sky_design_system): add border radius property in app_icon_button.dart.


## 2026-06-07

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_design_system` - `v1.5.1`](#sky_design_system---v151)

---

#### `sky_design_system` - `v1.5.1`

 - **FIX**(sky_design_system): app snackbar.


## 2026-06-07

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_architecture` - `v1.5.0`](#sky_architecture---v150)
 - [`sky_bloc` - `v2.0.7`](#sky_bloc---v207)
 - [`sky_network` - `v1.0.8`](#sky_network---v108)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `sky_bloc` - `v2.0.7`
 - `sky_network` - `v1.0.8`

---

#### `sky_architecture` - `v1.5.0`

 - **FEAT**(sky_design_system): update value_objects.dart.


## 2026-06-06

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_design_system` - `v1.5.0`](#sky_design_system---v150)

---

#### `sky_design_system` - `v1.5.0`

 - **FEAT**(sky_design_system): add TextInputAction.


## 2026-06-06

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_architecture` - `v1.4.0`](#sky_architecture---v140)
 - [`sky_bloc` - `v2.0.6`](#sky_bloc---v206)
 - [`sky_network` - `v1.0.7`](#sky_network---v107)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `sky_bloc` - `v2.0.6`
 - `sky_network` - `v1.0.7`

---

#### `sky_architecture` - `v1.4.0`

 - **FEAT**(sky_design_system): add password text field.


## 2026-06-06

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_design_system` - `v1.4.2`](#sky_design_system---v142)

---

#### `sky_design_system` - `v1.4.2`

 - **FIX**(sky_design_system): autoValidateMode is always by default.


## 2026-06-06

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_design_system` - `v1.4.1`](#sky_design_system---v141)

---

#### `sky_design_system` - `v1.4.1`

 - **FIX**(sky_design_system): app scroll under elevation.


## 2026-06-06

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_architecture` - `v1.3.0`](#sky_architecture---v130)
 - [`sky_bloc` - `v2.0.5`](#sky_bloc---v205)
 - [`sky_design_system` - `v1.4.0`](#sky_design_system---v140)
 - [`sky_network` - `v1.0.6`](#sky_network---v106)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `sky_network` - `v1.0.6`

---

#### `sky_architecture` - `v1.3.0`

 - **FEAT**(sky_architecture): add email, name and phone number value objects.

#### `sky_bloc` - `v2.0.5`

 - **FIX**(sky_bloc): dart format.

#### `sky_design_system` - `v1.4.0`

 - **FIX**(sky_design_system): dart format.
 - **FEAT**(sky_design_system): add color property in app bar.
 - **FEAT**(sky_design_system): add rich text.


## 2026-06-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_design_system` - `v1.3.1`](#sky_design_system---v131)

---

#### `sky_design_system` - `v1.3.1`

 - **FIX**(sky_design_system): default spacing.


## 2026-06-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_design_system` - `v1.3.0`](#sky_design_system---v130)

---

#### `sky_design_system` - `v1.3.0`

 - **FEAT**(sky_design_system): add TextAlign.


## 2026-06-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_design_system` - `v1.2.2`](#sky_design_system---v122)

---

#### `sky_design_system` - `v1.2.2`

 - **FIX**(sky_design_system): text height.


## 2026-06-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_design_system` - `v1.2.1`](#sky_design_system---v121)

---

#### `sky_design_system` - `v1.2.1`

 - **FIX**(sky_design_system): button responsive.


## 2026-06-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_design_system` - `v1.2.0`](#sky_design_system---v120)

---

#### `sky_design_system` - `v1.2.0`

 - **FEAT**(sky_design_system): add color in app_card.dart.
 - **FEAT**(sky_design_system): add scroll views.


## 2026-06-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_bloc` - `v2.0.4`](#sky_bloc---v204)

---

#### `sky_bloc` - `v2.0.4`

 - **FIX**(sky_bloc): print removed.


## 2026-06-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_architecture` - `v1.2.0`](#sky_architecture---v120)
 - [`sky_bloc` - `v2.0.3`](#sky_bloc---v203)
 - [`sky_network` - `v1.0.5`](#sky_network---v105)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `sky_bloc` - `v2.0.3`
 - `sky_network` - `v1.0.5`

---

#### `sky_architecture` - `v1.2.0`

 - **FEAT**(sky_bloc): add helper no params variable.


## 2026-06-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_bloc` - `v2.0.2`](#sky_bloc---v202)

---

#### `sky_bloc` - `v2.0.2`

 - **FIX**(sky_bloc): loading state fn name change.


## 2026-06-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_architecture` - `v1.1.0`](#sky_architecture---v110)
 - [`sky_bloc` - `v2.0.1`](#sky_bloc---v201)
 - [`sky_network` - `v1.0.4`](#sky_network---v104)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `sky_bloc` - `v2.0.1`
 - `sky_network` - `v1.0.4`

---

#### `sky_architecture` - `v1.1.0`

 - **FEAT**(sky_architecture): make usecases pure interfaces.


## 2026-06-05

### Changes

---

Packages with breaking changes:

 - [`sky_bloc` - `v2.0.0`](#sky_bloc---v200)

Packages with other changes:

 - There are no other changes in this release.

---

#### `sky_bloc` - `v2.0.0`

 - **BREAKING** **FEAT**(sky_bloc): remove isLoading getter.


## 2026-06-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_bloc` - `v1.2.3`](#sky_bloc---v123)

---

#### `sky_bloc` - `v1.2.3`

 - **FIX**(sky_bloc): fix loader widget.
 - **DOCS**(sky_bloc): add doc comments on BasePage.


## 2026-06-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_bloc` - `v1.2.2`](#sky_bloc---v122)

---

#### `sky_bloc` - `v1.2.2`

 - **DOCS**(sky_bloc): add pub.dev-compliant dartdoc comments to BasePage and export it.


## 2026-06-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_architecture` - `v1.0.3`](#sky_architecture---v103)
 - [`sky_bloc` - `v1.2.1`](#sky_bloc---v121)
 - [`sky_design_system` - `v1.1.1`](#sky_design_system---v111)
 - [`sky_network` - `v1.0.3`](#sky_network---v103)
 - [`sky_storage` - `v1.0.3`](#sky_storage---v103)
 - [`sky_storage_hive` - `v1.0.3`](#sky_storage_hive---v103)
 - [`sky_storage_isar` - `v1.0.3`](#sky_storage_isar---v103)
 - [`sky_telemetry` - `v1.0.3`](#sky_telemetry---v103)
 - [`sky_utils` - `v1.0.3`](#sky_utils---v103)

---

#### `sky_architecture` - `v1.0.3`

 - **DOCS**(sky_architecture): add pub.dev-compliant dartdoc comments to public API.

#### `sky_bloc` - `v1.2.1`

 - **FIX**(sky_bloc): add bloc lints as dependency.
 - **DOCS**(sky_bloc): add pub.dev-compliant dartdoc comments to public API.

#### `sky_design_system` - `v1.1.1`

 - **DOCS**(sky_design_system): add pub.dev-compliant dartdoc comments to public API.

#### `sky_network` - `v1.0.3`

 - **DOCS**(sky_network): add pub.dev-compliant dartdoc comments to public API.

#### `sky_storage` - `v1.0.3`

 - **DOCS**(sky_storage): add pub.dev-compliant dartdoc comments to public API.

#### `sky_storage_hive` - `v1.0.3`

 - **DOCS**(sky_storage_hive): add pub.dev-compliant dartdoc comments to public API.

#### `sky_storage_isar` - `v1.0.3`

 - **DOCS**(sky_storage_isar): add pub.dev-compliant dartdoc comments to public API.

#### `sky_telemetry` - `v1.0.3`

 - **DOCS**(sky_telemetry): add pub.dev-compliant dartdoc comments to public API.

#### `sky_utils` - `v1.0.3`

 - **DOCS**(sky_utils): add pub.dev-compliant dartdoc comments to public API.


## 2026-06-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_bloc` - `v1.2.0`](#sky_bloc---v120)

---

#### `sky_bloc` - `v1.2.0`

 - **FEAT**(sky_bloc): add flutter_bloc and bloc lints.


## 2026-05-31

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_design_system` - `v1.1.0`](#sky_design_system---v110)

---

#### `sky_design_system` - `v1.1.0`

 - **FEAT**(sky_design_system): add AppShimmer and AppImage.


## 2026-05-31

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_architecture` - `v1.0.2`](#sky_architecture---v102)
 - [`sky_bloc` - `v1.1.2`](#sky_bloc---v112)
 - [`sky_design_system` - `v1.0.2`](#sky_design_system---v102)
 - [`sky_lints` - `v1.0.2`](#sky_lints---v102)
 - [`sky_network` - `v1.0.2`](#sky_network---v102)
 - [`sky_storage` - `v1.0.2`](#sky_storage---v102)
 - [`sky_storage_hive` - `v1.0.2`](#sky_storage_hive---v102)
 - [`sky_storage_isar` - `v1.0.2`](#sky_storage_isar---v102)
 - [`sky_telemetry` - `v1.0.2`](#sky_telemetry---v102)
 - [`sky_utils` - `v1.0.2`](#sky_utils---v102)

---

#### `sky_architecture` - `v1.0.2`

 - **FIX**(sky_architecture): point repository URL to package subdirectory on GitHub.

#### `sky_bloc` - `v1.1.2`

 - **FIX**(sky_bloc): point repository URL to package subdirectory on GitHub.

#### `sky_design_system` - `v1.0.2`

 - **FIX**(sky_design_system): point repository URL to package subdirectory on GitHub.

#### `sky_lints` - `v1.0.2`

 - **FIX**(sky_lints): point repository URL to package subdirectory on GitHub.

#### `sky_network` - `v1.0.2`

 - **FIX**(sky_network): point repository URL to package subdirectory on GitHub.

#### `sky_storage` - `v1.0.2`

 - **FIX**(sky_storage): point repository URL to package subdirectory on GitHub.

#### `sky_storage_hive` - `v1.0.2`

 - **FIX**(sky_storage_hive): point repository URL to package subdirectory on GitHub.

#### `sky_storage_isar` - `v1.0.2`

 - **FIX**(sky_storage_isar): point repository URL to package subdirectory on GitHub.

#### `sky_telemetry` - `v1.0.2`

 - **FIX**(sky_telemetry): point repository URL to package subdirectory on GitHub.

#### `sky_utils` - `v1.0.2`

 - **FIX**(sky_utils): point repository URL to package subdirectory on GitHub.


## 2026-05-31

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_architecture` - `v1.0.1`](#sky_architecture---v101)
 - [`sky_bloc` - `v1.1.1`](#sky_bloc---v111)
 - [`sky_design_system` - `v1.0.1`](#sky_design_system---v101)
 - [`sky_lints` - `v1.0.1`](#sky_lints---v101)
 - [`sky_network` - `v1.0.1`](#sky_network---v101)
 - [`sky_storage` - `v1.0.1`](#sky_storage---v101)
 - [`sky_storage_hive` - `v1.0.1`](#sky_storage_hive---v101)
 - [`sky_storage_isar` - `v1.0.1`](#sky_storage_isar---v101)
 - [`sky_telemetry` - `v1.0.1`](#sky_telemetry---v101)
 - [`sky_utils` - `v1.0.1`](#sky_utils---v101)

---

#### `sky_architecture` - `v1.0.1`

#### `sky_bloc` - `v1.1.1`

#### `sky_design_system` - `v1.0.1`

#### `sky_lints` - `v1.0.1`

#### `sky_network` - `v1.0.1`

#### `sky_storage` - `v1.0.1`

#### `sky_storage_hive` - `v1.0.1`

#### `sky_storage_isar` - `v1.0.1`

#### `sky_telemetry` - `v1.0.1`

#### `sky_utils` - `v1.0.1`


## 2026-05-31

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`sky_bloc` - `v1.1.0`](#sky_bloc---v110)

---

#### `sky_bloc` - `v1.1.0`

 - **FEAT**(sky_bloc): update bloc version (#1).

