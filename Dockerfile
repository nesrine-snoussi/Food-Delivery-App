# Use the official Flutter Docker image
FROM cirrusci/flutter:stable

# Create and switch to a non-root user
RUN useradd -m flutteruser
USER flutteruser

# Set the working directory to /app
WORKDIR /app

# Copy the Flutter project files into the container
COPY . .

# Get dependencies (flutter pub get)
RUN flutter pub get

# Build the Flutter app for the desired platform (e.g., web or apk)
RUN flutter build web  # Or use flutter build apk depending on your target

# Expose the port (for web apps, e.g., port 5000)
EXPOSE 5000

# Set the command to run the app
CMD ["flutter", "run", "-d", "chrome"]  # Use appropriate command for your platform
