FROM ppoffice/mssql-odbc
MAINTAINER PPOffice <ppoffice_2008@163.com>

RUN apt-get update && \
    apt-get -y install vim apache2 php5 php5-mssql php5-pgsql php5-mysql libmcrypt-dev php5-intl php5-curl && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN /usr/sbin/a2enmod rewrite
RUN php5enmod mssql
RUN php5enmod mysql
RUN php5enmod pgsql
# RUN php5enmod mcrypt
RUN php5enmod intl

# Edit apache2.conf to change apache site settings.
ADD apache2.conf /etc/apache2/

# Edit 000-default.conf to change apache site settings.
ADD 000-default.conf /etc/apache2/sites-available/
ADD php.ini /etc/php5/apache2/

# Uncomment these two lines to fix "non-UTF8" chars encoding and time format problems
ADD freetds.conf /etc/freetds/
ADD locales.conf /etc/freetds/

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
