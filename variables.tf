variable "student" {
  type        = string
  description = "Студент тегі (латынша)"
}

variable "variant" {
  type        = number
  description = "Нұсқа нөмірі N"
}

variable "greeting" {
  type = string

  validation {
    condition     = contains(["Salem", "Hello", "Privet"], var.greeting)
    error_message = "greeting тек Salem, Hello немесе Privet болуы керек."
  }
}

variable "external_port" {
  type = number

  validation {
    condition     = var.external_port >= 8400 && var.external_port <= 8500
    error_message = "Порт 8400-8500 аралығында болуы керек."
  }
}
