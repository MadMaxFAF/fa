local Grid = import("/lua/ai/grid.lua").Grid

local TableInsert = table.insert

local WeakValue = { __mode = 'v' }

local Debug = false
function EnableDebugging()
    if ScenarioInfo.GameHasAIs or CheatsEnabled() then
        Debug = true
    end
end

function DisableDebugging()
    if ScenarioInfo.GameHasAIs or CheatsEnabled() then
        Debug = false
    end
end

---@type GridReclaimUIDebugCell
local DebugCellData = {
    ReclaimCount = -1,
    TotalEnergy = -1,
    TotalMass = -1,
    X = -1,
    Z = -1,
}

---@type GridReclaimUIDebugUpdate
local DebugUpdateData = {
    Processed = -1,
    Time = -1,
    Updates = -1,
}

---@class AIGridReclaimCell : AIGridCell
---@field TotalMass number
---@field TotalEnergy number
---@field ReclaimCount number
---@field Reclaim table<EntityId, Prop>

---@class AIGridReclaim : AIGrid
---@field Cells AIGridReclaimCell[][]
---@field UpdateList table<string, AIGridReclaimCell>
---@field OrderedCells AIGridReclaimCell[]
---@field Brains table<number, AIBrain>
GridReclaim = Class(Grid) {

    ---@param self AIGridReclaim
    __init = function(self)
        Grid.__init(self)

        local cellCount = self.CellCount
        local cells = self.Cells
        local orderedCells = {}

        for k = 1, cellCount do
            for l = 1, cellCount do
                local cell = cells[k][l]
                cell.TotalMass = 0
                cell.TotalEnergy = 0
                cell.ReclaimCount = 0
                cell.Reclaim = setmetatable({}, WeakValue)

                TableInsert(orderedCells, cell)
            end
        end

        self.OrderedCells = orderedCells
        self.UpdateList = {}
        self.Brains = {}

        self:Update()
        self:DebugUpdate()
    end,

    ---@param self AIGridReclaim
    Update = function(self)
        ForkThread(
            self.UpdateThread,
            self
        )
    end,

    ---@param self AIGridReclaim
    ---@param cell AIGridReclaimCell
    UpdateCell = function(self, cell)
        local count = 0
        local totalMass = 0
        local totalEnergy = 0

        for id, reclaim in cell.Reclaim do
            count = count + 1
            local fraction = reclaim.ReclaimLeft or 0
            totalMass = totalMass + fraction * (reclaim.MaxMassReclaim or 0)
            totalEnergy = totalEnergy + fraction * (reclaim.MaxEnergyReclaim or 0)
        end

        cell.TotalMass = totalMass
        cell.TotalEnergy = totalEnergy
        cell.ReclaimCount = count

        if Debug then
            DebugUpdateData.Processed = DebugUpdateData.Processed + cell.ReclaimCount
            DebugUpdateData.Updates = DebugUpdateData.Updates + 1
            self:DebugCellUpdate(cell.X, cell.Z)
        end
    end,

    ---@param self AIGridReclaim
    UpdateCells = function(self, limit)
        local updates = 0
        for id, cell in self.UpdateList do
            -- only update up to 8 cells
            updates = updates + 1
            if updates > limit then
                break
            end

            self.UpdateList[id] = nil
            self:UpdateCell(cell)

            -- inform ai brains of changes
            for k, brain in self.Brains do
                if brain.OnReclaimUpdate then
                    brain:OnReclaimUpdate(self, cell)
                end
            end
        end

        -- sort the cells
        if updates > 0 then
            table.sort(
                self.OrderedCells,

                ---@param a AIGridReclaimCell
                ---@param b AIGridReclaimCell
                ---@return boolean
                function(a, b)
                    return a.TotalMass > b.TotalMass
                end
            )
        end
    end,

    ---@param self AIGridReclaim
    UpdateThread = function(self)
        while true do
            WaitTicks(6)

            local start
            if Debug then
                start = GetSystemTimeSecondsOnlyForProfileUse()

                -- reset accumulative fields
                DebugUpdateData.Processed = 0
                DebugUpdateData.Updates = 0
            end

            self:UpdateCells(8)

            if Debug then
                -- DebugUpdateData.Memory = import("/lua/system/utils.lua").ToBytes(self, { Reclaim = true }) / (1024 * 1024)
                DebugUpdateData.Time = GetSystemTimeSecondsOnlyForProfileUse() - start
                Sync.GridReclaimUIDebugUpdate = DebugUpdateData
            end
        end
    end,

    -------------------------------
    -- Reclaim related functions --

    --- Called by a prop as it is destroyed
    ---@param self AIGridReclaim
    ---@param prop Prop
    OnReclaimDestroyed = function(self, prop)
        local position = prop.CachePosition or prop:GetPosition()
        local bx, bz = self:ToCellIndices(position[1], position[3])

        local cell = self.Cells[bx][bz]
        cell.Reclaim[prop.EntityId] = nil

        self.UpdateList[cell.Identifier] = cell

        self:DebugPropDestroyed(prop)
    end,

    --- Called by a prop as the reclaim value is adjusted
    ---@param self AIGridReclaim
    ---@param prop Prop
    OnReclaimUpdate = function(self, prop)
        local position = prop.CachePosition or prop:GetPosition()
        local bx, bz = self:ToCellIndices(position[1], position[3])

        local cell = self.Cells[bx][bz]
        cell.Reclaim[prop.EntityId] = prop

        self.UpdateList[cell.Identifier] = cell

        self:DebugPropUpdated(prop)
    end,

    -------------------------------
    -- AIBrain related functions --

    --- Called by a brain to initialize logic that runs for just that brain
    ---@param self AIGridReclaim
    ---@param brain AIBrain
    RegisterBrain = function(self, brain)
        self.Brains[brain:GetArmyIndex()] = brain
    end,

    ---------------------
    -- Debug functions --

    --- Contains various debug logic
    ---@param self AIGridReclaim
    DebugUpdate = function(self)
        ForkThread(
            self.DebugUpdateThread,
            self
        )
    end,

    --- Allows us to scan the map
    ---@param self AIGridReclaim
    DebugUpdateThread = function(self)
        while true do
            WaitTicks(1)

            -- mouse scanning
            if Debug then
                local mouse = GetMouseWorldPos()
                local bx, bz = self:ToCellIndices(mouse[1], mouse[3])
                local cell = self.Cells[bx][bz]

                local totalMass = cell.TotalMass
                if totalMass and totalMass > 0 then
                    self:DrawCell(bx, bz, math.log(totalMass) - 1, '00610B')
                end

                local totalEnergy = cell.TotalEnergy
                if totalEnergy and totalEnergy > 0 then
                    self:DrawCell(bx, bz, math.log(totalEnergy) - 1, 'B4C400')
                end

                self:DrawCell(bx, bz, 0, 'ffffff')

                local px, pz = self:ToWorldSpace(bx, bz)
                DrawCircle({px, GetSurfaceHeight(px, pz), pz}, 4, '000000')

                DebugCellData.ReclaimCount = cell.ReclaimCount
                DebugCellData.TotalEnergy = cell.TotalEnergy
                DebugCellData.TotalMass = cell.TotalMass
                DebugCellData.X = cell.X
                DebugCellData.Z = cell.Z
                Sync.GridReclaimUIDebugCell = DebugCellData

                -- draw most valuable cells
                for k = 1, 8 do 
                    local cell = self.OrderedCells[k]
                    self:DrawCell(cell.X, cell.Z, 0, 'ff0000')
                end
            end
        end
    end,

    --- Debugging logic when a cell is updated
    ---@param self AIGridReclaim
    ---@param bx number
    ---@param bz number
    DebugCellUpdate = function(self, bx, bz)
        if Debug then
            self:DrawCell(bx, bz, 1, '48FF00')
        end
    end,

    --- Debugging logic when a prop is destroyed
    ---@param self AIGridReclaim
    ---@param prop Prop
    DebugPropDestroyed = function(self, prop)
        if Debug then
            DrawCircle(prop.CachePosition, 2, 'ff0000')
        end
    end,

    --- Debugging logic when a prop is updated
    ---@param self AIGridReclaim
    ---@param prop Prop
    DebugPropUpdated = function(self, prop)
        if Debug then
            DrawCircle(prop.CachePosition, 2, '0000ff')
        end
    end,
}

---@type AIGridReclaim
GridReclaimInstance = false

---@param brain AIBrain
---@return AIGridReclaim
Setup = function(brain)
    if not GridReclaimInstance then
        GridReclaimInstance = GridReclaim() --[[@as AIGridReclaim]]
    end

    if brain then
        GridReclaimInstance:RegisterBrain(brain)
    end

    return GridReclaimInstance
end