<!DOCTYPE html>
<html>
<head>
    <title>Carrinho de Compras - @yield('pagina_titulo')</title>

    <!--Import Google Icon Font-->
    <link href="//fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/materialize/0.97.8/css/materialize.min.css" media="screen,projection">
    <!--Let browser know website is optimized for mobile-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <link href="{{url('/css/styles.css')}}" rel="stylesheet">

</head>
<body>
    <header>

        <nav>
            <div class="nav-wrapper light-blue row">
                <a href="{{ route('index') }}" class="brand-logo col offset-l1">Carrinho de Compras</a>
                <a href="#" data-activates="mobile-menu" class="button-collapse"><i class="material-icons">menu</i></a>
                <ul class="right hide-on-med-and-down">
                    <li><a href="{{ route('home.pesquisa') }}">Buscar</a></li>
                    <li><a href="{{ route('carrinho.compras') }}">Minhas compras</a></li>
                    <li><a href="{{ route('carrinho.index') }}">Carrinho</a></li>
                    @if (Auth::guest())
                        <li><a href="{{ url('/login') }}">Entrar</a></li>
                        <li><a href="{{ url('/register') }}">Cadastre-se</a></li>
                    @else
                        <li>
                            <a class="dropdown-button" href="#!" data-activates="dropdown-user">
                                Olá {{ Auth::user()->name }}!<i class="material-icons right">arrow_drop_down</i>
                            </a>
                            <ul id="dropdown-user" class="dropdown-content">
                                <li class="divider"></li>
                                <li>
                                    <a href="{{ url('/logout') }}"
                                        onclick="event.preventDefault();
                                                 document.getElementById('logout-form').submit();">
                                        Sair
                                    </a>
                                </li>
                            </ul>
                        </li>
                    @endif
                </ul>
            </div>
        </nav>
    </header>
    <main>
        @yield('pagina_conteudo')

        @if(!Auth::guest())
            <form id="logout-form" action="{{ url('/logout') }}" method="POST" class="hide">
                {{ csrf_field() }}
            </form>
        @endif
    </main>
    <footer class="page-footer blue">
        <div class="footer-copyright">
            <div class="container">
                Teste - Criação de uma loja simples:: Version Laravel {{ App::VERSION() }} - Cicero Vieira cicvieira@yahoo.com.br
            </div>
        </div>
    </footer>


    <!--Import jQuery before materialize.js-->
    <script type="text/javascript" src="//code.jquery.com/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/materialize/0.97.8/js/materialize.min.js"></script>

    <script src="{{url('js/util.js')}}" charset="utf-8"></script>

    @stack('scripts')
    <script type="text/javascript">
        $( document ).ready(function(){
            $(".button-collapse").sideNav();
            $('select').material_select();
        });
    </script>

    <script type="text/javascript">
        $('#pesquisar').keyup(function(){
            if($('#pesquisar').val().length >= 1){
                $('#qtde').html("Pesquisando...");
                $.get("{!! url('pesquisa') !!}", {pesquisar:$('#pesquisar').val()},function(data){

                    $('#qtde').html(data.produto.length.toString()+" Resultados");
                    var html = "";
                    for (var i = 0; i < data.produto.length; i++) {
                        var valor = formatBR(data.produto[i].valor);

                        html += "<div class='col s12 m6 l4'>";
                        html += "<div class='card medium'>";
                        html += "<div class='card-image'>";
                        html += "<img src="+data.url+"/images/"+data.produto[i].imagem+">";
                        html += "</div>";
                        html += "<div class='card-content'>";
                        html += "<span class='card-title grey-text text-darken-4 truncate' title="+data.produto[i].nome+">"+data.produto[i].nome+"</span>";
                        html += "<p>"+valor+"</p>";
                        html += "</div>";
                        html += "<div class='card-action'>";
                        html += "<a class='blue-text' href="+data.url+"/produto/"+data.produto[i].id+">Veja mais informações</a>";
                        html += "</div>";
                        html += "</div>";
                        html += "</div>";
                        
                    }
                    if(data.produto.length!=0){
                        $("#textos").html(html);
                    }else{
                        $('#qtde').html("Nenhum Produto Foi Encontrado!!!");
                        $("#textos").html("");
                    }
                });
            }
        });
    </script>


    <script type="text/javascript">
        $( document ).ready(function(){

            var my_data = {
                "0":"Apple",
                "1":"Microsoft",
                "2":"Google"
            }
            var myConvertedData = {};
            $.each(my_data, function(index, value) {
                myConvertedData[value] = null;
            });
            $('.chips-autocomplete').material_chip({
                autocompleteData: myConvertedData
            });
        });
    </script>



</body>
</html>