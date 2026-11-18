# Observability (Elastic, lab)

```bash
cd observability && docker compose up -d     # wait ~2 minutes, open http://localhost:5601

# Make traffic, including errors (nginx on port 80 proxies to the service on 8080)
for i in $(seq 1 200); do curl -s -o /dev/null http://localhost/; done
for i in $(seq 1 30);  do curl -s -o /dev/null http://localhost/does-not-exist; done   # 404s
docker stop balance
for i in $(seq 1 20);  do curl -s -o /dev/null http://localhost/; done                 # 502s
docker start balance
```

In Kibana:

1. **Discover**: create a data view for `filebeat-*`, search with KQL `message : "502"` and `message : "404"`.
2. **Dashboard** `Balance service health`: log count over time, and a count of `message : "502"`.
3. **Alert rule**: Stack Management > Rules > Elasticsearch query. Index `filebeat-*`, query `message : "502"`, fire when the count is above 5 in the last 5 minutes, action Server log.

`docker compose down` stops it all.
