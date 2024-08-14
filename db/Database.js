function dbGetHandle()
{
    try {
        var db = LocalStorage.openDatabaseSync("Note_DB", "", "Notes", 1000000)
    } catch (err) {
        console.log("Error opening database: " + err)
    }
    return db
}

function dbInit()
{
    var db = dbGetHandle()
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS books_table (id INTEGER PRIMARY KEY AUTOINCREMENT, surname text, title text, genre text, price text, amount text)')
        })
    } catch (err) {
        console.log("Error creating books_table in database: " + err)
    };
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS stationery_table (id INTEGER PRIMARY KEY AUTOINCREMENT, title text, price text, amount text)')
        })
    } catch (err) {
        console.log("Error creating stationery_table in database: " + err)
    };
}

function dbInsertBook(surname, title, genre, price, amount)
{
    try {
        var db = dbGetHandle()
        var id = 0;
        db.transaction(function (tx) {
            tx.executeSql('INSERT INTO books_table (surname,title,genre,price,amount) VALUES(?,?,?,?,?)', [surname, title, genre, price, amount])
            var result = tx.executeSql('SELECT id from books_table ORDER BY id DESC LIMIT 1')
            id = result.rows.item(0).id
        })
        booksModel.append({
            id: id,
            surname: surname,
            title: title,
            genre: genre,
            price: price,
            amount: amount
        })
    } catch (err) {
        console.log("Error insert books_table in database: " + err)
    };
}
function dbInsertStationery(title, price, amount)
{
    try {
        var db = dbGetHandle()
        var id = 0;
        db.transaction(function (tx) {
            tx.executeSql('INSERT INTO stationery_table (title,price,amount) VALUES(?,?,?)', [title, price, amount])
            var result = tx.executeSql('SELECT id from stationery_table ORDER BY id DESC LIMIT 1')
            id = result.rows.item(0).id
        })
        stationeryModel.append({
            id: id,
            title: title,
            price: price,
            amount: amount
        })
    } catch (err) {
        console.log("Error insert stationery_table in database: " + err)
    };
}

function dbDeleteBook(id)
{
    try {
        var db = dbGetHandle()
        db.transaction(function (tx) {tx.executeSql('DELETE FROM books_table WHERE id = ?', [id])})
    } catch (err) {
        console.log("Error delete books_table in database: " + err)
    };
}
function dbDeleteStationery(id)
{
    try {
        var db = dbGetHandle()
        db.transaction(function (tx) {tx.executeSql('DELETE FROM stationery_table WHERE id = ?', [id])})
    } catch (err) {
        console.log("Error delete stationery_table in database: " + err)
    };
}

function dbReadAllBooks()
{
    try {
        var db = dbGetHandle()
        db.transaction(function (tx) {
            var results = tx.executeSql('SELECT id,surname,title,genre,price,amount FROM books_table ORDER BY title')
            for (var i = 0; i < results.rows.length; i++) {
                booksModel.append({
                    id: results.rows.item(i).id,
                    surname: results.rows.item(i).surname,
                    title: results.rows.item(i).title,
                    genre: results.rows.item(i).genre,
                    price: results.rows.item(i).price,
                    amount: results.rows.item(i).amount
                })
            }
        })
    } catch (err) {
        console.log("Error read all books_table in database: " + err)
    };
}
function dbReadAllStationery()
{
    try {
        var db = dbGetHandle()
        db.transaction(function (tx) {
            var results = tx.executeSql('SELECT id,title,price,amount FROM stationery_table ORDER BY title')
            for (var i = 0; i < results.rows.length; i++) {
                stationeryModel.append({
                    id: results.rows.item(i).id,
                    title: results.rows.item(i).title,
                    price: results.rows.item(i).price,
                    amount: results.rows.item(i).amount
                })
            }
        })
    } catch (err) {
        console.log("Error read all stationery_table in database: " + err)
    };
}




function dbDropBooks()
{
    var db = dbGetHandle()
    try {
        db.transaction(function (tx) {tx.executeSql('DROP TABLE IF EXISTS books_table')})
    } catch (err) {
        console.log("Error dropping books_table in database: " + err)
    };
}
function dbDropStationery()
{
    var db = dbGetHandle()
    try {
        db.transaction(function (tx) {tx.executeSql('DROP TABLE IF EXISTS stationery_table')})
    } catch (err) {
        console.log("Error dropping stationery_table in database: " + err)
    };
}

function dbInitBooks()
{
    dbInsertBook("Толстой","Война и мир","Роман","300","10")
    dbInsertBook("Оруэлл","1984","Антиутопия","100","5")
    dbInsertBook("Толкин","Властелин колец","Фэнтези","50","7")
}

function dbInitStationery()
{
    dbInsertStationery("Карандаш", "5", "94")
    dbInsertStationery("Ручка", "10", "58")
}





function dbSearchBookGenre(genre)
{
    try {
        var db = dbGetHandle()
        db.transaction(function (tx) {
            var results = tx.executeSql('SELECT id,surname,title,genre,price,amount FROM books_table WHERE genre=?',[genre])
            for (var i = 0; i < results.rows.length; i++) {
                bookSearchModel.append({
                    id: results.rows.item(i).id,
                    surname: results.rows.item(i).surname,
                    title: results.rows.item(i).title,
                    genre: results.rows.item(i).genre,
                    price: results.rows.item(i).price,
                    amount: results.rows.item(i).amount
                })
            }
        })
    } catch (err) {
        console.log("Error search books_table in database: " + err)
    };
}

function dbSearchBookTitle(title)
{
    try {
        var db = dbGetHandle()
        db.transaction(function (tx) {
            var results = tx.executeSql('SELECT id,surname,title,genre,price,amount FROM books_table WHERE title=?', [title])
            for (var i = 0; i < results.rows.length; i++) {
                bookSearchModel.append({
                    id: results.rows.item(i).id,
                    surname: results.rows.item(i).surname,
                    title: results.rows.item(i).title,
                    genre: results.rows.item(i).genre,
                    price: results.rows.item(i).price,
                    amount: results.rows.item(i).amount
                })
            }
        })
    } catch (err) {
        console.log("Error search books_table in database: " + err)
    };
}

function dbSearchStationery(title)
{
    try {
        var db = dbGetHandle()
        db.transaction(function (tx) {
            var results = tx.executeSql('SELECT id,title,price,amount FROM stationery_table WHERE title=?', [title])
            for (var i = 0; i < results.rows.length; i++) {
                stationerySearchModel.append({
                    id: results.rows.item(i).id,
                    title: results.rows.item(i).title,
                    price: results.rows.item(i).price,
                    amount: results.rows.item(i).amount
                })
            }
        })
    } catch (err) {
        console.log("Error search stationery_table in database: " + err)
    };
}