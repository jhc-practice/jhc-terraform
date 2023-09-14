resource "aws_route53_zone" "my_zone" {
    name="www.babitha.netfy.in"
  
}
resource "aws_route53_record""my_route"{
    zone_id=aws_route53_zone.my_zone.zone_id
    name="www.babitha.netfy.in"
    type="A"
    ttl="300"
    records=["172.31.39.150"]

}