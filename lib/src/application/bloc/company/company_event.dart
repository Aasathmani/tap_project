class CompanyEvent {}

class OnInit extends CompanyEvent{}

class MetricToggleChange extends CompanyEvent{
  String metric;
  MetricToggleChange(this.metric);
}