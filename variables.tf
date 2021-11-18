variable "project" {
  description = "The GCP project to use when deploying resources"
  type        = string
}

variable "region" {
  description = "Default region for deploying resources"
  type        = string
}

variable "username" {
  default     = ""
  description = "cluster username"
}

variable "password" {
  default     = ""
  description = "cluster password"
}

variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "cluster_nodes" {
  default     = 3
  description = "Number of cluster nodes"
}

variable "kubernetes_version" {
  description = "cluster version"
  type        = string
  default     = "latest"
}

variable "release_channel" {
  type        = string
  description = "The release channel of this cluster. Accepted values are `UNSPECIFIED`, `RAPID`, `REGULAR` and `STABLE`. Defaults to `UNSPECIFIED`."
  default     = null
}

variable "create_service_account" {
  description = "Create service account for nodes to use"
  type        = bool
  default     = false
}

variable "service_account" {
  description = "Service account the worker nodes should run as"
  default     = null
}

variable "machine_type" {
  description = "Machine type for nodes"
  type        = string
  default     = "n2-standard-4"
}
