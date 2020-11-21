

docker run --name mysql -e MYSQL_ROOT_PASSWORD=password \
           -e MYSQL_PASSWORD=password -e MYSQL_USER=user \
           -e MYSQL_DATABASE=db -p 3306:3306 -d mysql

mysql -h 127.0.0.1 -uroot -ppassword -e "ALTER USER user IDENTIFIED WITH mysql_native_password BY 'password'; FLUSH PRIVILEGES;";
mysql -h 127.0.0.1 -uroot -ppassword -e "USE db; CREATE TABLE greeting (msg VARCHAR(40) NOT NULL); INSERT INTO greeting(msg) VALUES('Hello World');"

docker build -t maui:0.1 .
docker run -itd -e MYSQL_HOST=127.0.0.1 -p 4000:4000 maui:0.1
