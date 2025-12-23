# set up AWS user for terraform use

(base) ~/Desktop/PROJECTS/VERCEL> cat ~/.aws/credentials
[default]
aws_access_key_id = <key_id>
aws_secret_access_key = <secret_access_key>
(base) ~/Desktop/PROJECTS/VERCEL> aws sts get-caller-identity
{
"UserId": "AIDAWNHTHQB3A6CIRP6NB",
"Account": "440744247414",
"Arn": "arn:aws:iam::440744247414:user/fodi"
}
(base) ~/Desktop/PROJECTS/VERCEL> aws iam list-groups-for-user --user-name fodi
{
"Groups": [
{
"Path": "/",
"GroupName": "lambda-deploy",
"GroupId": "AGPAWNHTHQB3FFRK2DQHR",
"Arn": "arn:aws:iam::440744247414:group/lambda-deploy",
"CreateDate": "2025-12-23T02:15:30+00:00"
}
]
}

(base) ~/Desktop/PROJECTS/VERCEL> aws iam list-attached-group-policies --group-name lambda-deploy
{
"AttachedPolicies": [
{
"PolicyName": "IAMFullAccess",
"PolicyArn": "arn:aws:iam::aws:policy/IAMFullAccess"
},
{
"PolicyName": "AWSLambda_FullAccess",
"PolicyArn": "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
}
]
}

(base) ~/Desktop/PROJECTS/VERCEL> export AWS_PROFILE=fodi
(base) ~/Desktop/PROJECTS/VERCEL> echo $AWS_PROFILE
fodi
(base) ~/Desktop/PROJECTS/VERCEL>

# running

TF_LOG=DEBUG terraform init
