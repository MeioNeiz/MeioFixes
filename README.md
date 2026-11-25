# Meio Fixes

Stops Lua errors in Blizzard's own auction house and profession windows.

For WoW Forever.

![The same Linen Cloth post side by side: before, Create Auction gives a Lua error and
nothing is posted; with MeioFixes, "Auction created."](docs/before-after.png)

## What it does

Fixes bugs in Blizzard's UI that throw Lua errors (or a BugSack alert) in normal play. Each
fix changes nothing unless the error would happen.

- **Create Auction on trade goods posted nothing**: now the auction is created. The error
  was `Blizzard_AuctionHouseSellFrame.lua:477: attempt to compare nil with number`
- **Clicking an auction house result too early gave an error**: now that click does
  nothing; click again once the name shows. The error was
  `Blizzard_AuctionHouseFrame.lua:686: attempt to index local 'itemKeyInfo'`
- **Changing talents after a recipe search gave ten errors at once**: now nothing happens.
  The error was `Blizzard_ProfessionsRecipeList.lua:359: attempt to call a nil value`

![Auction house results, the mouse on a result still loading: before, a Lua error; with Meio
Fixes, nothing happens](docs/browse.png)

No settings.

## Install

Use your addon manager (CurseForge, Wago), or unzip a GitHub release into
`World of Warcraft\_forever_\Interface\AddOns` and restart WoW fully.

## Feedback

Bugs and ideas: [GitHub issues](https://github.com/MeioNeiz/MeioFixes/issues)

## More Meio addons

[Meio Trainer Compare](https://www.curseforge.com/wow/addons/trainercompare) | [Meio Next Stop](https://www.curseforge.com/wow/addons/leavebutton) | [Meio Auto Rank](https://www.curseforge.com/wow/addons/meio-autorank) | [Meio Meter Hover](https://www.curseforge.com/wow/addons/meterhover) | [Meio Map](https://addons.wago.io/addons/meiomap) | [Meio Alts](https://addons.wago.io/addons/meioalts) | [Meio DPS](https://addons.wago.io/addons/meiodps) | [Meio Plates](https://addons.wago.io/addons/meioplates) | [Meio Hub](https://addons.wago.io/addons/meiohub) | [Meio Pets](https://addons.wago.io/addons/meiopets) | [Meio Stats](https://addons.wago.io/addons/meiostats) | [Meio Bags](https://addons.wago.io/addons/meiobags) | [Meio Flight Times](https://addons.wago.io/addons/meioflighttimes) | [Meio Tooltip Fold](https://addons.wago.io/addons/meiotooltipfold) | [Meio Auto Run Turn](https://addons.wago.io/addons/meioautorunturn) | [Meio Mail](https://addons.wago.io/addons/meiomail) | [Meio QoL](https://addons.wago.io/addons/meioqol) | [Meio TSM Browse](https://addons.wago.io/addons/tsmbrowse) | [Meio Shards](https://addons.wago.io/addons/meioshards) | [Meio Spike Check](https://addons.wago.io/addons/meiospikecheck) | [Meio BiS Extras](https://addons.wago.io/addons/meiobisextras) | [Meio Buff Thanks](https://addons.wago.io/addons/meiobuffthanks) | [Meio Flare Fixes](https://addons.wago.io/addons/meioflarefixes) | [Meio Flare Questie](https://addons.wago.io/addons/meioflarequestie)

## Licence

[MIT](LICENSE)
