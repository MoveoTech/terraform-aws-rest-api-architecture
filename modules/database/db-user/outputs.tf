output "user_db" {
  description = "Database username"
  value       = mongodbatlas_database_user.user1.username
}

output "user_db_pass" {
  description = "Database password"
  value       = random_password.db_user_password.result
}