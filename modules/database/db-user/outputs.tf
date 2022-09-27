output "user_db" {
  description = "Database username"
  value       = mongodbatlas_database_user.user1.username
}

output "user_db_pass" {
  description = "Database password"
  value       = random_password.db_user_password.result
}

output "user_x509" {
  description = "x509 token"
  value       = data.mongodbatlas_x509_authentication_database_user.test.customer_x509_cas
}
