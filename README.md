# Meio Fixes

Stops Lua errors in Blizzard's own auction house and profession windows.

![Posting Linen Cloth on the auction house: before, Create Auction gives a Lua error and
nothing is posted; with MeioFixes, "Auction created."](docs/before-after.png)

## What it does

Fixes bugs in Blizzard's UI that throw Lua errors (or a BugSack alert) in normal play. Each
fix only steps in where the error would happen; everything else works as Blizzard made it.

- **Auction house, Create Auction**: on trade goods it sometimes failed with
  `Blizzard_AuctionHouseSellFrame.lua:477: attempt to compare nil with number` and nothing
  was posted. Now the auction is created.
- **Auction house, Browse**: clicking a result before its name had loaded failed with
  `Blizzard_AuctionHouseFrame.lua:686: attempt to index local 'itemKeyInfo'`. Now that
  click does nothing; click again once the name shows.
- **Profession window**: after a recipe search, changing talents failed with
  `Blizzard_ProfessionsRecipeList.lua:359: attempt to call a nil value`, often ten at once.
  Now nothing happens.

No settings.

## Install

Use your addon manager (CurseForge, Wago), or unzip a GitHub release into
`World of Warcraft\_forever_\Interface\AddOns` and restart WoW fully.

## Feedback

Bugs and ideas: [GitHub issues](https://github.com/MeioNeiz/MeioFixes/issues)

## More Meio addons

[Meio Next Stop](https://www.curseforge.com/wow/addons/leavebutton) | [Meio TrainerCompare](https://www.curseforge.com/wow/addons/trainercompare) | [Meio AutoRank](https://www.curseforge.com/wow/addons/meio-autorank) | [Meio MeterHover](https://www.curseforge.com/wow/addons/meterhover) | [Meio Map](https://addons.wago.io/addons/meiomap) | [Meio Alts](https://addons.wago.io/addons/meioalts) | [Meio DPS](https://addons.wago.io/addons/meiodps) | [Meio Plates](https://addons.wago.io/addons/meioplates) | [Meio Hub](https://addons.wago.io/addons/meiohub) | [Meio Pets](https://addons.wago.io/addons/meiopets) | [Meio Stats](https://addons.wago.io/addons/meiostats)

## Licence

[MIT](LICENSE)
