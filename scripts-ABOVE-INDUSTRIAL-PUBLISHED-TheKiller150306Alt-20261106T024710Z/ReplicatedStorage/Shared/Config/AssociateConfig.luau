-- Script path: game:GetService("ReplicatedStorage").Shared.Config.AssociateConfig
-- Decompile time: 0.14 ms

return {
    StoreName = "AboveAssociates_v1",
    Keep = 50,
    FlushSeconds = 300,
    VisitTickSeconds = 60,
    QuickRevokeSeconds = 1800,
    ReportTop = 6,
    Weights = {
        coop = 40,
        coopMinute = 0.1,
        grant = 25,
        quickRevoke = 15,
        trade = 3,
        pickup = 3,
        chest = 2,
        place = 0.5,
        visitMinute = 0.05,
        follow = 5,
        valuePerThousand = 2,
    },
}