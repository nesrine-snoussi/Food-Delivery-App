# Use the official Flutter Docker image (stable version)
FROM cirrusci/flutter:stable

# Create and switch to a non-root user
RUN useradd -m flutteruser
USER flutteruser

# Set the working directory to /app
WORKDIR /app

# Copy the Flutter project files into the container
COPY . .

# Clear any old dependencies and ensure the correct versions
RUN flutter clean

# Get dependencies (flutter pub get)
RUN flutter pub get

# Build the Flutter app for the desired platform (e.g., web or apk)
RUN flutter build web  # Or use flutter build apk depending on your target

# Expose the port (for web apps, e.g., port 5000)
EXPOSE 5000

# Set the command to run the app (use JSON array syntax)
CMD ["flutter", "run", "-d", "chrome"]  # Or use appropriate command for your platform
