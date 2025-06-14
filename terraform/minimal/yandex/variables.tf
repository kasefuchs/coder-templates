variable "yandex_subnet_id" {
  type        = string
  description = "ID of the subnet to attach VM instance to."
}

variable "yandex_image_family" {
  type        = string
  default     = "coder-workspace-minimal-debian-12"
  description = "Source image family to use when creating the boot disk."
}
