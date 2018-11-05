@extends('layout')
@section('pagina_titulo', 'Pesquisar')

@section('pagina_conteudo')
    <div class="container">
        <div class="row">
            <div class="col-md-offset-1 col-md-8">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">Buscar</h3>
                        </div>
                        <div class="panel-body">
                            <input placeholder="Digite uma palavra chave" type="text" class="form-control" id="pesquisar" name="pesquisar">
                        </div>
                    </div>
                </div>

                <div class="col-md-12">
                    <h4 id="qtde" ></h4>
                </div>

                <div id="textos" class="col-md-12">

                </div>

            </div>
        </div>
    </div>

@endsection