library(data.table)
library(ggplot2)
library(dplyr)
installed.packages()
data <- read.csv('PropPriceNMarket(I-IIIkv2020)_19_06_2019.csv', sep = ';', na.strings = c('','NA'))
getwd()
#убираю пропущенные значения
data <- data[-which(is.na(data)),]
any(is.na(data))
tibble(data)

#проверка на нормальность распределения переменной цены, и цены за квадратный метр
hist(data$TCena)
hist(data$za_m2)
install.packages("devtools")
library(devtools)


#удаляю некоретные цены за квадратный метр. 
data.f <- filter(data, za_m2<3*(mean(za_m2)))

#исправляю обозначения материалов
levels(data.f$Tip)
levels(data.f$Tip)[levels(data.f$Tip) == 'k/m'] <- 'K/M'
levels(data.f$Tip)[levels(data.f$Tip) == 'pn'] <- 'PN'
levels(data.f$Tip)
#K/M - кирпич/монолит
#MK - монолитно-каркасный
#MN - монолитный
#PM - панельно-монолитный
#PN - панель
#TBD - технология бесшовного домостроения

#исправляю значения переменной 
install.packages('readr')
library(readr)
data.f$S_Komnaty <- parse_number(gsub(",", ".", data.f$S_Komnaty))

#сделал две подвыборки Апарты и Квартиры
install.packages("stringr")
library(stringr)
data.f$type <- factor(ifelse(str_detect(data.f$Obekt.1, '1A'), 1, 
                             ifelse(str_detect(data.f$Obekt.1, '2A'), 1, 
                                    ifelse(str_detect(data.f$Obekt.1, 'SA'), 1, 0))), 
                      labels = c('K','A')
                      )
table(data.f$type)
unique(factor(filter(data.f, type == "A")$Prodavetc))

#удалил пустого застройщика
data.f <- filter(data.f, Prodavetc != "Nmarket.PRO SPb")

#библиотеки для работы графиков
install.packages('vcd')
install.packages('digest')
library(digest)
library(vcd)
library(grid)

#сколько уникальных значений в переменных
sapply(data.f, function(x) length(unique(x)))

#сколько уникальных типов квартир
table(data.f$Obekt.1)
as.data.table(table(data.f$Obekt))
mean(table(data.f$Obekt))

#количество предложений в каждом районе города по каждому жилому комплексу
ggplot(data.f, aes(Obekt))+
    geom_bar(aes(fill = Raion))+
    facet_grid(Raion ~ .,  scales = "free", space = "free")+
    coord_flip()+
    theme(strip.text.y = element_text(angle = 0))

#смотрим статистики в разрезе районов, жилых комплексов и квартирности квартир
data.obekt <- group_by(data.f, Obekt)
summary1 <- summarise(data.obekt,
                      numbers = n(),
                      mean_price = mean(za_m2),
                      median_price = median(za_m2),
                      min_price = min(za_m2),
                      max_price = max(za_m2),
            )

data.obekt <- group_by(data.f, Obekt)
summary1.1 <- summarise(data.obekt,
                      numbers = n(),
                      mean_price = mean(TCena),
                      median_price = median(TCena),
                      min_price = min(TCena),
                      max_price = max(TCena),
)

data.raion <- group_by(data.f, Raion)
summary2 <- summarise(data.raion,
                      numbers = n(),
                      mean_price = mean(za_m2),
                      median_price = median(za_m2),
                      min_price = min(za_m2),
                      max_price = max(za_m2),
            )

data.raion <- group_by(data.f, Raion)
summary2.1 <- summarise(data.raion,
                      numbers = n(),
                      mean_price = mean(TCena),
                      median_price = median(TCena),
                      min_price = min(TCena),
                      max_price = max(TCena),
)

data.obekt.1 <- group_by(data.f, Obekt.1)
summary3 <- summarise(data.obekt.1,
                      numbers = n(),
                      mean_price = mean(za_m2),
                      median_price = median(za_m2),
                      min_price = min(za_m2),
                      max_price = max(za_m2),
            )
library(kableExtra)
data.obekt.1 <- group_by(data.f, Obekt.1)
data.obekt.1 <- rename(data.obekt.1, "Тип квартиры" = Obekt.1)
summary3.1 <- summarise(data.obekt.1,
                      numbers = n(),
                      mean_price = mean(TCena),
                      median_price = median(TCena),
                      min_price = min(TCena),
                      max_price = max(TCena),
) 
                      

#####hist price по квартирам и по ЖК####

ggplot(data.f, aes(za_m2))+
    geom_histogram(aes(fill = Obekt.1), bins = 30)+
    facet_wrap(Obekt ~ .,  ncol = 4)+
    theme(strip.text.y = element_text(angle = 0))

ggplot(data.f, aes(za_m2))+
    geom_histogram(aes(fill = Raion), bins = 30)+
    facet_wrap(Obekt.1 ~ .,  ncol = 2)+
    theme(strip.text.y = element_text(angle = 0)
          axis.text.x = element_text(angle = 45, hjust = 1))

#####hist price по материалам и по квартирам####

ggplot(data.f, aes(za_m2))+
    geom_histogram(aes(fill = Obekt.1), bins = 30)+
    facet_wrap(Tip ~ .,  ncol = 4)+
    theme(strip.text.y = element_text(angle = 0),
          axis.text.x = element_text(angle = 45, hjust = 1))

####из чего строят застройщики####

ggplot(data.f, aes(Tip))+
    geom_bar(aes(fill = Tip))+
    facet_grid(Prodavetc ~ .,  scales = "free", space = "free")+
    coord_flip()+
    theme(strip.text.y = element_text(angle = 0))

ggplot(data.f, aes(za_m2))+
    geom_histogram(aes(fill = Tip), bins = 30)+
    facet_wrap(Obekt ~ .,  ncol = 4)+
    theme(strip.text.y = element_text(angle = 0))

#!!!! Далее я проверял, как материал дома воздействует на цену квартиры. На графике ниже цветом отмечены разные типы материалов из которых делаются дома. Гистограммы разбиты по отдельным застрощикам. Видно что в каждой ячейке несколько цветов со своим распределением - это разные жилые комплексы. Судя по гистограммам, можно сказать, что материал из которого делается дом, связан с отдельным ценовым сегментом квартир. О причинной зависимости говорить нельзя, посколькуна цену жилого комплекса, в целом, оказывают так же факторы его расположения. Например, монолитные дома могут стоить как относительно остальных цен дорого `r round(mean(filter(data.f, Tip == "MN" & Prodavetc == "Evrostroi")$za_m2), digits = 0)`р., так и находится в начале ценовой шкалы `r round(mean(filter(data.f, Tip == "MN" & Prodavetc == "Gazprombank-Invest")$za_m2), digits = 0)`р.
ggplot(data.f, aes(za_m2))+
    geom_histogram(aes(fill = Tip), bins = 30)+
    facet_wrap(Prodavetc ~ .,  ncol = 4)+
    theme(strip.text.y = element_text(angle = 0),
          axis.text.x = element_text(angle = 45, hjust = 1))

#### Какие объекты относятся к какому застройщику #####

ggplot(data.f, aes(Obekt))+
    geom_bar(aes(fill = type))+
    facet_grid(Prodavetc ~ .,  scales = "free", space = "free")+
    coord_flip()+
    theme(strip.text.y = element_text(angle = 0))
str(data.f)

# сделать две подвыборки Апарты и Квартиры и сравнить их средние цены за кв.м и обычную цену
data.type <- group_by(data.f, type)
summary.type <- summarise(data.type,
                      numbers = n(),
                      mean_price = mean(za_m2),
                      median_price = median(za_m2),
                      min_price = min(za_m2),
                      max_price = max(za_m2),
)

data.type <- group_by(data.f, type)
summary.type <- summarise(data.type,
                          numbers = n(),
                          mean_price = mean(TCena),
                          median_price = median(TCena),
                          min_price = min(TCena),
                          max_price = max(TCena),
)

#сравнение квартир и апартов по средней цене за кв. и по материалам
ggplot(data.f, aes(za_m2))+
    geom_histogram(aes(fill = Tip), bins = 30)+
    facet_wrap(type ~ .,  ncol = 4)+
    theme(strip.text.y = element_text(angle = 0))


####поиск закономерностей, построение регрессионной прямой

#проверить на нормальность графичекие тесты
ggplot(data.f, aes(za_m2))+
    geom_histogram(aes(fill = type), bins = 20)+
    facet_wrap(Tip ~ .,  ncol = 3)+
    theme(strip.text.y = element_text(angle = 0))

hist(data.f$TCena, breaks = 11)
hist(data.f$za_m2, breaks = 11)
hist(data.f$Etaj, breaks = 11)
hist(data.f$S_obshch, breaks = 11)
hist(data.f$S_zhil, breaks = 11)
hist(data.f$S_kukh, breaks = 11)
hist(data.f$S_Komnaty, breaks = 11)

#проверка на нормальность тестом Шапиро-Вилк
by(data.f$za_m2, INDICES = data.f$Tip, shapiro.test)
by(data.f$za_m2, INDICES = data.f$Otdelka, shapiro.test)
by(data.f$za_m2, INDICES = data.f$Obekt.1, shapiro.test)
by(data.f$za_m2, INDICES = data.f$type, shapiro.test)
#как видно тут нет нормальных распределений и графичеки ни на стат тесте
    
#корреляционные модели
data.num <- data.f[sapply(data.f, is.numeric)]
pairs(data.num)
cor(data.num)
#наблюдается положительная большая корреляция в 0,79 между переменной общей площади и общей ценой за квартиру, однако такая отсутсвует, когда цена пересчитывается за кв.м. 
cor.test(~ za_m2 + Etaj, data.f)
install.packages("coin")
library(coin)
spearman_test(~ za_m2 + Etaj, data.f)
#отбрасываем альтернативную гипотезу о наличии корреляции. 
plot(data.f$za_m2, data.f$Etaj)
plot(data.f$S_zhil, data.f$Etaj)
#корреляции нет, но есть интересное распределение на графике. Можно предположить, что была произведена манипуляция с данными. Возможно были исключены из выборки квартиры больше 50 м.кв. и выше 10 этажа, ценой выше 150 тыс. за к.м.. Такие квартиры относятся к элитным и, вероятно, зарезервированы для эксклюзивных продавцов/покупателей и поэтому отсутсвуют в общей выдаче.
ggplot(data.f, aes(za_m2, Etaj, col = factor(S.u)))+
    geom_point()
#к дорогие квартиры состоят преимущественно из тех, где 2 санузла, и как ни странно с совмещенным санузлом
ggplot(data.f, aes(za_m2, Etaj, col = factor(Otdelka)))+
    geom_point()
#интересно, что квартиры группируются пслойно, чередующимися колонками, по признаку отделки, перпендикулярно шкале цена.
ggplot(data.f, aes(za_m2, Etaj, col = factor(Obekt)))+
    geom_point()
#скорее всего это обусловлено тем, что разные объекты выстраиваются в похожие по структуре столбики


ggplot(data.f, aes(Etajnosty, za_m2, col = Raion))+
    geom_point()+
    facet_grid(Prodavetc ~ .,  scales = "free", space = "free")+
    coord_flip()+
    theme(strip.text.y = element_text(angle = 0))
#график показывает, что самые дорогие квартиры не малоэтажные - 4-6, а среднеэтажные - 10 этажей, принадлежат эти объекты четырем застройщикам.
ggplot(data.f, aes(Etajnosty, za_m2, col = type))+
    geom_point()+
    facet_grid(Raion ~ .,  scales = "free", space = "free")+
    coord_flip()+
    theme(strip.text.y = element_text(angle = 0))
#самые дорогие квартиры в районах Центральный, Васильевский и Красногвардейский. В последнем много объектов разной этажности. Самые недорогие квартиры в Ломоносовском районе. Именно в данных районах строятся апартаменты и они серьезно влияют на цену в большую сторону.
ggplot(data.f, aes(Etajnosty, za_m2, col = Tip))+
    geom_point()+
    facet_grid(Raion ~ .,  scales = "free", space = "free")+
    coord_flip()+
    theme(strip.text.y = element_text(angle = 0))
#Монолитный тип строения и в меньшей степени монолит/кирпич входит в группу дорогих строний. Группа недорогих так же включает в себя монолит, но еще и панель-монолит и панель. 


str(data.f)
#регрессионные модели
summary(lm(S_obshch ~ TCena, data.f))


#мультирегрессии

##написать текст о данных и о том, что я с ними делал

##собрать текст и проделанную работу в Маркдаун файл

##написать содержательные выводы по пулченным данным

##перевести на агл полученный результат




##### tests ######
install.packages('remotes')
install.packages("ggalluvial")
library(ggalluvial)
remotes::install_github("corybrunson/ggalluvial", build_vignettes = TRUE)
remotes::install_github("corybrunson/ggalluvial", ref = "optimization")
titanic_wide <- data.frame(Titanic)

ggplot(data.f,
       aes(axis1 = Obekt, axis2 = Prodavetc, axis3 = Raion, y = length(data.f))) +
    scale_x_discrete(limits = c("ЖК", "Застройщик", "Район"), expand = c(.1, .05)) +
    xlab("кол-во объектов") +
    geom_alluvium(aes(fill = length(data.f))) +
    geom_stratum() + geom_text(stat = "stratum", label.strata = TRUE) +
    theme_minimal() +
    ggtitle("passengers on the maiden voyage of the Titanic",
            "stratified by demographics and survival")
#############

ggplot(data.f, aes(za_m2))+
    geom_histogram(aes(fill = Obekt), bins = 30)+
    facet_wrap(Prodavetc ~ .,  ncol = 4)+
    theme(strip.text.y = element_text(angle = 0))

############

ifelse(nchar(data.f) < 6, as.numeric(data.f), 
       as.numeric(substr(gsub(',', '.', data.f), 1, 5)))