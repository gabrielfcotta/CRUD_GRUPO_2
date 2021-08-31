import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/heroes_provider.dart' as heroesProvider;
import 'package:shop_app/providers/powers_provider.dart';
import 'package:shop_app/providers/universe_provider.dart';
import 'package:shop_app/widgets/power_grid.dart';
import 'package:shop_app/widgets/universe_radio_tile.dart';

class EditHeroScreen extends StatefulWidget {
  const EditHeroScreen({Key? key}) : super(key: key);

  static const routeName = '/edit-hero';

  @override
  _EditHeroScreenState createState() => _EditHeroScreenState();
}

class _EditHeroScreenState extends State<EditHeroScreen> {
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _edittedHero = heroesProvider.Hero(
      id: '',
      name: '',
      imageUrl: '',
      powers: [],
      universe: Universe(id: '1', name: 'Universo A'),
      creationDate: 'TESTE');
  var _initValues = {
    'id': '',
    'name': '',
    'powers': '',
    'universe': '',
    'imageUrl': ' ',
  };

  var _isInit = true;
  var _isLoading = false;

  /* @override
  void dispose() {
    _imageUrlController.dispose();
    super.dispose();
  } */

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    // If there isn't and ID, the hero mut be added, else it should be updated
    if (_edittedHero.id != '') {
      Provider.of<heroesProvider.HeroesProvider>(context, listen: false)
          .updateHero(_edittedHero, _edittedHero.id);
    } else {
      try {
        Provider.of<heroesProvider.HeroesProvider>(context, listen: false)
            .addHero(_edittedHero);
      } catch (error) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('An error occured'),
            content: Text('Something went wrong!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final heroId = ModalRoute.of(context)?.settings.arguments as String;

      if (heroId != '') {
        _edittedHero =
            Provider.of<heroesProvider.HeroesProvider>(context, listen: false)
                .findById(heroId);
      }

      if (heroId != '') {
        _initValues = {
          'id': _edittedHero.id,
          'name': _edittedHero.name,
          'power': _edittedHero.powers.toString(),
          'universe': _edittedHero.universe.toString(),
          'imageUrl': _edittedHero.imageUrl,
        };
        //_imageUrlController.text = _edittedHero.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Edit Hero', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              _saveForm();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Form(
                    key: _form,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue: _initValues['name'],
                            decoration: InputDecoration(
                              labelText: 'Name',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please provide a value.';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            onSaved: (value) {
                              _edittedHero = heroesProvider.Hero(
                                id: _edittedHero.id,
                                name: value!,
                                imageUrl: _edittedHero.imageUrl,
                                powers: _edittedHero.powers,
                                universe: _edittedHero.universe,
                                creationDate: _edittedHero.creationDate,
                              );
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text('Choose an Universe: '),
                              UniverseRadioTile(hero: _edittedHero),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Select your hero powers...',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.width < 600
                                ? MediaQuery.of(context).size.height * 0.25
                                : 600,
                            width: MediaQuery.of(context).size.width < 600
                                ? MediaQuery.of(context).size.height * 0.5
                                : 600,
                            margin: EdgeInsets.only(top: 8, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2,
                                  color: Theme.of(context).primaryColor),
                              color: Colors.black,
                            ),
                            child: PowerGrid(hero: _edittedHero),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  initialValue: _initValues['imageUrl'],
                                  decoration:
                                      InputDecoration(labelText: 'Image URL'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter an image URL.';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.url,
                                  //controller: _imageUrlController,
                                  onFieldSubmitted: (_) {
                                    _saveForm();
                                  },
                                  onSaved: (value) {
                                    _edittedHero = heroesProvider.Hero(
                                        id: _edittedHero.id,
                                        name: _edittedHero.name,
                                        imageUrl: value!,
                                        powers: _edittedHero.powers,
                                        universe: _edittedHero.universe,
                                        creationDate:
                                            _edittedHero.creationDate);
                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
