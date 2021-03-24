--[[

 @file:       stagetalking.lua
 @source xls: excel_3D\StageTalking.xlsx
 @sheet name: STAGETALKING
 @brief:      this file was create by tools, DO NOT modify it!
 @author:     kevin

]]--
        local STAGETALKING = {
	[10001] = {stage_name= "或非剧情关1", talking1= "准备战斗……怎么一副苦大仇深的表情？", talking2= "现在的你对上他们应该毫无压力，一鼓作气打败他们吧。", talking3= "这里的对手都好弱啊。", talking4= "忽然有些怀念我们被一碰就碎的日子，真刺激啊……", talking5= "现在的我们势不可挡!", talking6= "这次的队友和敌人也是同一水平么……", talking7= "孤军奋战这种稀松平常的事，你不会害怕吧？", talking8= "怎么可能？你被谁下毒了吗？", talking9= "干的漂亮，这样的敌人再来几批也没关系吧？", talking10= "别吧？", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10002] = {stage_name= "或非剧情关2", talking1= "既然遇到了就只能认真对付了，准备好。", talking2= "虽然他们的实力入不了眼，但还是小心为上   。                                                                                               ", talking3= "果不其然，这些敌人都是杂鱼。", talking4= "这是菜园子里挑的兵么？", talking5= "收尾工作开始了~", talking6= "看着这种队友才能感受到新手教程的必要性啊……", talking7= "对于剑客来说同伴都是拖累，放开手脚战斗吧。", talking8= "你让我说你什么好……", talking9= "结束了，赶紧去找那个家伙！", talking10= "你在丢人？", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10003] = {stage_name= "或非剧情关3", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10004] = {stage_name= "或非剧情关4", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10005] = {stage_name= "或非剧情关5", talking1= "敌人的数量非常多！但质量挺让人心疼的……", talking2= "不要管太多，把视野内所有敌人尽数歼灭！", talking3= "是有谁向他们的工厂流水线里放了豆腐吗？", talking4= "对面的战士们和小黄鱼可堪一战啊。", talking5= "古话说的没错，没有敌人的敌人基地才是好基地。", talking6= "丢人的丢字有四种写法，这位队友看来是全学会了。", talking7= "你懂了吧，队友的存在就是为了告诉你队友没用。", talking8= "啊，为了不让我骂对面菜你可真是煞费苦心，辛苦了。", talking9= "防守完成，趁下一波经验宝宝到达之前离开吧。", talking10= "你啊，总是能给我整出点新花样。", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10006] = {stage_name= "或非剧情关6", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10007] = {stage_name= "或非剧情关7", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10008] = {stage_name= "或非剧情关8", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10009] = {stage_name= "或非剧情关9", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10010] = {stage_name= "", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10011] = {stage_name= "", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10012] = {stage_name= "", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10013] = {stage_name= "", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10014] = {stage_name= "", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10015] = {stage_name= "", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10016] = {stage_name= "", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10017] = {stage_name= "", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10018] = {stage_name= "", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10019] = {stage_name= "", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10020] = {stage_name= "", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10021] = {stage_name= "", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10022] = {stage_name= "", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10023] = {stage_name= "", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10024] = {stage_name= "", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10025] = {stage_name= "", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10026] = {stage_name= "", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10027] = {stage_name= "", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10028] = {stage_name= "", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10029] = {stage_name= "", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[10030] = {stage_name= "", talking1= "", talking2= "", talking3= "", talking4= "", talking5= "", talking6= "", talking7= "", talking8= "", talking9= "", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[50001] = {stage_name= "引导关卡", talking1= "欢迎来到竞技场，我将在这里教导你一些基础的操作。", talking2= "请集中你的注意力，仔细听讲。", talking3= "干得不错。", talking4= "操作很上手嘛，看来这些操作对你来说都是小意思。", talking5= "很好，你的操作已经可以支撑你在外界活下去了。", talking6= "", talking7= "", talking8= "", talking9= "好了，到此为止，引导便全部结束了，我会很期待你冒险归来的故事的。", talking10= "", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
	[90001] = {stage_name= "或非竞技场", talking1= "准备战斗，和往常一样，保持冷静。", talking2= "不要被外界干扰。", talking3= "干的漂亮，这下我们离胜利更近一步了", talking4= "集中注意力，给这场战斗一个完美谢幕。", talking5= "现在的我们势不可挡!", talking6= "我们失去了一个队友，从现在起要更认真了", talking7= "孤军奋战是常有的事，但是仍旧要小心。", talking8= "啊，你的队友们压力又大了一些。", talking9= "干的漂亮，竞技场奖励正在结算中……", talking10= "事实证明我们进步的空间还很大，返回吧。", talking11= "", talking12= "", talking13= "", talking14= "", talking15= "", talking16= "", talking17= "", talking18= "", talking19= "", talking20= "", talking21= "", },
};return STAGETALKING