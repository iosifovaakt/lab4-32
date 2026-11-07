provider "docker" {}

resource "random_pet" "name" {
  length = (var.variant % 3) + 1
}

resource "local_file" "index" {
  filename = "${path.module}/site/index.html"
  content = <<-EOT
    <h1>${var.greeting}, ${var.student}!</h1>
    <p>Variant ${var.variant}</p>
  EOT
}

resource "docker_image" "nginx" {
  name         = "nginx:alpine"
  keep_locally = true
}

resource "docker_container" "web" {
  name  = "web-${var.variant}-${random_pet.name.id}"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = var.external_port
  }

  volumes {
    host_path      = abspath("${path.module}/site")
    container_path = "/usr/share/nginx/html"
    read_only      = true
  }

  depends_on = [local_file.index]
}
