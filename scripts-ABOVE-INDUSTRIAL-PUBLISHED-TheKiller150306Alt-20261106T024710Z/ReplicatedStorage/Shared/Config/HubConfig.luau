-- Script path: game:GetService("ReplicatedStorage").Shared.Config.HubConfig
-- Decompile time: 0.44 ms

local v1 = {
    Origin = Vector3.new(0, 200, 0),
    SizeStuds = Vector3.new(600, 80, 600),
    BuildingAllowed = false,
    PrefabCategory = "Hub",
    Prefabs = {ShopKeeper = "ShopKeeper"},
    FolderName = "Hub",
    NPCFolderName = "NPC",
    ShopKeeperName = "ShopKeeper",
    SpawnNames = {"HubSpawn", "HomeSpawn"},
    ShopKeeperOffset = Vector3.new(0, 0, -40),
}
v1.VendorOffsets = {
    BlockDealer = Vector3.new(-34, 0, -22),
    SeedDealer = Vector3.new(34, 0, -22),
    Collector = Vector3.new(-62, 0, -44),
    Landman = Vector3.new(62, 0, -44),
    Machinist = Vector3.new(0, 0, -68),
    Florist = Vector3.new(-34, 0, -80),
    Chef = Vector3.new(34, 0, -80),
    Merchant = v1.ShopKeeperOffset,
}
v1.PondOffset = Vector3.new(84, -3, -43)
v1.SpawnsFolderName = "Spawns"
v1.GuardianAnchorName = "Guardian"
v1.AuthoredPortalName = "HOME"
v1.Ruins = {
    PortalName = "RUINS",
    ModelName = "Ruins",
    SpawnName = "RuinsSpawn",
    ArrivalLiftStuds = 3,
    HubPortalName = "HUB",
    ReturnSpawnName = "HubSpawnRuins",
}
v1.WellFillsFrom = require(script.Parent.BuildConfig).WellSourceBlock
v1.PortalCell = require(script.Parent.BuildConfig).HubPortalCell
v1.PortalSizeStuds = Vector3.new(9, 12, 2)
v1.PortalSolidParts = {Portal = true}
v1.PortalRotationDegrees = 90
v1.HomePortalRotationDegrees = 180
v1.HomePortalOffset = Vector3.new(0, 0, 24)
v1.ArrivalOffset = Vector3.new(0, 4, 40)
v1.PortalCooldownSeconds = 3
v1.PortalMove = {CooldownSeconds = 60, SpawnClearanceCells = 5, PromptActionText = "Move"}
v1.PortalSignLiftStuds = 6
v1.ShopReachStuds = 14

return v1