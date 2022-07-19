terraform {

  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "~> 5.0"
    }
  }

}

locals {

  staging_app    = "bmi-api-stag"
  production_app = "bmi-api-prod"

}

resource "heroku_app" "staging" {

  name   = local.staging_app
  region = "us"

}

resource "heroku_app" "production" {

  name   = local.production_app
  region = "us"

}

output "heroku_app_staging" {

  value     = heroku_app.staging
  sensitive = true

}

output "heroku_app_production" {

  value     = heroku_app.production
  sensitive = true
  
}
