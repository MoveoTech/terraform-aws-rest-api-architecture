output "user_db" {
  value = mongodbatlas_database_user.user1.username
}

output "user_db_pass" {
  value = random_password.db_user_password.result
}