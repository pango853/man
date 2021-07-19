

> show dbs
> show collections

> db.mycol.getIndexes()

> db.mycol.aggregate([{$group : {_id : "$by_user", num_tutorial : {$sum : 1}}}])


