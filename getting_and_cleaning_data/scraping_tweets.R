library(httr)
library(jsonlite)
myapp = oauth_app("twitter", key="JZ5uOKii3kSMDKJHnKfykg",secret="HU4Um4emr3Uij6GZBmVhhGxImgDEpCOZQeAgv8D4Fw4")
sig = sign_oauth1.0(myapp,token="376869783-J0fwS95B4YXzuifFwpZJJyn2P82okXsKUEgFjClG", token_secret = "mvzrsslnyH2BkeKFRMIsXblOw2yGEfFXe4XVdTV3Bc")

homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)
tw = GET("https://api.twitter.com/1.1/search/tweets.json?q=%23freebandnames&since_id=24012619984051000&max_id=250126199840518145&result_type=mixed&count=4", sig)
class(homeTL)

friends = GET("https://api.twitter.com/1.1/friends/ids.json", sig)
# content, the function transform response class into R class
friends = content(friends)
class(friends)
summary(friends)
str(friends)
friends$ids
# transform the list to data frame
friends1 = fromJSON(toJSON(friends))
json1 = content(homeTL)
class(json1)
json2 = fromJSON(toJSON(json1))
json2

class(json1)
summary(json1)
json1[1]

json1t = toJSON(json1)
class(json1t)
summary(json1t)


class(json2)
dim(json2)
names(json2)


tw1 = content(tw)
tw
tw2 = fromJSON(toJSON(tw1))



acarvin = GET("https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=acarvin&count=1000", sig)
acarvin1 = content(acarvin)
class(acarvin1)
acarvin2 = fromJSON(toJSON(acarvin1))  


acarvin_new = GET("https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=acarvin", sig)
acarvin_new1 = content(acarvin_new)
acarvin_new2 = fromJSON(toJSON(acarvin_new1))
acarvin_new2$user["created_at"][1,]



acarvin_test = GET("https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=acarvin&count=-20", sig)
acarvin_test1 = content(acarvin_test)
acarvin_test2 = fromJSON(toJSON(acarvin_test1))    
names(acarvin_test2)
class(acarvin_test2$user["created_at"])
acarvin_test2$user["created_at"][1,]
# max_id, setting only scrape tweets whose id is less the number of max_id, which is an effective way to avoid scraping redundent tweets.
acarvin_next = GET("https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=acarvin&count=200&max_id=532993620412878847", sig)
acarvin_next1 = content(acarvin_next)
acarvin_next2 = fromJSON(toJSON(acarvin_next1)) 
# the structure of the the data frame of tweets are still need be studied further. 
newdf = merge(acarvin2,acarvin_next2, all = TRUE)
dim(acarvin2[1,][1,][1,][1,][1,][1,][1,][1,])
dim(acarvin2[1,])
names(acarvin2) == names(acarvin_next2)








