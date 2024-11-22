# Use the official Flutter Docker image
FROM cirrusci/flutter:stable

# Set environment variables
ENV PUB_CACHE=/app/.pub-cache

# Set working directory
WORKDIR /app

# Copy the Flutter project files into the container
COPY . .

# Install the required Dart SDK version (3.5.4)
RUN apt-get update && \
    apt-get install -y unzip curl && \
    curl -LO https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-linux-x64-release.zip && \
    unzip dartsdk-linux-x64-release.zip -d /opt/dart-sdk && \
    rm dartsdk-linux-x64-release.zip && \
    export PATH="/opt/dart-sdk/dart-sdk/bin:$PATH"

# Configure Git for safe directory usage
RUN git config --global --add safe.directory /sdks/flutter

# Clean previous builds and install dependencies
RUN flutter clean
RUN flutter pub get

# Build the Android app
RUN flutter build apk --release

# Expose any necessary ports (if needed for debugging)
EXPOSE 8080

# Default command
CMD ["echo", "Flutter Android build complete!"]
