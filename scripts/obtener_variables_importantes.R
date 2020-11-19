m1 = lgb.load("candidatos/m1.txt")
m2 = lgb.load("candidatos/m2.txt")
m3 = lgb.load("candidatos/m3.txt")
m4 = lgb.load("candidatos/m4.txt")
m5 = lgb.load("candidatos/m5.txt")

m1_imp = lgb.importance(m1)[, 1:2]
m2_imp = lgb.importance(m2)[, 1:2]
m3_imp = lgb.importance(m3)[, 1:2]
m4_imp = lgb.importance(m4)[, 1:2]
m5_imp = lgb.importance(m5)[, 1:2]

importances <- merge(m5_imp,m4_imp, all=TRUE)
importances <- merge(importances,m3_imp, all=TRUE)
importances <- merge(importances,m2_imp, all=TRUE)
importances <- merge(importances,m1_imp, all=TRUE)

importances$Feature = gsub("_delta1","",importances$Feature)
importances$Feature = gsub("_lag1","",importances$Feature)

importances_max = importances[,max(Gain),by=Feature]
write.csv2(importances_max, "importances_max_1_5.csv", row.names = FALSE)
