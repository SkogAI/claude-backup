Id:    b038c4e906aa4294ac095e51e15226ff
Name:  skogai-pipeline
Sources:
  HTTP:
    Endpoint:        <https://b038c4e906aa4294ac095e51e15226ff.pipelines.cloudflare.com>
    Authentication:  off
    Format:          JSON
  Worker:
    Format:  JSON
Destination:
  Type:         R2
  Bucket:       skogai
  Format:       newline-delimited JSON
  Compression:  GZIP
  Batch hints:
    Max bytes:     100 MB
    Max duration:  300 seconds
    Max records:   10,000,000

🎉 You can now send data to your pipeline!

To send data to your pipeline from a Worker, add the following to your wrangler config file:

{
  "pipelines": [
    {
      "pipeline": "skogai-pipeline",
      "binding": "PIPELINE"
    }
  ]
}

Send data to your pipeline's HTTP endpoint:

curl "<https://b038c4e906aa4294ac095e51e15226ff.pipelines.cloudflare.com>" -d '[{"foo": "bar"}]'

---

Id:    b038c4e906aa4294ac095e51e15226ff
Name:  skogai-pipeline
Sources:
  HTTP:
    Endpoint:        <https://b038c4e906aa4294ac095e51e15226ff.pipelines.cloudflare.com>
    Authentication:  off
    Format:          JSON
  Worker:
    Format:  JSON
Destination:
  Type:         R2
  Bucket:       skogai
  Format:       newline-delimited JSON
  Compression:  GZIP
  Batch hints:
    Max bytes:     100 MB
    Max duration:  300 seconds
    Max records:   10,000,000
