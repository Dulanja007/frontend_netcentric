# Use an official Node.js image to build the application
FROM node:19 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire app directory
COPY . .

# Build the React app
RUN npm run build

# Use an Nginx image to serve the React app
FROM nginx:1.23

# Copy the build output to Nginx's default static directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 8080
EXPOSE 8080

# Start Nginx
# CMD ["nginx", "-g", "daemon off;"]
CMD [ "npm","start" ]
