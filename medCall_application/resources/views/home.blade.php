@extends('layouts.master')

@section('header')
    @include('layouts.menu')
@stop

@section('main')
    <div class="row">
        <div class="col-md-3">
            <div class="panel panel-default">
                <div class="panel-heading">Busca de Profissionais</div>
                <div class="panel-body">
                    <form>
                        <!-- Estado -->
                        <div class="form-group">
                            <label for="estado">Estado</label>
                            <select class="form-control" id="estado">
                                <option value=""></option>
                                @foreach ($estados as $estado)
                                    <option value="{{ $estado->id }}">{{ $estado->nome }}</option>
                                @endforeach
                            </select>
                        </div>
                        <!-- Cidade -->
                        <div class="form-group">
                            <label for="cidade">Cidade</label>
                            <select class="form-control" id="cidade">
                            </select>
                        </div>
                        <!-- Especialidade -->
                        <div class="form-group">
                            <label for="especialidade">Especialidade</label>
                            <select class="form-control" id="estado">
                                @foreach ($especialidades as $especialidade)
                                    <option value="{{ $especialidade->id }}">{{ $especialidade->especialidade }}</option>
                                @endforeach
                            </select>
                        </div>
                        <!-- Procedimento -->
                        <div class="form-group">
                            <label for="procedimento">Procedimento</label>
                            <select class="form-control" id="procedimento">
                                @foreach ($procedimentos as $procedimento)
                                    <option value="{{ $procedimento->id }}">{{ $procedimento->procedimento }}</option>
                                @endforeach
                            </select>
                        </div>
                        <!-- Botao Pesquisar -->
                        <button type="submit" class="btn btn-success">
                            <span class="glyphicon glyphicon-search"></span>
                            &nbsp;Pesquisar
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
@stop

{{--
@section('footer')
   &copy; Medcall Consultas
@stop
--}}
