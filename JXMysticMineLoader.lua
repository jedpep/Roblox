
getgenv([[

    https://discord.gg/jxu
    or
    https://discord.gg/BNxJpgymkE

    donate:
    LTC: LUEafMZScHjF3m1sMohj9LKqcRoFQn1bW2
    BTC: bc1q9ptr83ds6y2ly2jhlnn8qvypeucap3ez2v5zzr

]])


getgenv().JXMysticFarmerConfig = {
    AutoServerTripleDamage = true,
    MineMode = "Multi", -- Multi or All
    HideUnderMap = true,
    Webhook = {
        EnabledGemWebhook = true,
        EnableFruitWebhook = true,
        GemUrl = "",
        FruitUrl = "",
        ShowUsername = true,
        ShowFruits = true
    },
    Fruits = {
        Max = 175,
        StartFarmAt = 125,
        FruitsToFarm = {
            "Apple",
            "Orange",
            "Pineapple",
            "Pear", -- Golden apple thing
            "Rainbow Fruit",
            "Banana"
        },
        Worlds = {
            "Spawn",
            "Fantasy",
            "Tech",
            "Axolotl Ocean",
            "Pixel",
            "Cat",
            "Doodle",
            "Kawaii",
            --"Dog"
        }
    },
    Preformace = {
        FPS = 30,
    }
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/jedpep/Roblox/main/JXMysticMineFarm.lua"))()
