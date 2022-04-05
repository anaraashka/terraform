resource "aws_iam_user" "dev-user-0" {
  name = var.dev-users.0
}
resource "aws_iam_user" "dev-user-1" {
  name = var.dev-users.1
}
resource "aws_iam_user" "dev-user-2" {
  name = var.dev-users.2
}
resource "aws_iam_user" "dev-user-3" {
  name = var.dev-users.3
}
resource "aws_iam_user" "dev-user-4" {
  name = var.dev-users.4
}
resource "aws_iam_user" "dev-user-5" {
  name = var.dev-users.5
}
resource "aws_iam_user" "dev-user-6" {
  name = var.dev-users.6
}
resource "aws_iam_user" "dev-user-7" {
  name = var.dev-users.7
}
resource "aws_iam_user" "user8" {
  name = var.dev-users.8
}


resource "aws_iam_user" "test-user-0" {
  name = var.test-users.0
}
resource "aws_iam_user" "test-user-1" {
  name = var.test-users.1
}
resource "aws_iam_user" "test-user-2" {
  name = var.test-users.2
}
resource "aws_iam_user" "test-user-3" {
  name = var.test-users.3
}
resource "aws_iam_user" "test-user-4" {
  name = var.test-users.4
}
resource "aws_iam_user" "test-user-5" {
  name = var.test-users.5
}
resource "aws_iam_user" "test-user-6" {
  name = var.test-users.6
}


resource "aws_iam_user" "prod-user-0" {
  name = var.prod-users.0
}
resource "aws_iam_user" "prod-user-1" {
  name = var.prod-users.1
}
resource "aws_iam_user" "prod-user-2" {
  name = var.prod-users.2
}
resource "aws_iam_user" "prod-user-3" {
  name = var.prod-users.3
}
resource "aws_iam_user" "prod-user-4" {
  name = var.prod-users.4
}
resource "aws_iam_user" "prod-user-5" {
  name = var.prod-users.5
}
resource "aws_iam_user" "prod-user-6" {
  name = var.prod-users.6
}
resource "aws_iam_user" "prod-user-7" {
  name = var.prod-users.7
}



# Create group
resource "aws_iam_group" "dev-group" {
  name = var.dev-group
}

resource "aws_iam_group" "test-group" {
  name = var.test-group
}

resource "aws_iam_group" "prod-group" {
  name = var.prod-group
}



#Assign to the group
resource "aws_iam_group_membership" "dev-user-group" {
  name = "dev-user-group"

  users = [
    aws_iam_user.dev-user-0.name,
    aws_iam_user.dev-user-1.name,
    aws_iam_user.dev-user-2.name,
    aws_iam_user.dev-user-3.name,
    aws_iam_user.dev-user-4.name,
    aws_iam_user.dev-user-5.name,
    aws_iam_user.dev-user-6.name,
    aws_iam_user.dev-user-7.name,
    aws_iam_user.user8.name,
  ]

  group = aws_iam_group.dev-group.name
}

resource "aws_iam_group_membership" "test-user-group" {
  name = "test-user-group"

  users = [
    aws_iam_user.test-user-0.name,
    aws_iam_user.test-user-1.name,
    aws_iam_user.test-user-2.name,
    aws_iam_user.test-user-3.name,
    aws_iam_user.test-user-4.name,
    aws_iam_user.test-user-5.name,
    aws_iam_user.test-user-6.name,

  ]

  group = aws_iam_group.test-group.name
}

resource "aws_iam_group_membership" "prod-user-group" {
  name = "prod-user-group"

  users = [
    aws_iam_user.prod-user-0.name,
    aws_iam_user.prod-user-1.name,
    aws_iam_user.prod-user-2.name,
    aws_iam_user.prod-user-3.name,
    aws_iam_user.prod-user-4.name,
    aws_iam_user.prod-user-5.name,
    aws_iam_user.prod-user-6.name,
    aws_iam_user.prod-user-7.name,

  ]

  group = aws_iam_group.prod-group.name
}
