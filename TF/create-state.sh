STAGE="production"
AWS_REGION="eu-west-1"

ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"

BUCKET="${ACCOUNT_ID}-terraform-state-${STAGE}-${AWS_REGION}"
LOCK_TABLE="${ACCOUNT_ID}-terraform-lock-${STAGE}-${AWS_REGION}"

if aws s3api list-buckets | grep -oq $BUCKET; then
    echo "Bucket already exists"
else
aws s3api create-bucket \
    --region "${AWS_REGION}" \
    --bucket "${BUCKET}" \
    --reate-bucket-configuration LocationConstraint=${AWS_REGION}
fi

if aws dynamodb list-tables | grep -oq ${LOCK_TABLE}; then
    echo "Table exists"
else
    aws dynamodb create-table \
    --region "${AWS_REGION}" \
    --table-name "${LOCK_TABLE}}" \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1
fi

cat <<EOF > ./backend.tf
terraform {
    backend "s3" {
        bucket         = "${BUCKET}"
        key            = "${STAGE}.tfstate"
        region         = "${AWS_REGION}"
        dynamodb_table = "${LOCK_TABLE}"
    }
}
EOF