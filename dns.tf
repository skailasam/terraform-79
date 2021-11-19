resource "google_dns_managed_zone" "xecm_zone" {
  name        = "xecm-zone"
  dns_name    = "${var.domain}."
  description = "Extended ECM DNS zone"
}

resource "google_dns_record_set" "otcs" {
  name = "otcs.${google_dns_managed_zone.xecm_zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.xecm_zone.name

  rrdatas = [google_compute_address.xecm_ip_address.address]
}

resource "google_dns_record_set" "otac" {
  name = "otac.${google_dns_managed_zone.xecm_zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.xecm_zone.name

  rrdatas = [google_compute_address.xecm_ip_address.address]
}

resource "google_dns_record_set" "otds" {
  name = "otds.${google_dns_managed_zone.xecm_zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.xecm_zone.name

  rrdatas = [google_compute_address.xecm_ip_address.address]
}

resource "google_dns_record_set" "otpd" {
  name = "otpd.${google_dns_managed_zone.xecm_zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.xecm_zone.name

  rrdatas = [google_compute_address.xecm_ip_address.address]
}
