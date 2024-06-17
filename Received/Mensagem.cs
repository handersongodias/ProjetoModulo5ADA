using Newtonsoft.Json;

public class Mensagem
{
    [JsonProperty("id")]
    public string? Id { get; set; }
    [JsonProperty("codigoTransacao")]
    public string? CodigoTransacao { get; set; }
    [JsonProperty("nome")]
    public string? Nome { get; set; }
    [JsonProperty("valorCompra")]
    public string? ValorCompra { get; set; }   
    [JsonProperty("registro")]
    public string? Registro { get; set; }
    [JsonProperty("valorMaiorCompra")]
    public string? ValorMaiorCompra { get; set; }

}
