resource "google_dns_managed_zone" "xecm-zone" {
  name        = "xecm-cloud.com"
  dns_name    = "xecm-cloud.com."
  description = "Extended ECM DNS zone"
}

resource "google_dns_record_set" "otcs" {
  name = "otcs.${google_dns_managed_zone.xecm-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.xecm-zone.name

#  rrdatas = [google_compute_instance.frontend.network_interface[0].access_config[0].nat_ip]
}
