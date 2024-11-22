# Use an official Flutter image from the Docker Hub as the base image
FROM cirrusci/flutter:stable AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Flutter project files into the container
COPY . .

# Get dependencies
RUN flutter pub get

# Build the Flutter app for the desired platform (e.g., web or apk)
RUN flutter build web # Or use 'flutter build apk' for Android

# Use a minimal web server to serve the app (if building for the web)
FROM nginx:alpine

# Copy the build output to the Nginx server directory
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose the port on which the app will be served
EXPOSE 80

# Start Nginx to serve the Flutter web app
CMD ["nginx", "-g", "daemon off;"]
