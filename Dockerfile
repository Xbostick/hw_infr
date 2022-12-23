FROM ubuntu:18.04
RUN useradd --create-home --shell /bin/bash app_user
WORKDIR /home/app_user
USER root
RUN 	apt update	&& \
	apt-get update 	&& \
	apt-get install -y wget && 	\
	apt-get install -y make &&	\
	apt install -y openjdk-11-jdk &&\
	apt-get install -y unzip &&	\
	apt-get install -y git 	&&	\
	apt-get install -y python3-pip

# install fastqc rdy
RUN  	echo 'FastQC installation process begin'
RUN  	echo 'FastQC need java to run. So make sure u have it'
RUN	wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip
RUN  	unzip fastqc_v0.11.9.zip && rm fastqc_v0.11.9.zip 
RUN    	chmod a+x FastQC/fastqc
RUN    	echo 'alias fastqc="/FastQC/fastqc"' >> /.bashrc
RUN  	echo 'U can run it now with "fastqc" cmd in terminal'


#install samtools rdy
RUN 	git clone -b 1.16.1 https://github.com/samtools/samtools.git
RUN	mv samtools/misc samtools_tools && rm -R samtools 
RUN	echo 'alias samtools="/samtools_tools/samtools.pl"' >> /.bashrc
RUN	echo "samtools installed"

#gradle done
RUN 	wget https://services.gradle.org/distributions/gradle-7.6-bin.zip
RUN	mkdir /opt/gradle && unzip -d /opt/gradle gradle-7.6-bin.zip &&\
	rm gradle-7.6-bin.zip
RUN	export PATH=$PATH:/opt/gradle/gradle-7.6/bin

#picard rdy
RUN	git clone -b 2.27.5 https://github.com/broadinstitute/picard.git
RUN	cd picard/ && ./gradlew shadowJar
RUN	echo 'alias picard="java -jar ./picard/bin/picard.jar"' >> /.bashrc


#salmon v.1.9.0	
RUN wget https://github.com/COMBINE-lab/salmon/releases/download/v1.9.0/salmon-1.9.0_linux_x86_64.tar.gz && \
    tar -zxvf salmon-1.9.0_linux_x86_64.tar.gz && \
    rm salmon-1.9.0_linux_x86_64.tar.gz && \
    chmod a+x salmon-1.9.0_linux_x86_64/bin/salmon && \
    mv salmon-1.9.0_linux_x86_64/bin/salmon /bin/salmon && \
    rm -r salmon-1.9.0_linux_x86_64 
    
#STAR v.2.7.10b
RUN wget https://github.com/alexdobin/STAR/releases/download/2.7.10b/STAR_2.7.10b.zip && \
    unzip STAR_2.7.10b.zip && \
    rm STAR_2.7.10b.zip && \
    chmod a+x STAR_2.7.10b/Linux_x86_64_static/STAR && \
    mv STAR_2.7.10b/Linux_x86_64_static/STAR /bin/STAR && \
    rm -r STAR_2.7.10b


RUN pip3 install --upgrade pip    
RUN pip3 install multiqc==1.13






