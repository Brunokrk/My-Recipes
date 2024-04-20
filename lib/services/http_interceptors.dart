import 'package:http_interceptor/http_interceptor.dart';
import 'package:logger/logger.dart';

//Fica atento se está rolando uma requisição ou resposta
//E quando acontece nos permite fazer alguma coisa com essa requisição ou resposta
//Possível visualizar todas as informações do fluxo

class LoggingInterceptor implements InterceptorContract {
  // Importante printar 3 coisas:
  // Para onde estamos enviando
  // Quais os cabeçalhos
  // Qual o conteúdo

  Logger logger = Logger();

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    logger.v("Requisição para ${data.baseUrl}\nCabeçalhos: ${data.headers}\nCorpo: ${data.body}");
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if(data.statusCode ~/ 100 == 2){
      logger.i("Resposta de ${data.url}\nStatus da Resposta:${data.statusCode}\nCabeçalhos: ${data.headers}\nCorpo: ${data.body}");
    }else{
      logger.e("Resposta de ${data.url}\nStatus da Resposta:${data.statusCode}\nCabeçalhos: ${data.headers}\nCorpo: ${data.body}");
    }

    return data;
  }

}