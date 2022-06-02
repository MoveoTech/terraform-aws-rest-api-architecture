package test

import (
	"os"
	"testing"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestTerraformSimpleExample(t *testing.T) {
	t.Parallel()

	// Construct the terraform options with default retryable errors to handle the most common
	// retryable errors in terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/simple-test",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"region": "us-east-1"
			"availability_zones":["us-east-1a"]
			"public_key":   os.Getenv("ATLAS_PUBLIC_KEY"),
			"private_key":  os.Getenv("ATLAS_PRIVATE_KEY"),
			"atlas_org_id": os.Getenv("ATLAS_ORG_ID"),
		},
	})

	// At the end of the test, run `terraform destroy` to clean up any resources that were created.
	defer terraform.Destroy(t, terraformOptions)

	// Run `terraform init` and `terraform apply`. Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// // Run `terraform output` to get the IP of the instance
	// publicIp := terraform.Output(t, terraformOptions, "public_ip")

	// // Make an HTTP request to the instance and make sure we get back a 200 OK with the body "Hello, World!"
	// url := fmt.Sprintf("http://%s:8080", publicIp)
	// http_helper.HttpGetWithRetry(t, url, nil, 200, "Hello, World!", 30, 5*time.Second)
}
