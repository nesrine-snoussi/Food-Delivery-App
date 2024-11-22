# Use the official Flutter Docker image (stable version)
FROM cirrusci/flutter:stable

# Switch to root user to ensure we have permissions for setup
USER root

# Set the working directory to /app
WORKDIR /app

# Copy the Flutter project files into the container
COPY . .

# Resolve "dubious ownership" error by configuring Git
RUN git config --global --add safe.directory /sdks/flutter

# Ensure proper permissions for the Flutter directory
RUN chmod -R a+w /sdks/flutter && chmod -R a+w /app

# Clean previous builds and ensure correct dependencies
RUN flutter pub get

# Build the Android app
RUN flutter build apk --release

# Expose any necessary ports (if needed for debugging or testing)
EXPOSE 8080

# Default command (if running the app directly from the container isn't intended, you can remove this)
CMD ["echo", "Flutter Android build complete!"]
