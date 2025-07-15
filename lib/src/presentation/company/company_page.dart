import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tap_project/generated/l10n.dart';
import 'package:tap_project/src/application/bloc/company/company_bloc.dart';
import 'package:tap_project/src/application/bloc/company/company_event.dart';
import 'package:tap_project/src/application/bloc/company/company_state.dart';
import 'package:tap_project/src/application/model/company_model.dart';
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
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: _getBodyLayout(context),
    );
  }

  Widget _getBodyLayout(BuildContext context) {
    return BlocBuilder<CompanyBloc, CompanyState>(
      builder: (context, state) {
        if (state.companyModel == null) {
          return Center(child: CircularProgressIndicator());
        }
        return DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Units.kStandardPadding,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.companyModel != null) ...[
                        _getLogoLayout(context, state),
                        _getCompanyDetails(context, state),
                        _getIsInNumberAndActiveLayout(context, state),
                      ],
                    ],
                  ),
                ),
              ),
              TabBar(
                isScrollable: true,
                labelColor: AppColors.blueRibbon,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppColors.blueRibbon,
                tabs: [
                  Tab(text: "ISIN Analysis"),
                  Tab(text: "Pros & Cons"),
                ],
              ),

              // Tab Views
              Expanded(
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Units.kStandardPadding,
                      ),
                      child: Column(
                        children: [
                          _getCompanyFinancialsLayout(context, state),
                          _getIssuerDetails(context, state),
                        ],
                      ),
                    ),

                    SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Units.kStandardPadding,
                      ),
                      child: _getProsAndConsLayout(context, state),
                    ),
                  ],
                ),
              ),
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

  Widget _getCompanyFinancialsLayout(BuildContext context, CompanyState state) {
    return Container(
      margin: EdgeInsets.only(top: Units.kStandardPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
        border: Border.all(color: AppColors.lightGrey, width: 1),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Company Financials",
                  style: TextStyles.buttonSemiBold(
                    context,
                  )!.copyWith(color: AppColors.grey),
                ),
                _buildToggle(context, state),
              ],
            ),
          ),
          FinancialChartWidget(
            financials: state.companyModel!.financials,
            selectedMetric: state.selectedMetric,
          ),
        ],
      ),
    );
  }

  Widget _buildToggle(BuildContext context, CompanyState state) {
    final List<String> metrics = ['EBITDA', 'Revenue'];
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200, // background for the toggle group
        borderRadius: BorderRadius.circular(30),
      ),
      height: 30,
      child: ToggleButtons(
        isSelected: metrics.map((m) => state.selectedMetric == m).toList(),
        borderRadius: BorderRadius.circular(30),
        onPressed: (index) {
          final newMetric = metrics[index];
          _bloc!.add(MetricToggleChange(newMetric));
        },
        selectedColor: Colors.black87, // text color when selected
        color: Colors.grey, // text color when not selected
        fillColor: Colors.white, // background for selected
        selectedBorderColor: Colors.transparent,
        borderColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        children: metrics
            .map(
              (m) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(m, style: TextStyle(fontSize: 12)),
              ),
            )
            .toList(),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getIconWithUserDetails(context, state),
            Divider(),
            _getCommonNameLayout(
              context,
              "Issuer Name",
              state.companyModel!.issuerDetails.issuerName,
            ),
            _getCommonNameLayout(
              context,
              "Type of Issuer",
              state.companyModel!.issuerDetails.typeOfIssuer,
            ),
            _getCommonNameLayout(
              context,
              "Sector",
              state.companyModel!.issuerDetails.sector,
            ),
            _getCommonNameLayout(
              context,
              "Industry",
              state.companyModel!.issuerDetails.industry,
            ),
            _getCommonNameLayout(
              context,
              "Issuer nature",
              state.companyModel!.issuerDetails.industry,
            ),
            _getCommonNameLayout(
              context,
              "Corporate Identity Number (CIN)",
              state.companyModel!.issuerDetails.cin,
            ),
            _getCommonNameLayout(
              context,
              "Name of the Lead Manager",
              state.companyModel!.issuerDetails.leadManager,
            ),
            _getCommonNameLayout(
              context,
              "Registrar",
              state.companyModel!.issuerDetails.registrar,
            ),
            _getCommonNameLayout(
              context,
              "Name of Debenture Trustee",
              state.companyModel!.issuerDetails.debentureTrustee,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _getIconWithUserDetails(BuildContext context, CompanyState state) {
    return Padding(
      padding: EdgeInsets.all(Units.kStandardPadding),
      child: Row(
        children: [
          SvgPicture.asset(AppIcons.kContactInfo),
          Padding(
            padding: const EdgeInsets.only(left: Units.kSPadding),
            child: Text(
              S.current.labelIssuerDetails,
              style: TextStyles.buttonSemiBold(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getCommonNameLayout(BuildContext context, String name, String value) {
    return Padding(
      padding: const EdgeInsets.all(Units.kStandardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyles.captionBold(
              context,
            )!.copyWith(color: AppColors.blueRibbon),
          ),
          Text(value, style: TextStyles.buttonSemiBold(context)),
        ],
      ),
    );
  }

  Widget _getProsAndConsLayout(BuildContext context, CompanyState state) {
    return Padding(
      padding: EdgeInsets.only(top: Units.kXXLPadding),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
          border: Border.all(color: AppColors.lightGrey, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Units.kMPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Pros and Cons", style: TextStyles.buttonSemiBold(context)),
              SizedBox(height: 10),
              Text(
                "Pros",
                style: TextStyles.bodyBold(
                  context,
                )!.copyWith(color: AppColors.greenDarker),
              ),
              SizedBox(height: 8),
              _getProsContentLayout(context, state),
              SizedBox(height: 8),
              Text(
                "Cons",
                style: TextStyles.bodyBold(
                  context,
                )!.copyWith(color: AppColors.brown),
              ),
              _getConsContentLayout(context, state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getProsContentLayout(BuildContext context, CompanyState state) {
    final pros = state.companyModel?.prosAndCons.pros ?? [];

    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: Units.kMPadding),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(AppIcons.kIcPros),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: Units.kSPadding),
              child: Text(pros[index], style: TextStyles.labelRegular(context)),
            ),
          ),
        ],
      ),
      separatorBuilder: (context, index) => SizedBox(height: 25),
      itemCount: pros.length,
    );
  }

  Widget _getConsContentLayout(BuildContext context, CompanyState state) {
    final cons = state.companyModel?.prosAndCons.cons ?? [];

    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: Units.kMPadding),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(AppIcons.kIcCons),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: Units.kSPadding),
              child: Text(cons[index], style: TextStyles.labelRegular(context)),
            ),
          ),
        ],
      ),
      separatorBuilder: (context, index) => SizedBox(height: 25),
      itemCount: cons.length,
    );
  }
}

class FinancialChartWidget extends StatefulWidget {
  final Financials financials;
  final String selectedMetric;

  const FinancialChartWidget({
    super.key,
    required this.selectedMetric,
    required this.financials,
  });

  @override
  State<FinancialChartWidget> createState() => _FinancialChartWidgetState();
}

class _FinancialChartWidgetState extends State<FinancialChartWidget> {
  List<MonthlyValue> get currentData => widget.selectedMetric == 'EBITDA'
      ? widget.financials.ebitda
      : widget.financials.revenue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 12),
            child: BarChart(
              BarChartData(
                maxY: 3200000, // ₹3L
                barGroups: _buildBarGroups(currentData),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1000000, // interval of ₹1L
                  getDrawingHorizontalLine: (value) {
                    if (value == 1000000 ||
                        value == 2000000 ||
                        value == 3000000) {
                      return FlLine(
                        color: Colors.grey.shade300,
                        strokeWidth: 1,
                      );
                    }
                    return FlLine(strokeWidth: 0); // hide other lines
                  },
                ),
                titlesData: FlTitlesData(
                  topTitles: AxisTitles(),
                  rightTitles: AxisTitles(),
                  leftTitles: _buildLeftTitles(),
                  bottomTitles: _buildBottomTitles(currentData),
                ),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ),
      ],
    );
  }

  AxisTitles _buildLeftTitles() {
    return AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        interval: 1000000,
        getTitlesWidget: (value, _) {
          switch (value.toInt()) {
            case 1000000:
              return const Text('₹1L', style: TextStyle(fontSize: 10));
            case 2000000:
              return const Text('₹2L', style: TextStyle(fontSize: 10));
            case 3000000:
              return const Text('₹3L', style: TextStyle(fontSize: 10));
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  AxisTitles _buildBottomTitles(List<MonthlyValue> data) {
    return AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, _) {
          if (value.toInt() < data.length) {
            return Text(
              data[value.toInt()].month.substring(0, 1),
              style: const TextStyle(fontSize: 10),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups(List<MonthlyValue> data) {
    return List.generate(data.length, (index) {
      final total = data[index].value.toDouble();
      final base = total * 0.1;

      return BarChartGroupData(
        x: index,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
            fromY: 0,
            toY: base,
            color: widget.selectedMetric == 'EBITDA'
                ? AppColors.black
                : AppColors.denimBlue,
            width: 10,
            borderRadius: BorderRadius.zero,
          ),
        ],
      );
    });
  }
}
