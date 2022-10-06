resource "aws_iam_role" "EC2_dev_role" {
  name = "EC2_dev_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      tag-key = "Cloudwatch"
  }
}

resource "aws_iam_instance_profile" "dev_profile" {
  name = "dev_profile"
  role = "${aws_iam_role.EC2_dev_role.name}"
}

resource "aws_iam_role_policy" "CloudWatchFullAccess_COPY" {
  name = "CloudWatchFullAccess_COPY"
  role = "${aws_iam_role.EC2_dev_role.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
          "autoscaling:Describe*",
          "cloudwatch:*",
          "logs:*",
          "sns:*",
          "iam:GetPolicy",
          "iam:GetPolicyVersion",
          "iam:GetRole"
          
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "iam:CreateServiceLinkedRole",
      "Resource": "arn:aws:iam::*:role/aws-service-role/events.amazonaws.com/AWSServiceRoleForCloudWatchEvents*",
      "Condition": {
          "StringLike": {
              "iam:AWSServiceName": "events.amazonaws.com"
          }
        }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "CloudWatchAgentServerPolicy_COPY" {
  name = "CloudWatchAgentServerPolicy_COPY"
  role = "${aws_iam_role.EC2_dev_role.id}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "cloudwatch:PutMetricData",
                "ec2:DescribeVolumes",
                "ec2:DescribeTags",
                "logs:PutLogEvents",
                "logs:DescribeLogStreams",
                "logs:DescribeLogGroups",
                "logs:CreateLogStream",
                "logs:CreateLogGroup"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameter"
            ],
            "Resource": "arn:aws:ssm:*:*:parameter/AmazonCloudWatch-*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "s3-dev" {
  name = "s3-dev"
  role = "${aws_iam_role.EC2_dev_role.id}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}