# Use the official Flutter Docker image (stable version)
FROM cirrusci/flutter:stable

# Create a non-root user
RUN useradd -m flutteruser
USER flutteruser

# Set the working directory to /app
WORKDIR /app

# Copy the Flutter project files into the container
COPY . .

# Configure Git to avoid the "dubious ownership" error
RUN git config --global --add safe.directory /sdks/flutter

# Clear any old dependencies
RUN flutter clean

# Get dependencies (flutter pub get)
RUN flutter pub get

# Build the Flutter app for the desired platform (e.g., web or apk)
RUN flutter build web  # Or use flutter build apk depending on your target

# Expose the port (for web apps, e.g., port 5000)
EXPOSE 5000

# Set the command to run the app (use JSON array syntax)
CMD ["flutter", "run", "-d", "chrome"]  # Or use appropriate command for your platform
