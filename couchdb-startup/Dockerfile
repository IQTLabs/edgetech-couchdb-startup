FROM couchdb:3.3.3
ADD couchdbinit.sh .
CMD ["chmod", "+x", "/couchdbinit.sh"]
ENTRYPOINT ["sh", "-c", "/couchdbinit.sh"]
