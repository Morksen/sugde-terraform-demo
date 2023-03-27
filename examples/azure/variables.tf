variable "location" {
  default     = "westeurope"
  description = "The resource location"
}

variable "project_name" {
  default     = "SUGDE Demo"
  description = "The project name to add to the tags"
}

variable "tags" {
  description = "Additional tags to add to created resources"
}
