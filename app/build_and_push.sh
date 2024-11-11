npm run build:staging
gsutil -h "Cache-Control: no-cache, max-age=0" -m cp -r build/* gs://app.staging.winball.io
