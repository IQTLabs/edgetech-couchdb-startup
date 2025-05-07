FROM couchdb:3.5.0
ADD couchdbinit.sh .
CMD ["chmod", "+x", "/couchdbinit.sh"]
ENTRYPOINT ["sh", "-c", "/couchdbinit.sh"]
