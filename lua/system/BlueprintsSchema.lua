-- ==========================================================================================
-- * Authors : HUSSAR
-- * Summary : Provides schema for unit blueprints
-- * these tables were generated by collecting values 
-- * from FA/FAF blueprints in BlueprintsVerifier.lua
-- ==========================================================================================

LOG('BlueprintsSchema.lua ... ')

ValidRanges = {
    -- bp.BuildIconSortPriority range
    BuildIconSortPriority = { 
        Min = 10, Max = 220,
    },
    -- bp.StrategicIconSortPriority range
    StrategicIconSortPriority = { 
        Min = 0, Max = 250,
    },
} 

ValidEnums = {
    -- bp.Categories
    Categories = {
        TechLevels = {
            'TECH1',
            'TECH2',
            'TECH3',
            'EXPERIMENTAL',
        },
    },
    Defense = {
        -- bp.Defense.ArmorType
        ArmorTypes = {
            'ASF',
            'Commander',
            'Experimental',
            'FireBeetle',
            'Light',
            'Normal',
            'Structure',
            'TMD',
        },
    },
    Physics = {
        -- bp.Physics.BuildOnLayerCaps
        BuildOnLayers = {
            'LAYER_Air',
            'LAYER_Land',
            'LAYER_Orbit',
            'LAYER_Seabed',
            'LAYER_Sub',
            'LAYER_Water',
        },
        -- bp.Physics.MotionTypes
        MotionTypes = {
            'RULEUMT_Air',
            'RULEUMT_Amphibious',
            'RULEUMT_AmphibiousFloating',
            'RULEUMT_SurfacingSub',
            'RULEUMT_Hover',
            'RULEUMT_Water',
            'RULEUMT_Land',
            'RULEUMT_None',
        }
    },
    Weapon = {
        -- bp.Weapon[index].WeaponCategory
        WeaponCategories = {
            'Anti Air',
            'Anti Navy',
            'Artillery',
            'Bomb',
            'Death',
            'Defense',
            'Direct Fire',
            'Direct Fire Experimental', -- GC
            'Direct Fire Naval',
            'Experimental',
            'Indirect Fire',
            'Kamikaze',
            'Missile',
            'Teleport',
        },
        -- bp.Weapon[index].DamageType
        DamageTypes = {
            'CzarBeam',
            'Deathnuke',
            'EMP',
            'FireBeetleExplosion',
            'Normal',
            'Nuke',
            'OtheTacticalBomb',
            'Overcharge',
            'TacticalMissile',
        },
        -- bp.Weapon[index].RangeCategory
        RangeCategories = {
            'UWRC_AntiAir',
            'UWRC_AntiNavy',
            'UWRC_Countermeasure',
            'UWRC_DirectFire',
            'UWRC_IndirectFire',
            'UWRC_Undefined',
        },
        -- bp.Weapon[index].BallisticArc
        BallisticArcs = {
            'RULEUBA_HighArc',
            'RULEUBA_LowArc',
            'RULEUBA_None',
        },
    },
    General = {
        -- bp.General.Icon (background)
        Icons = { 
            'air',
            'amph',
            'land',
            'sea',
        },
        -- bp.General.TechLevel
        TechLevels = { 
            'RULEUTL_Experimental',
            'RULEUTL_Advanced',
            'RULEUTL_Secret',
            'RULEUTL_Basic',
        },
        -- bp.General.FactionName
        FactionNames = { 
            'Aeon',
            'Cybran',
            'Seraphim',
            'UEF',
            'Nomads',
        },
        -- bp.General.Classification
        Classifications = { 
            'RULEUC_Commander',
            'RULEUC_CounterMeasure',
            'RULEUC_Engineer',
            'RULEUC_Factory',
            'RULEUC_MilitaryAircraft',
            'RULEUC_MilitaryShip',
            'RULEUC_MilitarySub',
            'RULEUC_MilitaryVehicle',
            'RULEUC_MiscSupport',
            'RULEUC_Resource',
            'RULEUC_Sensor',
            'RULEUC_Weapon',
            'RULEUMT_Amphibious',
        },
        -- bp.General.Category
        Categories = { 
            'Anti Air',
            'Anti Navy',
            'Bomber',
            'Command',
            'Construction',
            'Defense',
            'Direct Fire',
            'Economy',
            'Experimental',
            'Factory',
            'Fighter',
            'Gunship',
            'Indirect Fire',
            'Intelligence',
            'Ship',
            'Strategic',
            'Submarine',
            'Transport',
            'Utility',
        }
    },
    Other = {
        -- bp.StrategicIconName
        StrategicIconNames = { 
            'icon_bomber_antinavy',
            'icon_bomber_directfire',
            'icon_bomber_generic',
            'icon_bomber1_antinavy',
            'icon_bomber1_directfire',
            'icon_bomber1_generic',
            'icon_bomber2_antinavy',
            'icon_bomber2_directfire',
            'icon_bomber2_generic',
            'icon_bomber3_antinavy',
            'icon_bomber3_directfire',
            'icon_bomber3_generic',
            'icon_bot_antiair',
            'icon_bot_armored',
            'icon_bot_directfire',
            'icon_bot_generic',
            'icon_bot_intel',
            'icon_bot_sniper',
            'icon_bot1_antiair',
            'icon_bot1_armored',
            'icon_bot1_directfire',
            'icon_bot1_generic',
            'icon_bot1_intel',
            'icon_bot1_sniper',
            'icon_bot2_antiair',
            'icon_bot2_armored',
            'icon_bot2_directfire',
            'icon_bot2_generic',
            'icon_bot2_intel',
            'icon_bot2_sniper',
            'icon_bot3_antiair',
            'icon_bot3_armored',
            'icon_bot3_directfire',
            'icon_bot3_generic',
            'icon_bot3_intel',
            'icon_bot3_sniper',
            'icon_commander_generic',
            'icon_experimental_generic',
            'icon_factory_air',
            'icon_factory_generic',
            'icon_factory_land',
            'icon_factory_naval',
            'icon_factory1_air',
            'icon_factory1_generic',
            'icon_factory1_land',
            'icon_factory1_naval',
            'icon_factory2_air',
            'icon_factory2_generic',
            'icon_factory2_land',
            'icon_factory2_naval',
            'icon_factory3_air',
            'icon_factory3_generic',
            'icon_factory3_land',
            'icon_factory3_naval',
            'icon_factoryhq1_air',
            'icon_factoryhq1_generic',
            'icon_factoryhq1_land',
            'icon_factoryhq1_naval',
            'icon_factoryhq2_air',
            'icon_factoryhq2_generic',
            'icon_factoryhq2_land',
            'icon_factoryhq2_naval',
            'icon_factoryhq3_air',
            'icon_factoryhq3_generic',
            'icon_factoryhq3_land',
            'icon_factoryhq3_naval',
            'icon_fighter_antiair',
            'icon_fighter_directfire',
            'icon_fighter_generic',
            'icon_fighter_intel',
            'icon_fighter1_antiair',
            'icon_fighter1_directfire',
            'icon_fighter1_generic',
            'icon_fighter1_intel',
            'icon_fighter2_antiair',
            'icon_fighter2_bomb',
            'icon_fighter2_directfire',
            'icon_fighter2_generic',
            'icon_fighter2_intel',
            'icon_fighter3_antiair',
            'icon_fighter3_directfire',
            'icon_fighter3_generic',
            'icon_fighter3_intel',
            'icon_gunship_antiair',
            'icon_gunship_directfire',
            'icon_gunship_generic',
            'icon_gunship_transport',
            'icon_gunship1_antiair',
            'icon_gunship1_directfire',
            'icon_gunship1_generic',
            'icon_gunship1_transport',
            'icon_gunship2_antiair',
            'icon_gunship2_directfire',
            'icon_gunship2_generic',
            'icon_gunship2_transport',
            'icon_gunship3_antiair',
            'icon_gunship3_directfire',
            'icon_gunship3_generic',
            'icon_gunship3_transport',
            'icon_land_antiair',
            'icon_land_antishield',
            'icon_land_artillery',
            'icon_land_bomb',
            'icon_land_counterintel',
            'icon_land_directfire',
            'icon_land_engineer',
            'icon_land_generic',
            'icon_land_intel',
            'icon_land_missile',
            'icon_land_shield',
            'icon_land1_antiair',
            'icon_land1_antishield',
            'icon_land1_artillery',
            'icon_land1_bomb',
            'icon_land1_counterintel',
            'icon_land1_directfire',
            'icon_land1_engineer',
            'icon_land1_generic',
            'icon_land1_intel',
            'icon_land1_missile',
            'icon_land1_shield',
            'icon_land2_antiair',
            'icon_land2_antishield',
            'icon_land2_artillery',
            'icon_land2_bomb',
            'icon_land2_counterintel',
            'icon_land2_directfire',
            'icon_land2_engineer',
            'icon_land2_generic',
            'icon_land2_intel',
            'icon_land2_missile',
            'icon_land2_shield',
            'icon_land3_antiair',
            'icon_land3_antishield',
            'icon_land3_artillery',
            'icon_land3_bomb',
            'icon_land3_counterintel',
            'icon_land3_directfire',
            'icon_land3_engineer',
            'icon_land3_generic',
            'icon_land3_intel',
            'icon_land3_missile',
            'icon_land3_shield',
            'icon_ship_air',
            'icon_ship_antiair',
            'icon_ship_antinavy',
            'icon_ship_counterintel',
            'icon_ship_directfire',
            'icon_ship_generic',
            'icon_ship_intel',
            'icon_ship_missile',
            'icon_ship_shield',
            'icon_ship1_air',
            'icon_ship1_antiair',
            'icon_ship1_antinavy',
            'icon_ship1_counterintel',
            'icon_ship1_directfire',
            'icon_ship1_generic',
            'icon_ship1_intel',
            'icon_ship1_missile',
            'icon_ship1_shield',
            'icon_ship2_air',
            'icon_ship2_antiair',
            'icon_ship2_antinavy',
            'icon_ship2_counterintel',
            'icon_ship2_directfire',
            'icon_ship2_generic',
            'icon_ship2_intel',
            'icon_ship2_missile',
            'icon_ship2_shield',
            'icon_ship3_air',
            'icon_ship3_antiair',
            'icon_ship3_antinavy',
            'icon_ship3_counterintel',
            'icon_ship3_directfire',
            'icon_ship3_generic',
            'icon_ship3_intel',
            'icon_ship3_missile',
            'icon_ship3_shield',
            'icon_structure_air',
            'icon_structure_antiair',
            'icon_structure_antimissile',
            'icon_structure_antinavy',
            'icon_structure_artillery',
            'icon_structure_counterintel',
            'icon_structure_directfire',
            'icon_structure_energy',
            'icon_structure_engineer',
            'icon_structure_generic',
            'icon_structure_intel',
            'icon_structure_land',
            'icon_structure_mass',
            'icon_structure_missile',
            'icon_structure_naval',
            'icon_structure_shield',
            'icon_structure_transport',
            'icon_structure_wall',
            'icon_structure1_air',
            'icon_structure1_antiair',
            'icon_structure1_antimissile',
            'icon_structure1_antinavy',
            'icon_structure1_artillery',
            'icon_structure1_counterintel',
            'icon_structure1_directfire',
            'icon_structure1_energy',
            'icon_structure1_engineer',
            'icon_structure1_generic',
            'icon_structure1_intel',
            'icon_structure1_land',
            'icon_structure1_mass',
            'icon_structure1_missile',
            'icon_structure1_naval',
            'icon_structure1_shield',
            'icon_structure1_transport',
            'icon_structure2_air',
            'icon_structure2_antiair',
            'icon_structure2_antimissile',
            'icon_structure2_antinavy',
            'icon_structure2_artillery',
            'icon_structure2_counterintel',
            'icon_structure2_directfire',
            'icon_structure2_energy',
            'icon_structure2_engineer',
            'icon_structure2_generic',
            'icon_structure2_intel',
            'icon_structure2_land',
            'icon_structure2_mass',
            'icon_structure2_missile',
            'icon_structure2_naval',
            'icon_structure2_shield',
            'icon_structure2_transport',
            'icon_structure3_air',
            'icon_structure3_antiair',
            'icon_structure3_antimissile',
            'icon_structure3_antinavy',
            'icon_structure3_artillery',
            'icon_structure3_counterintel',
            'icon_structure3_directfire',
            'icon_structure3_energy',
            'icon_structure3_engineer',
            'icon_structure3_generic',
            'icon_structure3_intel',
            'icon_structure3_land',
            'icon_structure3_mass',
            'icon_structure3_missile',
            'icon_structure3_naval',
            'icon_structure3_shield',
            'icon_structure3_transport',
            'icon_sub_antinavy',
            'icon_sub_directfire',
            'icon_sub_generic',
            'icon_sub_missile',
            'icon_sub1_antinavy',
            'icon_sub1_directfire',
            'icon_sub1_generic',
            'icon_sub1_missile',
            'icon_sub2_antinavy',
            'icon_sub2_directfire',
            'icon_sub2_generic',
            'icon_sub2_missile',
            'icon_sub3_antinavy',
            'icon_sub3_directfire',
            'icon_sub3_generic',
            'icon_sub3_missile',
        },
    },
}

-- override above tables with hash tables for quicker lookup in BlueprintsVerifier.lua
for k, tables in ValidEnums do
    for name, t in tables do
        ValidEnums[k][name] = table.hash(t)
    end
end

LOG('BlueprintsSchema.lua ... loaded')