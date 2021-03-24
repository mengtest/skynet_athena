package.path = "./static/AI/?.lua;" .. 
    "./static/Define/?.lua;" .. 
    "./static/Machine/?.lua;" .. 
    "./static/Other/?.lua;" .. 
    "./static/Player/?.lua;" .. 
    "./static/Stage/?.lua;" ..
    "./static/Store/?.lua;" ..
    package.path
local skynet = require "skynet"
local sharedata = require "skynet.sharedata"


skynet.start(function()
  local ls = { --配置你的数据表的名字
    "damagetype",
    "firecontrol",
    "firecontroltype",
    "machine_name",
    "machinebody",
    "machinechassis",
    "machinechassistype",
    "map",
    "skill",
    "stage",
    "weapontable",
    "weapontype",
    "beginningposition",
    "ai_group",
    "npc",
    "sensitive_word",
    "mod",
    "blueprint",
    "drop_list",
    "drop_package",
    "material_list",
    "machine_exp",
    "player_exp",
    "buff",
    "trigger_area",
    "avatar",
    "mod_levelup",
    "mod_sale",
    "mod_resolve",
    "fuction",
    "all_fuction",
    "jackpot",
    "store",
    "store_bag",
    "take_task",
    "task",
    "urgent_task",
    "date_task",
    "task_object",
  }
  for i,v in ipairs(ls) do 
      local temdata = require (v)
      sharedata.new(v,temdata)
  end
	skynet.exit()
end)
