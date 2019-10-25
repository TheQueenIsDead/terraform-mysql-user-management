

# Configure the docker provider
provider "docker" {
  host = "tcp://localhost:2375"
}

provider "mysql" {
  endpoint = "localhost:3306"
  username = "root"
  password = "testing"
}

resource "docker_image" "mysql" {
  name = "mysql:latest"
}

resource "docker_container" "mysql" {
  image = "${docker_image.mysql.latest}"
  name = "mysql"
  restart = "always"
  hostname = "mysql"
  env = ["MYSQL_ROOT_PASSWORD=testing"]
  ports {
    internal = 3306
    external = 3306
  }
}

resource "mysql_database" "app" {
  name = "testnewdb"
}