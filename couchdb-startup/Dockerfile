FROM couchdb:3.1.1
ADD couchdbinit.sh .
CMD ["chmod", "+x", "/couchdbinit.sh"]
ENTRYPOINT ["sh", "-c", "/couchdbinit.sh"]
