import 'package:flutter/material.dart';
import '../../models/category.dart';

class AddCategoryScreen extends StatefulWidget {
  final Category? category;

  const AddCategoryScreen({Key? key, this.category}) : super(key: key);

  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _urlPhoto;

  @override
  void initState() {
    super.initState();
    _name = widget.category?.name ?? '';
    _urlPhoto = widget.category?.urlPhoto ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category == null ? 'Adicionar Categoria' : 'Editar Categoria'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(
                  labelText: 'Nome da Categoria',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,  // Cor do texto em branco
                  ),
                ),
                validator: (value) => value!.isEmpty ? 'Este campo não pode estar vazio' : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _urlPhoto,
                decoration: InputDecoration(
                  labelText: 'URL da Foto',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,  // Cor do texto em branco
                  ),
                ),
                validator: (value) => value!.isEmpty ? 'Este campo não pode estar vazio' : null,
                onSaved: (value) => _urlPhoto = value!,
              ),
              ElevatedButton(
                onPressed:(){},// _submitForm,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //
  // void _submitForm() {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //     Category newCategory = Category(
  //       catId: widget.category?.catId ?? UniqueKey().toString(),
  //       name: _name,
  //       urlPhoto: _urlPhoto,
  //     );
  //     // Implementar a lógica para adicionar ou atualizar a categoria no banco de dados
  //     Navigator.pop(context, newCategory);  // Opção para retornar o objeto para uma tela anterior
  //   }
  // }
}
