using Minio;
using Minio.Exceptions;
using Minio.DataModel.Args;
using StackExchange.Redis;
using System.Xml.Serialization;
using System.Runtime.InteropServices;
using System.Net;
using System.Net.Sockets;


internal class SendFile
{

    /// <summary>
    /// Enviar o arquivo para o Minio
    /// </summary>
    /// <param name="nameFile"></param>
    /// <param name="nmArquivo"></param>
    public void EnviarArquivoMinio(string nameFile, string nmArquivo)
    {

        var ipAdress = Environment.GetEnvironmentVariable("IP_ADDRESS");
        var endpoint = "minio-svc";
        var port = 9000;
        var accessKey = "minioadmin";
        var secretKey = "minioadmin";
        string bucketName = "bucketrelatorioproject";
        try
        {
            IMinioClient minioClient = new MinioClient()
                              .WithEndpoint(endpoint, port)
                              .WithCredentials(accessKey, secretKey)
                              .Build();
            BucketExistsArgs args = new BucketExistsArgs().WithBucket(bucketName);
            MakeBucketArgs args2 = new MakeBucketArgs().WithBucket(bucketName);

            //Verificar se existe o bucket.
            bool found = minioClient.BucketExistsAsync(args).ConfigureAwait(false).GetAwaiter().GetResult();
            if (found)
            {
                //  Console.WriteLine(bucketName + " já existe");
            }
            else
            {
                // Cria bucket.
                // var policyJson = @"{{""Version"": ""2012-10-17"",""Statement"": [{""Effect"": ""Allow"", ""Principal"":{ ""AWS"": [""*""]}, ""Action"": [ ""s3:GetObject"",""s3:GetObjectAcl""],""Resource"": [""arn:aws:s3:::bucketproject/*"",""arn:aws:s3:::bucketproject""]}}";
                // var argsPolicy = new SetPolicyArgs()
                // .WithBucket(bucketName)
                // .WithPolicy(policyJson);
                // minioClient.SetPolicyAsync(argsPolicy).ConfigureAwait(false);
                minioClient.MakeBucketAsync(args2).ConfigureAwait(false).GetAwaiter().GetResult();
                Console.WriteLine(bucketName + " criado com sucesso!");
            }
            PutObjectArgs putObjectArgs = new PutObjectArgs()
                            .WithBucket(bucketName)
                            .WithObject(nmArquivo).WithFileName(nameFile)
                            .WithContentType("application/text");
            var result = minioClient.PutObjectAsync(putObjectArgs).ConfigureAwait(false).GetAwaiter().GetResult();
            var urlFile = minioClient.PresignedGetObjectAsync(new PresignedGetObjectArgs().WithBucket(bucketName).WithExpiry(25200).WithObject(nmArquivo)).ConfigureAwait(false).GetAwaiter().GetResult();

            Console.WriteLine("Arquivo criado com sucesso dentro do minio!");
            // Console.WriteLine(urlFile.Replace("minioserver", "localhost").Split("?")[0]);
            // Console.WriteLine(urlFile);
           
           ///verificar ip do docker
            // var host = Dns.GetHostEntry(Dns.GetHostName());

            // foreach (var ip in host.AddressList)
            // {
            //     if (ip.AddressFamily == AddressFamily.InterNetwork)
            //     {
            //         Console.WriteLine(ip.ToString()); 
            //     }
            // }
            minioClient.Dispose();
            ///enviar link para o redis
            ConnectionMultiplexer redis = ConnectionMultiplexer.Connect("redis-svc");
            IDatabase db = redis.GetDatabase();
            var hash = new HashEntry[] {
            new HashEntry("link", urlFile.Replace("minio-svc", "127.0.0.1"))
            };

            db.HashSet("link_" + nmArquivo, hash);

        }
        catch (MinioException e)
        {
            Console.WriteLine("Houve um erro ao enviar o arquivo: " + e);
        }

    }



}