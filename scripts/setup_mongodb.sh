mongo localhost:27017/admin << EOS

var user = {
    user : 'growiadmin',
    pwd:"GrowBrow",
    roles: [
        {
            role:"userAdminAnyDatabase",
            db:"admin"
        }
    ]
};

db.createUser(user);

EOS

mongo localhost:27017/growi << EOS

db.dropDatabase();

var user = {
    user : 'growiuser',
    pwd:"grogro",
    roles: [
        {
             role:"readWrite",
             db:"growi"
        }
    ]
};

db.createUser(user);

EOS
