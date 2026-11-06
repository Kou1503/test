-- Script path: game:GetService("StarterPlayer").StarterPlayerScripts.Client
-- Decompile time: 7.49 ms

local Shared = game:GetService("ReplicatedStorage"):WaitForChild("Shared")
local v1 = require(Shared.Config)
local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local LandscapeSensor = Enum.ScreenOrientation.LandscapeSensor

local function holdLandscape() -- Line: 21; upvalues: PlayerGui (val), LandscapeSensor (val)
    if PlayerGui.ScreenOrientation ~= LandscapeSensor then
        PlayerGui.ScreenOrientation = LandscapeSensor
    end
end

if PlayerGui.ScreenOrientation ~= LandscapeSensor then
    PlayerGui.ScreenOrientation = LandscapeSensor
end

;(PlayerGui:GetPropertyChangedSignal("ScreenOrientation")):Connect(holdLandscape)

Players.LocalPlayer.CharacterAdded:Connect(function() -- Line: 28; upvalues: holdLandscape (val)
    task.defer(holdLandscape)
end)

task.delay(
    5,
    function() -- Line: 32; upvalues: PlayerGui (val)
        if game:GetService("UserInputService").TouchEnabled then
            print((("[ABOVE] orientation: asked %*, device is %*"):format(PlayerGui.ScreenOrientation.Name, PlayerGui.CurrentScreenOrientation.Name)))
        end
    end
)

local Controllers = script.Controllers
require(Controllers.LoadChoiceController).start()
require(Controllers.SettingsController).start()

local DeviceMode = require(Controllers.DeviceMode)
DeviceMode.resolve()

local Ui = require(script.Ui)
Ui.TouchOnly = DeviceMode.touchOnly()

require(Controllers.ThemeController).start()
require(Controllers.TextSizeController).start()
require(Controllers.GuiScaleController).start()
require(Controllers.HintController).start()
require(Controllers.AudioController).start()
require(Controllers.AmbienceController).start()
require(Controllers.TimeController).start()
require(Controllers.WeatherFxController).start()
require(Controllers.NoticeController).start()
require(Controllers.ChatLineController).start()
require(Controllers.BeeController).start()
require(Controllers.BuilderLightController).start()
require(Controllers.PortalMoveController).start()
require(Controllers.SlimeController).start()
require(Controllers.ScreenshotModeController).start()
require(Controllers.FreecamController).start()
require(Controllers.HudController).start()
require(Controllers.NewBadges).start()
require(Controllers.BackpackController).start()
require(Controllers.HotbarController).start()
require(Controllers.BuildController).start()
require(Controllers.WaterZoneController).start()
require(Controllers.LooseCountController).start()
require(Controllers.BoostController).start()
require(Controllers.PumpController).start()
require(Controllers.MachineStatusController).start()
require(Controllers.CraftingController).start()
require(Controllers.StorageController).start()
require(Controllers.VendingController).start()
require(Controllers.ComposterController).start()
require(Controllers.GuestBookController).start()
require(Controllers.PromptController).start()
require(Controllers.ShopController).start()
require(Controllers.DialogueController).start()
require(Controllers.TargetController).start()
require(Controllers.AdminFxController).start()
require(Controllers.FoodFxController).start()
require(Controllers.LeaderboardYouController).start()
require(Controllers.PressStrokeController).start()
require(Controllers.ScrollBarController).start()
require(Controllers.ServerEventController).start()
require(Controllers.IslandInviteController).start()
require(Controllers.RestartNoticeController).start()
require(Controllers.BoundaryController).start()
require(Controllers.CameraController).start()
require(Controllers.ShiftLockController).start()
require(Controllers.CursorController).start()
require(Controllers.SettingsPanelController).start()
require(Controllers.NewsController).start()
require(Controllers.EnemyViewController).start()
require(Controllers.IslandPermissionsController).start()
require(Controllers.FavoritePromptController).start()
require(Controllers.FloaterController).start()
require(Controllers.AnnouncementController).start()
require(Controllers.ObjectiveController).start()
require(Controllers.TutorialController).start()
require(Controllers.VersionController).start()
require(Controllers.WelcomeController).start()
require(Controllers.ShowcaseController).start()
require(Controllers.GuideController).start()
require(Controllers.ShowroomController).start()
require(Controllers.TravelController).start()
require(Controllers.WorldLabelsController).start()
require(Controllers.CollectionController).start()
require(Controllers.AchievementsController).start()
require(Controllers.SpinningArtController).start()
require(Controllers.PortalSkinController).start()
require(Controllers.PremiumShopController).start()
require(Controllers.FriendsController).start()
require(Controllers.FlightController).start()
require(Controllers.SwimController).start()
require(Controllers.AnimationController).start()
require(Controllers.ViewmodelController).start()
require(Controllers.HitFeedbackController).start()
require(Controllers.GatherFxController).start()
require(Controllers.ToastController).start()
require(Controllers.SpecialDropController).start()
require(Controllers.CelebrationController).start()
require(Controllers.DevConsoleController).start()
require(Controllers.SignController).start()
require(Controllers.CartController).start()
require(Controllers.SaveViewBannerController).start()
require(Controllers.IslandResetController).start()
require(Controllers.IslandsController).start()
require(Controllers.MenuBarController).start()
require(Controllers.InputController).start()
require(Controllers.GamepadController).start()
require(Controllers.TouchController).start()
require(Controllers.TapDebugController).start()

local Remotes = require(Shared.Remotes)
Remotes.get(Remotes.RequestSync):FireServer()
print((("[ABOVE] client ready (v%*)"):format(v1.Version)))