resource "google_dns_managed_zone" "xecm-zone" {
  name        = "xecm-cloud"
  dns_name    = "xecm-cloud.com."
  description = "Extended ECM DNS zone"
}

resource "google_dns_record_set" "otcs" {
  name = "otcs.${google_dns_managed_zone.xecm-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.xecm-zone.name

  rrdatas = [google_compute_address.xecm_ip_address.address]
}

resource "google_dns_record_set" "otac" {
  name = "otac.${google_dns_managed_zone.xecm-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.xecm-zone.name

  rrdatas = [google_compute_address.xecm_ip_address.address]
}

resource "google_dns_record_set" "otds" {
  name = "otds.${google_dns_managed_zone.xecm-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.xecm-zone.name

  rrdatas = [google_compute_address.xecm_ip_address.address]
}

resource "google_dns_record_set" "otpd" {
  name = "otpd.${google_dns_managed_zone.xecm-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.xecm-zone.name

  rrdatas = [google_compute_address.xecm_ip_address.address]
}
