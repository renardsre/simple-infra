# How-to Run The Application?

Prerequisites:
  - Golang v1.18.1
  - Docker v20.10.7
  - Docker Compose v1.25.0

This simple application calculates BMI (Body Mass Index) score. The base programming language used in this application is golang with gin gonic module. Let's continue how to run this application.

## Run The Application in Local

1. Go to the scripts directory.
2. Run script `./running-app start`. This script will be running docker-compose in our local and building the BMI application. So ensure you already installed docker & docker-compose.
3. Or you could manually start di application within app directory by executing the command below:
   ```bash
   go mod download
   go mod tidy
   go run main.go
   ```
4. Open your browser and try hit this: `http://localhost:8000/?height=185&weight=65`.
5. This app will running on your localhost on port 8000.

## CI/CD Pipeline

CI/CD pipeline used by this application is GitHub Action. The GitHub Action workflows on staging will be triggered by pushing a new commit id to branch `main`. And for the production release, you need to trigger by pushing a new tag version likes `v1.0.0`. See below for the workflow pipeline.

```
push master -> vulnerability scanning -> build and push to staging
release tag -> vulnerability scanning -> build and push to production
```

See below for the stack used in this pipeline:
- Automation CI/CD: GitHub Action
- Vulnerability Scanning: Snyk
- Deploy to web server: Heroku

## Example For Deploy a New Update

1. Ensure you make changes/updates in the app directory. Because pipeline workflows are triggered on the app path.
2. Make commit and push to branch master for deploying to staging. Or release tag for deploying to production.
4. Hit this url for check on staging <https://bmi-api-stag.herokuapp.com/?height=170&weight=65> and for the production <https://bmi-api-prod.herokuapp.com/?height=185&weight=68>.
3. Go to the [Kibana](http://54.255.230.215:5601/) dashboard to monitor the application that has been deployed.
4. Go to the APM Observability dashboard to monitor the application that has been deployed.
