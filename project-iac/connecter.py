import psycopg2
engine = psycopg2.connect(
    database="postgres",
    user="babi",
    password="Babitha@1015",
    host="terraform-20230906100555283600000001.c0cl7k7rsgti.us-east-2.rds.amazonaws.com",
    port='5432'
)