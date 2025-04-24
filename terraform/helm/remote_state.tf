data "terraform_remote_state" "cluster" {
  backend = "local" # або "azurerm", якщо ти вже використовуєш Azure backend
  config = {
    path = "../cluster/cluster.terraform.tfstate" # шлях до .tfstate файлу з cluster/
  }
}