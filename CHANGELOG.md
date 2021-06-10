## 2.0.0 - 10.06.2021
- Migrate package to null-safety, increase minimum SDK version to 2.12 (Thanks @WebEferen https://github.com/WebEferen)
- Add method `deleteAll` for Delete all files and folders for passFiles from internal memory (Thanks @WebEferen https://github.com/WebEferen)
- Optimisation

## 1.2.2 - 01.04.2021
- Fix bug with compiling in Android and iOS
- Allow use package in all platform

## 1.2.1 - 26.03.2021
- Fix bug with colors (Thanks for report and fix to https://github.com/eltiganiomar).

## 1.2.0 - 02.10.2020
- Fix bug with images is null in PassJson model (Thanks for report about bug to https://github.com/srcnysf).

## 1.1.3 - 05.08.2020
- Fix bug with empty color in pass.json (Thanks for report about bug and fix to https://github.com/srcnysf).

## 1.1.2+hotfix1 - 16.07.2020
- Fix version in pubspec

## 1.1.2 - 16.07.2020
- Fix bug with use plugin in ios application
- Specifying a plugin’s supported platforms - ios and android

## 1.1.1 - 15.04.2020
- Update README.md after release 1.1.0 

## 1.1.0 - 14.04.2020
 - **BREAKING:** change method `fetchPreviewFromUrl` return type `PreviewPassFile` -> `PassFile`
 - **BREAKING:** remove `PreviewPassFile`
 - **BREAKING:** params name in methods `fetchPreviewFromUrl` and  `saveFromUrl` changed `urlToPass` -> `url`
 - Now `PassFile` include method for saving it toNow `PassFile` includes a method for saving it in the internal memory 
 - Refactoring and optimisation

## 1.0.4 - 07.04.2020
 - Now all colors value in pass.json converted from CSS-style RGB triple to Color

## 1.0.3 - 03.04.2020
 - **BREAKING:** change method name getFromUrl -> saveFromUrl and url now passes in `urlToPass`
 - add method `fetchPreviewFromUrl` for get preview from url
 - add method `PreviewPassFile.save` for save preview to app internal memory and deleting from temp directory
 - add documentation for all public api members
 - add `delete` method for deleting current pass file to class PassFile and PreviewPassFile
 - update return in `Pass.delete` method, after deleting now return list of saved pass files
 - enable stricter type checks
 - refactoring and optimization

## 1.0.2 - 28.03.2020
 - fix bug with `maxDistance` and `relevantDate` in pass json
 - fix bug with `auxiliaryFields`, `primaryFields`, `transitType`
 - add equatable for comparisons pass.json data
 - add documentation for Fields

## 1.0.1 - 13.03.2020
 - fix code format
 - add `altitude` to Location Dictionary Keys
 - add `maxDistance` to Relevance Keys
 - add documentation to Location Dictionary Keys model
 - add documentation to Barcode Dictionary Keys model
 - add documentation to Pass Structure Dictionary model
 - add documentation for Pass Json

## 1.0.0 - 13.03.2020
 - initial release