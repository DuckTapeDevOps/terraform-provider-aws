
## ECS

resource "aws_ecs_cluster" "main" {
  name = "terraform_example_ecs_cluster"
}

resource "aws_ecs_task_definition" "ghost" {
  family = "tf_example_ghost_td"
  container_definitions = templatefile("${path.module}/task-definition.json", {
    image_url        = "ghost:latest"
    container_name   = "ghost"
    log_group_region = var.aws_region
    log_group_name   = aws_cloudwatch_log_group.app.name
  })
}

resource "aws_ecs_service" "test" {
  name            = "tf-example-ecs-ghost"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.ghost.arn
  desired_count   = var.service_desired
  iam_role        = aws_iam_role.ecs_service.name

  load_balancer {
    target_group_arn = aws_alb_target_group.test.id
    container_name   = "ghost"
    container_port   = "2368"
  }

  depends_on = [
    aws_iam_role_policy.ecs_service,
    aws_alb_listener.front_end,
  ]
}