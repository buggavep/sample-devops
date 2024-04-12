FROM jenkins/inbound-agent:4.6-1-jdk11

USER root

# Add jenkins user to the passwd database
RUN echo "jenkins:x:1000:1000:jenkins user,,,:/home/jenkins:/bin/bash" >> /etc/passwd

# Install sudo
RUN apt-get update && \
    apt-get install -y sudo

# Add jenkins user to sudo group
RUN usermod -aG sudo jenkins

# Configure sudoers file to allow jenkins user to run commands as root without password
RUN echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install Docker
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

# Install Java
RUN apt-get install -y default-jdk

USER jenkins