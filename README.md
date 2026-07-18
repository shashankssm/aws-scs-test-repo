# Terraform AWS S3 Bucket + IAM User

This Terraform project creates:

- An Amazon S3 Bucket
- An IAM User
- IAM Access Keys for the user
- An IAM Policy granting **read-only access** to the specified S3 bucket
- Attaches the policy to the IAM User

---

## Prerequisites

- Terraform >= 1.5
- AWS Account
- AWS CLI (Optional)
- IAM credentials with permissions to create:
  - S3 Buckets
  - IAM Users
  - IAM Policies
  - IAM Access Keys

---

## Project Structure

```text
.
├── .env
├── .gitignore
├── versions.tf
├── variables.tf
├── terraform.tfvars
├── main.tf
├── outputs.tf
└── README.md
```

---

## Configure AWS Credentials

Create a `.env` file in the project root.

```bash
export AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY"
export AWS_SECRET_ACCESS_KEY="YOUR_SECRET_KEY"
export AWS_DEFAULT_REGION="us-east-1"
```

Load the environment variables:

```bash
source .env
```

Verify:

```bash
echo $AWS_ACCESS_KEY_ID
echo $AWS_DEFAULT_REGION
```

---

## Configure Variables

Edit `terraform.tfvars`

```hcl
bucket_name = "my-unique-demo-bucket-12345"
iam_username = "s3-reader"
```

> **Note:** S3 bucket names must be globally unique.

---

## Initialize Terraform

```bash
terraform init
```

---

## Validate Configuration

```bash
terraform validate
```

---

## Preview Changes

```bash
terraform plan
```

---

## Deploy Infrastructure

```bash
terraform apply
```

Type:

```
yes
```

when prompted.

---

## Resources Created

Terraform will create:

- Amazon S3 Bucket
- IAM User
- IAM Access Key
- IAM Secret Access Key
- IAM Policy
- IAM Policy Attachment

The IAM user will have permission to:

- List the bucket
- Read objects inside the bucket

The user will **not** have permission to:

- Upload objects
- Delete objects
- Delete bucket
- Modify bucket policy
- Manage IAM resources

---

## View Outputs

Display all outputs:

```bash
terraform output
```

Display Access Key:

```bash
terraform output access_key_id
```

Display Secret Key:

```bash
terraform output -raw secret_access_key
```

---

## Upload Test File

Using AWS CLI:

```bash
aws s3 cp test.txt s3://YOUR_BUCKET_NAME/
```

---

## Test IAM User

Export the generated credentials:

```bash
export AWS_ACCESS_KEY_ID=<Generated_Access_Key>
export AWS_SECRET_ACCESS_KEY=<Generated_Secret_Key>
export AWS_DEFAULT_REGION=us-east-1
```

List bucket:

```bash
aws s3 ls s3://YOUR_BUCKET_NAME
```

Download an object:

```bash
aws s3 cp s3://YOUR_BUCKET_NAME/example.txt .
```

Attempting to upload should fail:

```bash
aws s3 cp test.txt s3://YOUR_BUCKET_NAME/
```

Expected:

```
AccessDenied
```

---

## Destroy Infrastructure

Remove all created resources:

```bash
terraform destroy
```

---

## Security Notes

- Never commit the `.env` file to Git.
- Never commit Terraform state files if they contain secrets.
- Store IAM Access Keys securely.
- Rotate IAM credentials periodically.
- Grant only the minimum permissions required.

---

## .gitignore

```
.terraform/
terraform.tfstate
terraform.tfstate.*
.terraform.lock.hcl
.env
```

---

## Troubleshooting

### InvalidClientTokenId

Ensure your credentials are loaded:

```bash
source .env
```

Verify:

```bash
env | grep AWS
```

---

### BucketAlreadyExists

Choose a different bucket name in `terraform.tfvars`.

---

### AccessDenied

Ensure the IAM credentials in `.env` have permissions to create:

- IAM Users
- IAM Policies
- IAM Access Keys
- S3 Buckets

---

## Clean Up

To remove all resources:

```bash
terraform destroy -auto-approve
```

---

## License

This project is provided as an example for learning and infrastructure automation using Terraform.
