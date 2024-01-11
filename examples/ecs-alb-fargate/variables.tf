variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "az_count" {
  description = "Number of AZs to cover in a given AWS region"
  type        = number
  default     = "3"
}

variable "cpu_required" {
  description = "CPU required for the ECS task"
  default     = "256"
}

variable "memory_required" {
  description = "Memory required for the ECS task"
  default     = "512"
}

variable "task_count_min" {
  description = "Minimum desired numbers of instances in the ecs service"
  default     = "1"
}

variable "task_count_desired" {
  description = "Desired numbers of servers in ASG"
  default     = "1"
}

variable "task_count_max" {
  description = "Maximum desired numbers of instances in the ecs service"
  default     = "2"
}
