# %%
import mysql.connector

mydb = mysql.connector.connect(
    host = "localhost",
    port = "3306",
    user = "root",
    password = "@Ishumana2604",
    auth_plugin='mysql_native_password'
)
# %%
my_cursor = mydb.cursor()
# %%
my_cursor.execute("CREATE DATABASE IF NOT EXISTS test_db")
my_cursor.execute("SHOW DATABASES")
for db in my_cursor:
    print(db[0])


# %%
my_cursor.execute("USE test_db")
my_cursor.execute("CREATE TABLE IF NOT EXISTS users (name VARCHAR(255), email VARCHAR(255), age INT(3), user_id INT AUTO_INCREMENT PRIMARY KEY)")
# mydb.close()


# %%
my_cursor.execute("USE test_db")


# %%
sqlStuff =  "Insert into users (name, email, age) values (%s, %s, %s)"
record1 = ("Ishuman", "ishuman@example.com", 25)
my_cursor.execute(sqlStuff, record1)
mydb.commit()
# %%


# %%
my_cursor.execute("USE test_db")
sqlStuff =  "Insert into users (name, email, age) values (%s, %s, %s)"
records = [
           ("John", "john@example.com", 30),
              ("Jane", "jane@example.com", 28),
                ("Alice", "alice@example.com", 22),
           ]
my_cursor.executemany(sqlStuff, records)


mydb.commit()


# %%

my_cursor.execute("SELECT * FROM users")
result = my_cursor.fetchall()
# for row in result:
#     print(row[0], row[1], row[2], row[3])
        # ...existing code...
    
    # Print header
print("{:<10} {:<25} {:<5} {:<8}".format("Name", "Email", "Age", "User ID"))
print("-" * 50)
    # Print rows
for row in result:
    print("{:<10} {:<25} {:<5} {:<8}".format(row[0], row[1], row[2], row[3]))
    # ...existing code...
    # # print(row[0], "\t", row[1], "\t", row[2], "\t", row[3])

#%%


my_cursor.execute("update users set age = 26 where name = 'Ishuman'")
mydb.commit()





# %%
my_cursor.close()
mydb.close()

# %%
