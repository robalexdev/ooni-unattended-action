FROM debian:bookworm

# See https://ooni.org/install/cli/
RUN apt-get update && apt-get install -y gpg ca-certificates
RUN mkdir -p /root/.gnupg/ /etc/apt/keyrings/ && \
	gpg --no-default-keyring --keyserver hkp://keyserver.ubuntu.com --keyring /etc/apt/keyrings/ooni-apt-keyring.gpg --recv-keys 'B5A08F01796E7F521861B449372D1FF271F2DD50' && \
	echo "deb [signed-by=/etc/apt/keyrings/ooni-apt-keyring.gpg] https://deb.ooni.org/ unstable main" | tee /etc/apt/sources.list.d/ooniprobe.list && \
	apt-get update && \
	apt-get install -y ooniprobe-cli

# Skip onboarding
RUN ooniprobe onboard --yes

# Run unattended probes
ENTRYPOINT [ "ooniprobe" ]
CMD [ "run", "unattended" ]

