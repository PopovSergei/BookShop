function dbInit()
{
    var db = LocalStorage.openDatabaseSync("Note_DB", "", "Notes", 1000000)

    /*
    try {
        db.transaction(function (tx) {
            tx.executeSql('DROP TABLE product_table')
        })
    } catch (err) {
        console.log("Error drop table in database: " + err)
    };
    */

    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS product_table (' +
            'id INTEGER PRIMARY KEY AUTOINCREMENT, name text, cost text)')
        })
    } catch (err) {
        console.log("Error creating table in database: " + err)
    };
}

function dbGetHandle()
{
    try {
        var db = LocalStorage.openDatabaseSync("Note_DB", "", "Notes", 1000000)
    } catch (err) {
        console.log("Error opening database: " + err)
    }
    return db
}

function dbInsert(name, cost)
{
    var db = dbGetHandle()
    var rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO product_table (name, cost) VALUES(?, ?)', [name, cost])
        var result = tx.executeSql('SELECT last_insert_rowid()')
        rowid = result.insertId
    })
    return rowid;
}

function dbDelete(id)
{
    var db = dbGetHandle()
    db.transaction(function (tx) {
        tx.executeSql("DELETE FROM product_table WHERE id = ?;", [id]);
    });
}

function dbReadAll()
{
    var db = dbGetHandle()
    db.transaction(function (tx) {
        var results = tx.executeSql('SELECT id,name,cost FROM product_table')

        for (var i = 0; i < results.rows.length; i++) {
            productModel.append({
                id: results.rows.item(i).id,
                name: results.rows.item(i).name,
                cost: results.rows.item(i).cost
            })
        }
    })
}

function dbSum()
{
    var db = dbGetHandle()
    var sum = 0.0
    db.transaction(function (tx) {
        var results = tx.executeSql('SELECT cost FROM product_table')

        for (var i = 0; i < results.rows.length; i++) {
            sum += parseFloat(results.rows.item(i).cost)
        }
    })
    return sum;
}