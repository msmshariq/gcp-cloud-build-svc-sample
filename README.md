# Hello World REST API for Cloud Run

A simple Java Spring Boot REST API that can be built and deployed to Google Cloud Run using Cloud Build.

## Prerequisites

- Java 17+
- Maven 3.6+
- Google Cloud SDK (gcloud)
- A GCP project with Cloud Build and Cloud Run APIs enabled

## Local Development

### Build and Run Locally

```bash
mvn clean package
java -jar target/hello-world-api-1.0.0.jar
```

The API will be available at `http://localhost:8080`

### Test Endpoints

- `GET /` - Returns "Hello World from Cloud Run!"
- `GET /health` - Returns "OK"

## Deploy to Cloud Run

### Using Cloud Build

1. Enable required APIs:
```bash
gcloud services enable cloudbuild.googleapis.com
gcloud services enable run.googleapis.com
gcloud services enable containerregistry.googleapis.com
```

2. Submit the build:
```bash
gcloud builds submit --config cloudbuild.yaml
```

3. The build will automatically:
   - Build the Docker image
   - Push it to Container Registry
   - Deploy to Cloud Run

### Manual Deployment

1. Build the Docker image:
```bash
docker build -t gcr.io/YOUR_PROJECT_ID/hello-world-api .
```

2. Push to Container Registry:
```bash
docker push gcr.io/YOUR_PROJECT_ID/hello-world-api
```

3. Deploy to Cloud Run:
```bash
gcloud run deploy hello-world-api \
  --image gcr.io/YOUR_PROJECT_ID/hello-world-api \
  --region us-central1 \
  --platform managed \
  --allow-unauthenticated \
  --port 8080
```

## Configuration

- The application runs on port 8080 (Cloud Run default)
- The Cloud Build config deploys to `us-central1` region by default
- Modify `cloudbuild.yaml` to change the region or other settings

