---
jupyter:
  kernelspec:
    display_name: Python 3
    language: python
    name: python3
  language_info:
    codemirror_mode:
      name: ipython
      version: 3
    file_extension: .py
    mimetype: text/x-python
    name: python
    nbconvert_exporter: python
    pygments_lexer: ipython3
    version: 3.10.8
  nbformat: 4
  nbformat_minor: 2
  orig_nbformat: 4
  vscode:
    interpreter:
      hash: e7370f93d1d0cde622a1f8e1c04877d8463912d04d973331ad4851f04de6915a
---

::: {.cell .markdown}
# 1 - Dependencies management {#1---dependencies-management}

***git branch name:*** dependencies

## Theory \[2\]

As usual, we will start with a few theoretical questions:

-   \[0.5\] What is Docker, and how it differs from dependencies
    management systems? From virtual machines?
-   \[0.5\] What are the advantages and disadvantages of using
    containers over other approaches?
-   \[0.5\] Explain how Docker works: what are Dockerfiles, how are
    containers created, and how are they run and destroyed?
-   \[0.25\] Name and describe at least one Docker competitor (i.e., a
    tool based on the same containerization technology).
-   \[0.25\] What is conda? How it differs from apt, yarn, and others?

## Problem \[6.5\] {#problem-65}

The problem itself is relatively simple.

Imagine that you developed an excellent RNA-seq analysis pipeline and
want to share it with the world. Based on your experience, you are
confident that the popularity of the pipeline will be proportional to
its ease of use. So, you decided to help your future users and to pack
all dependencies in a Conda environment and a Docker container.

Here is the list of tools and their versions that are used in your work:

-   [fastqc](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/),
    v0.11.9
-   [STAR](https://github.com/alexdobin/STAR), v2.7.10b
-   [samtools](https://github.com/samtools/samtools), v1.16.1
-   [picard](https://github.com/broadinstitute/picard), v2.27.5
-   [salmon](https://github.com/COMBINE-lab/salmon), commit tag 1.9.0
-   [bedtools](https://github.com/arq5x/bedtools2), v2.30.0
-   [multiqc](https://github.com/ewels/MultiQC), v1.13
:::

::: {.cell .code execution_count="1"}
``` {.python}
#Conda
```
:::

::: {.cell .markdown}
## Теория \[2\]

Как обычно, мы начнем с нескольких теоретических вопросов:

-   \[0.5\] Что такое Docker и чем он отличается от систем управления
    зависимостями? С виртуальных машин?

Docker - это платформа с открытым исходным кодом для создания,
развертывания контейнерных приложений и управления ими.

Docker отличается от других систем управления зависимостями своей
гибкостью и безопасностью. Кроме того, этот облачный сервер
предоставляет множество бесплатных приложений, а также множество
публичных и частных реестров с официальными репозиториями от ведущих
сторонних поставщиков --- от Nginx и Ubuntu до MongoDB и Redis.

Docker разработан таким образом, чтобы быть легким и простым. Он имеет
хороший уровень безопасности 760 и очень популярен в использовании,
поэтому, если вы обнаружите ошибку, вероятность того, что вы найдете
решение онлайн, составляет 99%.

В то время как для каждой рабочей нагрузки на виртуальной машине (VM)
требуется полноценная ОС или гипервизор, многие рабочие нагрузки могут
выполняться на одной ОС при использовании Docker.

Контейнеры Docker имеют быстрое время запуска и сокращают время
загрузки. Запуск виртуальных машин занимает некоторое время и имеет
ужасную производительность. Поскольку контейнеры Docker меньше
виртуальных машин, перемещать файлы в файловую систему хоста проще.

Из-за того, что ОС запущена, приложения Docker containers запускаются
немедленно. Виртуальные машины должны запускать полноценную операционную
систему для установки одной программы, для чего требуется полный процесс
загрузки.

-   \[0.5\] Каковы преимущества и недостатки использования контейнеров
    по сравнению с другими подходами?

Преимущества контейнеров.

Контейнеры - это упрощенный способ создания, тестирования, развертывания
и повторного развертывания приложений в нескольких средах: от локального
ноутбука разработчика до локального центра обработки данных и даже
облака. Преимущества контейнеров включают в себя:

-   Меньше накладных расходов\*

Контейнеры требуют меньше системных ресурсов, чем традиционные или
аппаратные среды виртуальных машин, поскольку они не включают образы
операционной системы.

-   Повышенная мобильность\*

Приложения, работающие в контейнерах, могут быть легко развернуты на
нескольких различных операционных системах и аппаратных платформах.

*Более последовательная работа*

Команды DevOps знают, что приложения в контейнерах будут работать
одинаково, независимо от того, где они развернуты.

*Повышение эффективности*

Контейнеры позволяют быстрее развертывать, исправлять или масштабировать
приложения.

*Улучшенная разработка приложений*

Контейнеры поддерживают усилия agile и DevOps по ускорению циклов
разработки, тестирования и производства.

Контейнеры против виртуальных машин (VMS) Люди иногда путают
контейнерную технологию с виртуальными машинами (VMS) или технологией
виртуализации серверов. Несмотря на некоторые основные сходства,
контейнеры сильно отличаются от виртуальных машин.

Виртуальные машины выполняются в среде гипервизора, где каждая
виртуальная машина должна включать в себя свою собственную гостевую
операционную систему, а также связанные с ней двоичные файлы, библиотеки
и файлы приложений. Это потребляет большое количество системных ресурсов
и накладных расходов, особенно когда на одном физическом сервере
запущено несколько виртуальных машин, каждая со своей собственной
гостевой ОС.

Напротив, каждый контейнер использует одну и ту же ОС хоста или
системное ядро и имеет гораздо меньший размер, часто всего мегабайт. Это
часто означает, что запуск контейнера может занять всего несколько
секунд (по сравнению с гигабайтами и минутами, необходимыми для обычной
виртуальной машины).

-   \[0.5\] Объясните, как работает Docker: что такое Dockerfiles, как
    создаются контейнеры и как они запускаются и уничтожаются?

Докерфайл

Dockerfile - это текстовый документ, содержащий все команды, которые
пользователь может вызвать в командной строке для сборки изображения.

Создайте каталог для хранения всех образов Docker, которые будут созданы
:::

::: {.cell .markdown}
## Anaconda
:::

::: {.cell .code}
``` {.python}
##Install conda
%%bash
MINICONDA_INSTALLER_SCRIPT=Miniconda3-4.5.4-Linux-x86_64.sh
MINICONDA_PREFIX=/usr/local
wget https://repo.continuum.io/miniconda/$MINICONDA_INSTALLER_SCRIPT
chmod +x $MINICONDA_INSTALLER_SCRIPT
./$MINICONDA_INSTALLER_SCRIPT -b -f -p $MINICONDA_PREFIX

conda install --channel defaults conda python=3.9 --yes
conda update --channel defaults --all --yes
conda update -n base -c defaults conda
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
conda config --set channel_priority strict

conda create --name hw_env python=3.9
conda activate hw_env
```
:::

::: {.cell .code}
``` {.python}
%%bash
git clone -b 2.27.5 https://github.com/broadinstitute/picard.git
cd picard
./gradlew shadowJar
java -jar build/libs/picard.jar
./gradlew clean 
```
:::

::: {.cell .code}
``` {.python}
!pip install multiqc
```
:::

::: {.cell .code}
``` {.python}
%%bash
conda install -y star=2.7.10b  
conda install -y samtools=1.16.1 
conda install -y bedtools=2.30.0 
conda install -y salmon=1.9.0
conda install -y fastqc=0.11.9

!conda env export > hw_env.yml  
```
:::

::: {.cell .markdown}
## Docker
:::

::: {.cell .code}
``` {.python}
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

#salmon v.1.9.0	
RUN   wget https://github.com/COMBINE-lab/salmon/releases/download/v1.9.0/salmon-1.9.0_linux_x86_64.tar.gz 
RUN   tar -zxvf salmon-1.9.0_linux_x86_64.tar.gz && rm salmon-1.9.0_linux_x86_64.tar.gz 
RUN   chmod a+x salmon-1.9.0_linux_x86_64/bin/salmon && \
      mv salmon-1.9.0_linux_x86_64/bin/salmon /bin/salmon && \
      rm -r salmon-1.9.0_linux_x86_64 

RUN pip3 install --upgrade pip    
RUN pip3 install multiqc==1.13

#install samtools rdy
RUN 	git clone -b 1.16.1 https://github.com/samtools/samtools.git
RUN	  mv samtools/misc samtools_tools && rm -R samtools 
RUN	  echo 'alias samtools="/samtools_tools/samtools.pl"' >> /.bashrc
RUN	  echo "samtools installed"

# install fastqc rdy
RUN  	echo 'FastQC installation process begin'
RUN  	echo 'FastQC need java to run. So make sure u have it'
RUN	  wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip
RUN  	unzip fastqc_v0.11.9.zip && rm fastqc_v0.11.9.zip 
RUN   chmod a+x FastQC/fastqc
RUN   echo 'alias fastqc="/FastQC/fastqc"' >> /.bashrc
RUN  	echo 'U can run it now with "fastqc" cmd in terminal'

#picard rdy
RUN	  git clone -b 2.27.5 https://github.com/broadinstitute/picard.git
RUN	  cd picard/ && ./gradlew shadowJar
RUN	  echo 'alias picard="java -jar ./picard/bin/picard.jar"' >> /.bashrc

#gradle done
RUN 	wget https://services.gradle.org/distributions/gradle-7.6-bin.zip
RUN	  mkdir /opt/gradle && unzip -d /opt/gradle gradle-7.6-bin.zip &&\
	    rm gradle-7.6-bin.zip
RUN	  export PATH=$PATH:/opt/gradle/gradle-7.6/bin

    
#STAR v.2.7.10b
RUN   wget https://github.com/alexdobin/STAR/releases/download/2.7.10b/STAR_2.7.10b.zip
RUN   unzip STAR_2.7.10b.zip && rm STAR_2.7.10b.zip 
RUN   chmod a+x STAR_2.7.10b/Linux_x86_64_static/STAR
RUN   mv STAR_2.7.10b/Linux_x86_64_static/STAR /bin/STAR && \
      rm -r STAR_2.7.10b


```
:::
