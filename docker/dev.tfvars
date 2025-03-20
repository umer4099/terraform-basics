image_id = "alpine"
image_web = ""
command = ["/bin/sh", "-c", "while true; do sleep 1000; done"]
env = [ "name=web", "enviorment=dev","CHOKIDAR_USEPOLLING=true" ]
mysql_image = "mysql"
mysql_root = [ "MYSQL_ROOT_PASSWORD=newroot","MYSQL_DATABASE=terraform"]
pipline_image = "jenkins/jenkins:lts"
pma_image = "phpmyadmin"
