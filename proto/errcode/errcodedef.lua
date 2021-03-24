-- --------------------------------------
-- Version 		: 1.0
-- Filename		: errcodedef.lua
-- Introduce  	: 错误码定义
-- --------------------------------------

local errCodeDef = enum {

    -- common 1-10
    eEC_success = 1,      --成功
    eEC_unknow = 2,     -- 未知错误
    eEC_res_notEnough = 3,  -- 资源不足
    eEC_thing_notEnough = 4, -- 物品不足
    eEC_err_param = 5, -- 错误的参数
    eEC_magicCrystal_notEnough = 6, -- 魔晶不足
    eEC_gold_notEnough = 7, --金币不足
    eEC_cannot_found_gamecfg = 8, -- 游戏配置找不到
    eEC_vip_limit = 9, -- vip权限不足

    -- loginmodule 11-30
    eEC_error_message = 11,--协议号不对
    eEC_error_token = 12,--token验证失败
    eEC_multiple_login = 13,--已经登录
    eEC_error_back = 14,--没有找到重连的对象
    eEC_no_create_role = 15,--还未创建角色
    eEC_re_login = 16,--登录成功(重新登录)
    eEC_user_error = 17,--加载角色错误
    eEC_sign_expire = 18,--验证码失效

    eEC_have_create_role = 21,--已经创建过
    eEC_used_name = 22,--名字已被使用
    eEC_no_deploy = 23,--没有找到配置

    -- match module 31-40
    eEC_match_exitfail = 24, -- 找不到房间
    eEC_match_unallready = 25,    -- 有人未准备好
    eEC_match_wrongnum = 26,         -- 人数不对
    eEC_match_matching = 27,     -- 已在匹配中

    ---user module  41-50
    eEC_role_name_macth           = 41,       --包含特殊字符   
	eEC_db_error					= 42,	  --数据库操作失败
    eEC_role_not_exists			= 43,		  --玩家角色不存在
    eEC_role_name_repetition      = 44,       --玩家名字相同，不需更改
    eEC_role_name_length          = 45,       --玩家长度不符
    eEC_role_name_sensitive       = 46,       --包含敏感词汇

    -- chip module  51-60
    eEC_slot_notnull  = 51,                   --槽位已装备
    eEC_slot_isnull  = 52,                    --槽位为空
    eEc_slot_volume  = 53,                    --槽位容量不足
    eEc_slot_isdouble = 54,                   --此装备已经使用反应堆
    eEC_slot_upchipandremove  = 55,           --芯片升级成功，槽位容量不足已卸下
    eEC_chip_skill = 56,                      --已装备技能芯片
    eEC_chip_repeat = 57,                     --已装备该芯片
    eEC_chip_nofind = 58,                     --芯片未找到
    eEC_chip_fulllv = 59,                     --芯片已满级
    eEC_chip_type = 60,                       --芯片不可装备在该部位

    -- scan module  61-70
    eEC_machine_notlock  =  61,               --机甲不是锁定状态
    eEC_casting_full  =  62,                  --铸造位已满
    eEC_casting_max  =  63,                   --铸造位超出最大限制
    eEC_addsleep_no = 64,                     --无需加速，已完成
    eEC_equip_repeat = 65,                    --已装备该部件
    eEC_weapon_type = 66,                     --装备类型不匹配
    eEC_blueprint_nofind = 67,                --蓝图未找到
    eEC_cfgid_nofind = 68,                    --未找到此配置id
    eEC_equip_welding = 69,                   --部件已焊死
    eEC_machine_full = 70,                    --机甲数量已到最大限制
    eEC_warehouse_full = 71,                  --仓库已到最大限制

    -- shop module 81-90
    eEC_shop_price = 81,                      --价格有波动
    eEC_shop_full = 82,                       --栏位已满
    eEC_transport_full = 83,                  --运输机已满
    eEC_lv_nofull = 84,                       --装备未满级
    eEC_err_islock = 85,                      --物品已锁定
}

return errCodeDef
