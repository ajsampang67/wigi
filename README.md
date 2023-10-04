# wigi

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Local Dev
flutter run -d web-server --web-port=8080

# Docker
## Building docker image
docker build -t docker.io/ajsampang67/wigi .

## Running Docker image locally
docker run -p 5000:5000 wigi 

## Tagging new Docker image for push
docker tag <Docker image ID> docker.io/ajsampang67/wigi:<Version>

## Pushing new Docker image tag
docker push docker.io/ajsampang67/wigi:<Version>
