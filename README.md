# Running nodejs app on k8s with CI

## Info:
- HelloWorld NodeJs app in the `src` folder with the Dockerfile
- All deployment related files in `helm` folder
- Running CI via github actions. The config is in `.github/workflows/main.yaml`

## Details for CI
Using github actions for CI. For proper CI after cloning repo, add dockerhub secrets in the cloned repo.

CI is automated. Every commit triggers build and can create release from repo or create tag for custom version of docker images

## Details for CD
Was going for automated CD with weaveworks flux. But, it needs many details needs to be changed after cloning. For simple app like this, I could run a small CD in my k8s environment to watch for new version of app deployed on the docker repo. In the end, it might take a lot more time. So, maybe future imnprovement

Deployment include running a mysql db via helm with initscripts to create a new entry. After that installing an ingress controller. And lastly, installing my app.

CD is manual. Go to `helm` folder and run `deploy.sh`. I have created an ingress for [maui.org](maui.org). So, whereever the deployment takes place, create a dns entry for it.

## Run locally on docker
    docker run --name mysql -e MYSQL_ROOT_PASSWORD=password \
               -e MYSQL_PASSWORD=password -e MYSQL_USER=user \
               -e MYSQL_DATABASE=db -p 3306:3306 -d mysql
    sleep 10
    mysql -h 127.0.0.1 -uroot -ppassword -e "ALTER USER user IDENTIFIED WITH mysql_native_password BY 'password'; FLUSH PRIVILEGES;";
    mysql -h 127.0.0.1 -uroot -ppassword -e "USE db; CREATE TABLE greeting (msg VARCHAR(40) NOT NULL); INSERT INTO greeting(msg) VALUES('Hello World');"

    docker build -t maui:0.1 .
    docker run -itd -e MYSQL_HOST=127.0.0.1 -p 4000:4000 maui:0.1
