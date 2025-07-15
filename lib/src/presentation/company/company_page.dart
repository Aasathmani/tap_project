import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tap_project/generated/l10n.dart';
import 'package:tap_project/src/application/bloc/company/company_bloc.dart';
import 'package:tap_project/src/application/bloc/company/company_state.dart';
import 'package:tap_project/src/core/app_constants.dart';
import 'package:tap_project/src/presentation/core/colors.dart';
import 'package:tap_project/src/presentation/core/text_styles.dart';

class CompanyPage extends StatefulWidget {
  static const route = '/company';
  const CompanyPage({super.key});

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  CompanyBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= BlocProvider.of<CompanyBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
      ),
      body: _getBodyLayout(context),
    );
  }

  Widget _getBodyLayout(BuildContext context) {
    return BlocBuilder<CompanyBloc, CompanyState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Units.kStandardPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.companyModel == null)
                Center(child: CircularProgressIndicator()),
              if (state.companyModel != null) ...[
                _getLogoLayout(context, state),
                _getCompanyDetails(context, state),
                _getIsInNumberAndActiveLayout(context, state),
                _getIssuerDetails(context, state),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _getLogoLayout(BuildContext context, CompanyState state) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.lightGrey, width: 1),
      ),
      child: Image.network(state.companyModel!.logo, width: 48, height: 48),
    );
  }

  Widget _getCompanyDetails(BuildContext context, CompanyState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          state.companyModel!.companyName,
          style: TextStyles.bodyBold(context),
        ),
        Padding(
          padding: const EdgeInsets.only(top: Units.kMPadding),
          child: Text(
            state.companyModel!.description,
            style: TextStyles.labelRegular(context),
          ),
        ),
      ],
    );
  }

  Widget _getIsInNumberAndActiveLayout(
    BuildContext context,
    CompanyState state,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: Units.kStandardPadding),
      child: Row(
        children: [
          Material(
            color: AppColors.shadeBlue.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(Units.kXSPadding),
              child: Text(
                "ISIN: ${state.companyModel!.isin}",
                style: TextStyles.buttonNormal(
                  context,
                )!.copyWith(color: AppColors.shadeBlue),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: Units.kSPadding),
            child: Material(
              color: AppColors.green.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(Units.kXSPadding),
                child: Text(
                  state.companyModel!.status,
                  style: TextStyles.buttonNormal(
                    context,
                  )!.copyWith(color: AppColors.green),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getIssuerDetails(BuildContext context, CompanyState state) {
    return Padding(
      padding: EdgeInsets.only(top: Units.kXXLPadding),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
          border: Border.all(color: AppColors.lightGrey, width: 1),
        ),
        child: Column(children: [_getIconWithUserDetails(context, state)]),
      ),
    );
  }

  Widget _getIconWithUserDetails(BuildContext context, CompanyState state) {
    return Row(
      children: [
        SvgPicture.asset(AppIcons.kContactInfo),
        Text(S.current.labelIssuerDetails),
      ],
    );
  }
}
