import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_project/generated/l10n.dart';
import 'package:tap_project/src/application/bloc/home/home_bloc.dart';
import 'package:tap_project/src/application/bloc/home/home_event.dart';
import 'package:tap_project/src/application/bloc/home/home_state.dart';
import 'package:tap_project/src/application/model/bonds_model.dart';
import 'package:tap_project/src/core/app_constants.dart';
import 'package:tap_project/src/presentation/company/company_page.dart';
import 'package:tap_project/src/presentation/core/colors.dart';
import 'package:tap_project/src/presentation/core/text_styles.dart';
import 'package:tap_project/src/presentation/widgtes/bordered_text_field.dart';

class HomePage extends StatefulWidget {
  static const route = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc? _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc ??= BlocProvider.of<HomeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.labelHome),
        backgroundColor: AppColors.lightGrey1,
      ),
      body: _getBodyLayout(context),
    );
  }

  Widget _getBodyLayout(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.bondsList == null) {
          return Center(child: CircularProgressIndicator());
        }
        return ColoredBox(
          color: AppColors.lightGrey1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Units.kLPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getSearchTextFieldLayout(context),
                _getSuggestedResultLayout(context),
                if (state.bondsList != null && state.bondsList!.data.isNotEmpty)
                  _getBondsListLayout(context, state)
                else
                  Text("No list available"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getSearchTextFieldLayout(BuildContext context) {
    return BorderedTextField(
      hintText: S.current.labelSearchByIssuerName,
      borderColor: AppColors.fadeWhite,
      onTextChanged: (value) {
        _bloc!.add(SearchFieldChange(value));
      },
      prefixIcon: Icon(Icons.search),
    );
  }

  Widget _getSuggestedResultLayout(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Units.kXXLPadding),
      child: Text(
        S.current.labelSuggestedResults.toUpperCase(),
        style: TextStyles.buttonNormal(
          context,
        )!.copyWith(color: AppColors.lightBabyBlue),
      ),
    );
  }

  Widget _getBondsListLayout(BuildContext context, HomeState state) {
    List<BondsList>? bondList;
    if (state.searchValue == null) {
      bondList = state.bondsList?.data;
    } else {
      final searchTerms = state.searchValue!.toLowerCase().split(' ');

      bondList = state.bondsList?.data.where((element) {
        final companyName = element.companyName.toLowerCase();
        final isin = element.isin.toLowerCase();
        final rating = element.rating.toLowerCase();
        final tags = (element.tags ?? []).map((e) => e.toLowerCase()).toList();

        return searchTerms.every(
          (term) =>
              companyName.contains(term) ||
              isin.contains(term) ||
              rating.contains(term) ||
              tags.any((tag) => tag.contains(term)),
        );
      }).toList();
    }
    if (bondList!.isEmpty) {
      return Expanded(child: Center(child: Text("No item available")));
    } else {
      return Expanded(
        child: Card(
          color: AppColors.white,
          child: ListView.separated(
            padding: EdgeInsets.all(Units.kSPadding),
            itemCount: bondList.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.lightGrey, width: 1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Image.network(
                        state.bondsList!.data[index].logo,
                        width: 30,
                        height: 30,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.bondsList!.data[index].isin,
                            style: TextStyles.buttonLight(
                              context,
                            )!.copyWith(color: AppColors.grey),
                          ),
                          Text(
                            "${state.bondsList!.data[index].rating}. ${state.bondsList!.data[index].companyName}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.buttonNormal(
                              context,
                            )!.copyWith(color: AppColors.lightBabyBlue),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, CompanyPage.route);
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: AppColors.blueRibbon,
                      size: 18,
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) =>
                Padding(padding: const EdgeInsets.symmetric(vertical: 8.0)),
          ),
        ),
      );
    }
  }
}
