# In this example, we are building the container using docker build . for production environment
# then run docker run -p 8080:80 <image>; default Nginx port is 80
# This is a multi step build. First the app gets build to get the html and js file
# then it gets copied into the required Ngnix folder so that it can be served to clients
# the "FROM" keyword marks the beginning of each step

# Step One
FROM node:alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build


# Step Two
# the COPY command is copying the build folder from the WORKDIR(hence /app/build) folder of Step One. 
# the /build folder gets created in step one when the last Run npm run build is executed
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# the nginx image runs default command and the above two lines are the minimum needed to get the server up
# refer to the nginx page on dockerhub