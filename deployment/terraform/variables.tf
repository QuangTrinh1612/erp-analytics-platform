variable "location" {
    description = "Azure Region"
    default     = "Southeast Asia"
}

variable "prefix" {
    description = "Resource Prefix"
    default     = "demo-kafka"
}

variable "admin_password" {
    description = "VM administrator password"
    type        = string
    sensitive   = true
}

variable "tenant_id" {
    description = "Client Tenant ID"
    type        = string
    sensitive   = true
}

variable "subscription_id" {
    description = "Subscription ID"
    type        = string
    sensitive   = true
}