if test -d "$HOME/.ec2"; then
    set -x EC2_PRIVATE_KEY (/bin/ls "$HOME"/.ec2/pk-*.pem | /usr/bin/head -1)
    set -x EC2_CERT (/bin/ls "$HOME"/.ec2/cert-*.pem | /usr/bin/head -1)
    set -x EC2_HOME "/usr/local/Cellar/ec2-api-tools/1.6.12.0/libexec"
    set -x AWS_CREDENTIAL_FILE "$HOME"/.ec2/aws-credential
    set -x AWS_CLOUDFORMATION_HOME "/usr/local/Library/LinkedKegs/aws-cfn-tools/jars"
    set -x AWS_AUTO_SCALING_HOME "/usr/local/Library/LinkedKegs/auto-scaling/jars"
    set -x AWS_ELASTICACHE_HOME "/usr/local/Cellar/aws-elasticache/1.9.000/libexec"
    set -x AWS_SNS_HOME "/usr/local/Library/LinkedKegs/aws-sns-cli/jars"
    set -x AWS_CLOUDWATCH_HOME "/usr/local/Library/LinkedKegs/cloud-watch/jars"
    set -x SERVICE_HOME "$AWS_CLOUDWATCH_HOME"
    set -x EC2_AMITOOL_HOME "/usr/local/Library/LinkedKegs/ec2-ami-tools/jars"
    set -x AWS_ELB_HOME "/usr/local/Cellar/elb-tools/1.0.23.0/libexec"
    set -x AWS_RDS_HOME "/usr/local/Cellar/rds-command-line-tools/1.14.001/libexec"
    set -x AWS_IAM_HOME "/usr/local/opt/aws-iam-tools/libexec"
end
